import 'package:dkejvh/domain/auth/entities/user.dart';

abstract class UserInfoState {}

class UserInfoLoading extends UserInfoState {}

class UserInfoLoaded extends UserInfoState {
  final UserEntity user;
  UserInfoLoaded({required this.user});
}

class LoadUserInfoFailure extends UserInfoState {}
