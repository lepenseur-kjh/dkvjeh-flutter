import 'package:dkejvh/domain/schedule/entities/schedule.dart';

abstract class UserSchedulesState {}

class UserSchedulesDisplayLoading extends UserSchedulesState {}

class UserSchedulesDisplayLoaded extends UserSchedulesState {
  final List<ScheduleEntity> schedules;
  UserSchedulesDisplayLoaded({required this.schedules});
}

class LoadUserSchedulesFailure extends UserSchedulesState {
  final String errorMsg;
  LoadUserSchedulesFailure({required this.errorMsg});
}
