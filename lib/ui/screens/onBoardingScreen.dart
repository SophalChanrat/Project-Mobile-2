import 'package:app_mvp/models/topic.dart';
import 'package:app_mvp/router/appRouter.dart';
import 'package:app_mvp/ui/widget/button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Onboardingscreen extends StatelessWidget {
  const Onboardingscreen({super.key, required this.topics});
  final List<Topic> topics;

  void goToChooseTime (BuildContext context) {
    context.go(AppRouter.chooseTimeScreen, extra: topics);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(40),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(image: AssetImage('assets/Logo.png'), width: 200),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Welcome to",
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      color: Theme.of(context).colorScheme.onSurface,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Tork Tork!",
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Center(
                child: Text(
                  "Explore easy-to-follow lessons, practice with interactive exercises, and improve your skills every day.",
                  style: TextStyle(
                    decoration: TextDecoration.none,
                    color: Theme.of(context).colorScheme.onSurface,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 30,),
              Button(label: "Get Started", action:() => goToChooseTime(context)),
            ],
          ),
        ),
      ),
    );
  }
}
