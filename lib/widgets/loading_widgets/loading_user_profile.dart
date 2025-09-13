import 'package:flutter/material.dart';
import 'package:schedule_calendar/constants/constants.dart';
import 'package:schedule_calendar/widgets/widgets.dart';
import 'package:shimmer/shimmer.dart';

const double _containerHeight = 12.0;

class LoadingUserProfile extends UserProfile {
  const LoadingUserProfile({super.key}) : super(imageUrl: emptyString);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Shimmer.fromColors(
          baseColor: loadingBaseColor,
          highlightColor: loadingHighlightColor,
          child: const CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: 24.0,
            backgroundImage: AssetImage(userImage),
          ),
        ),
        const HorizontalSpace(13.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Shimmer.fromColors(
              baseColor: loadingBaseColor,
              highlightColor: loadingHighlightColor,
              child: Container(
                height: _containerHeight,
                width: 80.0,
                color: Colors.black,
              ),
            ),
            Shimmer.fromColors(
              baseColor: loadingBaseColor,
              highlightColor: loadingHighlightColor,
              child: Container(
                height: _containerHeight,
                width: 70.0,
                color: Colors.black,
              ),
            ),
            Shimmer.fromColors(
              baseColor: loadingBaseColor,
              highlightColor: loadingHighlightColor,
              child: Container(
                height: _containerHeight,
                width: 85.0,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
