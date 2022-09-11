import 'package:flutter/material.dart';
import 'package:savenko_test/results.dart';
import 'package:savenko_test/screens/resultlist.dart';

import '../domains/api_client/api_client.dart';

class PreviewScr extends StatefulWidget {
  const PreviewScr({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<PreviewScr> createState() => _PreviewScrState();
}

class _PreviewScrState extends State<PreviewScr> {
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
    ScrollController _scrollController = new ScrollController();
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.9,
            child: GridView.builder(
                itemCount: alltasks[m].size * alltasks[m].size,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: alltasks[m].size,
                ),
                itemBuilder: (context, index) {
                  var str = results[m].split('->');
                  return Container(
                      decoration: BoxDecoration(
                        color: '(' + (index - alltasks[m].size * (index ~/ alltasks[m].size))
                                        .toString() +',' +
                                    (index ~/ alltasks[m].size).toString() +
                                    ')' == str[0] ? Color.fromRGBO(100, 255, 218, 1)  : '(' +
                                        (index - alltasks[m].size * (index ~/ alltasks[m].size)).toString()+
                                        ',' + (index ~/ alltasks[m].size).toString() +
                                        ')' == str[str.length - 1]
                                ? Color.fromRGBO(0, 150, 136, 1)
                                : results[m].contains('(' +
                                        (index - alltasks[m].size * (index ~/ alltasks[m].size)).toString() +',' +
                                        (index ~/ alltasks[m].size).toString() +')')
                                    ? Color.fromRGBO(76, 175, 80, 1)
                                    : alltasks[m].blackpoints.contains(index)
                                        ? Colors.black
                                        : Colors.white,
                        //   borderRadius: BorderRadius.all(Radius.circular(15)),
                        border: Border.all(
                            color: Color.fromRGBO(0, 0, 0, 1), width: 1),
                      ),
                      child: Center(
                        child: Text(
                          '(' +(index - alltasks[m].size *(index ~/ alltasks[m].size)).toString() +
                              ',' +(index ~/ alltasks[m].size).toString() +')',
                          style: TextStyle(
                            color: alltasks[m].blackpoints.contains(index)
                                ? Colors.white
                                : Colors.black,
                            fontSize: 18,
                          ),
                        ),
                      ));
                })));
  }
}
