import 'package:flutter/material.dart';
import 'package:schedule_calendar/utils/utils.dart';

import '../constants/constants.dart';

class EllipsisText extends StatefulWidget {
  const EllipsisText({
    this.text,
    super.key,
  });

  final String? text;

  @override
  State<EllipsisText> createState() => _EllipsisTextState();
}

class _EllipsisTextState extends State<EllipsisText> {
  late bool hasReadMore;

  @override
  void initState() {
    super.initState();
    hasReadMore = false;
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = context.appTheme.textTheme;
    final maxLines = hasReadMore ? null : 4;
    final overflow = hasReadMore ? null : TextOverflow.ellipsis;

    return LayoutBuilder(
      builder: (context, size) {
        final hasExceeded = _hasTextOverflow(size);

        return Stack(
          children: <Widget>[
            Text(
              widget.text ?? emptyString,
              style: textTheme.bodyLarge?.copyWith(
                color: Palette.blackPanther,
                fontSize: 11.0,
                fontWeight: FontWeight.w400,
              ),
              maxLines: maxLines,
              overflow: overflow,
            ),
            if (hasExceeded && !hasReadMore)
              Positioned(
                bottom: 0.0,
                right: 0.0,
                child: GestureDetector(
                  onTap: _setHasReadMore,
                  child: Container(
                    color: Palette.white,
                    child: Text(
                      readMore,
                      style: textTheme.bodyLarge?.copyWith(
                        color: const Color(0xFF9B9B9B),
                        fontSize: 11.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              )
          ],
        );
      },
    );
  }

  // This checks if the text has overflowed using [TextPainter]
  bool _hasTextOverflow(BoxConstraints size) {
    final textTheme = context.appTheme.textTheme;

    final TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: widget.text,
        style: textTheme.bodyLarge?.copyWith(
          color: Palette.blackPanther,
          fontSize: 11.0,
          fontWeight: FontWeight.w400,
        ),
      ),
      maxLines: 4,
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: size.maxWidth);

    return textPainter.didExceedMaxLines;
  }

  // Handles showing all exceeded text when see more is clicked
  void _setHasReadMore() => setState(() => hasReadMore = !hasReadMore);
}
