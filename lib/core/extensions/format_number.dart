extension FormatNumber on double {
  String get formatNumber {
    final number = this;
    // Проверяем, является ли число целым
    if (number == number.toInt()) {
      return number.toInt().toString();
    } else {
      // Преобразуем число в строку с фиксированной точностью
      String numberString = number.toStringAsFixed(4);
      // Удаляем точку, если она является последним символом
      numberString = numberString.replaceAll(RegExp(r'\.$'), '');
      return numberString;
    }
  }
}
