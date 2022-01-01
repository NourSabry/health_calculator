import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_health_calculator/generated/l10n.dart';
import 'package:flutter_health_calculator/model/ResultModel.dart';
import 'package:flutter_health_calculator/model/RowItem.dart';

import 'ConstantData.dart';
import 'PrefData.dart';
import 'SizeConfig.dart';

class ConstantWidget {
  static double getPercentSize(double total, double percent) {
    return (total * percent) / 100;
  }

  static double largeTextSize = 28;

  static double getHeaderSize(BuildContext context) {
    return ConstantWidget.getScreenPercentSize(context, 3);
  }

  static double getSubTitleSize(BuildContext context) {
    return ConstantWidget.getScreenPercentSize(context, 2);
  }

  static double getActionTextSize(BuildContext context) {
    return ConstantWidget.getScreenPercentSize(context, 1.8);
  }

  static double getDefaultDialogPadding(BuildContext context) {
    return ConstantWidget.getScreenPercentSize(context, 2);
  }

  static double getDefaultDialogRadius(BuildContext context) {
    return ConstantWidget.getScreenPercentSize(context, 1);
  }

  static double getScreenPercentSize(BuildContext context, double percent) {
    return (MediaQuery.of(context).size.height * percent) / 100;
  }

  static double getWidthPercentSize(BuildContext context, double percent) {
    return (MediaQuery.of(context).size.width * percent) / 100;
  }

  static Widget getSpace(double space) {
    return SizedBox(
      height: space,
    );
  }

  static Widget getDefaultTextWidget(String s, TextAlign textAlign,
      FontWeight fontWeight, double fontSize, var color) {
    return Text(
      s,
      textAlign: textAlign,
      style: TextStyle(
          fontFamily: ConstantData.fontFamily,
          fontWeight: fontWeight,
          fontSize: fontSize,
          color: color),
    );
  }

  static Widget textOverFlowWidget(String s, FontWeight fontWeight, int maxLine,
      double fontSize, Color color) {
    return new Text(
      s,
      maxLines: maxLine,
      overflow: TextOverflow.ellipsis,
      style: new TextStyle(
        fontFamily: ConstantData.fontFamily,
        fontWeight: fontWeight,
        fontSize: fontSize,
        color: color,
      ),
    );
  }

  static Widget getCustomText(String text, Color color, int maxLine,
      TextAlign textAlign, FontWeight fontWeight, double textSizes) {
    return Text(
      text,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
          decoration: TextDecoration.none,
          fontSize: textSizes,
          color: color,
          fontFamily: ConstantData.fontFamily,
          fontWeight: fontWeight),
      maxLines: maxLine,
      textAlign: textAlign,
    );
  }

  static Widget getTextFiled(BuildContext context, Color themeColor, String s,
      double height, TextEditingController textEditingController) {
    double cellHeight = ConstantWidget.getScreenPercentSize(context, 5.5);

    return Container(
      height: cellHeight,
      child: Theme(
        data: new ThemeData(
          primaryColor: ConstantData.textColor,
          accentColor: ConstantData.textColor,
          hintColor: ConstantData.textColor,
        ),

        child: TextFormField(
          maxLines: 1,
          controller: textEditingController,

          cursorColor: ConstantData.textColor,
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly
          ], // Only numbers
          style: TextStyle(
              decoration: TextDecoration.none,
              fontSize: ConstantWidget.getPercentSize(cellHeight, 30),
              color: ConstantData.textColor,
              fontFamily: ConstantData.fontFamily,
              fontWeight: FontWeight.w400),
          decoration: InputDecoration(
            labelText: s,
            labelStyle: TextStyle(
                decoration: TextDecoration.none,
                fontSize: ConstantWidget.getPercentSize(cellHeight, 30),
                color: ConstantData.textColor,
                fontFamily: ConstantData.fontFamily,
                fontWeight: FontWeight.w300),
            hintStyle: TextStyle(
                decoration: TextDecoration.none,
                fontSize: ConstantWidget.getPercentSize(cellHeight, 25),
                color: ConstantData.textColor,
                fontFamily: ConstantData.fontFamily,
                fontWeight: FontWeight.w300),
            border: OutlineInputBorder(),
          ),
        ),
        // child: new TextField(
        //   controller: textEditingController,
        //   maxLines: 1,
        //   cursorColor: themeColor,
        //   style: TextStyle(
        //       decoration: TextDecoration.none,
        //       fontSize: ConstantWidget.getPercentSize(height, 25),
        //       color: ConstantData.textColor,
        //       fontFamily: ConstantData.fontFamily,
        //       fontWeight: FontWeight.w300),
        //   keyboardType: TextInputType.number,
        //   decoration: new InputDecoration(
        //       contentPadding: EdgeInsets.zero,
        //       labelText: s,
        //       labelStyle: TextStyle(
        //           decoration: TextDecoration.none,
        //           fontSize: ConstantWidget.getPercentSize(height, 30),
        //           color: ConstantData.textColor,
        //           fontFamily: ConstantData.fontFamily,
        //           fontWeight: FontWeight.w300)),
        //   onChanged: (value) {},
        // ),
      ),
    );
  }

  static Widget getDropDown(BuildContext context, String value,
      List<DropdownMenuItem<String>> _dropDownMenuItems, Function function) {
    double cellHeight = ConstantWidget.getScreenPercentSize(context, 7);

    return Container(
      width: double.infinity,
      margin:
          EdgeInsets.only(top: ConstantWidget.getPercentSize(cellHeight, 30)),
      child: DropdownButton(
        isExpanded: true,
        style: TextStyle(
            decoration: TextDecoration.none,
            fontSize: ConstantWidget.getPercentSize(cellHeight, 25),
            color: ConstantData.textColor,
            fontFamily: ConstantData.fontFamily,
            fontWeight: FontWeight.w300),
        value: value,
        items: _dropDownMenuItems,
        onChanged: function,
        underline: Container(
          height: ConstantWidget.getWidthPercentSize(context, 0.2),
          color: ConstantData.textColor,
        ),
      ),
    );
  }

  static Widget getImage(Color themeColor, BuildContext context, String s) {
    double cellHeight = ConstantWidget.getScreenPercentSize(context, 7);

    // double imgHeight = ConstantWidget.getPercentSize(cellHeight, 60);
    // double imgWidth = ConstantWidget.getWidthPercentSize(context, 7);
    //

    double imgHeight = ConstantWidget.getPercentSize(cellHeight, 62);
    double imgWidth = ConstantWidget.getWidthPercentSize(context, 8);

    Color color = themeColor;
    if (s == null) {
      color = Colors.transparent;
      s = "frequency-reading.png";
    }
    return Container(
      margin: EdgeInsets.only(
          right: ConstantWidget.getWidthPercentSize(context, 4)),
      child: Image.asset(
        ConstantData.assetsPath + s,
        color: color,
        height: imgHeight,
        width: imgWidth,
      ),
      // ),
    );
  }

  static getButton(
      BuildContext context, String s, Color color, Function function) {
    double buttonHeight = ConstantWidget.getScreenPercentSize(context, 6);

    double subRadius = ConstantWidget.getWidthPercentSize(context, 1.5);
    double fontSize = ConstantWidget.getPercentSize(buttonHeight, 32);
    double sliderHeight = SizeConfig.safeBlockVertical * 18;

    double margin = ConstantWidget.getPercentSize(sliderHeight, 13);

    return InkWell(
      child: Container(
        margin: EdgeInsets.only(top: (margin)),
        height: buttonHeight,
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.all(Radius.circular(subRadius))),
        child: Center(
          child: ConstantWidget.getDefaultTextWidget(
              s, TextAlign.center, FontWeight.w500, fontSize, Colors.white),
        ),
      ),
      onTap: function,
    );
  }

  static getDecoration(BuildContext context, Color themeColor) {
    return BoxDecoration(
        color: Colors.white,
        border: Border.all(
            color: themeColor,
            width: ConstantWidget.getScreenPercentSize(context, 0.2)));
  }

  static getBanner() {
    return Container(
      height: 55,
      color: ConstantData.bgColor,
      child: AdmobBanner(
        adUnitId: ConstantData.getBannerAdUnitId(),
        adSize: AdmobBannerSize.BANNER,
        listener: (AdmobAdEvent event, Map<String, dynamic> args) {},
        onBannerCreated: (AdmobBannerController controller) {},
      ),
    );
  }

  static getAppBar(String s, Color color, Color iconColor, double elevation,
      Function function) {
    return AppBar(
        backgroundColor: color,
        title: Text(
          s,
          style:
              TextStyle(fontFamily: ConstantData.fontFamily, color: iconColor),
        ),
        elevation: elevation,
        leading: InkWell(
          onTap: function,
          child: Icon(
            Icons.keyboard_backspace_outlined,
            color: iconColor,
          ),
        ));
  }

  static getSubDefaultWidget(
      BuildContext context, Widget widget, RowItem rowItem, Function function) {
    double sliderHeight = SizeConfig.safeBlockVertical * 12;
    double radius = ConstantWidget.getScreenPercentSize(context, 3.5);
    double margin = ConstantWidget.getPercentSize(sliderHeight, 10);

    return WillPopScope(
        child: Scaffold(
            backgroundColor: ConstantData.bgColor,
            bottomNavigationBar: ConstantWidget.getBanner(),
            appBar: ConstantWidget.getAppBar(
                rowItem.title, rowItem.color, Colors.white, 0, function),
            body: Container(
              width: double.infinity,
              height: double.infinity,
              color: ConstantData.bgColor,
              child: Stack(
                children: [
                  Container(
                    height: sliderHeight,
                    color: rowItem.color,
                  ),
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      color: ConstantData.bgColor,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(radius),
                        topLeft: Radius.circular(radius),
                      ),
                    ),
                    padding: EdgeInsets.all(margin),
                    child: widget,
                  )
                ],
              ),
            )),
        onWillPop: function);
  }

  static getBottomButton(BuildContext context, String s, Function function) {
    double margin = ConstantWidget.getScreenPercentSize(context, 3);

    double bottomHeight = ConstantWidget.getScreenPercentSize(context, 15);
    double height = ConstantWidget.getPercentSize(bottomHeight, 49);

    return Container(
        height: bottomHeight,
        margin: EdgeInsets.symmetric(horizontal: margin),
        child: InkWell(
          child: Center(
            child: Container(
              width: double.infinity,
              height: height,
              decoration: BoxDecoration(
                  color: ConstantData.accentColor,
                  borderRadius: BorderRadius.all(Radius.circular(
                      ConstantWidget.getPercentSize(height, 10)))),
              child: Center(
                child: ConstantWidget.getDefaultTextWidget(
                    s,
                    TextAlign.center,
                    FontWeight.w700,
                    ConstantWidget.getPercentSize(height, 38),
                    Colors.white),
              ),
            ),
          ),
          onTap: function,
        ));
  }

  static getMainDefaultWidget(
      BuildContext context, Widget widget, RowItem rowItem, Function function) {
    double sliderHeight = SizeConfig.safeBlockVertical * 18;
    double radius = ConstantWidget.getScreenPercentSize(context, 3.5);
    double paddingBottom = ConstantWidget.getPercentSize(sliderHeight, 3);
    double margin = ConstantWidget.getPercentSize(sliderHeight, 13);

    return WillPopScope(
        child: Scaffold(
            backgroundColor: ConstantData.bgColor,
            body: Stack(
              children: [
                Container(
                  height: sliderHeight + sliderHeight,
                  color: rowItem.color,
                ),
                NestedScrollView(
                    headerSliverBuilder: (context, innerBoxIsScrolled) {
                      return <Widget>[
                        SliverAppBar(
                            automaticallyImplyLeading: false,
                            backgroundColor: Colors.transparent,
                            leading: InkWell(
                              onTap: function,
                              child: Icon(
                                Icons.keyboard_backspace_outlined,
                                color: Colors.white,
                              ),
                            ),
                            expandedHeight: sliderHeight,
                            flexibleSpace: FlexibleSpaceBar(
                                centerTitle: false,
                                background: Container(
                                  color: rowItem.color,
                                  padding: EdgeInsets.all(margin),
                                  child: Stack(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(
                                            top: ConstantWidget.getPercentSize(
                                                sliderHeight, 22),
                                            left: ConstantWidget
                                                .getWidthPercentSize(
                                                    context, 50)),
                                        child: Center(
                                          child: Image.asset(
                                              ConstantData.assetsPath +
                                                  rowItem.transImage),
                                          // "transparent_bmi_icon.png"),
                                        ),
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          ConstantWidget.textOverFlowWidget(
                                              rowItem.title,
                                              FontWeight.w500,
                                              1,
                                              ConstantWidget.getPercentSize(
                                                  sliderHeight, 13),
                                              Colors.white),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: (paddingBottom)),
                                            child: ConstantWidget
                                                .textOverFlowWidget(
                                                    rowItem.description,
                                                    FontWeight.normal,
                                                    2,
                                                    ConstantWidget
                                                        .getPercentSize(
                                                            sliderHeight, 8),
                                                    Colors.white),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ))),
                      ];
                    },
                    body: Container(
                      width: double.infinity,
                      height: double.infinity,
                      child: Container(
                        decoration: BoxDecoration(
                          color: ConstantData.bgColor,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(radius),
                            topLeft: Radius.circular(radius),
                          ),
                        ),
                        padding: EdgeInsets.all(margin),
                        child: widget,
                      ),
                    ))
              ],
            ),
            bottomNavigationBar: ConstantWidget.getBanner()),
        onWillPop: function);
  }

  static getInterstitialAd(Function function) {
    AdmobInterstitial interstitialAd = AdmobInterstitial(
      adUnitId: ConstantData.getInterstitialAdUnitId(),
      listener: (AdmobAdEvent event, Map<String, dynamic> args) {
        if (event == AdmobAdEvent.closed) {
          function();
        }
      },
    );
    interstitialAd.load();
    return interstitialAd;
  }

  static sendData(
      BuildContext context, ResultModel resultModel, Widget widget) {
    if (resultModel != null) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => widget,
          ));
    }
    // Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //       builder: (context) => widget,
    //     ));
  }

  static showAds(
      AdmobInterstitial interstitialAd, ValueChanged<bool> function) async {
    int click = await PrefData.getClick();
    bool load = await interstitialAd.isLoaded;

    if (load && click > 1) {
      interstitialAd.show();
      PrefData.setClick(0);
      // function(false);
    } else {
      PrefData.setClick((click + 1));
      function(true);
    }
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
        InkWell(
          child: Container(
            margin: EdgeInsets.only(top: (margin)),
            height: buttonHeight,
            decoration: BoxDecoration(
                color: themeColor,
                borderRadius: BorderRadius.all(Radius.circular(subRadius))),
            child: Center(
              child: ConstantWidget.getDefaultTextWidget(
                  s, TextAlign.center, FontWeight.w500, fontSize, Colors.white),
            ),
          ),
          onTap: () {
            function(ConstantData.chart);
          },
        )
      ],
    );
  }
}
