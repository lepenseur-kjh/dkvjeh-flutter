import 'package:shared_preferences/shared_preferences.dart';

enum BudgetStatus {
  pending,
  inProgress,
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

  static Future<BudgetEntity> initialize() async {
    final prefs = await SharedPreferences.getInstance();

    int livingDays = prefs.getInt("livingDays") ?? 0;
    int passedDays = prefs.getInt("passedDays") ?? 0;
    int livingBudget = prefs.getInt("livingBudget") ?? 0;
    int usedBudget = prefs.getInt("usedBudget") ?? 0;
    String budgetStatusKey = prefs.getString("budgetStatus") ?? "";

    // 1. pending -> inProgess
    // 2. inProgress -> completed
    // 3. completed -> pending
    int recommendedDailyBudget = 0;
    if (livingDays != 0 && livingBudget != 0) {
      recommendedDailyBudget = livingBudget ~/ livingDays;
    }
    double remainDaysPercent = 0.0;
    if (livingDays != 0 && passedDays != 0) {
      remainDaysPercent =
          double.parse((passedDays / livingDays).toStringAsFixed(2));
    }
    double remainBudgetPercent = 0.0;
    if (livingBudget != 0 && usedBudget != 0) {
      remainBudgetPercent =
          double.parse((usedBudget / livingBudget).toStringAsFixed(2));
    }
    BudgetStatus budgetStatus = BudgetStatus.pending;
    if (budgetStatusKey == "inProgress") {
      budgetStatus = BudgetStatus.inProgress;
    } else if (budgetStatusKey == "completed") {
      budgetStatus = BudgetStatus.completed;
    }

    return BudgetEntity(
      livingDays: livingDays,
      passedDays: passedDays,
      remainDaysPercent: remainDaysPercent,
      livingBudget: livingBudget,
      usedBudget: usedBudget,
      recommendedDailyBudget: recommendedDailyBudget,
      remainBudgetPercent: remainBudgetPercent,
      budgetStatus: budgetStatus,
    );
  }
}
