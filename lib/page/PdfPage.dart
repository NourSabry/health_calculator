import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_health_calculator/model/RowItem.dart';
import 'package:flutter_health_calculator/utils/ConstantData.dart';
import 'package:flutter_health_calculator/utils/ConstantWidget.dart';
import 'package:flutter_health_calculator/utils/SizeConfig.dart';
import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';
import 'package:path_provider/path_provider.dart';

class PdfPage extends StatefulWidget {
  final String pdfName;
  final RowItem rowItem;

  PdfPage(this.pdfName, this.rowItem);

  @override
  _PdfPage createState() {
    return _PdfPage();
  }
}

class _PdfPage extends State<PdfPage> {
  Color themeColor = ConstantData.primaryColor;
  RowItem rowItem;

  int colorPosition = 0;
  String pathPDF = "";
  bool _isLoading = true;
  PDFDocument doc;

  void _loadFromAssets() async {
    setState(() {
      _isLoading = true;
    });
    doc = await PDFDocument.fromAsset(ConstantData.pdfPath + widget.pdfName);


    print("page---${widget.pdfName}");
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();

    _loadFromAssets();
    // fromAsset(ConstantData.pdfPath + widget.pdfName, widget.pdfName).then((f) {
    //   setState(() {
    //     pathPDF = f.path;
    //     print("pathPDF-2--${pathPDF}");
    //   });
    // });
  }

  Future<bool> _requestPop() {
    Navigator.of(context).pop();
    return new Future.value(true);
  }

  Future<File> fromAsset(String asset, String filename) async {
    // To open from assets, you can copy them to the app storage folder, and the access them "locally"
    Completer<File> completer = Completer();

    try {
      var dir = await getApplicationDocumentsDirectory();
      File file = File("${dir.path}/$filename");
      var data = await rootBundle.load(asset);
      var bytes = data.buffer.asUint8List();
      await file.writeAsBytes(bytes, flush: true);
      completer.complete(file);
    } catch (e) {
      throw Exception('Error parsing asset file!');
    }

    return completer.future;
  }

  @override
  Widget build(BuildContext context) {
    rowItem = widget.rowItem;
    themeColor = rowItem.color;
    SizeConfig().init(context);


    return ConstantWidget.getSubDefaultWidget(context, getMainWidget(), rowItem, _requestPop);

  }

  getMainWidget(){
    return Center(
      child:
      _isLoading
          ? CircularProgressIndicator()
          : PDFViewer(
        document: doc,
      ),
    );
  }

  getWidget(String s, String s1, String s3, bool isBold) {
    double textSize = ConstantWidget.getScreenPercentSize(context, 1.8);

    Color color = themeColor;

    FontWeight f = (isBold) ? FontWeight.w800 : FontWeight.w400;

    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: ConstantWidget.getScreenPercentSize(context, 1)),
      margin: EdgeInsets.symmetric(
          vertical: ConstantWidget.getScreenPercentSize(context, 2)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Center(
              child: ConstantWidget.textOverFlowWidget(
                  s, FontWeight.w800, 1, textSize, color),
            ),
            flex: 1,
          ),
          Expanded(
            child: Center(
              child:
                  ConstantWidget.textOverFlowWidget(s1, f, 1, textSize, color),
            ),
            // child: ConstantWidget.textOverFlowWidget(
            //     s1, FontWeight.w500, 1,textSize, color),
            flex: 1,
          ),
          Expanded(
            child: Center(
              child:
                  ConstantWidget.textOverFlowWidget(s3, f, 1, textSize, color),
            ),
            flex: 1,
          )
        ],
      ),
    );
  }

  getText(String s) {
    // double textHeight = ConstantWidget.getScreenPercentSize(context, 3);
    double textSize = ConstantWidget.getScreenPercentSize(context, 1.5);

    return Expanded(
      child: ConstantWidget.getDefaultTextWidget(s, TextAlign.center,
          FontWeight.w500, textSize, ConstantData.textColor),
      flex: 1,
    );
  }
}
