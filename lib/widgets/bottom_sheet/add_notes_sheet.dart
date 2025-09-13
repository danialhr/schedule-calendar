import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:schedule_calendar/constants/constants.dart';
import 'package:schedule_calendar/utils/utils.dart';
import 'package:schedule_calendar/widgets/widgets.dart';

const double _addIconSize = 40.0;

class AddNotesSheet extends StatelessWidget {
  const AddNotesSheet({
    this.height,
    this.onPressExpand,
    this.onPressAdd,
    this.maxLines,
    super.key,
  });

  final double? height;
  final VoidCallback? onPressExpand;
  final void Function(String)? onPressAdd;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    final textController = TextEditingController();
    final textTheme = context.appTheme.textTheme;

    return ScheduleCalendarBottomSheet(
      height: height,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 16.0,
          horizontal: 24.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: onPressExpand,
              child: SvgPicture.asset(expandIcon),
            ),
            TextField(
              controller: textController,
              maxLines: maxLines,
              style: textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w400),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: writeANote,
                hintStyle: textTheme.labelLarge?.copyWith(
                  color: Palette.mistyGrey,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
            Container(
              height: _addIconSize,
              width: _addIconSize,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Palette.boscoGrey,
              ),
              child: IconButton(
                onPressed: () => onPressAdd?.call(textController.text),
                color: Palette.white,
                icon: const Icon(
                  Icons.add,
                  color: Palette.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
