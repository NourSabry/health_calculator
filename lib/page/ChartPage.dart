import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_health_calculator/customWidget/photo_view.dart';
import 'package:flutter_health_calculator/model/RowItem.dart';
import 'package:flutter_health_calculator/utils/ConstantData.dart';
import 'package:flutter_health_calculator/utils/ConstantWidget.dart';
import 'package:flutter_health_calculator/utils/SizeConfig.dart';

class ChartPage extends StatefulWidget {
  final RowItem rowItem;

  ChartPage(this.rowItem);

  @override
  _ChartPage createState() {
    return _ChartPage();
  }
}

class _ChartPage extends State<ChartPage> {
  Color themeColor = ConstantData.primaryColor;
  RowItem rowItem;




  Future<bool> _requestPop() {
    Navigator.of(context).pop();
    return new Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    rowItem = widget.rowItem;
    themeColor = rowItem.color;
    SizeConfig().init(context);



      return ConstantWidget.getSubDefaultWidget(context, getWidget(), rowItem, _requestPop);


  }

  getWidget(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ConstantWidget.getDefaultTextWidget(
            widget.rowItem.resultDesc,
            TextAlign.center,
            FontWeight.bold,
            ConstantWidget.getWidthPercentSize(context, 3.5),
            ConstantData.textColor),
        Expanded(
          child: PhotoView(
            imageProvider: AssetImage(ConstantData.assetsPath+rowItem.pdf),
          ),
          flex: 1,
        )
      ],
    );
  }
}
