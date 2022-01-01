import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_health_calculator/generated/l10n.dart';
import 'package:flutter_health_calculator/model/ResultModel.dart';
import 'package:flutter_health_calculator/model/RowItem.dart';
import 'package:flutter_health_calculator/utils/ConstantData.dart';
import 'package:flutter_health_calculator/utils/ConstantWidget.dart';
import 'package:flutter_health_calculator/utils/SizeConfig.dart';

class WaterIntakeResultPage extends StatefulWidget {
  final ResultModel resultModel;
  final RowItem rowItem;

  WaterIntakeResultPage(this.resultModel, this.rowItem);

  @override
  _WaterIntakeResultPage createState() {
    return _WaterIntakeResultPage();
  }
}

class _WaterIntakeResultPage extends State<WaterIntakeResultPage> {
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

    return ConstantWidget.getSubDefaultWidget(
        context, getMainWidget(), rowItem, _requestPop);
  }

  getMainWidget() {
    double defaultMargin = ConstantWidget.getScreenPercentSize(context, 2);

    double width = ConstantWidget.getScreenPercentSize(context, 12);
    double height = ConstantWidget.getScreenPercentSize(context, 8);
    double containerHeight = ConstantWidget.getScreenPercentSize(context, 8);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.all(defaultMargin),
          alignment: Alignment.center,
          child: Wrap(
            children: [
              Container(
                color: themeColor,
                height: containerHeight,
                width: containerHeight,
                padding: EdgeInsets.all(ConstantWidget.getPercentSize(containerHeight, 20)),

                child: Center(
                  child: Image.asset(
                    ConstantData.assetsPath + rowItem.image,
                    color: Colors.white,
                    height: height,
                    width: width,
                  ),
                ),
              )
            ],
          ),
        ),
        ConstantWidget.getDefaultTextWidget(
            widget.rowItem.resultText,
            TextAlign.center,
            FontWeight.w400,
            ConstantWidget.getWidthPercentSize(context, 3.8),
            ConstantData.textColor),
        Container(
          margin: EdgeInsets.all(defaultMargin),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ConstantWidget.getDefaultTextWidget(
                  widget.resultModel.value1,
                  TextAlign.center,
                  FontWeight.bold,
                  ConstantWidget.getWidthPercentSize(context, 7),
                  themeColor),
              ConstantWidget.getDefaultTextWidget(
                  S.of(context).glasses,
                  TextAlign.center,
                  FontWeight.w400,
                  ConstantWidget.getWidthPercentSize(context, 4),
                  themeColor)
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(
              left: defaultMargin,
              right: defaultMargin,
              top: ConstantWidget.getWidthPercentSize(context, 1.5)),
          padding:
              EdgeInsets.all(ConstantWidget.getScreenPercentSize(context, 1.5)),
          decoration: ConstantWidget.getDecoration(context, themeColor),
          child: ConstantWidget.getDefaultTextWidget(
              S.of(context).take23GlassesOfWaterAdditionallyIfYouExercise,
              TextAlign.center,
              FontWeight.w400,
              ConstantWidget.getWidthPercentSize(context, 4),
              ConstantData.textColor),
        ),
      ],
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
    double textSize = ConstantWidget.getScreenPercentSize(context, 1.5);

    return Expanded(
      child: ConstantWidget.getDefaultTextWidget(s, TextAlign.center,
          FontWeight.w500, textSize, ConstantData.textColor),
      flex: 1,
    );
  }
}
