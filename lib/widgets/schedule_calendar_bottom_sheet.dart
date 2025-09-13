import 'package:flutter/material.dart';

import '../constants/constants.dart';

const double _bottomSheetBorderRadius = 24.0;

class ScheduleCalendarBottomSheet extends StatelessWidget {
  const ScheduleCalendarBottomSheet({
    this.height,
    this.child,
    super.key,
  });

  final double? height;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        borderRadius: const BorderRadiusDirectional.only(
          topStart: Radius.circular(_bottomSheetBorderRadius),
          topEnd: Radius.circular(_bottomSheetBorderRadius),
        ),
        color: Palette.blancoWhite,
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, -1),
            blurRadius: 10,
            color: Palette.blackPanther.withOpacity(0.25),
          ),
        ],
      ),
      child: child,
    );
  }
}
