import 'package:flutter/material.dart';
import 'package:schedule_calendar/widgets/widgets.dart';

import '../constants/constants.dart';

class EventTypeChip extends StatelessWidget {
  const EventTypeChip({
    this.color,
    this.leadingIcon,
    this.text,
    super.key,
  });

  final Color? color;
  final Widget? leadingIcon;
  final String? text;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14.5),
        color: color,
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 2.0,
        horizontal: 12.0,
      ),
      child: Row(
        children: [
          if (leadingIcon != null) ...[
            leadingIcon!,
            const HorizontalSpace(3.0),
          ],
          Text(
            text ?? emptyString,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Palette.black,
                  fontSize: 9.0,
                ),
          ),
        ],
      ),
    );
  }
}
