import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_health_calculator/generated/l10n.dart';
import 'package:flutter_health_calculator/model/ResultModel.dart';
import 'package:flutter_health_calculator/model/RowItem.dart';
import 'package:flutter_health_calculator/utils/ConstantData.dart';
import 'package:flutter_health_calculator/utils/ConstantWidget.dart';
import 'package:flutter_health_calculator/utils/SizeConfig.dart';

class HeartRateResultPage extends StatefulWidget {
  final ResultModel resultModel;
  final RowItem rowItem;

  HeartRateResultPage(this.resultModel, this.rowItem);

  @override
  _HeartRateResultPage createState() {
    return _HeartRateResultPage();
  }
}

class _HeartRateResultPage extends State<HeartRateResultPage> {
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

      return ConstantWidget.getSubDefaultWidget(context, getMainWidget(), rowItem, _requestPop);

  }

  getMainWidget(){

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

        getWidget(widget.rowItem.resultText,
            widget.resultModel.value1),
        getWidget(
            "Your training heart rate is",
            (widget.resultModel.value2 +
                " - " +
                widget.resultModel.value3)),


      ],
    );
  }

  getWidget(String s, String s1) {
    double defaultMargin = ConstantWidget.getScreenPercentSize(context, 4);

    return Column(
      children: [

        SizedBox(height: defaultMargin,),


        ConstantWidget.textOverFlowWidget(
            s,

            FontWeight.w400,1,
            ConstantWidget.getWidthPercentSize(context, 3.8),
            ConstantData.textColor),

        SizedBox(height: (defaultMargin/2),),



        ConstantWidget.textOverFlowWidget(
            s1,
            FontWeight.bold,1,
            ConstantWidget.getWidthPercentSize(context, 5),
            themeColor),

        ConstantWidget.textOverFlowWidget(
            S.of(context).beatsminute,
            FontWeight.w400,1,
            ConstantWidget.getWidthPercentSize(context, 4),
            themeColor)



        // Container(
        //   margin: EdgeInsets.symmetric(vertical: defaultMargin),
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceAround,
        //     mainAxisSize: MainAxisSize.max,
        //     children: [
        //
        //
        //
        //       Expanded(child: Align(alignment: Alignment.centerRight,
        //       child: ConstantWidget.textOverFlowWidget(
        //           s1+s1,
        //           FontWeight.bold,1,
        //           ConstantWidget.getWidthPercentSize(context, 5),
        //           themeColor),),flex: 1,),
        //
        //       // AutoSizeText(
        //       //   S.of(context).beatsminute,
        //       //   style: new TextStyle(
        //       //     fontFamily: ConstantData.fontFamily,
        //       //     fontWeight: FontWeight.w400,
        //       //     color: themeColor,
        //       //
        //       //   ),
        //       //   maxLines: 1,
        //       // ),
        //
        //
        //
        //
        //       ConstantWidget.textOverFlowWidget(
        //           S.of(context).beatsminute,
        //           FontWeight.w400,1,
        //           ConstantWidget.getWidthPercentSize(context, 4),
        //           themeColor)
        //     ],
        //   ),
        // )
      ],
    );
  }
}
