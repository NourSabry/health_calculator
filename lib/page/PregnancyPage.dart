import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_health_calculator/page/PregnancyResultPage.dart';

import 'package:flutter/material.dart';
import 'package:flutter_health_calculator/generated/l10n.dart';
import 'package:flutter_health_calculator/model/ResultModel.dart';
import 'package:flutter_health_calculator/model/RowItem.dart';
import 'package:flutter_health_calculator/page/ChartPage.dart';
import 'package:flutter_health_calculator/page/PdfPage.dart';
import 'package:flutter_health_calculator/utils/ConstantData.dart';
import 'package:flutter_health_calculator/utils/ConstantWidget.dart';
import 'package:flutter_health_calculator/utils/SizeConfig.dart';


class PregnancyPage extends StatefulWidget {
  @override
  _PregnancyPage createState() {
    return _PregnancyPage();
  }
}

class _PregnancyPage extends State<PregnancyPage> {
  Color themeColor = ConstantData.primaryColor;

  DateTime currentDate = DateTime.now();

  RowItem rowItem;
  String stringDate = "";

  AdmobInterstitial interstitialAd;
  ResultModel resultModel;

  @override
  void dispose() {
    interstitialAd.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    interstitialAd = ConstantWidget.getInterstitialAd(() {
      passData();
      interstitialAd.load();
    });


    setState(() {
      stringDate =ConstantData.getFormattedDate(new DateTime.now());
    });
  }

  Future<bool> _requestPop() {
    Navigator.of(context).pop();
    return new Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    rowItem = ConstantData.getThemeColor(context);
    themeColor = rowItem.color;
    SizeConfig().init(context);




    return ConstantWidget.getMainDefaultWidget(context, getWidget(), rowItem, _requestPop);

  }


  getWidget(){
    double sliderHeight = SizeConfig.safeBlockVertical * 18;
    double margin = ConstantWidget.getPercentSize(sliderHeight, 13);

    return  ListView(
      children: [
        SizedBox(
          height: (margin),
        ),
        ConstantWidget.getDefaultTextWidget(
            S
                .of(context)
                .chooseThe1stDayOfYourLastMenstrualPeriod,
            TextAlign.center,
            FontWeight.w500,
            ConstantWidget.getWidthPercentSize(context, 5),
            ConstantData.textColor),
        SizedBox(
          height: (margin),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ConstantWidget.getDefaultTextWidget(
                S.of(context).dateChosen,
                TextAlign.center,
                FontWeight.w500,
                ConstantWidget.getWidthPercentSize(
                    context, 3.5),
                ConstantData.textColor),
            SizedBox(
              width: (margin * 2),
            ),
            ConstantWidget.getDefaultTextWidget(
                stringDate,
                TextAlign.center,
                FontWeight.w500,
                ConstantWidget.getWidthPercentSize(
                    context, 3.5),
                themeColor),
          ],
        ),
        SizedBox(
          height: (margin),
        ),

        Wrap(
          children: [

            getButton(Icons.calendar_today, S.of(context).chooseDate, _selectDate),
            getButton(null, S.of(context).calculate,calculate)

          ],
        ),
        ConstantWidget.getButton(context,
            S.of(context).pregnancyWeightGainChart, themeColor, () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChartPage(
                        rowItem),
                  ));
            }),

        ConstantWidget.getButton(context,
            S.of(context).pregnancyFoodGuide, themeColor, () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PdfPage(
                        "pregnancy_food_guide.pdf", rowItem),
                  ));
            })
      ],
    );
  }

  calculate(){
    if(stringDate.isNotEmpty && stringDate!=null){
       resultModel = new ResultModel();


       var thirtyDaysFromNow = currentDate.add(new Duration(days: 282));

       resultModel.value1 = ConstantData.getDefaultDate(thirtyDaysFromNow);

       resultModel.value2 = ConstantData.getFormattedDate(thirtyDaysFromNow);


       ConstantWidget.showAds(interstitialAd, (value) {
         passData();
       });
    }
  }
  Future<void> _selectDate() async {
    final DateTime pickedDate = await showDatePicker(
        context: context,
        builder: (context, child) {
          return Theme(
            data: ThemeData.light().copyWith(
              primaryColor: themeColor,
              accentColor: themeColor,
              colorScheme:
              ColorScheme.light(primary: themeColor),
              buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
            ),
            child: child,
          );
        },
        initialDate: DateTime.now(),
        firstDate: DateTime(2005),
        lastDate: DateTime(2050));





    if (pickedDate != null )
      setState(() {
        currentDate = pickedDate;

        setState(() {
          stringDate = ConstantData.getFormattedDate(currentDate);
        });


      });
  }



  getButton(var icon,String s,Function function){

    double buttonHeight = ConstantWidget.getScreenPercentSize(context, 6);
    double buttonWidth = ConstantWidget.getScreenPercentSize(context, 25);

    double subRadius = ConstantWidget.getWidthPercentSize(context, 1.5);
    double fontSize = ConstantWidget.getPercentSize(buttonHeight, 32);
    double iconSize = ConstantWidget.getPercentSize(buttonHeight, 50);
    double sliderHeight = SizeConfig.safeBlockVertical * 18;

    double margin = ConstantWidget.getPercentSize(sliderHeight, 13);



    return     Center(
      child: InkWell(
        child: Container(
          margin: EdgeInsets.only(top: margin),
          // margin: EdgeInsets.all(
          //     ConstantWidget.getWidthPercentSize(context, 5)),
          width: buttonWidth,
          padding: EdgeInsets.all(
              ConstantWidget.getPercentSize(
                  buttonWidth, 1.5)),
          height: buttonHeight,
          decoration: BoxDecoration(
              color: themeColor,
              borderRadius: BorderRadius.all(
                  Radius.circular(subRadius))),
          child: Stack(
            children: [
              Visibility(child: Align(
                alignment: Alignment.centerLeft,
                child: Icon(
                  Icons.calendar_today,
                  color: Colors.white,
                  size: iconSize,
                ),
              ),visible: (icon!=null),),
              Center(
                child: ConstantWidget
                    .getDefaultTextWidget(
                    s,
                    TextAlign.center,
                    FontWeight.w500,
                    fontSize,
                    Colors.white),
              )
            ],
          ),
        ),
        onTap: function,
      ),
    );
  }

  void passData() {

    ConstantWidget.sendData(
        context, resultModel, PregnancyResultPage(resultModel, rowItem));

  }
}
