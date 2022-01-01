import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_health_calculator/generated/l10n.dart';
import 'package:flutter_health_calculator/model/ResultModel.dart';
import 'package:flutter_health_calculator/model/RowItem.dart';
import 'package:flutter_health_calculator/page/ChartPage.dart';
import 'package:flutter_health_calculator/utils/ConstantData.dart';
import 'package:flutter_health_calculator/utils/ConstantWidget.dart';
import 'package:flutter_health_calculator/utils/PrefData.dart';
import 'package:flutter_health_calculator/utils/SizeConfig.dart';

import 'HeartRateResultPage.dart';

class HeartRatePage extends StatefulWidget {
  @override
  _HeartRatePage createState() {
    return _HeartRatePage();
  }
}

class _HeartRatePage extends State<HeartRatePage> {
  Color themeColor = ConstantData.primaryColor;
  TextEditingController ageController = new TextEditingController();
  TextEditingController heartRateController = new TextEditingController();
  RowItem rowItem;
  List<DropdownMenuItem<String>> genderList;
  List<DropdownMenuItem<String>> typeList;
  String selectGender;
  double factor1;
  double factor2;
  String selectType;

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
        typeList = buildAndGetDropDownMenuItems([
          S.of(context).little,
          S.of(context).moderate,
          S.of(context).hard,
          S.of(context).veryHard
        ]);

        selectGender = genderList[0].value;
        selectType = typeList[0].value;

        setDefaultData();
      });
    });
  }

  setDefaultData() async {
    int age = await PrefData.getAge();
    int gender = await PrefData.getGender();

    ageController.text = age.toString();
    if (gender == null) {
      gender = 0;
    }
    selectGender = genderList[gender].value;
    setFactor();
    setState(() {});
  }

  setFactor() {
    if (selectType == S.of(context).little) {
      factor1 = 0.6;
      factor2 = 0.65;
    } else if (selectType == S.of(context).moderate) {
      factor1 = 0.65;
      factor2 = 0.7;
    } else if (selectType == S.of(context).hard) {
      factor1 = 0.7;
      factor2 = 0.75;
    } else {
      factor1 = 0.75;
      factor2 = 0.8;
    }
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




    return ConstantWidget.getMainDefaultWidget(context, getWidget(), rowItem, _requestPop);



  }

  getWidget(){
    double cellHeight = ConstantWidget.getScreenPercentSize(context, 7);
    double allMargin = ConstantWidget.getScreenPercentSize(context, 1);
    double width = ConstantWidget.getWidthPercentSize(context, 2);
    return ListView(
      children: [
        Container(
          height: cellHeight,
          margin: EdgeInsets.only(top: allMargin),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ConstantWidget.getImage(
                  themeColor, context, "gender.png"),
              Expanded(
                child: ConstantWidget.getTextFiled(
                    context,
                    themeColor,
                    S.of(context).enterAge,
                    cellHeight,
                    ageController),
                flex: 1,
              ),
              SizedBox(
                width: width,
              ),
              Container(
                width: ConstantWidget.getWidthPercentSize(
                    context, 30),
                child: ConstantWidget.getDropDown(
                    context, selectGender, genderList,
                        (value) {
                      setState(() {
                        selectGender = value;
                      });
                    }),
              )
            ],
          ),
        ),
        Container(
          height: cellHeight,
          margin: EdgeInsets.only(top: allMargin),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ConstantWidget.getImage(
                  themeColor, context, "heart-rate.png"),
              Expanded(
                child: ConstantWidget.getTextFiled(
                    context,
                    themeColor,
                    S.of(context).enterRestingHeartRate,
                    cellHeight,
                    heartRateController),
                flex: 1,
              ),
            ],
          ),
        ),
        Container(
          height: cellHeight,
          margin: EdgeInsets.only(top: allMargin),
          child: Row(
            children: [
              ConstantWidget.getImage(
                  themeColor, context, "height.png"),
              Expanded(
                child: ConstantWidget.getDropDown(
                    context, selectType, typeList, (value) {
                  setState(() {
                    selectType = value;
                    setFactor();
                  });
                }),
                flex: 1,
              ),
              Expanded(
                child: Container(),
                flex: 1,
              )
            ],
          ),
        ),
        ConstantWidget.getButtonWidget(context, themeColor,
            S.of(context).targetHeartRateChart, (type) {
              if (type == ConstantData.calculate) {
                calculate();
              } else if (type == ConstantData.reset) {
                reset();
              } else {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChartPage(rowItem),
                    ));
              }
            })
      ],
    );
  }

  calculate() {
    double rhr;
    double mhr;
    double age;
    bool check = false;

    if (ConstantData.check(heartRateController.text)) {
      rhr = double.parse(heartRateController.text);
    } else {
      check = true;
    }

    if (ConstantData.check(ageController.text)) {
      age = double.parse(ageController.text);
    } else {
      check = true;
    }

    if (check) {
      ConstantData.showToast(S.of(context).pleaseEnterValidValues, context);
      check = false;
    } else {
      if (selectGender == S.of(context).male) {
        age *= 0.8;
        mhr = 214.0 - age;
      } else {
        age *= 0.9;
        mhr = 209.0 - age;
      }

      PrefData.setAge(age.toInt());
       resultModel = new ResultModel();
      resultModel.value1 = ConstantData.formatData(mhr);

      mhr -= rhr;

      double min = (mhr * factor1) + rhr;
      double max = (mhr * factor2) + rhr;

      resultModel.value2 = ConstantData.formatData(min);
      resultModel.value3 = ConstantData.formatData(max);


      ConstantWidget.showAds(interstitialAd, (value) {
        passData();
      });

    }
  }

  void reset() {
    ageController.text = "";
    heartRateController.text = "";
    setState(() {});
  }

  void passData() {

    ConstantWidget.sendData(
        context, resultModel, HeartRateResultPage(resultModel, rowItem));

  }
}
