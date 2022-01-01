import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_health_calculator/generated/l10n.dart';
import 'package:flutter_health_calculator/model/ResultModel.dart';
import 'package:flutter_health_calculator/model/RowItem.dart';
import 'package:flutter_health_calculator/utils/ConstantData.dart';
import 'package:flutter_health_calculator/utils/ConstantWidget.dart';
import 'package:flutter_health_calculator/utils/SizeConfig.dart';

class BodyFatResultPage extends StatefulWidget {
  final ResultModel resultModel;
  final RowItem rowItem;

  BodyFatResultPage(this.resultModel, this.rowItem);

  @override
  _BodyFatResultPage createState() {
    return _BodyFatResultPage();
  }
}

class _BodyFatResultPage extends State<BodyFatResultPage> {
  Color themeColor = ConstantData.primaryColor;
  RowItem rowItem;


  String desc = "desc";
  int colorPosition = 0;







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
    double sliderHeight = SizeConfig.safeBlockVertical * 12;

    double margin = ConstantWidget.getPercentSize(sliderHeight, 8);
    double defaultMargin = ConstantWidget.getScreenPercentSize(context, 2);



    double width = ConstantWidget.getScreenPercentSize(context, 12);
    double height = ConstantWidget.getScreenPercentSize(context, 8);
    double containerHeight = ConstantWidget.getScreenPercentSize(context, 8);



    return ListView(
      children: [
        SizedBox(
          height: (margin * 2),
        ),


        Container(
          margin: EdgeInsets.all(
              defaultMargin),
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
          margin: EdgeInsets.all(
              defaultMargin),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              ConstantWidget.getDefaultTextWidget(
                  widget.resultModel.value1,
                  TextAlign.center,
                  FontWeight.bold,
                  ConstantWidget.getWidthPercentSize(context, 7),
                  themeColor),
              ConstantWidget.getDefaultTextWidget(
                  "%",
                  TextAlign.center,
                  FontWeight.w400,
                  ConstantWidget.getWidthPercentSize(context, 5),
                  themeColor)
            ],
          ),
        ),


        Container(

          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ConstantWidget.getDefaultTextWidget(
                  S.of(context).assessment+"  ",
                  TextAlign.center,
                  FontWeight.w500,
                  ConstantWidget.getWidthPercentSize(context, 4),
                  ConstantData.textColor),
              ConstantWidget.getDefaultTextWidget(
                  widget.resultModel.value2,
                  TextAlign.center,
                  FontWeight.bold,
                  ConstantWidget.getWidthPercentSize(context, 4),
                  ConstantData.textColor)
            ],
          ),
        ),

        Container(
          margin: EdgeInsets.only(right:
          defaultMargin,left: defaultMargin,top:(defaultMargin+defaultMargin)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ConstantWidget.getDefaultTextWidget(
                  S.of(context).toStayHealthy,
                  TextAlign.center,
                  FontWeight.w400,
                  ConstantWidget.getWidthPercentSize(context, 4),
                  ConstantData.textColor),
              new Spacer()
            ],
          ),
        ),


        Container(
          margin: EdgeInsets.only(
              top: ConstantWidget.getWidthPercentSize(
                  context, 1.5)),
          padding: EdgeInsets.only(bottom: ConstantWidget.getScreenPercentSize(
              context, 0.2)),
          decoration: ConstantWidget.getDecoration(context, themeColor),

          child: Column(
            children: [

              getWidget(
                  S.of(context).category, S.of(context).women,S.of(context).men,true),

              Container(
                margin: EdgeInsets.symmetric(vertical: ConstantWidget.getScreenPercentSize(
                    context, 0.2),),
                height: ConstantWidget.getScreenPercentSize(
                    context, 0.2),
                color: themeColor,
              ),

              getWidget(
                  S.of(context).essentialOfFat, "10 - 13","2 - 5",false),


              getWidget(
                  S.of(context).typicalAthlete, "14 - 20","6 - 13",false),


              getWidget(
                  S.of(context).physicallyFit, "21 - 24","14 - 17",false),

              getWidget(
                  S.of(context).acceptable, "25 - 31","18 - 24",false),

              getWidget(
                  S.of(context).obese, "32% or more","25% or more",false),

            ],
          ),
        ),
      ],
    );
  }

  getWidget(String s, String s1, String s3,bool isBold) {
    double textSize = ConstantWidget.getScreenPercentSize(context, 1.5);

    Color color = themeColor;

    FontWeight f = (isBold) ? FontWeight.w800 : FontWeight.w400;

    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: ConstantWidget.getScreenPercentSize(context, 1)),
      margin: EdgeInsets.symmetric(
          vertical: ConstantWidget.getScreenPercentSize(context, 1)),
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
