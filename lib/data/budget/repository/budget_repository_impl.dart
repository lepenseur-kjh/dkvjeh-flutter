import 'package:dartz/dartz.dart';
import 'package:dkejvh/data/budget/models/add_budget_command.dart';
import 'package:dkejvh/data/budget/source/budget_local_service.dart';
import 'package:dkejvh/domain/budget/repository/budget_repository.dart';
import 'package:dkejvh/service_locator.dart';

class BudgetRepositoryImpl extends BudgetRepository {
  @override
  Future<Either> addBudget(AddBudgetCommand command) async {
    return await sl<BudgetLocalService>().addBudget(command);
  }

  @override
  Future<Either> substractBudget(int useBudget) async {
    return await sl<BudgetLocalService>().substractBudget(useBudget);
  }

  @override
  Future<Either> resetBudget() async {
    return await sl<BudgetLocalService>().resetBudget();
  }
}
