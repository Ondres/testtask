import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiClientPost {
  Future<dynamic?> createPost(String text, List answers) async {
    var response = await http.post(Uri.parse(text),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          answers
        ));

    print(response.statusCode);
    return null;
  }
}
