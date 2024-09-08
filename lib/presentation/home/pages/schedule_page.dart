import 'package:dkejvh/common/helper/navigator/app_navigator.dart';
import 'package:dkejvh/common/widgets/appbar/app_bar.dart';
import 'package:dkejvh/common/widgets/button/basic_app_button.dart';
import 'package:dkejvh/core/configs/theme/app_colors.dart';
import 'package:dkejvh/domain/schedule/entities/schedule.dart';
import 'package:dkejvh/presentation/home/bloc/schedules_display_cubit.dart';
import 'package:dkejvh/presentation/home/bloc/user_schedules_cubit.dart';
import 'package:dkejvh/presentation/home/bloc/user_schedules_state.dart';
import 'package:dkejvh/presentation/home/pages/add_schedule_page.dart';
import 'package:dkejvh/presentation/home/widgets/user_schedule.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SchedulePage extends StatelessWidget {
  const SchedulePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const BasicAppBar(),
      body: SafeArea(
        child: BlocProvider(
          create: (context) => UserSchedulesCubit()..displayUserSchedules(),
          child: BlocBuilder<UserSchedulesCubit, UserSchedulesState>(
            builder: (context, state) {
              if (state is LoadUserSchedulesFailure) {
                var snackBar = SnackBar(
                  content: Text(state.errorMsg),
                  behavior: SnackBarBehavior.floating,
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
              if (state is UserSchedulesLoading) {
                return _schedulePage(context, true, []);
              }
              if (state is UserSchedulesLoaded) {
                return BlocProvider(
                  create: (context) => SchedulesDisplayCubit()
                    ..displaySchedules(state.schedules),
                  child:
                      BlocBuilder<SchedulesDisplayCubit, List<ScheduleEntity>>(
                          builder: (context, subState) {
                    return _schedulePage(context, false, subState);
                  }),
                );
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }

  Widget _schedulePage(
    BuildContext context,
    bool isLoading,
    List<ScheduleEntity> schedules,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.sizeOf(context).width * 0.05),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _scheduleTitle(context),
          const SizedBox(height: 32),
          _schedule(context, isLoading, schedules),
          const Spacer(),
          _addButton(context, schedules),
        ],
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

  Widget _schedule(
    BuildContext context,
    bool isLoading,
    List<ScheduleEntity> schedules,
  ) {
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
      return Skeletonizer(
        enabled: isLoading,
        child: SizedBox(
          height: MediaQuery.sizeOf(context).height * 0.55,
          child: ListView.separated(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              return UserSchedule(schedule: schedules[index]);
            },
            separatorBuilder: (context, index) => const SizedBox(height: 10),
            itemCount: schedules.length,
          ),
        ),
      );
    }
  }

  Widget _addButton(BuildContext context, List<ScheduleEntity> schedules) {
    return Container(
      height: 100,
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
