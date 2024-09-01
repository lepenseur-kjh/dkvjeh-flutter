import 'package:dkejvh/common/helper/navigator/app_navigator.dart';
import 'package:dkejvh/core/configs/theme/app_colors.dart';
import 'package:dkejvh/presentation/home/pages/schedule_page.dart';
import 'package:flutter/material.dart';

class ScheduleCard extends StatelessWidget {
  const ScheduleCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AppNavigator.push(context, const SchedulePage());
      },
      child: Container(
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
              _scheduleTitle(),
              const SizedBox(height: 20),
              _scheduleComment(),
              const SizedBox(height: 4),
              _scheduleText(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _scheduleTitle() {
    return const Text(
      "일정 관리",
      style: TextStyle(
        fontSize: 31,
        color: Colors.white,
      ),
    );
  }

  Widget _scheduleComment() {
    return const Text(
      "* 까먹지 말아야 할 일을 적어보세요!",
      style: TextStyle(
        fontSize: 21,
        color: Colors.white,
      ),
    );
  }

  Widget _scheduleText() {
    return const Text(
      "1. 해야 할 일과 기간을 작성 (최대 3개)\n" + "2. 체크 리스트 지우기\n" + "3. 목표 달성",
      style: TextStyle(
        fontSize: 21,
        color: Colors.white,
      ),
    );
  }
}
