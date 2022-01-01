import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_health_calculator/generated/l10n.dart';
import 'package:flutter_health_calculator/model/ResultModel.dart';
import 'package:flutter_health_calculator/model/RowItem.dart';
import 'package:flutter_health_calculator/page/CaloriesWeightResultPage.dart';
import 'package:flutter_health_calculator/page/ChartPage.dart';
import 'package:flutter_health_calculator/page/PdfPage.dart';
import 'package:flutter_health_calculator/utils/ConstantData.dart';
import 'package:flutter_health_calculator/utils/ConstantWidget.dart';
import 'package:flutter_health_calculator/utils/PrefData.dart';
import 'package:flutter_health_calculator/utils/SizeConfig.dart';


class CaloriesWeightPage extends StatefulWidget {
  @override
  _CaloriesWeightPage createState() {
    return _CaloriesWeightPage();
  }
}

class _CaloriesWeightPage extends State<CaloriesWeightPage> {
  Color themeColor = ConstantData.primaryColor;
  TextEditingController ageController = new TextEditingController();
  TextEditingController weightController = new TextEditingController();
  TextEditingController targetWeightController = new TextEditingController();
  bool centimeter;
  bool kg;
  TextEditingController ftController = new TextEditingController();
  TextEditingController inchController = new TextEditingController();
  RowItem rowItem;
  List<DropdownMenuItem<String>> genderList;
  List<DropdownMenuItem<String>> typeList;
  List<DropdownMenuItem<String>> sedentaryList;
  List<DropdownMenuItem<String>> weightList;
  List<DropdownMenuItem<String>> weekList;
  List<DropdownMenuItem<String>> currencyList;
  String selectGender;
  String selectCurrency;
  String selectTargetWeight;
  String selectSedentary;
  double factor = 0;
  String selectWeight;
  String selectWeek;
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

        sedentaryList = buildAndGetDropDownMenuItems([
          S.of(context).sedentary,
          S.of(context).little,
          S.of(context).moderate,
          S.of(context).hard,
          S.of(context).veryHard
        ]);
        weightList = buildAndGetDropDownMenuItems(
            [S.of(context).gainWeight, S.of(context).lossWeight]);
        weekList = buildAndGetDropDownMenuItems(
            ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"]);

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
    double weight = await PrefData.getWeight();
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

    if (kg) {
      selectTargetWeight = currencyList[0].value;
      selectCurrency = currencyList[0].value;
      weightController.text = weight.round().toString();
      targetWeightController.text = weight.round().toString();
    } else {
      selectTargetWeight = currencyList[1].value;
      selectCurrency = currencyList[1].value;
      weightController.text = ConstantData.kgToPound(weight).round().toString();
      targetWeightController.text =
          ConstantData.kgToPound(weight).round().toString();
    }

    selectSedentary = sedentaryList[0].value;
    selectWeek = weekList[0].value;
    selectWeight = weightList[0].value;


    setFactor();
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
    return  ListView(
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
            children: [
              ConstantWidget.getImage(
                  themeColor, context, "height.png"),
              Expanded(
                child: ConstantWidget.getDropDown(
                    context, selectSedentary, sedentaryList,
                        (value) {
                      setState(() {
                        selectSedentary = value;
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
                    S.of(context).targetWeight,
                    cellHeight,
                    targetWeightController),
                flex: 1,
              ),
              SizedBox(
                width: width,
              ),
              Container(
                width: ConstantWidget.getWidthPercentSize(
                    context, 30),
                child: ConstantWidget.getDropDown(
                    context, selectTargetWeight, currencyList,
                        (value) {
                      setState(() {
                        selectTargetWeight = value;
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
                  themeColor, context, "gym.png"),
              Expanded(
                child: ConstantWidget.getDropDown(
                    context, selectWeight, weightList,
                        (value) {
                      setState(() {
                        selectWeight = value;
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
                  themeColor, context, ""),
              Expanded(
                child: ConstantWidget.getDefaultTextWidget(
                    S.of(context).week,
                    TextAlign.start,
                    FontWeight.w400,
                    ConstantWidget.getPercentSize(
                        cellHeight, 30),
                    ConstantData.textColor),
                flex: 1,
              ),
              SizedBox(
                width: width,
              ),
              Expanded(
                child: ConstantWidget.getDropDown(
                    context, selectWeek, weekList, (value) {
                  setState(() {
                    selectWeek = value;
                  });
                }),
                flex: 1,
              ),
            ],
          ),
        ),
        ConstantWidget.getButtonWidget(context, themeColor,
            S.of(context).dailyCalorieChart, (type) {
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
            }),

        ConstantWidget.getButton(context, S.of(context).foodCaloriesList, themeColor, (){

          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PdfPage("food_calorie.pdf",rowItem),
                // builder: (context) => PdfPage("food_calorie_list.pdf",rowItem),
              ));
        })
      ],
    );
  }


  setFactor() {
    if (selectSedentary == S.of(context).sedentary) {
      factor = 1.2;
    } else if (selectSedentary == S.of(context).little) {
      factor = 1.375;
    } else if (selectSedentary == S.of(context).moderate) {
      factor = 1.55;
    } else if (selectSedentary == S.of(context).hard) {
      factor = 1.725;
    } else {
      factor = 1.9;
    }
  }

  calculate() {
    double height;
    double height2;
    double weight;
    double age;
    bool check = false;

    if (ConstantData.check(ftController.text)) {
      height = double.parse(ftController.text);
    } else {
      check = true;
    }

    if (ConstantData.check(weightController.text)) {
      weight = double.parse(weightController.text);
    } else {
      check = true;
    }

    if (ConstantData.check(ageController.text)) {
      age = double.parse(ageController.text);
    } else {
      check = true;
    }

    if (!centimeter) {
      if (ConstantData.check(inchController.text)) {
        height2 = double.parse(inchController.text);
      } else {
        check = true;
      }
    }

    if (check) {
      ConstantData.showToast(S.of(context).pleaseEnterValidValues, context);
      check = false;
    } else {
      if (!centimeter) {
        height *= 12.0;
        height += height2;
        height *= 2.54;
      }

      if (!kg) {
        weight *= 0.453592;
      }

      if (selectGender == S.of(context).male) {
        weight *= 13.7;
        weight += 66.0;
        height *= 5.0;
        age *= 6.8;
      } else {
        weight *= 9.6;
        weight += 655.0;
        height *= 1.8;
        age *= 4.7;
      }

      PrefData.setAge(age.toInt());

      int getWeight = 0;

      if (ConstantData.check(weightController.text)) {
        getWeight = int.parse(weightController.text);

        if (!kg) {
          getWeight = ConstantData.poundToKg(getWeight.roundToDouble()).round();
        }
      }


      String stringBmr;
      double bmr = (weight + height) - age;
      bmr *= factor;





      stringBmr = ConstantData.formatData(bmr);

       resultModel = new ResultModel();
      resultModel.value1 = stringBmr;

      if (ConstantData.check(targetWeightController.text)) {
        int targetWeight  = int.parse(targetWeightController.text);


        if (selectTargetWeight != S.of(context).kilogram) {

          int week = int.parse(selectWeek);

          double calRequired = 0;


          targetWeight = ConstantData.poundToKg(targetWeight.toDouble()).round();

          if(selectWeight == S.of(context).gainWeight){
            double calRequired1 = (targetWeight - getWeight) * (1100 / week);
            calRequired = calRequired1 + bmr;
          }else{
            double calRequired2 = (getWeight - targetWeight) * (1100 / week);
            calRequired = bmr - calRequired2;
          }
          resultModel.value2 = ConstantData.formatData(calRequired).toString();
        }



        ConstantWidget.showAds(interstitialAd, (value) {
          passData();
        });

        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //       builder: (context) => CaloriesWeightResultPage(resultModel, rowItem),
        //     ));

      }
      
    }
  }

  void reset() {
    setState(() {
      ageController.text = "";
      ftController.text = "";
      inchController.text = "";
      weightController.text = "";
      targetWeightController.text = "";
    });
  }

  void passData() {

    ConstantWidget.sendData(
        context, resultModel, CaloriesWeightResultPage(resultModel, rowItem));
  }
}
