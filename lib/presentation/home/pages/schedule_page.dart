import 'package:dkejvh/common/helper/navigator/app_navigator.dart';
import 'package:dkejvh/common/widgets/appbar/app_bar.dart';
import 'package:dkejvh/common/widgets/button/basic_app_button.dart';
import 'package:dkejvh/domain/schedule/entities/schedule.dart';
import 'package:dkejvh/presentation/home/bloc/user_schedules_display_cubit.dart';
import 'package:dkejvh/presentation/home/bloc/user_schedules_display_state.dart';
import 'package:dkejvh/presentation/home/pages/add_schedule_page.dart';
import 'package:dkejvh/presentation/home/widgets/user_schedule.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SchedulePage extends StatelessWidget {
  const SchedulePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BasicAppBar(),
      body: BlocProvider(
        create: (context) =>
            UserSchedulesDisplayCubit()..displayUserSchedules(),
        child:
            BlocBuilder<UserSchedulesDisplayCubit, UserSchedulesDisplayState>(
          builder: (context, state) {
            if (state is LoadUserSchedulesFailure) {
              var snackBar = SnackBar(
                content: Text(state.errorMsg),
                behavior: SnackBarBehavior.floating,
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
            if (state is UserSchedulesDisplayLoaded) {
              return Column(children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 40,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _scheduleTitle(context),
                      const SizedBox(height: 32),
                      _schedule(context, state.schedules),
                    ],
                  ),
                ),
                const Spacer(),
                _addButton(context, state.schedules),
              ]);
            }
            return Container();
          },
        ),
      ),
    );
  }

  Widget _scheduleTitle(BuildContext context) {
    return const Text(
      "일정 관리",
      style: TextStyle(
        fontSize: 44,
        color: Colors.black,
      ),
    );
  }

  Widget _schedule(BuildContext context, List<ScheduleEntity> schedules) {
    if (schedules.isEmpty) {
      return const Text(
        "꼭 기억해야 할 일을 등록해보세요. (최대 3개)\n" +
            "잊어버리지 않도록 마감일 전까지 푸시 알림을 발송해드립니다.\n\n" +
            "일정을 수정해야 하는 경우,\n" +
            "일정 삭제 후, 다시 등록해주세요.",
        style: TextStyle(
          fontSize: 21,
          color: Colors.black,
        ),
      );
    } else {
      return SizedBox(
        height: MediaQuery.of(context).size.height / 2,
        child: ListView.separated(
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            return UserSchedule(schedule: schedules[index]);
          },
          separatorBuilder: (context, index) => const SizedBox(height: 10),
          itemCount: schedules.length,
        ),
      );
    }
  }

  Widget _addButton(BuildContext context, List<ScheduleEntity> schedules) {
    return Container(
      height: 100,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      color: Colors.white,
      child: Center(
        child: Builder(builder: (context) {
          return BasicAppButton(
            onPressed: () {
              if (schedules.length < 3) {
                AppNavigator.push(context, AddSchedulePage());
              } else {
                var snackBar = const SnackBar(
                  content: Text("일정 등록은 최대 3개까지 가능합니다."),
                  behavior: SnackBarBehavior.floating,
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
            },
            title: "일정 등록",
          );
        }),
      ),
    );
  }
}
