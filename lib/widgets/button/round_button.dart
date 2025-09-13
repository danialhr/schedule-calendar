import 'package:flutter/material.dart';
import 'package:schedule_calendar/constants/constants.dart';
import 'package:schedule_calendar/utils/utils.dart';

class RoundButton extends StatelessWidget {
  const RoundButton({
    this.onTap,
    this.text,
    super.key,
  });

  final VoidCallback? onTap;
  final String? text;

  @override
  Widget build(BuildContext context) {
    final textTheme = context.appTheme.textTheme;

    return InkWell(
      splashColor: Palette.matTurquoise.withOpacity(0.5),
      borderRadius: BorderRadius.circular(100.0),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          border: Border.all(color: Palette.blackPanther),
          borderRadius: BorderRadius.circular(100.0),
        ),
        child: Text(
          text ?? emptyString,
          textAlign: TextAlign.center,
          style: textTheme.bodySmall?.copyWith(
            color: Palette.blackPanther,
            fontSize: 11.0,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
