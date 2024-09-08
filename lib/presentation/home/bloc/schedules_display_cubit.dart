import 'package:dkejvh/domain/schedule/entities/schedule.dart';
import 'package:dkejvh/domain/schedule/usecases/remove_schedule.dart';
import 'package:dkejvh/service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SchedulesDisplayCubit extends Cubit<List<ScheduleEntity>> {
  SchedulesDisplayCubit() : super([]);

  List<ScheduleEntity> initial = [];

  void displaySchedules(List<ScheduleEntity> schedules) {
    initial = schedules;
    emit(initial);
  }

  void removeSchedule(ScheduleEntity schedule) async {
    var resp = await sl<RemoveScheduleUseCase>().call(params: schedule.id);
    resp.fold((error) {
      //
    }, (data) {
      initial = initial.where((e) => e.id != schedule.id).toList();
      emit(initial);
    });
  }
}
