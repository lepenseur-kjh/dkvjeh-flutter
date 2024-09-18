import 'package:dartz/dartz.dart';
import 'package:dkejvh/core/usecase/usecase.dart';
import 'package:dkejvh/data/budget/models/add_budget_command.dart';
import 'package:dkejvh/domain/budget/repository/budget_repository.dart';
import 'package:dkejvh/service_locator.dart';

class AddBudgetUsecase extends UseCase<Either, AddBudgetCommand> {
  @override
  Future<Either> call({AddBudgetCommand? params}) async {
    return await sl<BudgetRepository>().addBudget(params!);
  }
}
