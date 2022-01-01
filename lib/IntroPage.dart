import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_health_calculator/utils/ConstantData.dart';
import 'package:flutter_health_calculator/utils/ConstantWidget.dart';
import 'package:flutter_health_calculator/utils/PrefData.dart';

import 'generated/l10n.dart';
import 'main.dart';

class IntroPage extends StatefulWidget {
  @override
  _IntroPage createState() {
    return _IntroPage();
  }
}

class _IntroPage extends State<IntroPage> {
  Future<bool> _requestPop() {
    if (_position > 0) {
      _position--;
      controller.jumpToPage(_position);
    } else {
      Future.delayed(const Duration(milliseconds: 200), () {
        SystemChannels.platform.invokeMethod('SystemNavigator.pop');
      });
    }

    return new Future.value(false);
  }

  final controller = PageController();

  bool isMale = true;
  int _position = 0;

  List<DropdownMenuItem<String>> typeList;

  TextEditingController ftController = new TextEditingController();
  TextEditingController inchController = new TextEditingController();

  String selectType;
  String string = "";
  bool centimeter;

  List<DropdownMenuItem<String>> currencyList;

  TextEditingController weightController = new TextEditingController();

  String selectCurrency;

  bool isKg;

  _onPageViewChange(int page) {
    _position = page;
    setState(() {});
  }

  setGender() async {
    int gender = await PrefData.getGender();

    if (gender == 0) {
      isMale = true;
    } else {
      isMale = false;
    }
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setGender();
    Future.delayed(Duration.zero, () {
      setState(() {
        typeList = buildAndGetDropDownMenuItems(
            [S.of(context).foot, S.of(context).centimeter]);

        currencyList = buildAndGetDropDownMenuItems(
            [S.of(context).kilogram, S.of(context).pounds]);

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

    double weight = await PrefData.getWeight();
    isKg = await PrefData.getKG();

    if (isKg) {
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

  void nextData() {
    saveData();

    if (_position == 2) {
      PrefData.setIntro(false);
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MyHomePage(isSplash: true,),
          ));
    } else {
      setState(() {
        _position++;

        controller.jumpToPage(_position);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetList = [
      getGenderWidget(),
      getHeightWidget(),
      getWeightWidget()
    ];

    return WillPopScope(
        child: Scaffold(
          backgroundColor: ConstantData.bgColor,

          bottomNavigationBar: ConstantWidget.getBottomButton(context,
              (_position == 2) ? S.of(context).done : S.of(context).next, () {
            nextData();
          }),

          body: Stack(
            children: [
              Visibility(child: InkWell(
                child: Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: ConstantWidget.getScreenPercentSize(context, 4.5),
                        right: ConstantWidget.getScreenPercentSize(context, 2)),
                    child: ConstantWidget.getDefaultTextWidget(
                        "Skip",
                        TextAlign.center,
                        FontWeight.w200,
                        ConstantWidget.getScreenPercentSize(context, 2),
                        ConstantData.textColor),
                  ),
                ),
                onTap: () {
                  nextData();
                },
              ),visible: (_position!=2),),
              PageView.builder(
                controller: controller,
                itemBuilder: (context, position) {
                  return widgetList[position];
                },
                itemCount: 3,
                onPageChanged: _onPageViewChange,
              )
            ],
          ),
          // body: Container(
          //   width: double.infinity,
          //   margin: EdgeInsets.all(margin),
          //   padding: EdgeInsets.symmetric(vertical: margin),
          //   child: Stack(
          //     children: [
          //
          //       Center(
          //         child: Container(
          //           width: double.infinity,
          //           child: Column(
          //             mainAxisAlignment: MainAxisAlignment.center,
          //             children: [
          //
          //               SizedBox(
          //                 height: ConstantWidget.getScreenPercentSize(context, 10),
          //               ),
          //
          //
          //               getRowCell("gender.png",S.of(context).gender,(){
          //                 Navigator.push(context, MaterialPageRoute(builder: (context) => GenderPage(),));
          //               }),
          //               getRowCell("height.png",S.of(context).height,(){
          //                 Navigator.push(context, MaterialPageRoute(builder: (context) => HeightPage(),));
          //
          //               }),
          //               getRowCell("weight.png",S.of(context).weight,(){
          //
          //                 Navigator.push(context, MaterialPageRoute(builder: (context) => WeightPage(),));
          //
          //               }),
          //
          //             ],
          //           ),
          //         ),
          //       ),
          //       Column(
          //         children: [
          //           SizedBox(
          //             height: ConstantWidget.getScreenPercentSize(context, 3),
          //           ),
          //           Center(
          //             //   alignment: Alignment.topCenter,
          //             child: ConstantWidget.getDefaultTextWidget(
          //                 S.of(context).personalData,
          //                 TextAlign.center,
          //                 FontWeight.w700,
          //                 ConstantWidget.getScreenPercentSize(context, 3.5),
          //                 ConstantData.textColor),
          //           ),
          //           SizedBox(
          //             height: ConstantWidget.getScreenPercentSize(context, 1),
          //           ),
          //           Center(
          //             //   alignment: Alignment.topCenter,
          //             child: ConstantWidget.getDefaultTextWidget(
          //                 S.of(context).persnoalDesc,
          //                 TextAlign.center,
          //                 FontWeight.w300,
          //                 ConstantWidget.getScreenPercentSize(context, 1.5),
          //                 ConstantData.textColor),
          //           )
          //         ],
          //       ),
          //
          //     ],
          //   ),
          // ),
        ),
        onWillPop: _requestPop);
  }

  getWeightWidget() {
    double margin = ConstantWidget.getScreenPercentSize(context, 3);
    double circle = ConstantWidget.getScreenPercentSize(context, 15);
    double cellHeight = ConstantWidget.getScreenPercentSize(context, 7);
    double allMargin = ConstantWidget.getScreenPercentSize(context, 1);

    Color themeColor = ConstantData.accentColor;

    return Container(
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
                      context, selectCurrency, currencyList, (value) {
                    setState(() {
                      selectCurrency = value;

                      isKg = (selectCurrency == S.of(context).kilogram);
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
                ConstantWidget.getImage(themeColor, context, "weight.png"),
                Expanded(
                  child: ConstantWidget.getTextFiled(context, themeColor,
                      S.of(context).enterWeight, cellHeight, weightController),
                  flex: 1,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  getHeightWidget() {
    double margin = ConstantWidget.getScreenPercentSize(context, 3);
    double circle = ConstantWidget.getScreenPercentSize(context, 15);
    double cellHeight = ConstantWidget.getScreenPercentSize(context, 7);
    double allMargin = ConstantWidget.getScreenPercentSize(context, 1);
    double width = ConstantWidget.getWidthPercentSize(context, 2);

    Color themeColor = ConstantData.accentColor;
    return Container(
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
    );
  }

  getGenderWidget() {
    double margin = ConstantWidget.getScreenPercentSize(context, 3);
    double circle = ConstantWidget.getScreenPercentSize(context, 15);

    return Container(
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
                  ConstantData.assetsPath + "gender_icon.png",
                  color: Colors.white,
                  height: ConstantWidget.getPercentSize(circle, 50),
                ),
              )),
          SizedBox(
            height: ConstantWidget.getScreenPercentSize(context, 3),
          ),
          ConstantWidget.getDefaultTextWidget(
              S.of(context).selectGender,
              TextAlign.center,
              FontWeight.w700,
              ConstantWidget.getScreenPercentSize(context, 3),
              ConstantData.textColor),
          SizedBox(
            height: ConstantWidget.getScreenPercentSize(context, 1),
          ),
          ConstantWidget.getDefaultTextWidget(
              S.of(context).pleaseSelectYourGender,
              TextAlign.center,
              FontWeight.w300,
              ConstantWidget.getScreenPercentSize(context, 1.5),
              ConstantData.textColor),
          //
          // SizedBox(
          //   height: ConstantWidget.getScreenPercentSize(context, 2),
          // ),
          // Container(
          //   height: cellHeight,
          //   margin: EdgeInsets.only(top: allMargin),
          //   child: Row(
          //     crossAxisAlignment: CrossAxisAlignment.center,
          //     children: [
          //       ConstantWidget.getImage(
          //           ConstantData.accentColor, context, "gender.png"),
          //       Expanded(
          //         child: ConstantWidget.getTextFiled(
          //             context,
          //             ConstantData.accentColor,
          //             S.of(context).enterAge,
          //             cellHeight,
          //             ageController),
          //         flex: 1,
          //       ),
          //
          //
          //     ],
          //   ),
          // ),
          //

          new Spacer(),
          Row(
            children: [
              getWidget("male.png", S.of(context).male, isMale ? true : false,
                  () {
                setState(() {
                  isMale = true;
                });
              }),
              SizedBox(
                width: ConstantWidget.getWidthPercentSize(context, 2),
              ),
              getWidget(
                  "female.png", S.of(context).female, isMale ? false : true,
                  () {
                setState(() {
                  isMale = false;
                });
              }),
            ],
          )
        ],
      ),
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

  getRowCell(String icon, String s, Function function) {
    double height = ConstantWidget.getScreenPercentSize(context, 8);
    return InkWell(
      child: Container(
        height: height,
        decoration: BoxDecoration(
            color: ConstantData.primaryColor,
            borderRadius: BorderRadius.all(
                Radius.circular(ConstantWidget.getPercentSize(height, 20)))),
        margin: EdgeInsets.symmetric(
            vertical: ConstantWidget.getWidthPercentSize(context, 2)),
        padding: EdgeInsets.symmetric(
            horizontal: ConstantWidget.getWidthPercentSize(context, 2)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              ConstantData.assetsPath + icon,
              color: ConstantData.textColor,
              height: ConstantWidget.getPercentSize(height, 50),
            ),
            SizedBox(
              width: ConstantWidget.getWidthPercentSize(context, 5),
            ),
            ConstantWidget.getDefaultTextWidget(
                s,
                TextAlign.center,
                FontWeight.w200,
                ConstantWidget.getPercentSize(height, 25),
                ConstantData.textColor),
            new Spacer(),
            Icon(
              CupertinoIcons.right_chevron,
              color: ConstantData.textColor,
              size: ConstantWidget.getPercentSize(height, 30),
            ),
          ],
        ),
      ),
      onTap: function,
    );
  }

  void saveData() async {
    if (isMale) {
      PrefData.setGender(0);
    } else {
      PrefData.setGender(1);
    }

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

    PrefData.setKG(isKg);

    double weight = 0;
    if (ConstantData.check(weightController.text)) {
      weight = double.parse(weightController.text);
    }

    print("weight----$weight");

    if (isKg) {
      print("weight---12-$weight");
      PrefData.setWeight(weight);
    } else {
      print("weight----12$weight");
      PrefData.setWeight(ConstantData.poundToKg(weight).roundToDouble());
    }

    weight = await PrefData.getWeight();

    if (isKg) {
      weightController.text = weight.round().toString();
    } else {
      weightController.text = ConstantData.kgToPound(weight).round().toString();
    }
  }
}
