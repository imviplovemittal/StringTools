import 'package:flutter/material.dart';

import 'components/appbar.dart';
import 'logic/listToolsLogic.dart';

class ListToolsPage extends StatefulWidget {
  @override
  _ListToolsPageState createState() => _ListToolsPageState();
}

class _ListToolsPageState extends State<ListToolsPage> {
  final inputATextController = TextEditingController();
  final inputBTextController = TextEditingController();
  final outputTextController = TextEditingController();

  aMinusB() {
    final inputTextA = inputATextController.text;
    final inputTextB = inputBTextController.text;

    outputTextController.text = ListToolsLogic.subtract(inputTextA, inputTextB);
  }

  bMinusA() {
    final inputTextA = inputATextController.text;
    final inputTextB = inputBTextController.text;

    outputTextController.text = ListToolsLogic.subtract(inputTextB, inputTextA);
  }

  intersectLists() {
    final inputTextA = inputATextController.text;
    final inputTextB = inputBTextController.text;

    outputTextController.text = ListToolsLogic.intersection(inputTextB, inputTextA);
  }

  removeDuplicates() {
    outputTextController.text = outputTextController.text.split("\n").toSet().join("\n");
  }

  sortOutput() {
    var input = outputTextController.text.split("\n");
    input.sort();
    outputTextController.text = input.join("\n");
  }

  @override
  void dispose() {
    inputATextController.dispose();
    inputBTextController.dispose();
    outputTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    bool putPadding = width > height && width > 1080;

    return Scaffold(
      appBar: buildAppBar(context, pageName: "List Tools"),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: putPadding ? (width * 0.2) : 40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Input",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: 200,
                      maxWidth: putPadding ? width * 0.7 : width,
                    ),
                    child: FractionallySizedBox(
                      widthFactor: 0.4,
                      child: TextField(
                        controller: inputATextController,
                        maxLines: null,
                        decoration: InputDecoration(
                          hintText: "List A, Eg:\n1\n2\n3",
                          border: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey, width: 1.0)),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 20,),
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: 200,
                      maxWidth: putPadding ? width * 0.7 : width,
                    ),
                    child: FractionallySizedBox(
                      widthFactor: 0.4,
                      child: TextField(
                        controller: inputBTextController,
                        maxLines: null,
                        decoration: InputDecoration(
                          hintText: "List B, Eg:\n1\n2\n3",
                          border: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey, width: 1.0)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: aMinusB,
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Text("A - B"),
                    ),
                    style: TextButton.styleFrom(primary: Colors.white, onSurface: Colors.grey, backgroundColor: Colors.teal),
                  ),
                  TextButton(
                    onPressed: bMinusA,
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Text("B - A"),
                    ),
                    style: TextButton.styleFrom(primary: Colors.white, onSurface: Colors.grey, backgroundColor: Colors.teal),
                  ),
                  TextButton(
                    onPressed: intersectLists,
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Text("A intersection B"),
                    ),
                    style: TextButton.styleFrom(primary: Colors.white, onSurface: Colors.grey, backgroundColor: Colors.teal),
                  ),
                ],
              ),
              Divider(),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Output",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton(
                      onPressed: removeDuplicates,
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Text("Remove duplicates"),
                      ),
                      style: TextButton.styleFrom(primary: Colors.white, onSurface: Colors.grey, backgroundColor: Colors.teal),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton(
                      onPressed: sortOutput,
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Text("Sort"),
                      ),
                      style: TextButton.styleFrom(primary: Colors.white, onSurface: Colors.grey, backgroundColor: Colors.teal),
                    ),
                  ),
                ],
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
