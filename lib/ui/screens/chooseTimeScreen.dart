import 'package:app_mvp/ui/widget/button.dart';
import 'package:app_mvp/ui/widget/chooseTime/bottomInformation.dart';
import 'package:app_mvp/ui/widget/chooseTime/chooseTime.dart';
import 'package:flutter/material.dart';

class Choosetimescreen extends StatelessWidget {
  const Choosetimescreen({super.key});

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
            Choosetime(),
            SizedBox(height: 100,),
            Bottominformation(),
            Spacer(),
            Button(label: "Continuous")
          ],
        ),
      ),
    );
  }
}
