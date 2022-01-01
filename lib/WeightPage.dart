import 'package:flutter/material.dart';
import 'package:flutter_health_calculator/utils/ConstantData.dart';
import 'package:flutter_health_calculator/utils/ConstantWidget.dart';
import 'package:flutter_health_calculator/utils/PrefData.dart';

import 'generated/l10n.dart';

class WeightPage extends StatefulWidget {
  @override
  _WeightPage createState() {
    return _WeightPage();
  }
}

class _WeightPage extends State<WeightPage> {
  Future<bool> _requestPop() {
    Navigator.of(context).pop();
    return new Future.value(true);
  }

  List<DropdownMenuItem<String>> currencyList;

  TextEditingController weightController = new TextEditingController();

  String selectCurrency;

  bool isKg;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(Duration.zero, () {
      setState(() {
        currencyList = buildAndGetDropDownMenuItems(
            [S.of(context).kilogram, S.of(context).pounds]);

        setDefaultData();
      });
    });
  }

  List<DropdownMenuItem<String>> buildAndGetDropDownMenuItems(List fruits) {
    List<DropdownMenuItem<String>> items = [];
    for (String fruit in fruits) {
      items.add(new DropdownMenuItem(value: fruit, child: new Text(fruit)));
    }
    return items;
  }

  setDefaultData() async {
    double weight = await PrefData.getWeight();
    isKg = await PrefData.getKG();

    if (isKg) {
      selectCurrency = currencyList[0].value;
      weightController.text = weight.round().toString();
    } else {
      selectCurrency = currencyList[1].value;
      weightController.text = ConstantData.kgToPound(weight).round().toString();
    }

    setState(() {});
  }




  void saveData() {

    PrefData.setKG(isKg);

    double weight = 0;
    if (ConstantData.check(weightController.text)) {
      weight = double.parse(weightController.text);
    }

    if (isKg) {
      PrefData.setWeight(weight);
    } else {
      PrefData.setWeight(ConstantData.poundToKg(weight).roundToDouble());
    }

    _requestPop();
  }

  @override
  Widget build(BuildContext context) {
    double margin = ConstantWidget.getScreenPercentSize(context, 3);
    double circle = ConstantWidget.getScreenPercentSize(context, 15);
    double cellHeight = ConstantWidget.getScreenPercentSize(context, 7);
    double allMargin = ConstantWidget.getScreenPercentSize(context, 1);


    Color themeColor = ConstantData.accentColor;
    return WillPopScope(
      child: Scaffold(
        backgroundColor: ConstantData.bgColor,
        bottomNavigationBar: ConstantWidget.getBottomButton(
            context, S.of(context).done, saveData),
        body: Container(
          width: double.infinity,
          margin: EdgeInsets.all(margin),
          padding: EdgeInsets.symmetric(vertical: margin),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: ConstantWidget.getScreenPercentSize(context, 3),
              ),
              Container(
                  height: circle,
                  width: circle,
                  decoration: BoxDecoration(
                    color: ConstantData.accentColor,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Image.asset(
                      ConstantData.assetsPath + "human_weight.png",
                      color: Colors.white,
                      height: ConstantWidget.getPercentSize(circle, 50),
                    ),
                  )),
              SizedBox(
                height: ConstantWidget.getScreenPercentSize(context, 3),
              ),
              ConstantWidget.getDefaultTextWidget(
                  S.of(context).weight,
                  TextAlign.center,
                  FontWeight.w700,
                  ConstantWidget.getScreenPercentSize(context, 3),
                  ConstantData.textColor),
              SizedBox(
                height: ConstantWidget.getScreenPercentSize(context, 1),
              ),
              ConstantWidget.getDefaultTextWidget(
                  S.of(context).youNeedToCreateANewBasicProfileWithWeight,
                  TextAlign.center,
                  FontWeight.w300,
                  ConstantWidget.getScreenPercentSize(context, 1.5),
                  ConstantData.textColor),
              SizedBox(
                height: ConstantWidget.getScreenPercentSize(context, 2),
              ),



              Container(
                height: cellHeight,
                margin: EdgeInsets.only(top: allMargin),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ConstantWidget.getImage(
                        themeColor, context, "weight-scale.png"),
                    Expanded(
                      child: ConstantWidget.getDropDown(
                          context, selectCurrency, currencyList,
                              (value) {
                            setState(() {
                              selectCurrency = value;

                              isKg = (selectCurrency ==
                                  S.of(context).kilogram);
                            });
                          }),
                      flex: 1,
                    ),


                  ],
                ),
              ),
              SizedBox(
                height: ConstantWidget.getScreenPercentSize(context, 0.5),
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


                  ],
                ),
              ),


            ],
          ),

        ),
      ),
      onWillPop: _requestPop,
    );
  }


}
