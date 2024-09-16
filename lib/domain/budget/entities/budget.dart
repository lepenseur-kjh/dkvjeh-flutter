enum BudgetStatus {
  pending,
  starting,
  inProgress,
  finishing,
  completed,
}

class BudgetEntity {
  final int livingDays;
  final int passedDays;
  final double remainDaysPercent;
  final int livingBudget;
  final int usedBudget;
  final double remainBudgetPercent;
  final int recommendedDailyBudget;
  final BudgetStatus budgetStatus;

  const BudgetEntity({
    required this.livingDays,
    required this.passedDays,
    required this.remainDaysPercent,
    required this.livingBudget,
    required this.usedBudget,
    required this.remainBudgetPercent,
    required this.recommendedDailyBudget,
    required this.budgetStatus,
  });

  factory BudgetEntity.initialize() {
    // TODO: SharedPreference 사용
    return const BudgetEntity(
      livingDays: 0,
      passedDays: 0,
      remainDaysPercent: 0.0,
      livingBudget: 0,
      usedBudget: 0,
      recommendedDailyBudget: 0,
      remainBudgetPercent: 0.0,
      budgetStatus: BudgetStatus.pending,
    );
  }
}
