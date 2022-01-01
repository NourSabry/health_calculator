import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_health_calculator/page/CanDonatePage.dart';
import 'package:flutter_health_calculator/page/EligiblePage.dart';

import 'package:flutter/material.dart';
import 'package:flutter_health_calculator/generated/l10n.dart';
import 'package:flutter_health_calculator/model/ResultModel.dart';
import 'package:flutter_health_calculator/model/RowItem.dart';
import 'package:flutter_health_calculator/utils/ConstantData.dart';
import 'package:flutter_health_calculator/utils/ConstantWidget.dart';
import 'package:flutter_health_calculator/utils/SizeConfig.dart';

import 'BloodDonationResultPage.dart';

class BloodDonationPage extends StatefulWidget {
  @override
  _BloodDonationPage createState() {
    return _BloodDonationPage();
  }
}

class _BloodDonationPage extends State<BloodDonationPage> {
  Color themeColor = ConstantData.primaryColor;

  DateTime currentDate = DateTime.now();

  RowItem rowItem;
  String stringDate = "hj";

  AdmobInterstitial interstitialAd;

  @override
  void dispose() {
    interstitialAd.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    interstitialAd = ConstantWidget.getInterstitialAd(() {
      calculate();
      interstitialAd.load();
    });

      setState(() {
        stringDate = ConstantData.getFormattedDate(new DateTime.now());

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
            S.of(context).chooseTheDateOfLastDonation,
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


        Material(
          color: Colors.transparent,

          child: getButton(Icons.calendar_today, S.of(context).chooseDate, _selectDate,null),
        ),

        Material(
          color: Colors.transparent,

          child: getButton(null, S.of(context).calculate,calculate,interstitialAd)

        ),

        ConstantWidget.getButton(context,


            S.of(context).canIDonate, themeColor, () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CanDonatePage(
                        rowItem),
                  ));
            }),

        ConstantWidget.getButton(context,
            S.of(context).eligibilityToDonate, themeColor, () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EligiblePage(
                        rowItem),
                  ));
            })
      ],
    );
  }

  calculate(){
    if(stringDate.isNotEmpty && stringDate!=null){
      ResultModel resultModel = new ResultModel();


      var thirtyDaysFromNow = currentDate.add(new Duration(days: 56));


      resultModel.value1 = ConstantData.getDefaultDate(thirtyDaysFromNow);
      resultModel.value2 = ConstantData.getFormattedDate(thirtyDaysFromNow);

      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BloodDonationResultPage(resultModel, rowItem),
          ));


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
        firstDate: DateTime.now(),
        lastDate: DateTime(2050));





    if (pickedDate != null )
      setState(() {
        currentDate = pickedDate;

        setState(() {
          stringDate =ConstantData.getFormattedDate(currentDate);
        });


      });
  }



  getButton(var icon,String s,Function function,AdmobInterstitial interstitial){

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
        onTap: (){
          if(interstitialAd!=null){
            ConstantWidget.showAds(interstitialAd, (value) {
              function();
            });
          }else{
            function();
          }
        },
      ),
    );
  }
}
