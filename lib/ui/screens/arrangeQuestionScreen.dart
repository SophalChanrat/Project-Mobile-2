import 'package:app_mvp/models/question/arrangeAnswersQuestion.dart';
import 'package:app_mvp/ui/widget/button.dart';
import 'package:app_mvp/ui/widget/question/arrange/arrangeQuestion.dart';
import 'package:flutter/material.dart';

class ArrangeQuestionScreen extends StatefulWidget {
  const ArrangeQuestionScreen({super.key, required this.question});
  final ArrangeAnswersQuestion question;

  @override
  State<ArrangeQuestionScreen> createState() => _ArrangeQuestionScreenState();
}

class _ArrangeQuestionScreenState extends State<ArrangeQuestionScreen> {
  late List<String> currentOrder;

  @override
  void initState() {
    super.initState();
    currentOrder = List.from(widget.question.items);
  }

  void _onReorder(List<String> newOrder) {
    setState(() {
      currentOrder = newOrder;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),

              Text(
                widget.question.title,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 24),

              Expanded(
                child: ArrangeQuestion(
                  items: currentOrder,
                  onReorder: _onReorder,
                ),
              ),

              Button(label: "Continue", action: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
