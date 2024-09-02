import 'package:dkejvh/common/bloc/button_state.dart';
import 'package:dkejvh/common/bloc/button_state_cubit.dart';
import 'package:dkejvh/common/helper/formatter/time_range_formatter.dart';
import 'package:dkejvh/common/helper/navigator/app_navigator.dart';
import 'package:dkejvh/common/widgets/appbar/app_bar.dart';
import 'package:dkejvh/common/widgets/button/basic_reactive_button.dart';
import 'package:dkejvh/core/configs/theme/app_colors.dart';
import 'package:dkejvh/data/schedule/models/add_schedule_command.dart';
import 'package:dkejvh/domain/schedule/usecases/add_schedule.dart';
import 'package:dkejvh/presentation/home/pages/schedule_page.dart';
import 'package:dkejvh/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddSchedulePage extends StatelessWidget {
  AddSchedulePage({super.key});

  final TextEditingController _scheduleContentCon = TextEditingController();
  final TextEditingController _scheduleNotificationTimeCon =
      TextEditingController();
  final TextEditingController _scheduleDeadlineCon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const BasicAppBar(),
      body: BlocProvider(
        create: (context) => ButtonStateCubit(),
        child: BlocListener<ButtonStateCubit, ButtonState>(
          listener: (context, state) {
            if (state is ButtonFailureState) {
              var snackBar = SnackBar(
                content: Text(state.errorMsg),
                behavior: SnackBarBehavior.floating,
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
            if (state is ButtonSuccessState) {
              AppNavigator.pushAndRemove(context, const SchedulePage());
            }
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                    _scheduleContent(context),
                    const SizedBox(height: 20),
                    _scheduleNotificationTime(context),
                    const SizedBox(height: 20),
                    _scheduleDeadline(context),
                  ],
                ),
              ),
              const Spacer(),
              _finishButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _scheduleTitle(BuildContext context) {
    return const Text(
      "일정 등록",
      style: TextStyle(
        fontSize: 44,
        color: Colors.black,
      ),
    );
  }

  Widget _scheduleContent(BuildContext context) {
    return TextField(
      controller: _scheduleContentCon,
      decoration: const InputDecoration(hintText: "할 일 (예: 퇴근 후 다이소에서 찍찍이 사기)"),
      style: const TextStyle(
        fontSize: 21,
        color: Colors.white,
      ),
    );
  }

  Widget _scheduleNotificationTime(BuildContext context) {
    return TextField(
      controller: _scheduleNotificationTimeCon,
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
        LimitRangeTextInpitFormatter(0, 23),
      ],
      decoration: const InputDecoration(hintText: "푸시 알림을 받고 싶은 시간 (예: 15시)"),
      style: const TextStyle(
        fontSize: 21,
        color: Colors.white,
      ),
    );
  }

  Widget _scheduleDeadline(BuildContext context) {
    return TextField(
        controller: _scheduleDeadlineCon,
        keyboardType: TextInputType.datetime,
        decoration: const InputDecoration(hintText: "마감일 (예: 2024/08/31)"),
        style: const TextStyle(
          fontSize: 21,
          color: Colors.white,
        ),
        readOnly: true,
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime(DateTime.now().year + 1),
          );
          if (pickedDate != null) {
            _scheduleDeadlineCon.text =
                "${pickedDate.year}/${pickedDate.month}/${pickedDate.day}";
          }
        });
  }

  Widget _finishButton(BuildContext context) {
    return Container(
      height: 100,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Center(
        child: Builder(
          builder: (context) {
            return BasicReactiveButton(
              onPressed: () {
                // request body 설정
                List<String> deadlineList =
                    _scheduleDeadlineCon.text.split("/");
                // request body 설정
                context.read<ButtonStateCubit>().execute(
                      usecase: sl<AddScheduleUseCase>(),
                      params: AddScheduleCommand(
                        content: _scheduleContentCon.text,
                        notificationTime:
                            int.parse(_scheduleNotificationTimeCon.text),
                        deadline: DateTime(
                          int.parse(deadlineList[0]),
                          int.parse(deadlineList[1]),
                          int.parse(deadlineList[2]),
                          23,
                          59,
                          59,
                        ),
                        createdAt: DateTime.now(),
                      ),
                    );
              },
              title: "등록",
            );
          },
        ),
      ),
    );
  }
}
