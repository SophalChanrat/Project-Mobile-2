import 'package:app_mvp/models/player.dart';
import 'package:app_mvp/models/question/arrangeAnswersQuestion.dart';
import 'package:app_mvp/models/question/stepByStepQuestion.dart';
import 'package:app_mvp/models/topic.dart';
import 'package:app_mvp/router/AppRouter.dart';
import 'package:app_mvp/ui/screens/SplashScreen.dart';
import 'package:app_mvp/ui/screens/arrangeQuestionScreen.dart';
import 'package:app_mvp/ui/screens/chooseTimeScreen.dart';
import 'package:app_mvp/ui/screens/lessonMapScreen.dart';
import 'package:app_mvp/ui/screens/onBoardingScreen.dart';
import 'package:app_mvp/ui/screens/stepQuestionScreen.dart';
import 'package:app_mvp/ui/screens/topicScreen.dart';
import 'package:go_router/go_router.dart';

GoRouter router({
  required List<Topic> topics,
  required bool isFirstTime,
  Player? player,
}) {
  return GoRouter(
    initialLocation: isFirstTime ? AppRouter.onBoardingScreen : AppRouter.topicScreen,
    // initialLocation: '/arrange',
    routes: [
      GoRoute(
        path: AppRouter.splashScreen,
        builder: (context, state) {
          return Splashscreen();
        },
      ),
      GoRoute(
        path: AppRouter.onBoardingScreen,
        builder: (context, state) {
          return Onboardingscreen(topics: topics);
        },
      ),
      GoRoute(
        path: AppRouter.chooseTimeScreen,
        builder: (context, state) {
          return Choosetimescreen(topics: topics);
        },
      ),
      GoRoute(
        path: AppRouter.topicScreen,
        builder: (context, state) {
          return Topicscreen(topics: topics);
        },
      ),
      GoRoute(
        path: AppRouter.lessonScreen,
        builder: (context, state) {
          // final lessons = state.extra as List<Lesson>;
          return LessonMapScreen();
        },
      ),
      GoRoute(
        path: AppRouter.stepsQuestionScreen,
        builder: (context, state) => StepQuestionScreen(
          question: StepByStepQuestion(
            title: 'Choose step orders to solve',
            content: '2x + 6 = 10',
            answers: [],
            steps: ['Subtract 6', 'Divide by 2', 'Add 6', 'Multiply by 2'],
            correctStep: ['Subtract 6', 'Divide by 2'],
          ),
        ),
      ),
      GoRoute(
        path: AppRouter.arrangeQuestionScreen,
        builder: (context, state) => ArrangeQuestionScreen(
          question: ArrangeAnswersQuestion(
            title: 'Arrange the steps to solve 2x + 6 = 10',
            answers: [],
            items: ['Divide by 2', 'Subtract 6', 'Get x = 2'], // Shuffled
            correctOrder: ['Subtract 6', 'Divide by 2', 'Get x = 2'],
          ),
        ),
      ),
    ],
  );
}
