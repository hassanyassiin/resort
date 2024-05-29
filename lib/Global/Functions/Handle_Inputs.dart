import 'dart:math';

var numbers = ['One', 'Two', 'Three', 'Four', 'Five', 'Six', 'Seven'];

String Format_Double(double value) {
  if (value == value.toInt().toDouble()) {
    return value.toInt().toString();
  } else {
    return value.toStringAsFixed(2);
  }
}

String Generate_32_Random_Numbers() {
  var random = Random();

  String number = '';
  for (var i = 0; i < 10; i++) {
    number += random.nextInt(100).toString();
  }

  return number;
}

String Covert_Date_To_Local({required String date}) {
  return DateTime.parse(date).toLocal().toString();
}
