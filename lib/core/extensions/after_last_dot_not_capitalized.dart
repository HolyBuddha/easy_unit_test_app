extension AfterLastDotNotCapitalized on String {
  String get afterLastNotDotCapitalized {
    int lastDotIndex = lastIndexOf('.');

    if (lastDotIndex != -1 && lastDotIndex < length - 1) {
      String result = substring(lastDotIndex + 1);

      return result[0].toLowerCase() + result.substring(1);
    }

    return this[0].toLowerCase() + substring(1);
  }
}