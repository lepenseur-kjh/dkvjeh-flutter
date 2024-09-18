import 'package:dkejvh/domain/budget/entities/budget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BudgetDisplayCubit extends Cubit<BudgetEntity?> {
  BudgetDisplayCubit() : super(null);

  Future<void> displayBudget() async {
    final initial = await BudgetEntity.initialize();
    emit(initial);
  }

  // void removeSchedule(ScheduleEntity schedule) async {
  //   var resp = await sl<RemoveScheduleUseCase>().call(params: schedule.id);
  //   resp.fold((error) {
  //     //
  //   }, (data) {
  //     initial = initial.where((e) => e.id != schedule.id).toList();
  //     emit(initial);
  //   });
  // }
}
