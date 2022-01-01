import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_health_calculator/generated/l10n.dart';
import 'package:flutter_health_calculator/model/ResultModel.dart';
import 'package:flutter_health_calculator/model/RowItem.dart';
import 'package:flutter_health_calculator/utils/ConstantData.dart';
import 'package:flutter_health_calculator/utils/ConstantWidget.dart';
import 'package:flutter_health_calculator/utils/SizeConfig.dart';

import 'BloodPressureResultPage.dart';

class BloodPressurePage extends StatefulWidget {
  @override
  _BloodPressurePage createState() {
    return _BloodPressurePage();
  }
}

class _BloodPressurePage extends State<BloodPressurePage> {
  Color themeColor = ConstantData.primaryColor;
  bool kg;
  TextEditingController value1Controller = new TextEditingController();
  TextEditingController value2Controller = new TextEditingController();
  RowItem rowItem;
  List<DropdownMenuItem<String>> genderList;
  List<DropdownMenuItem<String>> typeList;
  List<DropdownMenuItem<String>> currencyList;
  List<DropdownMenuItem<String>> drinkList;
  List<DropdownMenuItem<String>> timeList;
  String selectGender;
  String selectCurrency;
  String selectDrink;
  String selectTime;
  String selectType;
  String string = "";

  double factor;
  double factor1;

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

    Future.delayed(Duration.zero, () {
      setState(() {
        genderList = buildAndGetDropDownMenuItems(
            [S.of(context).male, S.of(context).female]);
        typeList = buildAndGetDropDownMenuItems(
            [S.of(context).foot, S.of(context).centimeter]);

        currencyList = buildAndGetDropDownMenuItems(
            [S.of(context).kilogram, S.of(context).pounds]);
        drinkList = buildAndGetDropDownMenuItems(
            [S.of(context).ounce, S.of(context).ml, S.of(context).cup]);

        timeList = buildAndGetDropDownMenuItems(
            [S.of(context).hour, S.of(context).minute, S.of(context).day]);
        selectGender = genderList[0].value;
        selectType = typeList[0].value;

        string = S.of(context).ft;

        setDefaultData();
      });
    });
  }

  setDefaultData() async {
    setState(() {});
  }

  List<DropdownMenuItem<String>> buildAndGetDropDownMenuItems(List fruits) {
    List<DropdownMenuItem<String>> items = [];
    for (String fruit in fruits) {
      items.add(new DropdownMenuItem(value: fruit, child: new Text(fruit)));
    }
    return items;
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
    double cellHeight = ConstantWidget.getScreenPercentSize(context, 7);

    return ListView(
      children: [
        ConstantWidget.getDefaultTextWidget(
            S.of(context).systolicBloodPressure,
            TextAlign.start,
            FontWeight.w300,
            ConstantWidget.getScreenPercentSize(context, 2),
            ConstantData.textColor),
        SizedBox(
          height: ConstantWidget.getScreenPercentSize(context, 2),
        ),
        ConstantWidget.getTextFiled(context, themeColor,
            S.of(context).enterValue, cellHeight, value1Controller),
        SizedBox(
          height: ConstantWidget.getScreenPercentSize(context, 3),
        ),
        ConstantWidget.getDefaultTextWidget(
            S.of(context).diastolicBloodPressure,
            TextAlign.start,
            FontWeight.w300,
            ConstantWidget.getScreenPercentSize(context, 2),
            ConstantData.textColor),
        SizedBox(
          height: ConstantWidget.getScreenPercentSize(context, 2),
        ),
        ConstantWidget.getTextFiled(context, themeColor,
            S.of(context).enterValue, cellHeight, value2Controller),
        getButtonWidget(context, themeColor, (type) {
          if (type == ConstantData.calculate) {
            calculate();
          } else if (type == ConstantData.reset) {
            reset();
          }
        })
      ],
    );
  }

  setFactor() {
    if (selectDrink == S.of(context).ounce) {
      factor = 1;
    } else if (selectDrink == S.of(context).ml) {
      factor = 2;
    } else {
      factor = 3;
    }
  }

  setFactor2() {
    if (selectTime == S.of(context).hour) {
      factor1 = 1;
    } else if (selectTime == S.of(context).minute) {
      factor1 = 2;
    } else {
      factor1 = 3;
    }
  }

  getButtonWidget(
      BuildContext context, Color themeColor, ValueChanged<String> function) {
    double buttonHeight = ConstantWidget.getScreenPercentSize(context, 6);

    double subRadius = ConstantWidget.getWidthPercentSize(context, 1.5);
    double fontSize = ConstantWidget.getPercentSize(buttonHeight, 32);
    double sliderHeight = SizeConfig.safeBlockVertical * 18;

    double margin = ConstantWidget.getPercentSize(sliderHeight, 13);

    return Row(
      children: [
        Expanded(
          child: InkWell(
            child: Container(
              margin: EdgeInsets.only(right: (margin / 3), top: (margin)),
              height: buttonHeight,
              decoration: BoxDecoration(
                  color: themeColor,
                  borderRadius: BorderRadius.all(Radius.circular(subRadius))),
              child: Center(
                child: ConstantWidget.getDefaultTextWidget(
                    S.of(context).calculate,
                    TextAlign.center,
                    FontWeight.w500,
                    fontSize,
                    Colors.white),
              ),
            ),
            onTap: () {
              function(ConstantData.calculate);
            },
          ),
          flex: 1,
        ),
        Expanded(
          child: InkWell(
            child: Container(
              margin: EdgeInsets.only(left: (margin / 3), top: (margin)),
              height: buttonHeight,
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(
                      width: ConstantWidget.getPercentSize(buttonHeight, 1.5),
                      color: themeColor),
                  borderRadius: BorderRadius.all(Radius.circular(subRadius))),
              child: Center(
                child: ConstantWidget.getDefaultTextWidget(S.of(context).reset,
                    TextAlign.center, FontWeight.w500, fontSize, themeColor),
              ),
            ),
            onTap: () {
              function(ConstantData.reset);
            },
          ),
          flex: 1,
        )
      ],
    );
  }

  calculate() {
    bool check = false;

    double sBp;
    double dBp;

    if (ConstantData.check(value1Controller.text)) {
      sBp = double.parse(value1Controller.text);
    } else {
      check = true;
    }
    if (ConstantData.check(value2Controller.text)) {
      dBp = double.parse(value2Controller.text);
    } else {
      check = true;
    }
    if (check) {
      ConstantData.showToast(S.of(context).pleaseEnterValidValues, context);
      check = false;
    } else {
      String result = "";
      if (sBp > 180 || dBp > 110) {
        result = S.of(context).hypertensiveCrisis;
      } else if (sBp >= 160 || dBp >= 100) {
        result = S.of(context).highBloodPressureStage2;
      } else if (sBp > 140 || dBp > 90) {
        result = S.of(context).highBloodPressureStage1;
      } else if (sBp > 120 || dBp > 80) {
        result = S.of(context).prehypertension;
      } else if (sBp > 80 && dBp > 60) {
        result = S.of(context).normal;
      } else {
        result = S.of(context).low;
      }

      resultModel = new ResultModel();
      resultModel.value1 = result;

      ConstantWidget.showAds(interstitialAd, (value) {
        passData();
      });
    }
  }

  void passData() {
    ConstantWidget.sendData(
        context, resultModel, BloodPressureResultPage(resultModel, rowItem));
  }

  void reset() {
    value1Controller.text = "";
    value2Controller.text = "";
    setState(() {});
  }
}
