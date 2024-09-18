import 'package:dartz/dartz.dart';
import 'package:dkejvh/data/budget/models/add_budget_command.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class BudgetLocalService {
  Future<Either> addBudget(AddBudgetCommand command);
}

class BudgetLocalServiceImpl extends BudgetLocalService {
  @override
  Future<Either> addBudget(AddBudgetCommand command) async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.setInt("livingDays", command.livingDays);
      sharedPreferences.setInt("livingBudget", command.livingBudget);
      sharedPreferences.setString("budgetStatus", "starting");

      return const Right("생존 시작!");
    } catch (e) {
      return Left(e);
    }
  }
}
