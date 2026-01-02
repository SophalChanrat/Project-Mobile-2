import 'package:app_mvp/models/player.dart';
import 'package:app_mvp/models/topic.dart';
import 'package:app_mvp/router/AppRouter.dart';
import 'package:app_mvp/ui/screens/SplashScreen.dart';
import 'package:app_mvp/ui/screens/chooseTimeScreen.dart';
import 'package:app_mvp/ui/screens/lessonMapScreen.dart';
import 'package:app_mvp/ui/screens/onBoardingScreen.dart';
import 'package:app_mvp/ui/screens/topicScreen.dart';
import 'package:go_router/go_router.dart';

GoRouter router({
  required List<Topic> topics,
  required bool isFirstTime,
  Player? player,
}) {
  return GoRouter(
    initialLocation: isFirstTime ? AppRouter.onBoardingScreen : AppRouter.topicScreen,
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
    ],
  );
}
