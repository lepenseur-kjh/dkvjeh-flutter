import 'package:dkejvh/core/configs/theme/app_colors.dart';
import 'package:dkejvh/domain/auth/entities/user.dart';
import 'package:dkejvh/presentation/home/bloc/userinfo_cubit.dart';
import 'package:dkejvh/presentation/home/bloc/userinfo_state.dart';
import 'package:dkejvh/presentation/home/widgets/budget_card.dart';
import 'package:dkejvh/presentation/home/widgets/schedule_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Container(
          width: MediaQuery.sizeOf(context).width,
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.sizeOf(context).width * 0.05,
          ),
          child: Column(
            children: [
              _header(context),
              const SingleChildScrollView(
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
        ),
      ),
    );
  }

  Widget _header(BuildContext context) {
    return BlocProvider(
      create: (context) => UserInfoCubit()..displayUserInfo(),
      child: BlocBuilder<UserInfoCubit, UserInfoState>(
        builder: (context, state) {
          if (state is UserInfoLoading) {
            return _homePage(context, true, null);
          }
          if (state is UserInfoLoaded) {
            return _homePage(context, false, state.user);
          }
          return Container();
        },
      ),
    );
  }

  Widget _homePage(
    BuildContext context,
    bool isLoading,
    UserEntity? user,
  ) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.15,
      width: MediaQuery.sizeOf(context).width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _headerUserInfo(context, isLoading, user),
          _headerNotification(context),
        ],
      ),
    );
  }

  Widget _headerUserInfo(
    BuildContext context,
    bool isLoading,
    UserEntity? user,
  ) {
    return Skeletonizer(
      enabled: isLoading,
      child: Text(
        "반갑습니다,\n${user?.username}님",
        style: const TextStyle(
          fontSize: 24,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _headerNotification(BuildContext context) {
    return IconButton(
        onPressed: () {
          // TODO: 알림 페이지 이동
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
