import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:http/http.dart';
import 'package:savenko_test/screens/process.dart';
import 'package:vector_math/vector_math.dart';
import '../../class/class.dart';
import '../../results.dart';

int sizem = 0;
int n = 0;
var twoDList = [];
final params = [];
final alltasks = <Data>[
  // Data(field: [''], start: [1,2], end: [2,3], id: '')
];

class ApiClient {
  final client = HttpClient();

  var http;

  Future<int> getPost(String text) async {
    final response = await get(Uri.parse(text));
    if (response.statusCode == 200) {
      int i = alltasks.length;
      List<dynamic> ns = jsonDecode(response.body)['data'];
      for (i; i < ns.length; i++) {
        int x1 = jsonDecode(response.body)['data'][i]['start']['x'];
        int y1 = jsonDecode(response.body)['data'][i]['start']['y'];
        int x2 = jsonDecode(response.body)['data'][i]['end']['x'];
        int y2 = jsonDecode(response.body)['data'][i]['end']['y'];
        alltasks.add(Data(
            path: [],
            blackpoints: [],
            size: 0,
            field: jsonDecode(response.body)['data'][i]['field'],
            start: [x1, y1],
            end: [x2, y2],
            id: jsonDecode(response.body)['data'][i]['id']));

        alltasks[i].size = alltasks[i].field.length;
        alltasks[i].BlackP(alltasks[i].field);
        sizem = alltasks[i].field.length;
        results.add('');
        List l =
            List.filled(alltasks[i].size, List.filled(alltasks[i].size, 0));
        List<int> nullable = [];
        for (int i = 0; i < l.length * l.length; i++) nullable.add(0);

        l = shortest(l.length);
        for (int i1 = 0; i1 < l.length; i1++) {
          for (int j1 = 0; j1 < l.length; j1++) {
            if (alltasks[i].blackpoints.contains(j1)) {
              l[i1][j1] = 0;
              l[j1] = nullable;
            }
          }
        }

        alltasks[i].path =
            Smallbfs(l as List<List<int>>, x1, y1, x2, y2, alltasks[i].size);
        List<int> path = alltasks[i].path;
        for (int i1 = 0; i1 < path.length; i1++) {
          if (i1 != 0)
            results[i] += ('->(' +
                ((path[i1] - 1) % alltasks[i].size).toString() +
                ',' +
                ((path[i1] - 1) ~/ alltasks[i].size).toString() +
                ')');
          else
            results[i] += ('(' +
                ((path[i1] - 1) % alltasks[i].size).toString() +
                ',' +
                ((path[i1] - 1) ~/ alltasks[i].size).toString() +
                ')');
        }

        params.add(<String, dynamic>{
          "id": alltasks[i].id,
          "result": {
            //  "steps": path,
            "path": results[i]
          }
        });
      }

      visible = true;
      return (response.statusCode);
    } else {
      return (response.statusCode);
    }
  }
}

List<List<int>> shortest(int size) {
  int i = 0;

  List<List<int>> twoDList = [];
  List<int> mas = [];
  for (int l = 0; l < size * size; l++) {
    mas.add(0);
  }
  for (int l = 0; l < size * size; l++) {
    twoDList.add(mas);
  }

  for (int j = 0; j < size * size; j++) {
    twoDList[j] = Func(size, j, i);
    i++;
  }
  return twoDList;
}

List<int> Func(int size, int j, int i) {
  List<List<int>> twoDList = [];
  List<int> mas = [];
  for (int l = 0; l < size * size; l++) {
    mas.add(0);
  }

  for (int l = 0; l < size * size; l++) {
    twoDList.add(mas);
  }

  if ((j + 1) % size != 0) twoDList[i][j + 1] = 1;

  if (i + 1 < size * size && j + size < size * size) twoDList[i][j + size] = 1;

  if (i + 1 < size * size && (j + 1) % size != 0 && j + size + 1 < size * size)
    twoDList[i][j + size + 1] = 1;

  if (i - 1 >= 0 && j - size >= 0) twoDList[i][j - size] = 1;

  if (j % size != 0) twoDList[i][j - 1] = 1;

  if (i - 1 >= 0 && j % size != 0 && j - size - 1 >= 0)
    twoDList[i][j - size - 1] = 1;

  if (j % size != 0 && i + 1 < size * size && j + size - 1 < size * size)
    twoDList[i][j + size - 1] = 1;

  if (i - 1 >= 0 && (j + 1) % size != 0 && j - size + 1 >= 0)
    twoDList[i][j - size + 1] = 1;

  return twoDList[i];
}

List<int> Smallbfs(
    List<List<int>> ld, int x1, int x2, int y1, int y2, int len) {
  int end = len * x1 + y1;
  int start = len * x2 + y2;

  int n = ld.length, m, start_v = start + 1, end_v = end + 1;

  List<List<int>> g = [];
  List<List<int>> g1 = [
    [],
  ];
  List<int> empty = [];
  List<List<int>> min_way = [];
  for (int i = 0; i <= ld.length; i++) {
    min_way.add([]);
  }
  for (int i = 0; i < ld.length; i++) {
    g.add([]);
    for (int j = 0; j < ld.length; j++) {
      if (ld[i][j] == 1) g[0].add(j + 1);
    }
    //    print(g[0]);
    g1.add(g[0]);
    g[0] = [];
  }
  g = g1;
  min_way[start_v].add(start_v);
  List<int> q = [];
  q.add(start_v);
  while (!q.isEmpty) {
    int v = q.first;
    q.removeAt(0);
    for (int it in g[v]) {
      if ((min_way[it].length > min_way[v].length + 1) ||
          min_way[it].length == 0) {
        q.add(it);
        for (int vertex in min_way[v]) {
          min_way[it].add(vertex);
        }
        min_way[it].add(it);
      }
    }
  }
  List<int> path = [];
  for (int it in min_way[end_v]) {
    path.add(it);
  }
  return path;
}
