import 'package:flutter/material.dart';

import 'components/appbar.dart';

class PrefixSuffixPage extends StatefulWidget {
  @override
  _PrefixSuffixPageState createState() => _PrefixSuffixPageState();
}

class _PrefixSuffixPageState extends State<PrefixSuffixPage> {
  final inputTextController = TextEditingController();
  final prefixTextController = TextEditingController();
  final suffixTextController = TextEditingController();
  final outputTextController = TextEditingController();

  addPrefix({String? prefixAuto, String? suffixAuto}) {
    final inputText = inputTextController.text;
    final prefix = prefixAuto ?? prefixTextController.text;
    final suffix = suffixAuto ?? suffixTextController.text;

    final outputString = inputText.split("\n").map((e) => "$prefix$e$suffix").join("\n");
    outputTextController.text = (prefixAuto == null) ? outputString : outputString.substring(0, outputString.length - 1);
  }

  sql() {
    addPrefix(prefixAuto: "'", suffixAuto: "',");
  }

  code() {
    addPrefix(prefixAuto: "\"", suffixAuto: "\",");
  }

  removePrefix() {
    final inputText = inputTextController.text;
    final prefix = prefixTextController.text;
    final suffix = suffixTextController.text;

    outputTextController.text = inputText.split("\n").map((e) => removeSinglePrefixSuffix(e, prefix, suffix)).join("\n");
  }

  String removeSinglePrefixSuffix(String s, String prefix, String suffix) {
    var output = s;
    if (s.startsWith(prefix)) {
      output = s.replaceFirst(prefix, "");
    }
    if (output.endsWith(suffix)) {
      output = output.substring(0, output.length - suffix.length);
    }
    return output;
  }

  @override
  void dispose() {
    inputTextController.dispose();
    prefixTextController.dispose();
    suffixTextController.dispose();
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
      drawer: customDrawer(height > width),
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
                  Text("Prefix"),
                  SizedBox(
                    width: 30,
                  ),
                  Expanded(
                    child: TextField(
                      controller: prefixTextController,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text("Suffix"),
                  SizedBox(
                    width: 30,
                  ),
                  Expanded(
                    child: TextField(
                      controller: suffixTextController,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: addPrefix,
                      child: Text("Add"),
                      style: TextButton.styleFrom(primary: Colors.white, onSurface: Colors.grey, backgroundColor: Colors.teal),
                    ),
                    TextButton(
                      onPressed: removePrefix,
                      child: Text("Remove"),
                      style: TextButton.styleFrom(primary: Colors.white, onSurface: Colors.grey, backgroundColor: Colors.teal),
                    ),
                    TextButton(
                      onPressed: sql,
                      child: Text("Sql String"),
                      style: TextButton.styleFrom(primary: Colors.white, onSurface: Colors.grey, backgroundColor: Colors.teal),
                    ),
                    TextButton(
                      onPressed: code,
                      child: Text("Code String"),
                      style: TextButton.styleFrom(primary: Colors.white, onSurface: Colors.grey, backgroundColor: Colors.teal),
                    ),
                  ],
                ),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Output",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
                ),
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
