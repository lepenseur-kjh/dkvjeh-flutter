import 'package:dartz/dartz.dart';
import 'package:dkejvh/data/budget/models/add_budget_command.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class BudgetLocalService {
  Future<Either> addBudget(AddBudgetCommand command);
  Future<Either> substractBudget(int useBudget);
  Future<Either> resetBudget();
}

class BudgetLocalServiceImpl extends BudgetLocalService {
  @override
  Future<Either> addBudget(AddBudgetCommand command) async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.setInt("livingDays", command.livingDays);
      sharedPreferences.setInt("livingBudget", command.livingBudget);
      sharedPreferences.setString("budgetStatus", "inProgress");

      return const Right("생존 시작!");
    } catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either> substractBudget(int useBudget) async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      int livingDays = sharedPreferences.getInt('livingDays') ?? 0;

      // passedDays
      int passedDays;
      if (sharedPreferences.containsKey('passedDays')) {
        passedDays = (sharedPreferences.getInt('passedDays') ?? 0) + 1;
      } else {
        passedDays = 1;
      }
      await sharedPreferences.setInt('passedDays', passedDays);

      // livingDays -> completed
      if (livingDays == passedDays) {
        await sharedPreferences.setString('budgetStatus', "completed");
      }

      // usedBudget
      int usedBudget;
      if (sharedPreferences.containsKey('usedBudget')) {
        usedBudget = (sharedPreferences.getInt('usedBudget') ?? 0) + useBudget;
      } else {
        usedBudget = useBudget;
      }
      await sharedPreferences.setInt('usedBudget', usedBudget);

      return const Right("생존 진행!");
    } catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either> resetBudget() async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.clear();

      return const Right("탈출!");
    } catch (e) {
      return Left(e);
    }
  }
}
