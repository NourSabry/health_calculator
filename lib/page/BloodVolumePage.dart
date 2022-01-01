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

import 'BloodVolumeResultPage.dart';

class BloodVolumePage extends StatefulWidget {
  @override
  _BloodVolumePage createState() {
    return _BloodVolumePage();
  }
}

class _BloodVolumePage extends State<BloodVolumePage> {
  Color themeColor = ConstantData.primaryColor;
  TextEditingController weightController = new TextEditingController();
  bool centimeter;
  bool kg;
  TextEditingController ftController = new TextEditingController();
  TextEditingController inchController = new TextEditingController();
  RowItem rowItem;
  List<DropdownMenuItem<String>> typeList;
  List<DropdownMenuItem<String>> currencyList;
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
        typeList = buildAndGetDropDownMenuItems(
            [S.of(context).foot, S.of(context).centimeter]);

        currencyList = buildAndGetDropDownMenuItems(
            [S.of(context).kilogram, S.of(context).pounds]);
        selectType = typeList[0].value;

        string = S.of(context).ft;

        setDefaultData();
      });
    });
  }

  setDefaultData() async {
    int gender = await PrefData.getGender();
    double height = await PrefData.getHeight();
    double weight = await PrefData.getWeight();
    centimeter = await PrefData.getCM();
    kg = await PrefData.getKG();

    if (gender == null) {
      gender = 0;
    }

    if (centimeter) {
      selectType = typeList[1].value;
      string = S.of(context).cm;
      ftController.text = ConstantData.meterToCm(height).round().toString();
    } else {
      selectType = typeList[0].value;
      string = S.of(context).ft;
      setState(() {
        ConstantData.meterToInchAndFeet(height, ftController, inchController);
      });
    }

    if (kg) {
      selectCurrency = currencyList[0].value;
      weightController.text = weight.round().toString();
    } else {
      selectCurrency = currencyList[1].value;
      weightController.text = ConstantData.kgToPound(weight).round().toString();
    }
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
                  child:
                  ConstantWidget.getDefaultTextWidget(
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
                  child:
                  ConstantWidget.getDefaultTextWidget(
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
        getButtonWidget(
            context, themeColor, S.of(context).bmiChart,
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

  calculate() {
    double height;
    double height2;
    double weight;
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
      if (centimeter) {
        height /= 100.0;
      } else {
        height *= 12.0;
        height += height2;
        height *= 2.54;
        height /= 100.0;
      }
      if (!kg) {
        weight *= 0.453592;
      }

      weight *= 0.03219;
      weight += 0.6041;
      height = height * height * height;
      height *= 0.3669;


      print("bmi----$weight=====$height");

      double bloodVol = weight+height;

       resultModel = new ResultModel();
      resultModel.value1 = ConstantData.formatData(bloodVol);


      ConstantWidget.showAds(interstitialAd, (value) {
        passData();
      });
    }
  }

  void passData() {
    ConstantWidget.sendData(
        context, resultModel, BloodVolumeResultPage(resultModel, rowItem));
  }



  static getButtonWidget(BuildContext context, Color themeColor, String s,
      ValueChanged<String> function) {
    double buttonHeight = ConstantWidget.getScreenPercentSize(context, 6);

    double subRadius = ConstantWidget.getWidthPercentSize(context, 1.5);
    double fontSize = ConstantWidget.getPercentSize(buttonHeight, 32);
    double sliderHeight = SizeConfig.safeBlockVertical * 18;

    double margin = ConstantWidget.getPercentSize(sliderHeight, 13);

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: InkWell(
                child: Container(
                  margin: EdgeInsets.only(right: (margin / 3), top: (margin)),
                  height: buttonHeight,
                  decoration: BoxDecoration(
                      color: themeColor,
                      borderRadius:
                      BorderRadius.all(Radius.circular(subRadius))),
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
                          width:
                          ConstantWidget.getPercentSize(buttonHeight, 1.5),
                          color: themeColor),
                      borderRadius:
                      BorderRadius.all(Radius.circular(subRadius))),
                  child: Center(
                    child: ConstantWidget.getDefaultTextWidget(
                        S.of(context).reset,
                        TextAlign.center,
                        FontWeight.w500,
                        fontSize,
                        themeColor),
                  ),
                ),
                onTap: () {
                  function(ConstantData.reset);
                },
              ),
              flex: 1,
            )
          ],
        ),
      ],
    );
  }

  void reset() {
    ftController.text = "";
    inchController.text = "";
    weightController.text = "";
    checkData(centimeter);
    setState(() {});
  }

  }
