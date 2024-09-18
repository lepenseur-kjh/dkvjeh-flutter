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
}
