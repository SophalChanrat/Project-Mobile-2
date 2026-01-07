import 'package:app_mvp/models/lesson.dart';
import 'package:app_mvp/models/topic.dart';
import 'package:app_mvp/router/AppRouter.dart';
import 'package:app_mvp/ui/screens/chooseTimeScreen.dart';
import 'package:app_mvp/ui/screens/lessonMapScreen.dart';
import 'package:app_mvp/ui/screens/onBoardingScreen.dart';
import 'package:app_mvp/ui/screens/questionScreen.dart';
import 'package:app_mvp/ui/screens/topicScreen.dart';
import 'package:app_mvp/utils/animationUtils.dart';
import 'package:go_router/go_router.dart';

GoRouter router({
  required List<Topic> topics,
  required bool isFirstTime,
}) {
  return GoRouter(
    initialLocation: isFirstTime ? AppRouter.onBoardingScreen : AppRouter.topicScreen,
    initialExtra: topics,
    routes: [
      GoRoute(
        path: AppRouter.onBoardingScreen,
        pageBuilder: (context, state) {
          final topics = state.extra as List<Topic>;
          return Animationutils.leftToRight(Onboardingscreen(topics: topics,));
        },
      ),
      GoRoute(
        path: AppRouter.chooseTimeScreen,
        pageBuilder: (context, state) {
          final topics = state.extra as List<Topic>;
          return Animationutils.leftToRight(Choosetimescreen(topics: topics,));
        },
      ),
      GoRoute(
        path: AppRouter.topicScreen,
        pageBuilder: (context, state) {
          final topics = state.extra as List<Topic>;
          return Animationutils.rightToLeft(Topicscreen(topics: topics));
        },
      ),
      GoRoute(
        path: AppRouter.lessonScreen,
        pageBuilder: (context, state) {
          final topic = state.extra as Topic;
          return Animationutils.bottomToTop(LessonMapScreen(topic: topic));
        },
      ),
      GoRoute(
        path: AppRouter.questionScreen,
        pageBuilder: (context, state) {
          final lesson = state.extra as Lesson;
          return Animationutils.bottomToTop(QuestionScreen(lesson: lesson));
        },
      ),
    ],
  );
}
