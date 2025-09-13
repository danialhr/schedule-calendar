import 'package:flutter/material.dart';
import 'package:schedule_calendar/constants/constants.dart';
import 'package:schedule_calendar/utils/utils.dart';

class ScheduleCalendarButton extends StatelessWidget {
  const ScheduleCalendarButton({
    this.text,
    this.onTap,
    this.buttonColor,
    this.customBorderColor,
    this.customTextColor,
    this.padding,
    this.textStyle,
    this.borderRadius,
    super.key,
  });

  final String? text;
  final VoidCallback? onTap;
  final Color? buttonColor;
  final Color? customBorderColor;
  final Color? customTextColor;
  final EdgeInsets? padding;
  final TextStyle? textStyle;
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    final textTheme = context.appTheme.textTheme;
    final isContained = buttonColor != null;
    final borderColor = isContained ? Colors.transparent : Palette.blackPanther;
    final textColor = isContained ? Palette.white : Palette.blackPanther;

    return InkWell(
      splashColor: Palette.matTurquoise.withOpacity(0.5),
      borderRadius: BorderRadius.circular(8.0),
      onTap: onTap,
      child: Container(
        padding: padding ?? const EdgeInsets.symmetric(vertical: 16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius ?? 8.0),
          border: Border.all(color: customBorderColor ?? borderColor),
          color: buttonColor,
        ),
        child: Text(
          text ?? emptyString,
          textAlign: TextAlign.center,
          style: textStyle ?? textTheme.labelLarge?.copyWith(color: customTextColor ?? textColor),
        ),
      ),
    );
  }
}
