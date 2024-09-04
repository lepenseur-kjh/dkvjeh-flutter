import 'package:dartz/dartz.dart';
import 'package:dkejvh/core/usecase/usecase.dart';
import 'package:dkejvh/domain/schedule/repository/schedule_repository.dart';
import 'package:dkejvh/service_locator.dart';

class RemoveScheduleUseCase extends UseCase<Either, String> {
  @override
  Future<Either> call({String? params}) async {
    return await sl<ScheduleRepository>().removeSchedule(params!);
  }
}
