import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schedule_calendar/bloc/coach/coach_bloc.dart';
import 'package:schedule_calendar/constants/strings.dart';
import 'package:schedule_calendar/utils/utils.dart';
import 'package:schedule_calendar/widgets/widgets.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({
    required this.imageUrl,
    this.name = 'Sarah Chu',
    this.email = '@sarah.sports',
    this.workPosition = 'Personal Trainer',
    this.textColor,
    super.key,
  });

  factory UserProfile.loading() => const LoadingUserProfile();

  final String imageUrl;
  final String name;
  final String email;
  final String workPosition;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    final textTheme = context.appTheme.textTheme;

    return BlocBuilder<CoachBloc, CoachState>(
      builder: (context, state) {
        if (state is! CoachSuccess) return UserProfile.loading();

        final coach = state.coach;

        return Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 24.0,
              backgroundImage: NetworkImage(coach.imageUrl ?? userImage),
            ),
            const HorizontalSpace(13.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  '${coach.firstName} ${coach.lastName} ',
                  style: textTheme.bodyLarge?.copyWith(color: textColor),
                ),
                Text(
                  '@${coach.userName}',
                  style: textTheme.bodyLarge?.copyWith(
                    color: textColor,
                    fontSize: 11.0,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                Text(
                  '${coach.role}',
                  style: textTheme.bodyLarge?.copyWith(
                    color: textColor,
                    fontSize: 11.0,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
