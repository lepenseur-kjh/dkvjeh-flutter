import 'package:dartz/dartz.dart';
import 'package:dkejvh/data/budget/models/add_budget_command.dart';

abstract class BudgetRepository {
  Future<Either> addBudget(AddBudgetCommand command);
}
