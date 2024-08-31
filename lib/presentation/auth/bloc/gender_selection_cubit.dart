import 'package:flutter_bloc/flutter_bloc.dart';

class GenderSelectionCubit extends Cubit<int> {
  GenderSelectionCubit() : super(0);

  int selectedIndex = 0;

  void selectGender(int index) {
    selectedIndex = index;
    emit(index);
  }
}
