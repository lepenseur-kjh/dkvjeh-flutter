import 'package:dartz/dartz.dart';
import 'package:dkejvh/data/schedule/models/add_schedule_command.dart';
import 'package:dkejvh/data/schedule/source/schedule_firebase_service.dart';
import 'package:dkejvh/domain/schedule/repository/schedule_repository.dart';
import 'package:dkejvh/service_locator.dart';

class ScheduleRepositoryImpl extends ScheduleRepository {
  @override
  Future<Either> addSchedule(AddScheduleCommand command) async {
    return await sl<ScheduleFirebaseService>().addSchedule(command);
  }
}
