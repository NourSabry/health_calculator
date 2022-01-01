import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_health_calculator/generated/l10n.dart';
import 'package:flutter_health_calculator/model/ResultModel.dart';
import 'package:flutter_health_calculator/model/RowItem.dart';
import 'package:flutter_health_calculator/utils/ConstantData.dart';
import 'package:flutter_health_calculator/utils/ConstantWidget.dart';
import 'package:flutter_health_calculator/utils/SizeConfig.dart';

class ResultPage extends StatefulWidget {
  final ResultModel resultModel;
  final RowItem rowItem;

  ResultPage(this.resultModel, this.rowItem);

  @override
  _ResultPage createState() {
    return _ResultPage();
  }
}

class _ResultPage extends State<ResultPage> {
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
    double containerHeight = ConstantWidget.getScreenPercentSize(context, 8);

    double width = ConstantWidget.getScreenPercentSize(context, 12);
    double height = ConstantWidget.getScreenPercentSize(context, 12);
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Container(
        //   margin: EdgeInsets.all(
        //       ConstantWidget.getScreenPercentSize(context, 4)),
        //   child: Image.asset(
        //     ConstantData.assetsPath + ,height: height,width: width,),
        // ),


        Container(
          margin: EdgeInsets.all(ConstantWidget.getScreenPercentSize(context, 4)),
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
              widget.resultModel.value1+" "+S.of(context).kg+" / "+widget.resultModel.value2+" "+S.of(context).lbs,
              TextAlign.center,
              FontWeight.bold,
              ConstantWidget.getWidthPercentSize(context, 7),
              themeColor),

        ),



      ],
    );
  }


}
