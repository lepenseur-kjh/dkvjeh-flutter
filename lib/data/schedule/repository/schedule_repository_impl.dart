import 'package:dartz/dartz.dart';
import 'package:dkejvh/data/schedule/models/add_schedule_command.dart';
import 'package:dkejvh/data/schedule/models/schedule.dart';
import 'package:dkejvh/data/schedule/source/schedule_firebase_service.dart';
import 'package:dkejvh/domain/schedule/repository/schedule_repository.dart';
import 'package:dkejvh/service_locator.dart';

class ScheduleRepositoryImpl extends ScheduleRepository {
  @override
  Future<Either> addSchedule(AddScheduleCommand command) async {
    return await sl<ScheduleFirebaseService>().addSchedule(command);
  }

  @override
  Future<Either> getSchedules() async {
    var resp = await sl<ScheduleFirebaseService>().getSchedules();
    return resp.fold((error) {
      return Left(error);
    }, (data) {
      return Right(List.from(data)
          .map((e) => ScheduleModel.fromMap(e).toEntity())
          .toList());
    });
  }
}
