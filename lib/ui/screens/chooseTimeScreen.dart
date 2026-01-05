import 'package:app_mvp/data/userRepository.dart';
import 'package:app_mvp/models/topic.dart';
import 'package:app_mvp/router/appRouter.dart';
import 'package:app_mvp/ui/widget/button.dart';
import 'package:app_mvp/ui/widget/chooseTime/bottomInformation.dart';
import 'package:app_mvp/ui/widget/chooseTime/chooseTime.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Choosetimescreen extends StatefulWidget {
  const Choosetimescreen({super.key, required this.topics});
  final List<Topic> topics;

  @override
  State<Choosetimescreen> createState() => _ChoosetimescreenState();
}

class _ChoosetimescreenState extends State<Choosetimescreen> {
  Duration? selectedTime;

  void goToTopic(BuildContext context) async {
    /* 
      UnComment this when Done because this will make the app 
      skip onBoarding and chooseTime when open for the second time
    */
    
    if (selectedTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select a time goal first')),
      );
      return;
    }

    await UserRepository.setNotFirstOpen();
    await UserRepository.setPlayerPreferTime(selectedTime!);
    context.go(AppRouter.topicScreen, extra: widget.topics);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Pick A Goal",
          style: TextStyle(
            decoration: TextDecoration.none,
            color: Theme.of(context).colorScheme.onSurface,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.surface,
      ),
      body: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          children: [
            Choosetime(
              onTimeSelected: (duration) {
                setState(() {
                  selectedTime = duration;
                });
              },
            ),
            SizedBox(height: 100,),
            Bottominformation(),
            Spacer(),
            Button(label: "Continuous", action: () => goToTopic(context))
          ],
        ),
      ),
    );
  }
}
