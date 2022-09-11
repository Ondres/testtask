import 'package:flutter/material.dart';
import 'package:savenko_test/domains/api_client/api_client.dart';
import 'package:savenko_test/domains/api_client/post.dart';
import 'package:savenko_test/results.dart';

import 'home.dart';

bool visible = false;

class ProcessScr extends StatefulWidget {
  const ProcessScr({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<ProcessScr> createState() => _ProcessScrState();
}

class _ProcessScrState extends State<ProcessScr> {
  int _counter = 0;
  late TextEditingController _controller;
  String email = '';

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
                child: Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Text(
                      'All calculations has finished, you can send '
                      ' your results to server',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.center,
                    ))),
            Center(
                child: Container(
                    child: Text(
              '100%',
              style: TextStyle(
                fontSize: 20,
              ),
            ))),
          ],
        ),
        bottomSheet: Visibility(
          visible: visible,
          child: Container(
              margin: EdgeInsets.fromLTRB(
                  MediaQuery.of(context).size.width * 0.025, 0, 0, 20),
              padding: EdgeInsets.all(0),
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.all(Radius.circular(15)),
                border: Border.all(color: Color.fromRGBO(0, 0, 0, 1), width: 2),
              ),
              width: MediaQuery.of(context).size.width * 0.95,
              height: 50,
              child: TextButton(
                  onPressed: () async {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        });

                    var answers = [];

                    for (int i = 0; i < results.length; i++) {
                      var steps = [];
                      for (int j = 0; j < alltasks[i].path.length; j++) {
                        steps.add({
                          'x': ((alltasks[i].path[j] - 1) % alltasks[i].size),
                          'y': ((alltasks[i].path[j] - 1) ~/ alltasks[i].size)
                        });
                      }
                      answers.add({
                        "id": alltasks[i].id,
                        "result": {"steps": steps, "path": results[i]}
                      });
                    }

                    try{
                         await ApiClientPost().createPost(url, answers);
                      }
                    catch(e){

                    }
                    Navigator.of(context).pop();

                    Navigator.pushNamed(context, '/2');
                  },
                  child: Text(
                    'Send Results to server',
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ))),
        ));
  }
}
