import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_health_calculator/generated/l10n.dart';
import 'package:flutter_health_calculator/model/RowItem.dart';
import 'package:flutter_health_calculator/page/ChartPage.dart';
import 'package:flutter_health_calculator/utils/ConstantData.dart';
import 'package:flutter_health_calculator/utils/ConstantWidget.dart';
import 'package:flutter_health_calculator/utils/SizeConfig.dart';

class CanDonatePage extends StatefulWidget {
  final RowItem rowItem;

  CanDonatePage(this.rowItem);

  @override
  _CanDonatePage createState() {
    return _CanDonatePage();
  }
}

class _CanDonatePage extends State<CanDonatePage> {
  Color themeColor = ConstantData.primaryColor;
  RowItem rowItem;


  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      setData();
    });
  }

  setData() {
    setState(() {});
  }

  Future<bool> _requestPop() {
    Navigator.of(context).pop();
    return new Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    rowItem = widget.rowItem;
    themeColor = rowItem.color;
    SizeConfig().init(context);

    return ConstantWidget.getMainDefaultWidget(context, getMainWidget(), rowItem, _requestPop);

  }

  getMainWidget(){
    return ListView(
      children: [

        getWidget(S.of(context).donate1),

        ConstantWidget.getButton(context,
            S.of(context).bloodVolumeChart, themeColor, () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChartPage(
                        rowItem),
                  ));
            }),




      ],
    );
  }

  getWidget(String s) {
    double textSize = ConstantWidget.getScreenPercentSize(context, 2);

    return Container(
      margin: EdgeInsets.symmetric(
          vertical: ConstantWidget.getScreenPercentSize(context, 1.5),horizontal:ConstantWidget.getScreenPercentSize(context, 0.5) ),
      child: ConstantWidget.getDefaultTextWidget(
          s, TextAlign.start, FontWeight.w800, textSize,  ConstantData.textColor),
    );
  }
}
