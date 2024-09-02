import 'package:dartz/dartz.dart';
import 'package:dkejvh/data/schedule/models/add_schedule_command.dart';

abstract class ScheduleRepository {
  Future<Either> addSchedule(AddScheduleCommand command);
}
