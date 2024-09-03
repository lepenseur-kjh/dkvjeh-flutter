import 'package:dkejvh/core/configs/theme/app_colors.dart';
import 'package:dkejvh/domain/auth/entities/user.dart';
import 'package:dkejvh/presentation/home/bloc/user_info_display_cubit.dart';
import 'package:dkejvh/presentation/home/bloc/user_info_display_state.dart';
import 'package:dkejvh/presentation/home/widgets/budget_card.dart';
import 'package:dkejvh/presentation/home/widgets/schedule_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          _header(context),
          const SizedBox(height: 32),
          const SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                ScheduleCard(),
                SizedBox(height: 8),
                BudgetCard(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _header(BuildContext context) {
    return BlocProvider(
      create: (context) => UserInfoDisplayCubit()..displayUserInfo(),
      child: Padding(
        padding: const EdgeInsets.only(
          top: 40,
          right: 16,
          left: 16,
        ),
        child: BlocBuilder<UserInfoDisplayCubit, UserInfoDisplayState>(
            builder: (context, state) {
          if (state is UserInfoLoading) {
            return const Center(
                child: CircularProgressIndicator(
              color: AppColors.primary,
            ));
          }
          if (state is UserInfoLoaded) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(16, 40, 16, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _headerUserInfo(context, state.user),
                  _headerNotification(context),
                ],
              ),
            );
          }
          return Container();
        }),
      ),
    );
  }

  Widget _headerUserInfo(BuildContext context, UserEntity user) {
    return Text(
      "반갑습니다,\n${user.username}님",
      style: const TextStyle(
        fontSize: 24,
        color: Colors.black,
      ),
    );
  }

  Widget _headerNotification(BuildContext context) {
    return IconButton(
        onPressed: () {
          // 알림 페이지 이동
        },
        icon: Container(
          height: 50,
          width: 50,
          decoration: const BoxDecoration(
            color: AppColors.primary,
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.notifications,
            size: 15,
            color: Colors.white,
          ),
        ));
  }
}
