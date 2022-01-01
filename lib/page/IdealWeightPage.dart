import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_health_calculator/generated/l10n.dart';
import 'package:flutter_health_calculator/model/ResultModel.dart';
import 'package:flutter_health_calculator/model/RowItem.dart';
import 'package:flutter_health_calculator/page/ChartPage.dart';
import 'package:flutter_health_calculator/page/ResultPage.dart';
import 'package:flutter_health_calculator/utils/ConstantData.dart';
import 'package:flutter_health_calculator/utils/ConstantWidget.dart';
import 'package:flutter_health_calculator/utils/PrefData.dart';
import 'package:flutter_health_calculator/utils/SizeConfig.dart';

class IdealWeightPage extends StatefulWidget {
  @override
  _IdealWeightPage createState() {
    return _IdealWeightPage();
  }
}

class _IdealWeightPage extends State<IdealWeightPage> {
  Color themeColor = ConstantData.primaryColor;
  TextEditingController ageController = new TextEditingController();
  bool centimeter;
  TextEditingController ftController = new TextEditingController();
  TextEditingController inchController = new TextEditingController();
  RowItem rowItem;
  List<DropdownMenuItem<String>> genderList;
  List<DropdownMenuItem<String>> typeList;
  String selectGender;
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
    ageController.text = age.toString();

    if (gender == null) {
      gender = 0;
    }

    selectGender = genderList[gender].value;

    if (centimeter) {
      selectType = typeList[1].value;
      string = S.of(context).ft;
      ftController.text = ConstantData.meterToCm(height).round().toString();
    } else {
      print("age---${ageController.text.toString()}");

      selectType = typeList[0].value;
      string = S.of(context).cm;
      setState(() {
        ConstantData.meterToInchAndFeet(height, ftController, inchController);
      });
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

    return ConstantWidget.getMainDefaultWidget(
        context, getWidget(), rowItem, _requestPop);
  }

  Widget getWidget() {

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
              ConstantWidget.getImage(themeColor, context, "gender.png"),
              Expanded(
                child: ConstantWidget.getTextFiled(context, themeColor,
                    S.of(context).enterAge, cellHeight, ageController),
                flex: 1,
              ),
              SizedBox(
                width: width,
              ),
              Container(
                width: ConstantWidget.getWidthPercentSize(context, 30),
                child: ConstantWidget.getDropDown(
                    context, selectGender, genderList, (value) {
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
              ConstantWidget.getImage(themeColor, context, "height.png"),
              Expanded(
                child: ConstantWidget.getDropDown(context, selectType, typeList,
                    (value) {
                  bool oldVal = centimeter;

                  setState(() {
                    selectType = value;

                    centimeter = (selectType == S.of(context).centimeter);

                    checkData(oldVal);

                    if (selectType == S.of(context).centimeter) {
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
              ConstantWidget.getImage(themeColor, context, "centimeter.png"),
              Expanded(
                child: ConstantWidget.getTextFiled(context, themeColor,
                    S.of(context).enterHeight, cellHeight, ftController),
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
                      ConstantWidget.getPercentSize(cellHeight, 30),
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
                ConstantWidget.getImage(themeColor, context, "inch.png"),
                Expanded(
                  child: ConstantWidget.getTextFiled(context, themeColor,
                      S.of(context).enterHeight, cellHeight, inchController),
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
                      ConstantWidget.getPercentSize(cellHeight, 30),
                      ConstantData.textColor),
                  flex: 1,
                )
              ],
            ),
          ),
          visible: (selectType == S.of(context).foot),
        ),
        ConstantWidget.getButtonWidget(
            context, themeColor, S.of(context).idealWeightChart, (type) {
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
    bool check = false;

    if (centimeter) {
      if (ConstantData.check(ftController.text)) {
        height = double.parse(ftController.text);
      } else {
        check = true;
      }
    } else {
      int h1 = 0, h2 = 0;
      if (ConstantData.check(ftController.text)) {
        h1 = int.parse(ftController.text);
      } else {
        check = true;
      }
      if (ConstantData.check(inchController.text)) {
        h2 = int.parse(inchController.text);
      } else {
        check = true;
      }
      double iww = ConstantData.feetAndInchToMeter(h1, h2);
      height = ConstantData.meterToCm(iww).roundToDouble();
    }

    if (ConstantData.check(ageController.text)) {
    } else {
      check = true;
    }


    if (check) {
      ConstantData.showToast(S.of(context).pleaseEnterValidValues, context);
      check = false;
    } else {
      if (height < 153) {
        ConstantData.showToast(
            S.of(context).youMustBeOver153CmToCalculateIdealWeight, context);
      } else {
        height *= 0.393701;
        height -= 60.0;

        double id;

        if (selectGender == S.of(context).male) {
          id = (height * 1.9) + 52.0;
        } else {
          id = (height * 1.7) + 49.0;
        }

        String value1 = ConstantData.formatData(id);

        id *= 2.20462;

        String value2 = ConstantData.formatData(id);
        resultModel = new ResultModel();
        resultModel.value1 = value1;
        resultModel.value2 = value2;

        ConstantWidget.showAds(interstitialAd, (value) {
          passData();
        });
      }
    }
  }

  void reset() {
    ageController.text = "";
    ftController.text = "";
    inchController.text = "";
    checkData(centimeter);
    setState(() {});
  }

  void passData() {
    ConstantWidget.sendData(
        context, resultModel, ResultPage(resultModel, rowItem));
  }
}
