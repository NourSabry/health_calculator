import 'package:flutter/material.dart';
import 'package:flutter_health_calculator/utils/ConstantData.dart';
import 'package:flutter_health_calculator/utils/ConstantWidget.dart';
import 'package:flutter_health_calculator/utils/PrefData.dart';

import 'generated/l10n.dart';

class HeightPage extends StatefulWidget {
  @override
  _HeightPage createState() {
    return _HeightPage();
  }
}

class _HeightPage extends State<HeightPage> {
  Future<bool> _requestPop() {
    Navigator.of(context).pop();
    return new Future.value(true);
  }

  List<DropdownMenuItem<String>> typeList;

  TextEditingController ftController = new TextEditingController();
  TextEditingController inchController = new TextEditingController();

  bool isMale = true;
  String selectType;
  String string = "";
  bool centimeter;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(Duration.zero, () {
      setState(() {
        typeList = buildAndGetDropDownMenuItems(
            [S.of(context).foot, S.of(context).centimeter]);

        selectType = typeList[0].value;

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
    double height = await PrefData.getHeight();
    centimeter = await PrefData.getCM();

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

  void saveData() {
    PrefData.setCM(centimeter);

    if (centimeter) {
      double i = 0;

      if (ConstantData.check(ftController.text)) {
        i = double.parse(ftController.text);
      }
      PrefData.setHeight(ConstantData.cmToMeter(i));
    } else {
      int feet = 0;
      if (ConstantData.check(ftController.text)) {
        feet = int.parse(ftController.text);
      }
      int inch = 0;
      if (ConstantData.check(inchController.text)) {
        inch = int.parse(inchController.text);
      }

      PrefData.setHeight(ConstantData.feetAndInchToMeter(feet, inch));
    }




    _requestPop();
  }

  @override
  Widget build(BuildContext context) {
    double margin = ConstantWidget.getScreenPercentSize(context, 3);
    double circle = ConstantWidget.getScreenPercentSize(context, 15);
    double cellHeight = ConstantWidget.getScreenPercentSize(context, 7);
    double allMargin = ConstantWidget.getScreenPercentSize(context, 1);
    double width = ConstantWidget.getWidthPercentSize(context, 2);

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
                      ConstantData.assetsPath + "human_height.png",
                      color: Colors.white,
                      height: ConstantWidget.getPercentSize(circle, 50),
                    ),
                  )),
              SizedBox(
                height: ConstantWidget.getScreenPercentSize(context, 3),
              ),
              ConstantWidget.getDefaultTextWidget(
                  S.of(context).height,
                  TextAlign.center,
                  FontWeight.w700,
                  ConstantWidget.getScreenPercentSize(context, 3),
                  ConstantData.textColor),
              SizedBox(
                height: ConstantWidget.getScreenPercentSize(context, 1),
              ),
              ConstantWidget.getDefaultTextWidget(
                  S.of(context).youNeedToCreateANewBasicProfileWithHeight,
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
                  children: [
                    ConstantWidget.getImage(themeColor, context, "height.png"),
                    Expanded(
                      child: ConstantWidget.getDropDown(
                          context, selectType, typeList, (value) {
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
                    ConstantWidget.getImage(
                        themeColor, context, "centimeter.png"),
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
                            ConstantWidget.getPercentSize(cellHeight, 30),
                            ConstantData.textColor),
                        flex: 1,
                      )
                    ],
                  ),
                ),
                visible: (selectType == S.of(context).foot),
              ),
            ],
          ),
          // child: Stack(
          //   children: [
          //
          //     // Column(
          //     //   children: [
          //     //     SizedBox(
          //     //       height: ConstantWidget.getScreenPercentSize(context, 3),
          //     //     ),
          //     //     Center(
          //     //       //   alignment: Alignment.topCenter,
          //     //       child: ConstantWidget.getDefaultTextWidget(
          //     //           S.of(context).selectGender,
          //     //           TextAlign.center,
          //     //           FontWeight.w700,
          //     //           ConstantWidget.getScreenPercentSize(context, 3.5),
          //     //           ConstantData.textColor),
          //     //     ),
          //     //
          //     //
          //     //   ],
          //     // ),
          //
          //
          //     Center(
          //       child: Wrap(
          //
          //         children: [
          //           Row(
          //
          //
          //
          //             children: [
          //
          //               getWidget("male.png", S.of(context).male,isMale?true:false,(){
          //                 setState(() {
          //                   isMale=true;
          //                 });
          //               }),
          //               getWidget("female.png", S.of(context).female,isMale?false:true,(){
          //                 setState(() {
          //                   isMale=false;
          //                 });
          //               }),
          //
          //
          //             ],
          //           )
          //         ],
          //       ),
          //     )
          //   ],
          // ),
        ),
      ),
      onWillPop: _requestPop,
    );
  }

  getWidget(String icon, String name, bool selected, Function function) {
    double height = ConstantWidget.getScreenPercentSize(context, 25);
    double margin = ConstantWidget.getWidthPercentSize(context, 1);
    // double margin = ConstantWidget.getWidthPercentSize(context, 6);
    // double height = ConstantWidget.getScreenPercentSize(context, 12);

    double subRadius = ConstantWidget.getWidthPercentSize(context, 2);

    double imgHeight = ConstantWidget.getPercentSize(height, 40);

    return Expanded(
      child: InkWell(
        child: Container(
          height: height,
          margin: EdgeInsets.symmetric(horizontal: margin),

          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade200,
                  blurRadius: 10,
                )
              ],
              color: Colors.white,
              border: Border.all(
                  width: ConstantWidget.getPercentSize(height, 1),
                  color: (selected) ? ConstantData.accentColor : Colors.white),
              borderRadius: BorderRadius.all(Radius.circular(subRadius))),

          // foregroundDecoration: (selected)
          //     ? null
          //     : BoxDecoration(
          //         color: Colors.grey,
          //         backgroundBlendMode: BlendMode.saturation,
          //       ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  height: imgHeight,
                  decoration: BoxDecoration(
                    color: ConstantData.accentColor,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade200,
                        blurRadius: 10,
                      )
                    ],

                    // image: DecorationImage(
                    //     image: AssetImage(
                    //   ConstantData.assetsPath + icon,
                    // ))
                  ),
                  child: Center(
                    child: Image.asset(
                      ConstantData.assetsPath + icon,
                      height: ConstantWidget.getPercentSize(imgHeight, 70),
                    ),
                  )),
              SizedBox(
                height: ConstantWidget.getPercentSize(height, 5),
              ),
              ConstantWidget.getDefaultTextWidget(
                  name,
                  TextAlign.center,
                  FontWeight.w500,
                  ConstantWidget.getPercentSize(height, 8),
                  ConstantData.textColor),
            ],
          ),
        ),
        onTap: function,
      ),
      flex: 1,
    );
  }
}
