import 'dart:convert';
import 'dart:html' as html;

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:stringtools/utils.dart';


class SplitTools {

  String getSingleColumn(String text, String delimiter, int column) {
    var l = [];
    l = text.split("\n");
    var splittedRows = [for (var row in l) row.split(delimiter)];

    print(splittedRows);

    var output = "";

    splittedRows.forEach((element) {
      output += element[column-1];
      output += "\n";
    });

    return output;

  }

  getCsv(String text, String delimiter) {
    final newText = text.replaceAll(delimiter, ",").replaceAll("null", "");
    //
    // var excel = Excel.createExcel();
    // Sheet sheetObject = excel['SheetName'];

    writeAndDownload(newText);

  }

  writeAndDownload(String text) async {

    var blob = html.Blob([text], 'text/plain', 'native');

    html.AnchorElement(href: html.Url.createObjectUrlFromBlob(blob).toString())
      ..setAttribute("download", "${getRandString(10)}.csv")
      ..click();
  }

}