import 'package:dkejvh/domain/budget/entities/budget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BudgetDisplayCubit extends Cubit<BudgetEntity?> {
  BudgetDisplayCubit() : super(null);

  Future<void> displayBudget() async {
    final initial = await BudgetEntity.initialize();
    emit(initial);
  }
}
