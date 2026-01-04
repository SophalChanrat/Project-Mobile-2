import 'package:app_mvp/data/userRepository.dart';
import 'package:app_mvp/models/answer.dart';
import 'package:app_mvp/models/feedback.dart';
import 'package:app_mvp/models/lesson.dart';
import 'package:app_mvp/models/question/arrangeAnswersQuestion.dart';
import 'package:app_mvp/models/question/dragDropQuestion.dart';
import 'package:app_mvp/models/question/multipleChoice.dart';
import 'package:app_mvp/models/question/question.dart';
import 'package:app_mvp/models/question/stepByStepQuestion.dart';
import 'package:app_mvp/models/submission.dart';
import 'package:app_mvp/ui/widget/button.dart';
import 'package:app_mvp/ui/widget/question/arrange/arrangeQuestionBody.dart';
import 'package:app_mvp/ui/widget/question/stepQuestion/stepQuestionBody.dart';
import 'package:app_mvp/utils/animationUtils.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({super.key, required this.lesson});
  final Lesson lesson;

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  int currentQuestionIndex = 0;
  List<String> selectedSteps = [];
  List<String> currentOrder = [];
  int correctCount = 0;

  /// Current submission being built - stored locally, not mutating widget
  late Submission _currentSubmission;

  Question get currentQuestion => widget.lesson.questions[currentQuestionIndex];
  bool get isLastQuestion =>
      currentQuestionIndex >= widget.lesson.questions.length - 1;
  int get totalQuestions => widget.lesson.questions.length;

  @override
  void initState() {
    super.initState();
    // Create submission locally - don't mutate widget.lesson
    _currentSubmission = Submission(
      lessonId: widget.lesson.lessonId,
      date: DateTime.now(),
      progress: 0,
      isComplete: false,
      answers: [],
    );
    _initializeQuestionState();
  }

  void _initializeQuestionState() {
    final question = currentQuestion;

    selectedSteps = [];

    if (question is ArrangeAnswersQuestion) {
      currentOrder = List.from(question.items);
    } else {
      currentOrder = [];
    }
  }

  void _onStepTap(String step) {
    setState(() {
      if (selectedSteps.contains(step)) {
        selectedSteps.remove(step);
      } else {
        selectedSteps.add(step);
      }
    });
  }

  void _onReorder(List<String> newOrder) {
    setState(() {
      currentOrder = newOrder;
    });
  }

  bool _checkAnswer() {
    final question = currentQuestion;

    if (question is StepByStepQuestion) {
      return _listEquals(selectedSteps, question.correctStep);
    } else if (question is ArrangeAnswersQuestion) {
      return _listEquals(currentOrder, question.correctOrder);
    }
    return true;
  }

  bool _listEquals(List<String> a, List<String> b) {
    if (a.length != b.length) return false;
    for (int i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }

  void _onContinue() {
    final isCorrect = _checkAnswer();
    if (isCorrect) {
      correctCount++;
    }

    final question = currentQuestion;
    String responseStr;
    if (question is StepByStepQuestion) {
      responseStr = selectedSteps.join(', ');
    } else if (question is ArrangeAnswersQuestion) {
      responseStr = currentOrder.join(', ');
    } else {
      responseStr = '';
    }

    _currentSubmission.answers.add(
      Answer(
        questionId: question.qid,
        response: responseStr,
        attempsCount: 1,
        feedback: FeedbackModel(
          explaination: isCorrect ? 'Correct!' : 'Incorrect answer',
          hint: isCorrect ? '' : 'Try reviewing the material',
        ),
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(isCorrect ? '✓ Correct!' : '✗ Incorrect'),
        backgroundColor: isCorrect ? Colors.green : Colors.red,
        duration: Duration(milliseconds: 600),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.height - 150,
          left: 20,
          right: 20,
        ),
      ),
    );

    if (isLastQuestion) {
      _saveSubmissionAndComplete();
    } else {
      setState(() {
        currentQuestionIndex++;
        _initializeQuestionState();
      });
    }
  }

  Future<void> _saveSubmissionAndComplete() async {
    final percentage = ((correctCount / totalQuestions) * 100).round();

    final completedSubmission = Submission(
      lessonId: _currentSubmission.lessonId,
      date: _currentSubmission.date,
      progress: percentage,
      isComplete: true,
      answers: _currentSubmission.answers,
    );

    await UserRepository.addSubmission(completedSubmission);

    if (!mounted) return;
    _showCompletionDialog(percentage);
  }

  void _showCompletionDialog(int percentage) {
    Navigator.of(context).push(
      Animationutils.createScalePopupRoute(
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Material(
            borderRadius: BorderRadius.circular(16),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Lesson Complete!',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Text('You completed "${widget.lesson.lessonName}"!'),
                  const SizedBox(height: 16),
                  Text(
                    'Score: $correctCount / $totalQuestions ($percentage%)',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text('Points earned: +${widget.lesson.point}'),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          context.pop();
                        },
                        child: const Text('Continue'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.lesson.questions.isEmpty) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('No questions available for this lesson'),
              SizedBox(height: 20),
              Button(label: 'Go Back', action: () => context.pop()),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),

              Expanded(
                child: AnimatedSwitcher(
                  duration: Duration(milliseconds: 400),
                  transitionBuilder: (child, animation) {
                    return Animationutils.fadeSlideTransition(child, animation);
                  },
                  child: _buildQuestionContent(),
                ),
              ),

              Button(
                label: isLastQuestion ? "Finish" : "Continue",
                action: _onContinue,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuestionContent() {
    final question = currentQuestion;

    if (question is StepByStepQuestion) {
      return StepQuestionBody(
        key: ValueKey(currentQuestionIndex),
        question: question,
        selectedSteps: selectedSteps,
        onStepTap: _onStepTap,
      );
    } else if (question is ArrangeAnswersQuestion) {
      return ArrangeQuestionBody(
        key: ValueKey(currentQuestionIndex),
        question: question,
        currentOrder: currentOrder,
        onReorder: _onReorder,
      );
    } else if (question is MultipleChoice) {
      // TODO: Implement MultipleChoice widget
      return Placeholder(child: Text("Coming Soon"));
    } else if (question is DragDropQuestion) {
      // TODO: Implement DragDrop widget
      return Placeholder(child: Text("Coming Soon"));
    }
    return Placeholder(child: Text("Not available"));
  }
}
