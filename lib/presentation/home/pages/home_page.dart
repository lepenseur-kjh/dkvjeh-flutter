import 'package:dkejvh/common/helper/navigator/app_navigator.dart';
import 'package:dkejvh/core/configs/theme/app_colors.dart';
import 'package:dkejvh/domain/auth/entities/user.dart';
import 'package:dkejvh/domain/auth/usecases/logout.dart';
import 'package:dkejvh/presentation/auth/pages/sign_in_page.dart';
import 'package:dkejvh/presentation/home/bloc/userinfo_cubit.dart';
import 'package:dkejvh/presentation/home/bloc/userinfo_state.dart';
import 'package:dkejvh/presentation/home/widgets/budget_card.dart';
import 'package:dkejvh/presentation/home/widgets/schedule_card.dart';
import 'package:dkejvh/service_locator.dart';
import 'package:dkejvh/social_login.dart';
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
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: ListView(
          // padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: AppColors.primary,
              ),
              child: Text(
                '이용해주셔서 감사합니다.\n서비스 고도화 중입니다.',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.account_circle),
              title: const Text(
                '로그아웃',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
              onTap: () async {
                var resp = await sl<LogoutUseCase>().call();
                resp.fold((error) {
                  showToast(error);
                  return;
                }, (data) {
                  AppNavigator.pushReplacement(context, const SignInPage());
                });
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text(
                '회원탈퇴',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
              onTap: () {
                showToast("고객센터에 문의해주세요.");
              },
            ),
          ],
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
          // 드로어 열기
          Scaffold.of(context).openDrawer();
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
