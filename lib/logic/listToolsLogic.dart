
class ListToolsLogic{

  static String subtract(String A, String B) {
    final listA = A.split("\n");
    final listB = B.split("\n");

    final outputList = listA.where((element) => !listB.contains(element));
    return outputList.join('\n');
  }

  static String intersection(String A, String B) {
    final listA = A.split("\n");
    final listB = B.split("\n");

    final outputList = listA.toSet().intersection(listB.toSet());
    return outputList.join('\n');
  }

}