import 'package:flutter/material.dart';
import 'package:schedule_calendar/constants/constants.dart';
import 'package:schedule_calendar/widgets/widgets.dart';
import 'package:shimmer/shimmer.dart';

const double _containerWidth = 40.0;
const double _containerHeight = 12.0;

class LoadingEventTile extends EventTile {
  const LoadingEventTile({super.key}) : super(event: null);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8.0),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Palette.ashGrey,
            width: 0.5,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
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
            const HorizontalSpace(16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Shimmer.fromColors(
                            baseColor: loadingBaseColor,
                            highlightColor: loadingHighlightColor,
                            child: Container(
                              height: _containerHeight,
                              width: _containerWidth * 2,
                              color: Palette.black,
                            ),
                          ),
                          const VerticalSpace(4.0),
                          Row(
                            children: [
                              Shimmer.fromColors(
                                baseColor: loadingBaseColor,
                                highlightColor: loadingHighlightColor,
                                child: Container(
                                  height: _containerHeight,
                                  width: _containerWidth,
                                  color: Palette.black,
                                ),
                              ),
                              const HorizontalSpace(8.0),
                              Shimmer.fromColors(
                                baseColor: loadingBaseColor,
                                highlightColor: loadingHighlightColor,
                                child: Container(
                                  height: _containerHeight,
                                  width: _containerWidth,
                                  color: Palette.black,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      Shimmer.fromColors(
                        baseColor: loadingBaseColor,
                        highlightColor: loadingHighlightColor,
                        child: Container(
                          height: _containerHeight * 2,
                          width: 60.0,
                          color: Palette.black,
                        ),
                      ),
                    ],
                  ),
                  const VerticalSpace(7.0),
                  Shimmer.fromColors(
                    baseColor: loadingBaseColor,
                    highlightColor: loadingHighlightColor,
                    child: Container(
                      height: 24.0,
                      width: double.infinity,
                      color: Palette.black,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
