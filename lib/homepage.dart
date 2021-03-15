import 'dart:html';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:stringtools/logic/split.dart';

import 'components/appbar.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SplitTools st = SplitTools();

  final inputTextController = TextEditingController();
  final delimiterTextController = TextEditingController();
  final columnTextController = TextEditingController();
  final outputTextController = TextEditingController();

  getColumn() {
    int? column;
    try {
      column = int.parse(columnTextController.text);
    } on Exception catch (e) {
      print(e);
      BotToast.showSimpleNotification(title: "Column number is invalid");
    }
    if (column != null) {
      var output = st.getSingleColumn(inputTextController.text, delimiterTextController.text, column);
      outputTextController.text = output;
    } else if (delimiterTextController.text.trim() != "") {
      st.getCsv(inputTextController.text, delimiterTextController.text);
    } else {
      BotToast.showSimpleNotification(
          title: "Delimiter can not be empty",
          backgroundColor: Colors.red,
          titleStyle: TextStyle(
            color: Colors.white,
          ));
    }
  }

  @override
  void dispose() {
    inputTextController.dispose();
    delimiterTextController.dispose();
    columnTextController.dispose();
    outputTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    bool putPadding = width > height && width > 1080;

    return Scaffold(
      appBar: buildAppBar(context),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: putPadding ? (width * 0.2) : 40.0),
          child: Column(
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: 200,
                ),
                child: TextField(
                  controller: inputTextController,
                  maxLines: null,
                  decoration: InputDecoration(
                    hintText: "Enter your text here*",
                    border: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey, width: 1.0)),
                  ),
                ),
              ),
              Divider(),
              Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Text("Delimiter*"),
                        SizedBox(
                          width: 30,
                        ),
                        Container(
                          width: 30,
                          child: TextField(
                            controller: delimiterTextController,
                          ),
                        ),
                        SizedBox(
                          width: 60,
                        ),
                        Text("Column Number (optional)"),
                        SizedBox(
                          width: 30,
                        ),
                        Container(
                          width: 30,
                          child: TextField(
                            controller: columnTextController,
                          ),
                        ),
                      ],
                      crossAxisAlignment: CrossAxisAlignment.center,
                    ),
                  ),
                  TextButton(
                    onPressed: getColumn,
                    child: Text("Convert"),
                    style: TextButton.styleFrom(primary: Colors.white, onSurface: Colors.grey, backgroundColor: Colors.teal),
                  ),
                ],
              ),
              Divider(),
              Container(
                child: TextField(
                  controller: outputTextController,
                  maxLines: null,
                  decoration: InputDecoration(
                    hintText: "Output comes here",
                    border: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey, width: 1.0)),
                  ),
                ),
                height: 200,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
