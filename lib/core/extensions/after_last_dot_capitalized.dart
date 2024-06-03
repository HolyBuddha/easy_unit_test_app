//Возвращаем значение строки после точки с заглавной буквы
extension AfterLastDotCapitalized on String {
  String get afterLastDotCapitalized {
    int lastDotIndex = lastIndexOf('.');

    if (lastDotIndex != -1 && lastDotIndex < length - 1) {
      String result = substring(lastDotIndex + 1);

      return result[0].toUpperCase() + result.substring(1);
    }

    return this[0].toUpperCase() + substring(1);
  }
}
