import 'package:flutter/material.dart';
import 'package:schedule_calendar/constants/constants.dart';
import 'package:schedule_calendar/utils/utils.dart';
import 'package:schedule_calendar/widgets/widgets.dart';
import 'package:swipeable_button_view/swipeable_button_view.dart';

class TermsAndConditionSheet extends StatelessWidget {
  const TermsAndConditionSheet({
    required this.onLoading,
    super.key,
  });

  final VoidCallback onLoading;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textTheme = context.appTheme.textTheme;

    return ScheduleCalendarBottomSheet(
      height: size.height * 0.5,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 13.0,
          horizontal: 34.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Bottom Sheet Indicator
            Center(
              child: Container(
                height: 5.0,
                width: 36.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  color: const Color(0xFF414141),
                ),
              ),
            ),
            const VerticalSpace(26.0),
            Text(
              termsAndConditions,
              style: textTheme.titleLarge,
            ),
            const VerticalSpace(10.0),
            // Terms and Condition
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  termsAndConditionsMessage,
                  style: textTheme.bodyLarge?.copyWith(
                    color: Palette.boscoGrey,
                    fontSize: 11.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            // Swipeable Button - [Swipe to accept]
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Palette.boscoGrey),
                    borderRadius: BorderRadius.circular(100.0),
                  ),
                  child: SwipeableButtonView(
                    // not needed but is required by the widget
                    onFinish: () {},
                    onWaitingProcess: onLoading,
                    activeColor: Palette.blancoWhite,
                    buttontextstyle: textTheme.titleLarge?.copyWith(
                      color: Palette.boscoGrey,
                      fontWeight: FontWeight.w400,
                    ),
                    buttonWidget: Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Palette.boscoGrey,
                      ),
                    ),
                    indicatorColor: const AlwaysStoppedAnimation<Color>(Palette.boscoGrey),
                    buttonText: swipeToAccept,
                    isFinished: false,
                  ),
                ),
              ),
            ),
            // Cancel
            Container(
              width: size.width,
              margin: const EdgeInsets.only(bottom: 20.0),
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: InkWell(
                onTap: context.navigator.pop,
                child: Text(
                  cancel,
                  textAlign: TextAlign.center,
                  style: textTheme.titleLarge?.copyWith(
                    color: Palette.boscoGrey,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
