import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_health_calculator/page/BreathCountResultPage.dart';

import 'package:flutter/material.dart';
import 'package:flutter_health_calculator/generated/l10n.dart';
import 'package:flutter_health_calculator/model/ResultModel.dart';
import 'package:flutter_health_calculator/model/RowItem.dart';
import 'package:flutter_health_calculator/utils/ConstantData.dart';
import 'package:flutter_health_calculator/utils/ConstantWidget.dart';
import 'package:flutter_health_calculator/utils/SizeConfig.dart';

class BreathCountPage extends StatefulWidget {
  @override
  _BreathCountPage createState() {
    return _BreathCountPage();
  }
}

class _BreathCountPage extends State<BreathCountPage> {
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

    return ConstantWidget.getMainDefaultWidget(
        context, getWidget(), rowItem, _requestPop);
  }

  getWidget() {
    double sliderHeight = SizeConfig.safeBlockVertical * 18;
    double margin = ConstantWidget.getPercentSize(sliderHeight, 13);
    return ListView(
      children: [
        SizedBox(
          height: (margin),
        ),
        ConstantWidget.getDefaultTextWidget(
            S.of(context).chooseYourBirthDate,
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
                ConstantWidget.getWidthPercentSize(context, 3.5),
                ConstantData.textColor),
            SizedBox(
              width: (margin * 2),
            ),
            ConstantWidget.getDefaultTextWidget(
                stringDate,
                TextAlign.center,
                FontWeight.w500,
                ConstantWidget.getWidthPercentSize(context, 3.5),
                themeColor),
          ],
        ),
        SizedBox(
          height: (margin),
        ),
        Wrap(
          children: [
            getButton(
                Icons.calendar_today, S.of(context).chooseDate, _selectDate),
            getButton(null, S.of(context).calculate, calculate)
          ],
        ),
      ],
    );
  }

  calculate() {
    if (stringDate.isNotEmpty && stringDate != null) {
      var now = DateTime.now();

      if (currentDate.isBefore(now)) {
        int yearsInBetween = now.year - currentDate.year;
        int monthsDiff = now.month - currentDate.month;

        final daysBetween = DateTime.now().difference(currentDate).inDays;

        double breaths = daysBetween.toDouble();

        if (yearsInBetween >= 1 && yearsInBetween <= 5) {
          breaths = breaths * 25 * 1440;
        } else if (yearsInBetween > 5) {
          breaths = breaths * 11 * 1440;
        } else {
          if (monthsDiff < 6) {
            breaths = breaths * 45 * 1440;
          } else {
            breaths = breaths * 27 * 1440;
          }
        }

        resultModel = new ResultModel();

        resultModel.value1 = ConstantData.formatData(breaths);

        ConstantWidget.showAds(interstitialAd, (value) {
          passData();
        });
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //       builder: (context) => BreathCountResultPage(resultModel, rowItem),
        //     ));

      }
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
              colorScheme: ColorScheme.light(primary: themeColor),
              buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
            ),
            child: child,
          );
        },
        initialDate: DateTime.now(),
        firstDate: DateTime(1970),
        lastDate: DateTime.now());

    if (pickedDate != null)
      setState(() {
        currentDate = pickedDate;

        setState(() {
          stringDate = ConstantData.getFormattedDate(currentDate);
        });
      });
  }

  getButton(var icon, String s, Function function) {
    double buttonHeight = ConstantWidget.getScreenPercentSize(context, 6);
    double buttonWidth = ConstantWidget.getScreenPercentSize(context, 25);

    double subRadius = ConstantWidget.getWidthPercentSize(context, 1.5);
    double fontSize = ConstantWidget.getPercentSize(buttonHeight, 32);
    double iconSize = ConstantWidget.getPercentSize(buttonHeight, 50);
    double sliderHeight = SizeConfig.safeBlockVertical * 18;

    double margin = ConstantWidget.getPercentSize(sliderHeight, 13);

    return Center(
      child: InkWell(
        child: Container(
          margin: EdgeInsets.only(top: margin),
          // margin: EdgeInsets.all(
          //     ConstantWidget.getWidthPercentSize(context, 5)),
          width: buttonWidth,
          padding:
              EdgeInsets.all(ConstantWidget.getPercentSize(buttonWidth, 1.5)),
          height: buttonHeight,
          decoration: BoxDecoration(
              color: themeColor,
              borderRadius: BorderRadius.all(Radius.circular(subRadius))),
          child: Stack(
            children: [
              Visibility(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Icon(
                    Icons.calendar_today,
                    color: Colors.white,
                    size: iconSize,
                  ),
                ),
                visible: (icon != null),
              ),
              Center(
                child: ConstantWidget.getDefaultTextWidget(s, TextAlign.center,
                    FontWeight.w500, fontSize, Colors.white),
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
        context, resultModel, BreathCountResultPage(resultModel, rowItem));
  }
}
