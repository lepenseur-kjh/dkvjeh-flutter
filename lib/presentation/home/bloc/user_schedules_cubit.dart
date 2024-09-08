import 'package:dkejvh/domain/schedule/usecases/get_schedules.dart';
import 'package:dkejvh/presentation/home/bloc/user_schedules_state.dart';
import 'package:dkejvh/service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserSchedulesCubit extends Cubit<UserSchedulesState> {
  UserSchedulesCubit() : super(UserSchedulesLoading());

  void displayUserSchedules() async {
    var resp = await sl<GetSchedulesUseCase>().call();
    resp.fold((error) {
      emit(LoadUserSchedulesFailure(errorMsg: error));
    }, (data) {
      emit(UserSchedulesLoaded(schedules: data));
    });
  }
}
