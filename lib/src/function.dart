class Add {
  final int value1;
  final int value2;

  Add({required this.value1, required this.value2});

  int addValue(){
    int result = value1 + value2;
    return result;
  }
}