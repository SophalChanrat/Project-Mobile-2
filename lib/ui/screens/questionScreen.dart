import 'package:app_mvp/data/userRepository.dart';
import 'package:app_mvp/models/answer.dart';
import 'package:app_mvp/models/lesson.dart';
import 'package:app_mvp/models/question/arrangeAnswersQuestion.dart';
import 'package:app_mvp/models/question/dragDropQuestion.dart';
import 'package:app_mvp/models/question/multipleChoice.dart';
import 'package:app_mvp/models/question/question.dart';
import 'package:app_mvp/models/question/stepByStepQuestion.dart';
import 'package:app_mvp/models/submission.dart';
import 'package:app_mvp/ui/widget/button.dart';
import 'package:app_mvp/ui/widget/question/arrange/arrangeQuestionBody.dart';
import 'package:app_mvp/ui/widget/question/dragDrop/dragDropBody.dart';
import 'package:app_mvp/ui/widget/question/multipleChoices/multipleChoicesBody.dart';
import 'package:app_mvp/ui/widget/question/progressBar.dart';
import 'package:app_mvp/ui/widget/question/stepQuestion/stepQuestionBody.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({super.key, required this.lesson});
  final Lesson lesson;

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  // Use for Navigating between questions
  int currentQuestionIndex = 0;
  // Use for track user attempts
  int totalAttempts = 0;
  // Use for scoring systems
  int correctCount = 0;
  int incorrectCount = 0;
  /* Use for store answer in each type of questions
    - selectedSteps use for StepbyStep question
    - currentOrder use for Arrange question
    - selectedChoiceIndex use for MultipleChoices question
    - selectedDragAnswer use for Drag and Drop question
  */
  List<String> selectedSteps = [];
  List<String> currentOrder = [];
  int? selectedChoiceIndex;
  String? selectedDragAnswer;

  late final Submission _currentSubmission;
  

  Question get currentQuestion => widget.lesson.questions[currentQuestionIndex];
  bool get isLastQuestion =>
      currentQuestionIndex >= widget.lesson.questions.length - 1;
  int get totalQuestions => widget.lesson.questions.length;
  bool get hasAnswer {
    final question = currentQuestion;
    if (question is StepByStepQuestion) return selectedSteps.isNotEmpty;
    if (question is ArrangeAnswersQuestion) return true;
    if (question is MultipleChoice) return selectedChoiceIndex != null;
    if (question is DragDropQuestion) return selectedDragAnswer != null;
    return false;
  }

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    totalAttempts = widget.lesson.maxAttempts;
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
    selectedChoiceIndex = null;
    selectedDragAnswer = null;

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

  void _onChoiceSelected(int index) {
    setState(() {
      selectedChoiceIndex = index;
    });
  }

  void _onDragAnswerSelected(String value) {
    setState(() {
      selectedDragAnswer = value;
    });
  }

  bool _checkAnswer() {
    final question = currentQuestion;

    if (question is StepByStepQuestion) {
      return compareList(selectedSteps, question.correctStep);
    } else if (question is ArrangeAnswersQuestion) {
      return compareList(currentOrder, question.correctOrder);
    } else if (question is MultipleChoice) {
      if (selectedChoiceIndex == null) return false;
      return question.choices[selectedChoiceIndex!] == question.goodChoice;
    } else if (question is DragDropQuestion) {
      return selectedDragAnswer == question.correctAnswer;
    }
    return true;
  }

  bool compareList(List<String> a, List<String> b) {
    if (a.length != b.length) return false;
    for (int i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }

  void onContinue() {
    final isCorrect = _checkAnswer();
    _updateScore(isCorrect);
    _saveAnswer(isCorrect);
    _showFeedback(isCorrect);
    if (isCorrect) {
      _handleNextStep();
    }
  }


  void _updateScore(bool isCorrect) {
    setState(() {
      if (isCorrect) {
        correctCount++;
      } else {
        incorrectCount++;
        totalAttempts--;
        if(totalAttempts == 0){
          _showNoAttemptsDialog();
        }
      }
    });
  }

  String _getCurrentResponse() {
    final question = currentQuestion;

    if (question is StepByStepQuestion) {
      return selectedSteps.join(', ');
    } else if (question is ArrangeAnswersQuestion) {
      return currentOrder.join(', ');
    } else if (question is MultipleChoice) {
      return selectedChoiceIndex != null
          ? question.choices[selectedChoiceIndex!]
          : '';
    } else if (question is DragDropQuestion) {
      return selectedDragAnswer ?? '';
    }
    return '';
  }

  void _saveAnswer(bool isCorrect) {
    _currentSubmission.answers.add(
      Answer(
        questionId: currentQuestion.qid,
        response: _getCurrentResponse(),
        attempsCount: isCorrect ? 0 : 1,
      ),
    );
  }

  void _showFeedback(bool isCorrect) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(isCorrect ? '✓ Correct!' : '✗ Incorrect'),
        backgroundColor: isCorrect ? Colors.green : Colors.red,
        duration: Duration(milliseconds: 600),
      ),
    );
  }

  void _handleNextStep() {
    if (totalAttempts <= 0) {
      _saveSubmissionAndComplete();
      return;
    }

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

    final basePoints = widget.lesson.point;
    final maxAttempts = widget.lesson.maxAttempts;
    final attemptsUsed = incorrectCount;
    final penaltyPerAttempt = (basePoints / maxAttempts).ceil();
    int earnedPoints = basePoints - (attemptsUsed * penaltyPerAttempt);
    if (earnedPoints < 0) {
      earnedPoints = 0;
    }

    final completedSubmission = Submission(
      lessonId: _currentSubmission.lessonId,
      date: _currentSubmission.date,
      progress: percentage,
      isComplete: true,
      answers: _currentSubmission.answers,
    );

    await UserRepository.addSubmission(
      completedSubmission,
      earnedPoints: earnedPoints,
    );

    if (!mounted) return;
    _showCompletionDialog(percentage, earnedPoints);
  }

  void _showCompletionDialog(int percentage, int earnedPoints) {
    _showDialog(
      title: 'Lesson Complete!',
      buttonTitle: 'Continue',
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('You completed "${widget.lesson.lessonName}"!'),
          SizedBox(height: 16),
          Text(
            'Score: $correctCount / $totalQuestions ($percentage%)',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text('Points earned: +$earnedPoints'),
        ],
      ),
      onContinue: () => context.pop(earnedPoints),
    );
  }

  void _showNoAttemptsDialog() {
    _showDialog(
      title: 'No Attempts Left',
      buttonTitle: 'Exit',
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('You have no attempts left for this lesson.'),
        ],
      ),
      onContinue: () => context.pop(),
    );
  }

  void _showDialog({
    required String title,
    required String buttonTitle,
    required Widget content,
    required VoidCallback onContinue,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => AlertDialog(
        title: Text(title),
        content: content,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              onContinue();
            },
            child: Text(buttonTitle),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Progressbar(
              currentQuestion: currentQuestionIndex + 1,
              totalQuestions: totalQuestions,
              totalAttempts: totalAttempts,
              onClose: () => context.pop(),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),

                    Expanded(child: _buildQuestionContent()),

                    Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: Button(
                        label: isLastQuestion ? "Finish" : "Continue",
                        action: hasAnswer ? onContinue : null,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuestionContent() {
    final question = currentQuestion;

    if (question is StepByStepQuestion) {
      return StepQuestionBody(
        question: question,
        selectedSteps: selectedSteps,
        onStepTap: _onStepTap,
      );
    } else if (question is ArrangeAnswersQuestion) {
      return ArrangeQuestionBody(
        question: question,
        currentOrder: currentOrder,
        onReorder: _onReorder,
      );
    } else if (question is MultipleChoice) {
      return MultipleChoicesBody(
        question: question,
        selectedIndex: selectedChoiceIndex,
        onChoiceSelected: _onChoiceSelected,
      );
    } else if (question is DragDropQuestion) {
      return DragDropBody(
        question: question,
        selectedAnswer: selectedDragAnswer,
        onAnswerSelected: _onDragAnswerSelected,
      );
    }
    return Placeholder(child: Text("Not available"));
  }
}
