import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_health_calculator/generated/l10n.dart';
import 'package:flutter_health_calculator/model/ResultModel.dart';
import 'package:flutter_health_calculator/model/RowItem.dart';
import 'package:flutter_health_calculator/page/BodyFatResultPage.dart';
import 'package:flutter_health_calculator/page/ChartPage.dart';
import 'package:flutter_health_calculator/utils/ConstantData.dart';
import 'package:flutter_health_calculator/utils/ConstantWidget.dart';
import 'package:flutter_health_calculator/utils/PrefData.dart';
import 'package:flutter_health_calculator/utils/SizeConfig.dart';

class BodyFatPage extends StatefulWidget {
  @override
  _BodyFatPage createState() {
    return _BodyFatPage();
  }
}

class _BodyFatPage extends State<BodyFatPage> {
  Color themeColor = ConstantData.primaryColor;
  TextEditingController ageController = new TextEditingController();
  TextEditingController weightController = new TextEditingController();
  TextEditingController waistController = new TextEditingController();
  TextEditingController forArmController = new TextEditingController();
  TextEditingController wristController = new TextEditingController();
  TextEditingController hipController = new TextEditingController();
  TextEditingController neckController = new TextEditingController();
  bool centimeter;
  bool kg;
  TextEditingController ftController = new TextEditingController();
  TextEditingController inchController = new TextEditingController();
  RowItem rowItem;
  List<DropdownMenuItem<String>> genderList;
  List<DropdownMenuItem<String>> typeList;
  List<DropdownMenuItem<String>> currencyList;
  List<DropdownMenuItem<String>> cnList;
  List<DropdownMenuItem<String>> femaleList;
  String selectGender;
  String selectWaist;
  String selectArm;
  String selectWrist;
  String selectHip;
  String selectNeck;
  String selectCurrency;
  String selectType;
  String string = "";


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

        cnList = buildAndGetDropDownMenuItems(
            [S.of(context).centimeter, S.of(context).inches]);
        femaleList = buildAndGetDropDownMenuItems(
            [S.of(context).centimeter, S.of(context).foot]);

        selectGender = genderList[0].value;
        selectType = typeList[0].value;

        string = S.of(context).ft;

        setDefaultData();
      });
    });
  }

  setDefaultData() async {
    int age = await PrefData.getAge();
    int gender = await PrefData.getGender();
    double height = await PrefData.getHeight();
    centimeter = await PrefData.getCM();
    kg = await PrefData.getKG();
    ageController.text = age.toString();

    if (gender == null) {
      gender = 0;
    }

    selectGender = genderList[gender].value;

    if (centimeter) {
      selectType = typeList[1].value;
      string = S.of(context).cm;
      ftController.text = ConstantData.meterToCm(height).round().toString();
    } else {
      print("age---${ageController.text.toString()}");

      selectType = typeList[0].value;
      string = S.of(context).ft;
      setState(() {
        ConstantData.meterToInchAndFeet(height, ftController, inchController);
      });
    }

    selectCurrency = currencyList[0].value;
    selectWaist = cnList[0].value;
    selectNeck = cnList[0].value;
    selectHip = femaleList[0].value;
    selectWrist = femaleList[0].value;
    selectArm = femaleList[0].value;

    kg = (selectCurrency ==
        S.of(context).kilogram);

    checkData(centimeter);
    setState(() {});
  }

  void checkData(bool val) {
    if (centimeter != val) {
      if (centimeter) {
        if (ConstantData.check(ftController.text) &&
            ConstantData.check(inchController.text)) {
          int i1 = 0;

          try {
            i1 = int.parse(ftController.text);
          } on Exception catch (_) {
            print('never reached');
          }

          int i2 = 0;

          try {
            i2 = int.parse(inchController.text);
          } on Exception catch (_) {
            print('never reached');
          }

          String s =
              ConstantData.meterToCm(ConstantData.feetAndInchToMeter(i1, i2))
                  .round()
                  .toString();

          setState(() {
            ftController.text = s;
          });
        }
      } else {
        if (ConstantData.check(ftController.text)) {
          setState(() {
            ConstantData.meterToInchAndFeet(
                ConstantData.cmToMeter(double.parse(ftController.text)),
                ftController,
                inchController);
          });
        }
      }
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
            children: [
              ConstantWidget.getImage(
                  themeColor, context, "height.png"),
              Expanded(
                child: ConstantWidget.getDropDown(
                    context, selectType, typeList, (value) {
                  bool oldVal = centimeter;

                  setState(() {
                    selectType = value;

                    centimeter = (selectType ==
                        S.of(context).centimeter);

                    checkData(oldVal);

                    if (selectType ==
                        S.of(context).centimeter) {
                      string = S.of(context).cm;
                    } else {
                      string = S.of(context).ft;
                    }
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
        Container(
          height: cellHeight,
          margin: EdgeInsets.only(top: allMargin),
          child: Row(
            children: [
              ConstantWidget.getImage(
                  themeColor, context, "centimeter.png"),
              Expanded(
                child: ConstantWidget.getTextFiled(
                    context,
                    themeColor,
                    S.of(context).enterHeight,
                    cellHeight,
                    ftController),
                flex: 1,
              ),
              SizedBox(
                width: width,
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: ConstantWidget.getDefaultTextWidget(
                      string,
                      TextAlign.start,
                      FontWeight.w400,
                      ConstantWidget.getPercentSize(
                          cellHeight, 30),
                      ConstantData.textColor),
                ),
                flex: 1,
              )
            ],
          ),
        ),
        Visibility(
          child: Container(
            height: cellHeight,
            margin: EdgeInsets.only(top: (allMargin)),
            child: Row(
              children: [
                ConstantWidget.getImage(
                    themeColor, context, "inch.png"),
                Expanded(
                  child: ConstantWidget.getTextFiled(
                      context,
                      themeColor,
                      S.of(context).enterHeight,
                      cellHeight,
                      inchController),
                  flex: 1,
                ),
                SizedBox(
                  width: width,
                ),
                Expanded(
                  child: ConstantWidget.getDefaultTextWidget(
                      S.of(context).inch,
                      TextAlign.start,
                      FontWeight.w400,
                      ConstantWidget.getPercentSize(
                          cellHeight, 30),
                      ConstantData.textColor),
                  flex: 1,
                )
              ],
            ),
          ),
          visible: (selectType == S.of(context).foot),
        ),
        Container(
          height: cellHeight,
          margin: EdgeInsets.only(top: allMargin),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ConstantWidget.getImage(
                  themeColor, context, "weight.png"),
              Expanded(
                child: ConstantWidget.getTextFiled(
                    context,
                    themeColor,
                    S.of(context).enterWeight,
                    cellHeight,
                    weightController),
                flex: 1,
              ),
              SizedBox(
                width: width,
              ),
              Container(
                width: ConstantWidget.getWidthPercentSize(
                    context, 30),
                child: ConstantWidget.getDropDown(
                    context, selectCurrency, currencyList,
                        (value) {
                      setState(() {
                        selectCurrency = value;

                        kg = (selectCurrency ==
                            S.of(context).kilogram);
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
                  themeColor, context, "waist.png"),
              Expanded(
                child: ConstantWidget.getTextFiled(
                    context,
                    themeColor,
                    S.of(context).enterWaist,
                    cellHeight,
                    waistController),
                flex: 1,
              ),
              SizedBox(
                width: width,
              ),
              Container(
                width: ConstantWidget.getWidthPercentSize(
                    context, 30),
                child: ConstantWidget.getDropDown(
                    context, selectWaist, cnList, (value) {
                  setState(() {
                    selectWaist = value;
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
                  themeColor, context, "neck.png"),
              Expanded(
                child: ConstantWidget.getTextFiled(
                    context,
                    themeColor,
                    S.of(context).enterNeck,
                    cellHeight,
                    neckController),
                flex: 1,
              ),
              SizedBox(
                width: width,
              ),
              Container(
                width: ConstantWidget.getWidthPercentSize(
                    context, 30),
                child: ConstantWidget.getDropDown(
                    context, selectNeck, cnList, (value) {
                  setState(() {
                    selectNeck = value;
                  });
                }),
              )
            ],
          ),
        ),
        Visibility(
            child: Container(
              height: cellHeight,
              margin: EdgeInsets.only(top: allMargin),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ConstantWidget.getImage(
                      themeColor, context, "arm.png"),
                  Expanded(
                    child: ConstantWidget.getTextFiled(
                        context,
                        themeColor,
                        S.of(context).forearm,
                        cellHeight,
                        forArmController),
                    flex: 1,
                  ),
                  SizedBox(
                    width: width,
                  ),
                  Container(
                    width: ConstantWidget.getWidthPercentSize(
                        context, 30),
                    child: ConstantWidget.getDropDown(
                        context, selectArm, femaleList,
                            (value) {
                          setState(() {
                            selectArm = value;
                          });
                        }),
                  )
                ],
              ),
            ),
            visible: (selectGender == S.of(context).female)),
        Visibility(
            child: Container(
              height: cellHeight,
              margin: EdgeInsets.only(top: allMargin),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ConstantWidget.getImage(
                      themeColor, context, "wrist.png"),
                  Expanded(
                    child: ConstantWidget.getTextFiled(
                        context,
                        themeColor,
                        S.of(context).wrist,
                        cellHeight,
                        wristController),
                    flex: 1,
                  ),
                  SizedBox(
                    width: width,
                  ),
                  Container(
                    width: ConstantWidget.getWidthPercentSize(
                        context, 30),
                    child: ConstantWidget.getDropDown(
                        context, selectWrist, femaleList,
                            (value) {
                          setState(() {
                            selectWrist = value;
                          });
                        }),
                  )
                ],
              ),
            ),
            visible: (selectGender == S.of(context).female)),
        Visibility(
            child: Container(
              height: cellHeight,
              margin: EdgeInsets.only(top: allMargin),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ConstantWidget.getImage(
                      themeColor, context, "hip.png"),
                  Expanded(
                    child: ConstantWidget.getTextFiled(
                        context,
                        themeColor,
                        S.of(context).hip,
                        cellHeight,
                        hipController),
                    flex: 1,
                  ),
                  SizedBox(
                    width: width,
                  ),
                  Container(
                    width: ConstantWidget.getWidthPercentSize(
                        context, 30),
                    child: ConstantWidget.getDropDown(
                        context, selectHip, femaleList,
                            (value) {
                          setState(() {
                            selectHip = value;
                          });
                        }),
                  )
                ],
              ),
            ),
            visible: (selectGender == S.of(context).female)),
        ConstantWidget.getButtonWidget(
            context, themeColor, S.of(context).bodyFatChart,
                (type) {
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

  maleCalculate() {
    double weight;
    double waist;

    bool check = false;

    if (ConstantData.check(ftController.text)) {
    } else {
      check = true;
    }

    if (!centimeter) {
      if (ConstantData.check(inchController.text)) {
      } else {
        check = true;
      }
    }

    if (ConstantData.check(weightController.text)) {
      weight = double.parse(weightController.text);
    } else {
      check = true;
    }
    if (ConstantData.check(waistController.text)) {
      waist = double.parse(waistController.text);
    } else {
      check = true;
    }
    if (ConstantData.check(neckController.text)) {
    } else {
      check = true;
    }

    if (check) {
      ConstantData.showToast(S.of(context).pleaseEnterValidValues, context);
      check = false;
    } else {
      if (kg) {
        weight *= 2.20462;
      }

      if (centimeter) {
      } else {
      }

      if (selectWaist == S.of(context).centimeter) {
        waist *= 0.393701;
      }
      if (selectNeck == S.of(context).centimeter) {
      }

      double result1 = (weight * 1.082) + 94.42;
      double result2 = result1 - (waist * 4.15);

      double bf = ((weight - result2) * 100.0) / weight;
      String strAssess;
      if (bf >= 2.0 && bf <= 5.0) {
        strAssess = S.of(context).essentialOfFat;
      } else if (bf >= 6.0 && bf <= 13.0) {
        strAssess = S.of(context).typicalAthlete;
      } else if (bf >= 14.0 && bf <= 17.0) {
        strAssess = S.of(context).physicallyFit;
      } else if (bf < 18.0 || bf > 24.0) {
        strAssess = S.of(context).obese;
      } else {
        strAssess = S.of(context).acceptable;
      }

      String strBf = ConstantData.formatData(bf);




      sendPage(strBf, strAssess);
    }
  }

  calculate() {
    if (selectGender == S.of(context).male) {
      maleCalculate();
    } else {
      femaleCalculate();
    }
  }

  void reset() {
    ageController.text = "";
    ftController.text = "";
    inchController.text = "";
    weightController.text = "";
    waistController.text = "";
    neckController.text = "";
    wristController.text = "";
    hipController.text = "";
    forArmController.text = "";
    checkData(centimeter);
    setState(() {});
  }

  void femaleCalculate() {
    double weight;
    double waist;
    double forearm;
    double wrist;
    double hip;
    bool check = false;

    if (ConstantData.check(ftController.text)) {
    } else {
      check = true;
    }

    if (!centimeter) {
      if (ConstantData.check(inchController.text)) {
      } else {
        check = true;
      }
    }

    if (ConstantData.check(weightController.text)) {
      weight = double.parse(weightController.text);
    } else {
      check = true;
    }
    if (ConstantData.check(waistController.text)) {
      waist = double.parse(waistController.text);
    } else {
      check = true;
    }
    if (ConstantData.check(neckController.text)) {
    } else {
      check = true;
    }

    if (ConstantData.check(forArmController.text)) {
      forearm = double.parse(forArmController.text);
    } else {
      check = true;
    }

    if (ConstantData.check(wristController.text)) {
      wrist = double.parse(wristController.text);
    } else {
      check = true;
    }

    if (ConstantData.check(hipController.text)) {
      hip = double.parse(hipController.text);
    } else {
      check = true;
    }

    if (check) {
      ConstantData.showToast(S.of(context).pleaseEnterValidValues, context);
      check = false;
    } else {
      if (kg) {
        weight *= 2.20462;
      }

      if (centimeter) {
      } else {
      }

      if (selectWaist == S.of(context).centimeter) {
        waist *= 0.393701;
      }
      if (selectNeck == S.of(context).centimeter) {
      }

      if (selectArm == S.of(context).centimeter) {
        forearm *= 0.393701;
      }

      if (selectWrist == S.of(context).centimeter) {
        wrist *= 0.393701;
      }
      if (selectHip == S.of(context).centimeter) {
        hip *= 0.393701;
      }

      double result3 =
          (((((weight * 0.0732) + 8.987) + (wrist / 3.14)) - (waist * 0.157)) -
                  (hip * 0.249)) +
              (forearm * 0.434);

      double bf = ((weight - result3) * 100.0) / weight;
      String strAssess;
      if (bf >= 10.0 && bf <= 13.0) {
        strAssess = S.of(context).essentialOfFat;
      } else if (bf >= 14.0 && bf <= 20.0) {
        strAssess = S.of(context).typicalAthlete;
      } else if (bf >= 21.0 && bf <= 24.0) {
        strAssess = S.of(context).physicallyFit;
      } else if (bf < 25.0 || bf > 31.0) {
        strAssess = S.of(context).obese;
      } else {
        strAssess = S.of(context).acceptable;
      }
      String strBf = ConstantData.formatData(bf);


      sendPage(strBf, strAssess);
    }
  }


  sendPage(String value1,String value2){

     resultModel = new ResultModel();
    resultModel.value1 = value1;
    resultModel.value2 = value2;


     ConstantWidget.showAds(interstitialAd, (value) {
       passData();
     });

  }

  void passData() {
    ConstantWidget.sendData(
        context, resultModel, BodyFatResultPage(resultModel, rowItem));
  }
}
