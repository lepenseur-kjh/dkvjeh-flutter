import 'package:dartz/dartz.dart';
import 'package:dkejvh/core/usecase/usecase.dart';
import 'package:dkejvh/data/schedule/models/add_schedule_command.dart';
import 'package:dkejvh/data/schedule/source/schedule_firebase_service.dart';
import 'package:dkejvh/service_locator.dart';

class AddScheduleUseCase extends UseCase<Either, AddScheduleCommand> {
  @override
  Future<Either> call({AddScheduleCommand? params}) async {
    return await sl<ScheduleFirebaseService>().addSchedule(params!);
  }
}
