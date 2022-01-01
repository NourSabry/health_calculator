import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:admob_flutter/admob_flutter.dart';
import 'package:feedback/feedback.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter_health_calculator/customWidget/MotionTabController.dart';
import 'package:flutter_health_calculator/data/DataFile.dart';
import 'package:flutter_health_calculator/page/BloodAlcoholPage.dart';
import 'package:flutter_health_calculator/page/BloodDonationPage.dart';
import 'package:flutter_health_calculator/page/BloodPressurePage.dart';
import 'package:flutter_health_calculator/page/BloodVolumePage.dart';
import 'package:flutter_health_calculator/page/BodyFatPage.dart';
import 'package:flutter_health_calculator/page/BodyMassPage.dart';
import 'package:flutter_health_calculator/page/BreathCountPage.dart';
import 'package:flutter_health_calculator/page/CaloriesWeightPage.dart';
import 'package:flutter_health_calculator/page/IdealWeightPage.dart';
import 'package:flutter_health_calculator/page/HeartRatePage.dart';
import 'package:flutter_health_calculator/page/OvulationPage.dart';
import 'package:flutter_health_calculator/page/PregnancyPage.dart';
import 'package:flutter_health_calculator/page/WaterIntakePage.dart';
import 'package:flutter_health_calculator/utils/ConstantData.dart';
import 'package:flutter_health_calculator/utils/ConstantWidget.dart';
import 'package:flutter_health_calculator/utils/PrefData.dart';
import 'package:flutter_health_calculator/utils/SizeConfig.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:launch_review/launch_review.dart';
import 'package:path_provider/path_provider.dart';

import 'IntroPage.dart';
import 'customWidget/fab_bottom_app_bar.dart';
import 'customWidget/fab_with_icons.dart';
import 'customWidget/layout.dart';
import 'customWidget/motiontabbar.dart';
import 'generated/l10n.dart';
import 'model/RowItem.dart';
import 'model/ScreenArguments.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Admob.initialize();

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(
    BetterFeedback(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ThemeData themeData = new ThemeData(
        primaryColor: ConstantData.primaryColor,
        splashColor: Colors.transparent,
        textTheme: Theme.of(context).textTheme.apply(fontFamily: 'Poppins'),
        primaryTextTheme:
            Theme.of(context).textTheme.apply(fontFamily: 'Poppins'),
        accentTextTheme:
            Theme.of(context).textTheme.apply(fontFamily: 'Poppins'),
        primaryColorDark: ConstantData.primaryColor,
        accentColor: ConstantData.accentColor);

    return MaterialApp(
      routes: {
        "/IdealWeightPage": (context) => IdealWeightPage(),
        "/BodyMassPage": (context) => BodyMassPage(),
        "/BodyFatPage": (context) => BodyFatPage(),
        "/CaloriesWeightPage": (context) => CaloriesWeightPage(),
        "/WaterIntakePage": (context) => WaterIntakePage(),
        "/HeartRatePage": (context) => HeartRatePage(),
        "/PregnancyPage": (context) => PregnancyPage(),
        "/OvulationPage": (context) => OvulationPage(),
        "/BloodVolumePage": (context) => BloodVolumePage(),
        "/BloodDonationPage": (context) => BloodDonationPage(),
        "/BloodAlcoholPage": (context) => BloodAlcoholPage(),
        "/BreathCountPage": (context) => BreathCountPage(),
        "/BloodPressurePage": (context) => BloodPressurePage(),
      },
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        S.delegate
      ],
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: themeData,
      home: MyHomePage(
        title: 'Flutter Demo Home Page',
        isSplash: true,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title, this.isSplash}) : super(key: key);

  final String title;
  final bool isSplash;

  @override
  _MyHomePageState createState() => _MyHomePageState(this.isSplash);
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  MotionTabBar motionTabBar;
  List<String> s = ["Setting", "Home", "Profile"];
  List<RowItem> rowItemList = [];
  MotionTabController _tabController;
  int _selectedIndex = 2;
  AdmobInterstitial interstitialAd;
  RowItem rowItem;

  TextEditingController ageController = new TextEditingController();
  TextEditingController weightController = new TextEditingController();
  bool centimeter;
  bool kg;
  TextEditingController ftController = new TextEditingController();
  TextEditingController inchController = new TextEditingController();
  List<DropdownMenuItem<String>> genderList;
  List<DropdownMenuItem<String>> typeList;
  List<DropdownMenuItem<String>> currencyList;
  String selectGender;
  String selectCurrency;
  String selectType;
  String string = "";
  bool isSplash = false;

  @override
  void dispose() {
    interstitialAd.dispose();
    super.dispose();
  }

  _MyHomePageState(this.isSplash);

  Future<bool> _requestPop() {
    if (_selectedIndex != 2) {
      // if (_selectedIndex == 0 || _selectedIndex == 2) {
      _tabController.index = 2;
      _selectedIndex = 2;

      setState(() {});
    } else {
      Future.delayed(const Duration(milliseconds: 200), () {
        SystemChannels.platform.invokeMethod('SystemNavigator.pop');
      });
    }
    return new Future.value(false);
  }

  void checkIntro() async {
    bool isIntro = await PrefData.getIntro();

    if (isIntro) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => IntroPage(),
          ));
    } else {
      if (isSplash) {
        Timer(Duration(seconds: 3), () {
          setState(() {
            isSplash = false;
          });
        });
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    checkIntro();

    _tabController =
        new MotionTabController(initialIndex: _selectedIndex, vsync: this);

    interstitialAd = ConstantWidget.getInterstitialAd(() {
      sendPage(rowItem);
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
        selectGender = genderList[0].value;
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

  Widget _buildFab(BuildContext context) {
    final icons = [Icons.sms, Icons.mail, Icons.phone];
    return AnchoredOverlay(
      showOverlay: false,
      overlayBuilder: (context, offset) {
        return CenterAbout(
          position: Offset(offset.dx, offset.dy - icons.length * 35.0),
          child: FabWithIcons(
            icons: icons,
            onIconTapped: selectPosition,
          ),
        );
      },
      child: FloatingActionButton(
        backgroundColor: ConstantData.accentColor,
        onPressed: () {
          selectPosition(2);
        },
        // onPressed: () { },
        tooltip: 'Increment',
        child: Icon(
          Icons.home,
          color: Colors.white,
        ),
        elevation: 2.0,
      ),
    );
  }

  void selectPosition(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    setState(() {
      rowItemList = DataFile.getCategoryModel(context);
    });

    motionTabBar = new MotionTabBar(
      labels: ["Setting", "Home", "Profile"],
      initialSelectedTab: s[_selectedIndex],
      tabIconColor: ConstantData.accentColor,
      tabSelectedColor: ConstantData.accentColor,
      selectedIndex: _selectedIndex,
      onTabItemSelected: (int value) {
        print(value);
        setState(() {
          _tabController.index = value;
          _selectedIndex = value;
        });
      },
      icons: [Icons.settings, Icons.calculate, Icons.account_circle],
      textStyle: TextStyle(
          color: Colors.black,
          fontSize: ConstantWidget.getWidthPercentSize(context, 3.5),
          fontFamily: ConstantData.fontFamily),
    );

    List<Widget> getList = [getProfilePage(), getSettingPage(), getHomePage()];
    return WillPopScope(
        child: (isSplash)
            ? getSplash()
            : Scaffold(
                bottomNavigationBar: FABBottomAppBar(
                  centerItemText: "Home",
                  backgroundColor: ConstantData.accentColor,
                  color: Colors.white60,
                  selectedColor: Colors.white,
                  notchedShape: CircularNotchedRectangle(),
                  onTabSelected: selectPosition,
                  items: [
                    FABBottomAppBarItem(
                        iconData: Icons.account_circle, text: "Profile"),
                    FABBottomAppBarItem(
                        iconData: Icons.settings, text: "Setting"),
                  ],
                ),
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.centerDocked,
                floatingActionButton: _buildFab(context),
                body: getList[_selectedIndex],
              ),

        // child: Scaffold(
        //   bottomNavigationBar: FABBottomAppBar(
        //     centerItemText: "Home",
        //     backgroundColor: ConstantData.accentColor,
        //     color: Colors.white60,
        //     selectedColor: Colors.white,
        //     notchedShape: CircularNotchedRectangle(),
        //     onTabSelected: selectPosition,
        //     items: [
        //       FABBottomAppBarItem(
        //           iconData: Icons.account_circle, text: "Profile"),
        //       FABBottomAppBarItem(iconData: Icons.settings, text: "Setting"),
        //     ],
        //   ),
        //
        //   floatingActionButtonLocation:
        //       FloatingActionButtonLocation.centerDocked,
        //   floatingActionButton: _buildFab(context),
        //
        //   body: getList[_selectedIndex],
        //
        // ),
        onWillPop: _requestPop);
  }

  Widget getProfilePage() {
    double buttonHeight = ConstantWidget.getScreenPercentSize(context, 6);

    double subRadius = ConstantWidget.getWidthPercentSize(context, 1.5);
    double fontSize = ConstantWidget.getPercentSize(buttonHeight, 32);

    double cellHeight = ConstantWidget.getScreenPercentSize(context, 7);
    double allMargin = ConstantWidget.getScreenPercentSize(context, 1);
    double width = ConstantWidget.getWidthPercentSize(context, 2);

    Color themeColor = ConstantData.accentColor;

    Widget widget = Container(
      height: double.infinity,
      color: ConstantData.bgColor,
      margin: EdgeInsets.all(ConstantWidget.getScreenPercentSize(context, 2)),
      child: Wrap(
        children: [
          Card(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                  ConstantWidget.getScreenPercentSize(context, 0.5)),
            ),
            child: Container(
              padding: EdgeInsets.all(
                  ConstantWidget.getScreenPercentSize(context, 2)),
              child: Column(
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
                          width:
                              ConstantWidget.getWidthPercentSize(context, 30),
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
                        ConstantWidget.getImage(
                            themeColor, context, "height.png"),
                        Expanded(
                          child: ConstantWidget.getDropDown(
                              context, selectType, typeList, (value) {
                            bool oldVal = centimeter;

                            setState(() {
                              selectType = value;

                              centimeter =
                                  (selectType == S.of(context).centimeter);

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
                                ConstantWidget.getPercentSize(cellHeight, 30),
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
                          width:
                              ConstantWidget.getWidthPercentSize(context, 30),
                          child: ConstantWidget.getDropDown(
                              context, selectCurrency, currencyList, (value) {
                            setState(() {
                              selectCurrency = value;

                              kg = (selectCurrency == S.of(context).kilogram);
                            });
                          }),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Center(
            child: InkWell(
              child: Container(
                margin: EdgeInsets.all(
                    ConstantWidget.getWidthPercentSize(context, 5)),
                width: ConstantWidget.getWidthPercentSize(context, 30),
                height: buttonHeight,
                decoration: BoxDecoration(
                    color: themeColor,
                    borderRadius: BorderRadius.all(Radius.circular(subRadius))),
                child: Center(
                  child: ConstantWidget.getDefaultTextWidget(
                      S.of(context).save,
                      TextAlign.center,
                      FontWeight.w500,
                      fontSize,
                      Colors.white),
                ),
              ),
              onTap: () {
                saveData();
              },
            ),
          )
        ],
      ),
    );
    return getHeader(S.of(context).profile, widget);
  }

  Widget getSplash() {
    double height = SizeConfig.safeBlockVertical * 50;
    double width = ConstantWidget.getWidthPercentSize(context, 78);

    double padding = ConstantWidget.getPercentSize(height, 5);
    double radius = ConstantWidget.getPercentSize(height, 14);

    double margin = (SizeConfig.safeBlockVertical * 2);

    double remainHeight =
        (SizeConfig.safeBlockVertical * 100) - height - (margin * 2);
    double circleSize = ConstantWidget.getPercentSize(remainHeight, 15);

    return Container(
      color: "#E1FAF7".toColor(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
                color: ConstantData.accentColor,
                borderRadius: BorderRadius.all(Radius.circular(radius))),
            padding:
                EdgeInsets.only(left: padding, right: padding, top: padding),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Image.asset(ConstantData.assetsPath + "splash_png.png"),
            ),
          ),
          SizedBox(
            height: margin,
          ),
          ConstantWidget.getCustomText(
              "Target Health",
              ConstantData.accentColor,
              1,
              TextAlign.center,
              FontWeight.w400,
              ConstantWidget.getPercentSize(remainHeight, 8)),
          SizedBox(
            height: SizeConfig.safeBlockVertical * 0.3,
          ),
          ConstantWidget.getCustomText(
              "Calculation",
              ConstantData.accentColor,
              1,
              TextAlign.center,
              FontWeight.bold,
              ConstantWidget.getPercentSize(remainHeight, 8)),
          SizedBox(
            height: (margin * 3.5),
          ),
          Material(
            color: Colors.transparent,
            child: InkWell(
              child: Container(
                height: circleSize,
                width: circleSize,
                decoration: BoxDecoration(
                    color: ConstantData.accentColor, shape: BoxShape.circle),
                child: Center(
                  child: Icon(
                    CupertinoIcons.right_chevron,
                    color: Colors.white,
                    size: ConstantWidget.getPercentSize(circleSize, 40),
                  ),
                ),
              ),
              onTap: () {
                setState(() {
                  isSplash = false;
                });
              },
            ),
          )
        ],
      ),
    );
  }

  Widget getHomePage() {
    return getHeader(S.of(context).appName, gridList());
  }

  Widget getHeader(String s, Widget widget) {
    double radius = ConstantWidget.getScreenPercentSize(context, 3.5);

    double height = SizeConfig.safeBlockVertical * 16;
    double secHeight = SizeConfig.safeBlockVertical * 13;
    return Container(
      color: ConstantData.accentColor,
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: height,
            color: ConstantData.accentColor,
            child: Center(
              child: ConstantWidget.getDefaultTextWidget(
                  s,
                  TextAlign.center,
                  FontWeight.bold,
                  ConstantWidget.getPercentSize(height, 20),
                  Colors.white),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: ConstantData.bgColor,
              // color: Colors.green,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(radius),
                topLeft: Radius.circular(radius),
              ),
            ),
            margin: EdgeInsets.only(top: secHeight),
            width: double.infinity,
            child: Container(
              child: widget,
            ),
          ),
        ],
      ),
    );
  }

  Widget gridList() {
    double leftRightMargin = ConstantWidget.getScreenPercentSize(context, 2.3);

    double _crossAxisSpacing = 0;
    var _screenWidth = MediaQuery.of(context).size.width;
    var _crossAxisCount = 2;
    var _width = (_screenWidth - ((_crossAxisCount - 1) * _crossAxisSpacing)) /
        _crossAxisCount;
    var cellHeight = SizeConfig.safeBlockVertical * 29;
    var _aspectRatio = _width / cellHeight;
    var height = ConstantWidget.getPercentSize(cellHeight, 78);
    var width = ConstantWidget.getPercentSize(cellHeight, 72);

    double dotSize = ConstantWidget.getPercentSize(width, 35);
    double iconSize = ConstantWidget.getPercentSize(dotSize, 50);
    double padding = ConstantWidget.getPercentSize(height, 6);
    double paddingBottom = ConstantWidget.getPercentSize(height, 2);

    return Container(
        margin: EdgeInsets.symmetric(horizontal: leftRightMargin),
        child: GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          primary: false,
          childAspectRatio: _aspectRatio,
          children: List.generate(rowItemList.length, (index) {
            RowItem model = rowItemList[index];

            print("image----${model.transImage}");

            return InkWell(
              child: Container(
                  margin: EdgeInsets.only(
                      bottom: ConstantWidget.getPercentSize(cellHeight, 7)),
                  child: Column(
                    children: [
                      Container(
                        height: height,
                        width: width,
                        decoration: BoxDecoration(
                            color: model.color,
                            // color: "#FE686A".toColor(),
                            borderRadius: BorderRadius.all(Radius.circular(
                                ConstantWidget.getPercentSize(
                                    cellHeight, 13)))),
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.topRight,
                              child: Container(
                                height: dotSize,
                                width: dotSize,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Image.asset(
                                    ConstantData.assetsPath + model.image,
                                    height: iconSize,
                                    width: iconSize,
                                    color: model.color,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  right:
                                      ConstantWidget.getPercentSize(height, 30),
                                  bottom: ConstantWidget.getPercentSize(
                                      height, 12)),
                              child: Center(
                                child: Image.asset(
                                  ConstantData.assetsPath + model.transImage,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: Container(
                                margin: EdgeInsets.only(
                                    left: padding,
                                    right: padding,
                                    bottom: padding),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ConstantWidget.textOverFlowWidget(
                                        model.title,
                                        FontWeight.w500,
                                        1,
                                        ConstantWidget.getPercentSize(
                                            height, 10),
                                        Colors.white),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: paddingBottom),
                                      child: ConstantWidget.textOverFlowWidget(
                                          model.description,
                                          FontWeight.w400,
                                          2,
                                          ConstantWidget.getPercentSize(
                                              height, 6),
                                          Colors.white),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  )),
              onTap: () async {
                rowItem = rowItemList[index];

                // ConstantWidget.showAds(interstitialAd, (value) {
                sendPage(rowItem);
                // });
              },
            );
          }),
        ));
  }

  sendPage(RowItem rowItem) {
    if (rowItem != null) {
      print("pagfenae,-----${rowItem.pageName}");
      if (rowItem.pageName.isNotEmpty && rowItem.pageName != null) {
        Navigator.pushNamed(context, "/" + rowItem.pageName,
            arguments: ScreenArguments(rowItem));
      }
    }
  }

  void saveData() {
    if (selectGender == S.of(context).male) {
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

    int age = 0;
    if (ConstantData.check(ageController.text)) {
      age = int.parse(ageController.text);
    }

    PrefData.setAge(age);
    PrefData.setKG(kg);

    double weight = 0;
    if (ConstantData.check(weightController.text)) {
      weight = double.parse(weightController.text);
    }

    if (kg) {
      PrefData.setWeight(weight);
    } else {
      PrefData.setWeight(ConstantData.poundToKg(weight).roundToDouble());
    }

    ConstantData.showToast(
        S.of(context).yourProfileSavedSuccessfullty, context);
  }

  Widget getSettingPage() {
    double marginSize = ConstantWidget.getScreenPercentSize(context, 2);
    double imgSize = ConstantWidget.getScreenPercentSize(context, 6.3);

    Widget widgetDivider = Padding(
      padding: EdgeInsets.only(left: imgSize + marginSize, right: marginSize),
      child: Divider(
        color: Colors.grey,
        height: 7,
      ),
    );

    Widget widget = Container(
      color: Colors.transparent,
      height: double.infinity,
      margin: EdgeInsets.only(top: (marginSize / 2)),
      child: ListView(
        // padding: EdgeInsets.only(top: marginSize),
        padding: EdgeInsets.zero,
        children: [
          getCell(S.of(context).privacyPolicy, Icons.security, false, () {
            ConstantData.launchURL(ConstantData.privacyPolicy);
          }),
          widgetDivider,
          getCell(S.of(context).share, Icons.share, false, () {
            ConstantData.shareApp(context);
          }),
          widgetDivider,
          getCell(S.of(context).rateUs, Icons.thumb_up, false, () {
            LaunchReview.launch();
            // BetterFeedback.of(context).show();
          }),
          widgetDivider,
          getCell(S.of(context).feedback, Icons.mail, false, () {
            // BetterFeedback.of(context).show();

            BetterFeedback.of(context)?.show(
              (
                String feedbackText,
                Uint8List feedbackScreenshot,
              ) async {
                // draft an email and send to developer
                final screenshotFilePath =
                    await writeImageToStorage(feedbackScreenshot);

                final Email email = Email(
                  body: feedbackText,
                  subject: S.of(context).appName + ': App Feedback',
                  recipients: ['abc@gmail.com'],
                  attachmentPaths: [screenshotFilePath],
                  isHTML: false,
                );
                await FlutterEmailSender.send(email);
              },
            );

            // ConstantData.launchEmail(
            //     'demo@gmail.com', 'Flutter Email Test', 'Hello Flutter');
          }),
        ],
      ),
    );
    return getHeader(S.of(context).setting, widget);
  }

  Future<String> writeImageToStorage(Uint8List feedbackScreenshot) async {
    final Directory output = await getTemporaryDirectory();
    final String screenshotFilePath = '${output.path}/feedback.png';
    final File screenshotFile = File(screenshotFilePath);
    await screenshotFile.writeAsBytes(feedbackScreenshot);
    return screenshotFilePath;
  }

  Widget getCell(String s, var icon, bool isText, Function function) {
    double imgSize = ConstantWidget.getScreenPercentSize(context, 6.3);
    double marginSize = ConstantWidget.getScreenPercentSize(context, 1.5);

    return InkWell(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.all(marginSize),
              height: imgSize,
              width: imgSize,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 20.0,
                      // has the effect of softening the shadow
                      spreadRadius: 2.0,
                      offset: Offset(
                        5.0, // horizontal, move right 10
                        5.0, // vertical, move down 10
                      ),
                    ),
                  ],
                  color: ConstantData.accentColor),
              child: IconButton(
                onPressed: () {},
                icon: Icon(
                  icon,
                  color: Colors.white,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                s,
                style: TextStyle(
                    color: Colors.black,
                    fontSize:
                        ConstantWidget.getScreenPercentSize(context, 2.3)),
              ),
            ),
          ],
        ),
        onTap: function);
  }
}
