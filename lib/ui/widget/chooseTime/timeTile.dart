import 'package:app_mvp/ui/widget/chooseTime/chooseTime.dart';
import 'package:flutter/material.dart';

class TimeRow extends StatelessWidget {
  const TimeRow({
    super.key,
    required this.timeOption,
    this.isFirst = false,
    this.isLast = false,
    required this.isSelected,
    required this.selectTime,
  });
  final TimeOption timeOption;
  final bool isLast;
  final bool isFirst;
  final bool isSelected;
  final VoidCallback selectTime;

  BorderRadius get borderRadius {
    if (isFirst) {
      return const BorderRadius.vertical(top: Radius.circular(15));
    }
    if (isLast) {
      return const BorderRadius.vertical(bottom: Radius.circular(15));
    }
    return BorderRadius.zero;
  }

  Color? get tileColor => isSelected ? Colors.blue[400] : Colors.white;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: selectTime,
      tileColor: tileColor,
      shape: RoundedRectangleBorder(borderRadius: borderRadius),
      leading: Text(
        timeOption.name,
        style: TextStyle(
          decoration: TextDecoration.none,
          color: Theme.of(context).colorScheme.onSurface,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
      trailing: Text(
        "${timeOption.timeSpend.inMinutes}min/ day",
        style: TextStyle(
          decoration: TextDecoration.none,
          color: Theme.of(context).colorScheme.onSurface,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
