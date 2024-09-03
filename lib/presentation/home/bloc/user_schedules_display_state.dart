import 'package:dkejvh/domain/schedule/entities/schedule.dart';

abstract class UserSchedulesDisplayState {}

class UserSchedulesDisplayLoading extends UserSchedulesDisplayState {}

class UserSchedulesDisplayLoaded extends UserSchedulesDisplayState {
  final List<ScheduleEntity> schedules;
  UserSchedulesDisplayLoaded({required this.schedules});
}

class LoadUserSchedulesFailure extends UserSchedulesDisplayState {
  final String errorMsg;
  LoadUserSchedulesFailure({required this.errorMsg});
}
