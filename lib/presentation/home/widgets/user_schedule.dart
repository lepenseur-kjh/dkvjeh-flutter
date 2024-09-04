import 'package:dkejvh/core/configs/theme/app_colors.dart';
import 'package:dkejvh/domain/schedule/entities/schedule.dart';
import 'package:dkejvh/presentation/home/bloc/user_schedules_display_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserSchedule extends StatelessWidget {
  final ScheduleEntity schedule;
  const UserSchedule({
    required this.schedule,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 232,
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _scheduleContent(context, schedule),
            const SizedBox(height: 14),
            _scheduleNotificationTime(context, schedule),
            const SizedBox(height: 14),
            _scheduleDeadline(context, schedule),
          ],
        ),
      ),
    );
  }

  Widget _scheduleContent(BuildContext context, ScheduleEntity schedule) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          schedule.content,
          style: const TextStyle(
            fontSize: 31,
            color: Colors.white,
          ),
        ),
        IconButton(
            onPressed: () {
              context
                  .read<UserSchedulesDisplayCubit>()
                  .removeSchedule(schedule);
            },
            icon: Container(
              height: 30,
              width: 30,
              decoration: const BoxDecoration(
                  color: Colors.white, shape: BoxShape.circle),
              child: const Icon(
                Icons.remove,
                size: 15,
                color: AppColors.primary,
              ),
            )),
      ],
    );
  }

  Widget _scheduleNotificationTime(
      BuildContext context, ScheduleEntity schedule) {
    int notificationTime = 0;
    bool isAM = true;
    if (schedule.notificationTime <= 12) {
      notificationTime = schedule.notificationTime;
    } else {
      notificationTime = schedule.notificationTime - 12;
      isAM = false;
    }
    return Text(
      isAM
          ? "푸시 알림 시간\n오전 $notificationTime시"
          : "푸시 알림 시간\n오후 $notificationTime시",
      style: const TextStyle(
        fontSize: 21,
        color: Colors.white,
      ),
    );
  }

  Widget _scheduleDeadline(BuildContext context, ScheduleEntity schedule) {
    String deadline =
        "${schedule.deadline.year}년 ${schedule.deadline.month}월 ${schedule.deadline.day}일";
    return Text(
      "마감일\n$deadline",
      style: const TextStyle(
        fontSize: 21,
        color: Colors.white,
      ),
    );
  }
}
