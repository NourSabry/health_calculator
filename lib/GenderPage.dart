import 'package:flutter/material.dart';
import 'package:flutter_health_calculator/utils/ConstantData.dart';
import 'package:flutter_health_calculator/utils/ConstantWidget.dart';
import 'package:flutter_health_calculator/utils/PrefData.dart';

import 'generated/l10n.dart';

class GenderPage extends StatefulWidget {
  @override
  _GenderPage createState() {
    return _GenderPage();
  }
}

class _GenderPage extends State<GenderPage> {
  Future<bool> _requestPop() {
    Navigator.of(context).pop();
    return new Future.value(true);
  }


  bool isMale = true;


  TextEditingController ageController = new TextEditingController();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setGender();




  }

  List<DropdownMenuItem<String>> buildAndGetDropDownMenuItems(List fruits) {
    List<DropdownMenuItem<String>> items = [];
    for (String fruit in fruits) {
      items.add(new DropdownMenuItem(value: fruit, child: new Text(fruit)));
    }
    return items;
  }

  setGender() async {
    int gender = await PrefData.getGender();
    int age = await PrefData.getAge();
    ageController.text = age.toString();

    if (gender == 0) {
      isMale = true;
    } else {
      isMale = false;
    }
    setState(() {});
  }

  saveData(){
    if (isMale) {
      PrefData.setGender(0);
    } else {
      PrefData.setGender(1);
    }


    int age = 0;
    if (ConstantData.check(ageController.text)) {
      age = int.parse(ageController.text);
    }

    PrefData.setAge(age);

    _requestPop();
  }

  @override
  Widget build(BuildContext context) {
    double margin = ConstantWidget.getScreenPercentSize(context, 3);
    double circle = ConstantWidget.getScreenPercentSize(context, 15);


    return WillPopScope(
      child: Scaffold(
        backgroundColor: ConstantData.bgColor,


        bottomNavigationBar:
            ConstantWidget.getBottomButton(context, S.of(context).done, () {
        saveData();
        }),
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
                  getWidget(
                      "male.png", S.of(context).male, isMale ? true : false,
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
