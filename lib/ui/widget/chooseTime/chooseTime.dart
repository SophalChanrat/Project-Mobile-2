import 'package:app_mvp/ui/widget/chooseTime/timeTile.dart';
import 'package:flutter/material.dart';
// import 'package:app_mvp/ui/widget/timeTile.dart';

enum TimeOption {
  casual(name: "Casual", timeSpend: Duration(minutes: 5)),
  regular(name: "Regular", timeSpend: Duration(minutes: 10)),
  serious(name: "Serious", timeSpend: Duration(minutes: 15)),
  intense(name: "Intense", timeSpend: Duration(minutes: 20));

  const TimeOption({required this.name, required this.timeSpend});
  final String name;
  final Duration timeSpend;
}

class Choosetime extends StatefulWidget {
  const Choosetime({super.key});

  @override
  State<Choosetime> createState() => _ChoosetimeState();
}

class _ChoosetimeState extends State<Choosetime> {
  TimeOption? selectedTime;

  void selectTime(int index) {
    setState(() {
      selectedTime = TimeOption.values[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Colors.black),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (int i = 0; i < TimeOption.values.length; i++) ...[
            if (i > 0) Divider(height: 1, color: Colors.black),
            TimeRow(
              timeOption: TimeOption.values[i],
              isFirst: i == 0,
              isLast: i == TimeOption.values.length - 1,
              isSelected: selectedTime == TimeOption.values[i],
              selectTime: () => selectTime(i),
            ),
          ]
        ]
      ),
    );
  }
}

