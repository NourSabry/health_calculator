import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_health_calculator/generated/l10n.dart';
import 'package:flutter_health_calculator/model/ResultModel.dart';
import 'package:flutter_health_calculator/model/RowItem.dart';
import 'package:flutter_health_calculator/page/UnderstandBMIPage.dart';
import 'package:flutter_health_calculator/utils/ConstantData.dart';
import 'package:flutter_health_calculator/utils/ConstantWidget.dart';
import 'package:flutter_health_calculator/utils/SizeConfig.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class BodyMassResultPage extends StatefulWidget {
  final ResultModel resultModel;
  final RowItem rowItem;

  BodyMassResultPage(this.resultModel, this.rowItem);

  @override
  _BodyMassResultPage createState() {
    return _BodyMassResultPage();
  }
}

class _BodyMassResultPage extends State<BodyMassResultPage> {
  Color themeColor = ConstantData.primaryColor;
  RowItem rowItem;
  double myNum = 0;

  int num = 0;
  String desc = "desc";
  int colorPosition = 0;



  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      setData();
    });
  }

  setData() {
    String data = widget.resultModel.value1;
    if (ConstantData.check(data)) {
      myNum = double.parse(data);
      num = myNum.toInt();

      print("num----12--" + num.toString());

      if (num < 16) {
        num = 1;

        desc = "Extremely under weight";

        colorPosition = 1;
      } else if (this.num > 40) {
        num = 100;
        desc = S.of(context).morbidObese;
        colorPosition = 7;
      } else {
        if (myNum >= 16.0 && this.myNum <= 18.5) {
          desc = S.of(context).underWeight;
          colorPosition = 2;
        } else if (this.myNum > 18.5 && this.myNum <= 25.0) {
          desc = S.of(context).normalWeight;

          colorPosition = 3;
        } else if (this.myNum > 25.0 && this.myNum <= 30.0) {
          desc = S.of(context).overWeight;

          colorPosition = 4;
        } else if (this.myNum > 30.0 && this.myNum <= 35.0) {
          desc = S.of(context).obeseClassOne;
          colorPosition = 5;
        } else if (this.myNum > 35.0 && this.myNum <= 40.0) {
          desc = S.of(context).obeseClassTwo;
          colorPosition = 6;
        } else if (this.myNum < 16.0) {
          desc = S.of(context).extremelyUnderWeight;

          colorPosition = 1;
        } else if (this.myNum > 40.0) {
          desc = S.of(context).morbidObese;
          colorPosition = 7;
        }

        num -= 15;
        num *= 4;

      }



      print("num----12----$num");
    }

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

    print("countDownPercent----" + num.toString());



    return ConstantWidget.getMainDefaultWidget(context, getMainWidget(), rowItem, _requestPop);


  }

  getMainWidget (){


    double buttonHeight = ConstantWidget.getScreenPercentSize(context, 6);

    double subRadius = ConstantWidget.getWidthPercentSize(context, 1.5);
    double fontSize = ConstantWidget.getPercentSize(buttonHeight, 32);

    double width = ConstantWidget.getScreenPercentSize(context, 12);
    double height = ConstantWidget.getScreenPercentSize(context, 8);
    double containerHeight = ConstantWidget.getScreenPercentSize(context, 10);


    return ListView(
      children: [

        ConstantWidget.getDefaultTextWidget(
            desc,
            TextAlign.center,
            FontWeight.w700,
            ConstantWidget.getWidthPercentSize(context, 5),
            themeColor),
        Container(
          margin: EdgeInsets.all(
              ConstantWidget.getScreenPercentSize(context, 2)),
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
              ConstantWidget.getScreenPercentSize(context, 2)),
          child: ConstantWidget.getDefaultTextWidget(
              widget.resultModel.value1,
              TextAlign.center,
              FontWeight.bold,
              ConstantWidget.getWidthPercentSize(context, 7),
              themeColor),
        ),


        Container(
          margin: EdgeInsets.all(
              ConstantWidget.getScreenPercentSize(context, 2)),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal:
                    ConstantWidget.getWidthPercentSize(
                        context, 10)),

                child: StepProgressIndicator(
                  totalSteps: 100,
                  currentStep: num,
                  // currentStep: double.parse(widget.resultModel.value1).round(),
                  size: ConstantWidget.getScreenPercentSize(
                      context, 5),
                  padding: 0,
                  selectedColor: Colors.yellow,
                  unselectedColor: Colors.cyan,
                  roundedEdges: Radius.circular(
                      ConstantWidget.getScreenPercentSize(
                          context, 1)),
                  selectedGradientColor: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      themeColor,
                      themeColor.withOpacity(0.8)
                    ],
                  ),
                  unselectedGradientColor: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.black87.withOpacity(0.8),
                      Colors.grey
                    ],
                  ),
                ),

              ),
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal:
                    ConstantWidget.getWidthPercentSize(
                        context, 4)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    getText("-16"),
                    getText("20"),
                    getText("25"),
                    getText("30"),
                    getText("35"),
                    getText("40+"),
                  ],
                ),
              )
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(
              left: ConstantWidget.getWidthPercentSize(
                  context, 2.5),
              right: ConstantWidget.getWidthPercentSize(
                  context, 2.5),
              top: ConstantWidget.getWidthPercentSize(
                  context, 1.5)),

          decoration: ConstantWidget.getDecoration(context, themeColor),
          child: Column(
            children: [
              getWidget(
                  "16-", S.of(context).extremelyUnderWeight, 1),
              getWidget(
                  "16 – 18.5", S.of(context).underWeight, 2),
              getWidget(
                  "18.6 – 25", S.of(context).normalWeight, 3),
              getWidget(
                  "25.1 – 30", S.of(context).overWeight, 4),
              getWidget(
                  "30.1 – 35", S.of(context).obeseClassOne, 5),
              getWidget(
                  "35.1 – 40", S.of(context).obeseClassTwo, 6),
              getWidget("40+", S.of(context).morbidObese, 7),
            ],
          ),
        ),
        InkWell(
          child: Container(
            margin: EdgeInsets.only(
                left: ConstantWidget.getWidthPercentSize(
                    context, 2.5),
                right: ConstantWidget.getWidthPercentSize(
                    context, 2.5),
                top: ConstantWidget.getWidthPercentSize(
                    context, 4)),
            height: buttonHeight,
            decoration: BoxDecoration(
                color: themeColor,
                borderRadius: BorderRadius.all(
                    Radius.circular(subRadius))),
            child: Center(
              child: ConstantWidget.getDefaultTextWidget(
                  S.of(context).understandYourBmiResult,
                  TextAlign.center,
                  FontWeight.w500,
                  fontSize,
                  Colors.white),
            ),
          ),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      UnderstandBMIPage(rowItem),
                ));
          },
        )
      ],
    );
  }

  getWidget(String s, String s1, int position) {
    double textSize = ConstantWidget.getScreenPercentSize(context, 1.5);

    Color color =
        (position == colorPosition) ? themeColor : ConstantData.textColor;

    return Container(
      margin: EdgeInsets.symmetric(
          vertical: ConstantWidget.getScreenPercentSize(context, 0.5)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: ConstantWidget.getDefaultTextWidget(
                s, TextAlign.center, FontWeight.w500, textSize, color),
            flex: 1,
          ),
          Expanded(
            child: ConstantWidget.textOverFlowWidget(
                s1, FontWeight.w500, 1, textSize, color),
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
