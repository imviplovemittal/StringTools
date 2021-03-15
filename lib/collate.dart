import 'package:flutter/material.dart';

import 'components/appbar.dart';

class CollatePage extends StatefulWidget {
  @override
  _CollatePageState createState() => _CollatePageState();
}

class _CollatePageState extends State<CollatePage> {

  final inputTextController = TextEditingController();
  final delimiterTextController = TextEditingController();
  final outputTextController = TextEditingController();

  collateText() {
    final inputText = inputTextController.text;
    final delimiter = delimiterTextController.text;

    outputTextController.text = inputText.replaceAll("\n", delimiter);
  }

  @override
  void dispose() {
    inputTextController.dispose();
    delimiterTextController.dispose();
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Input", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),),
              ),
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
                            controller: delimiterTextController..text = ',',
                          ),
                        ),
                      ],
                      crossAxisAlignment: CrossAxisAlignment.center,
                    ),
                  ),
                  TextButton(
                    onPressed: collateText,
                    child: Text("Convert"),
                    style: TextButton.styleFrom(primary: Colors.white, onSurface: Colors.grey, backgroundColor: Colors.teal),
                  ),
                ],
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Output", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),),
              ),
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
