class DynamicScoring {
  String? name;
  int index = 0;
  int indexesPerPoint = 2;

  int getScore() {
    return (index / indexesPerPoint).floor();
  }
}
