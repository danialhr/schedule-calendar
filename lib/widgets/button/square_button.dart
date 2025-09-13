import 'package:flutter/material.dart';
import 'package:schedule_calendar/utils/utils.dart';
import 'package:super_tooltip/super_tooltip.dart';

import '../../constants/constants.dart';
import '../widgets.dart';

const double _buttonSize = 72.0;

class SquareButton extends StatelessWidget {
  const SquareButton({
    this.title,
    this.subtitle,
    this.tooltipMessage,
    super.key,
  });

  final Widget? title;
  final String? subtitle;
  final String? tooltipMessage;

  @override
  Widget build(BuildContext context) {
    final textTheme = context.appTheme.textTheme;
    final controller = SuperTooltipController();
    final tooltipContainerColor = tooltipMessage == null ? Colors.transparent : const Color(0xFFD9D9D9);

    return SuperTooltip(
      controller: controller,
      arrowTipDistance: 40.0,
      arrowBaseWidth: 14,
      arrowLength: 7,
      backgroundColor: tooltipContainerColor,
      borderColor: tooltipContainerColor,
      barrierColor: Colors.transparent,
      shadowColor: Colors.transparent,
      content: Text(
        tooltipMessage ?? emptyString,
        style: textTheme.bodyLarge?.copyWith(
          fontSize: 11.0,
          fontWeight: FontWeight.w300,
        ),
      ),
      child: Container(
        height: _buttonSize,
        width: _buttonSize,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: Palette.muteGrey,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (title != null) title!,
            const VerticalSpace(4.0),
            Text(
              subtitle ?? emptyString,
              style: textTheme.bodyLarge?.copyWith(
                color: Palette.ashGrey,
                fontSize: 11.0,
                fontWeight: FontWeight.w400,
              ),
            )
          ],
        ),
      ),
    );
  }
}
