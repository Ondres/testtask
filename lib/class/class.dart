class Point {
  int x;
  int y;

  Point({required this.x, required this.y});
}

class Data {
  String id;
  List<dynamic> field;
  List<int> start;
  List<int> end;
  List<int> blackpoints;
  List<int> path;
  int size;

  Data(
      {required this.path,
      required this.field,
      required this.start,
      required this.end,
      required this.id,
      required this.size,
      required this.blackpoints});

  void BlackP(List<dynamic> f) {
    String s = '';
    for (int i = 0; i < f.length; i++) s += f[i];

    for (int i = 0; i < s.length; i++) if (s[i] == 'X') blackpoints.add(i);
  }
}
