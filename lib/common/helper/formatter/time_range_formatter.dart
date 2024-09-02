import 'package:flutter/services.dart';

class LimitRangeTextInpitFormatter extends TextInputFormatter {
  final int min;
  final int max;

  LimitRangeTextInpitFormatter(
    this.min,
    this.max,
  );

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue;
    }

    final int enteredValue = int.parse(newValue.text);
    if (enteredValue >= min && enteredValue <= max) {
      return newValue;
    } else {
      return oldValue;
    }
  }
}
