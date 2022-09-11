//import 'dart:js';

import 'package:flutter/material.dart';

//import 'package:fluttertoast/fluttertoast.dart';
import 'package:savenko_test/domains/api_client/api_client.dart';

String url = 'https://flutter.webspark.dev/flutter/api';
bool next = false;

class HomeScr extends StatefulWidget {
  const HomeScr({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomeScr> createState() => _HomeScrState();
}

class _HomeScrState extends State<HomeScr> {
  late TextEditingController _controller;
  String email = 'https://flutter.webspark.dev/flutter/api';

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
        //  mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.fromLTRB(10, 20, 0, 0),
              child: Text(
                'Set valid API base url in order to continue',
                style: TextStyle(
                  fontSize: 16,
                ),
              )),
          Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.fromLTRB(10, 20, 0, 0),
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 20),
                    child: Icon(Icons.compare_arrows,
                        color: Colors.black, size: 25),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: TextField(
                      controller: _controller,
                      onChanged: (String value) {
                        setState(() {
                          url = value;
                        });
                      },
                      style: TextStyle(color: Colors.black, fontSize: 16),
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 1,
                            style: BorderStyle.solid,
                          ),
                        ),
                        enabled: true,
                      ),
                    ),
                  ),
                ],
              )),
        ],
      ),
      bottomSheet: Container(
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
                setState(() {
                  next = true;
                });
                await AddAndCount(url, context);
               // Navigator.of(context).pop();
                if(next)
                Navigator.pushNamed(context, '/1');

              },
              child: Text(
                'Start counting process',
                style: TextStyle(fontSize: 16, color: Colors.black),
              ))),
    );
  }

  Future<int> AddAndCount(String text, BuildContext context) async {
    showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: CircularProgressIndicator(),
          );
        });

    try {
      await ApiClient().getPost(text);
    } catch (e) {
      if(ApiClient().getPost(text)!=200)
      setState(() {
        next = false;
      });
    }

    Navigator.of(context).pop();
    return 0;
  }
}
