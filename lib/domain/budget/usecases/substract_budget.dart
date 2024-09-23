import 'package:dartz/dartz.dart';
import 'package:dkejvh/core/usecase/usecase.dart';
import 'package:dkejvh/domain/budget/repository/budget_repository.dart';
import 'package:dkejvh/service_locator.dart';

class SubstractBudgetUseCase extends UseCase<Either, int> {
  @override
  Future<Either> call({int? params}) async {
    return await sl<BudgetRepository>().substractBudget(params!);
  }
}
