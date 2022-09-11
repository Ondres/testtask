import 'package:flutter/material.dart';
import 'package:savenko_test/results.dart';


int m=0;


class ResultsScr extends StatefulWidget {
  const ResultsScr({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<ResultsScr> createState() => _ResultsScrState();
}

class _ResultsScrState extends State<ResultsScr> {
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
      body:
      Container(
        width: MediaQuery.of(context).size.width,
    height:  MediaQuery.of(context).size.height*0.9,
    child: ListView.builder(

    controller: _scrollController,
    itemCount: results.length,
    itemBuilder: (_, index) {
      return Container(
        margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
          width: MediaQuery.of(context).size.width,
          child: TextButton(
              onPressed: (){
                setState(() {
                  m = index;
                });
                Navigator.pushNamed(context, '/3');
              },
              child:
          Center(child:
          Text(results[index], style: TextStyle(
            fontSize: 22,
            color: Colors.black
          ),)
      )));
    }))

    );
  }
}
