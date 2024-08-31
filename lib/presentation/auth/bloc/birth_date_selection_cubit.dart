import 'package:flutter_bloc/flutter_bloc.dart';

class BirthDateSelectionCubit extends Cubit<DateTime> {
  BirthDateSelectionCubit() : super(DateTime.now());

  DateTime selectedDate = DateTime.now();

  void changeDate(DateTime? changedDate) {
    if (changedDate != null) {
      selectedDate = changedDate;
      emit(selectedDate);
    }
  }
}
