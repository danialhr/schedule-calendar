import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:schedule_calendar/utils/utils.dart';
import 'package:schedule_calendar/widgets/widgets.dart';

import '../constants/constants.dart';

const double iconSize = 32.0;

class SchedulCalendarAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SchedulCalendarAppBar({
    this.title,
    this.onPressBack,
    this.onPressMore,
    super.key,
  });

  final Widget? title;
  final VoidCallback? onPressMore;
  final VoidCallback? onPressBack;

  @override
  Widget build(BuildContext context) {
    const iconPadding = EdgeInsets.symmetric(
      vertical: 8.0,
      horizontal: 12.0,
    );

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                IconButton(
                  padding: iconPadding,
                  iconSize: iconSize,
                  icon: SvgPicture.asset(backIcon),
                  onPressed: () => _navigateBack(context),
                ),
                title ?? const UserProfile(imageUrl: userImage),
              ],
            ),
            IconButton(
              padding: iconPadding,
              iconSize: iconSize,
              icon: SvgPicture.asset(moreIcon),
              onPressed: onPressMore,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(55);

  void _navigateBack(BuildContext context) {
    if (!context.navigator.canPop()) return;

    context.navigator.pop();
  }
}
