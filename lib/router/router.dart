import 'package:app_mvp/models/topic.dart';
import 'package:app_mvp/router/AppRouter.dart';
import 'package:app_mvp/ui/screens/SplashScreen.dart';
import 'package:app_mvp/ui/screens/chooseTimeScreen.dart';
import 'package:app_mvp/ui/screens/lessonMapScreen.dart';
import 'package:app_mvp/ui/screens/onBoardingScreen.dart';
import 'package:app_mvp/ui/screens/topicScreen.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  initialLocation: AppRouter.splashScreen,
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
        final topics = state.extra as List<Topic>;
        return Onboardingscreen(topics: topics);
      },
    ),
    GoRoute(
      path: AppRouter.chooseTimeScreen,
      builder: (context, state) {
        final topics = state.extra as List<Topic>;
        return Choosetimescreen(topics: topics);
      },
    ),
    GoRoute(
      path: AppRouter.topicScreen,
      builder: (context, state) {
        final topics = state.extra as List<Topic>;
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
