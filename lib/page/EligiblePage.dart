import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_health_calculator/generated/l10n.dart';
import 'package:flutter_health_calculator/model/RowItem.dart';
import 'package:flutter_health_calculator/utils/ConstantData.dart';
import 'package:flutter_health_calculator/utils/ConstantWidget.dart';
import 'package:flutter_health_calculator/utils/SizeConfig.dart';

class EligiblePage extends StatefulWidget {
  final RowItem rowItem;

  EligiblePage(this.rowItem);

  @override
  _EligiblePage createState() {
    return _EligiblePage();
  }
}

class _EligiblePage extends State<EligiblePage> {
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



    return ConstantWidget.getSubDefaultWidget(context, getMainWidget(), rowItem, _requestPop);

  }

  getMainWidget(){

    return ListView(
      children: [

        getWidget(S.of(context).el1, S.of(context).el2),
        getWidget(S.of(context).el3, S.of(context).el4),
        getWidget(S.of(context).el5, S.of(context).el6),
        getWidget(S.of(context).el8,S.of(context).el9),
        getWidget(S.of(context).el10,S.of(context).el11),
      ],
    );
  }
  getWidget(String s, String s1) {
    double textSize = ConstantWidget.getScreenPercentSize(context, 2);

    return Container(
      margin: EdgeInsets.symmetric(
          vertical: ConstantWidget.getScreenPercentSize(context, 1.5),horizontal:ConstantWidget.getScreenPercentSize(context, 0.5) ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ConstantWidget.getDefaultTextWidget(
              s, TextAlign.center, FontWeight.w800, textSize,  ConstantData.textColor),

          SizedBox(height: ConstantWidget.getScreenPercentSize(context, 1.5),),
          Container(
            height: ConstantWidget.getScreenPercentSize(context, 0.2),
            color: themeColor,
          ),
          SizedBox(height: ConstantWidget.getScreenPercentSize(context, 1.5),),

          ConstantWidget.getDefaultTextWidget(
              s1, TextAlign.start, FontWeight.w400, textSize,  ConstantData.textColor),

          // ConstantWidget.textOverFlowWidget(
          //     s1, FontWeight.w500, 3, textSize, themeColor),
        ],
      ),
    );
  }
}
