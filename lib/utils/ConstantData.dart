import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter_health_calculator/generated/l10n.dart';
import 'package:flutter_health_calculator/model/RowItem.dart';
import 'package:flutter_health_calculator/model/ScreenArguments.dart';
import 'package:share/share.dart';
import 'package:toast/toast.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';


class ConstantData {
  static Color primaryColor = "#FFFFFF".toColor();
  static Color accentColor = "#1F857C".toColor();
  static Color bgColor = "#F2F6F9".toColor();
  static Color defaultColor = "#F3BC3D".toColor();
  static Color textColor = "#333333".toColor();
  static Color color1 = "#F96F26".toColor();
  static Color color2 = "#5C8FED".toColor();
  static Color color3 = "#F3BC3D".toColor();
  static Color color4 = "#29AFD3".toColor();
  static Color color5 = "#B248C7".toColor();
  static Color color6 = "#3D739F".toColor();
  static Color color7 = "#F96F26".toColor();
  static Color color8 = "#5C8FED".toColor();
  static Color color9 = "#F3BC3D".toColor();
  static Color color10 = "#29AFD3".toColor();
  static Color color11 = "#B248C7".toColor();
  static Color color12 = "#3D739F".toColor();
  static Color color13 = "#F96F26".toColor();
  static Color color14 = "#5C8FED".toColor();
  static Color color15 = "#F3BC3D".toColor();
  static String privacyPolicy="https://google.com";


  static String fontFamily = "SFProText";
  static String assetsPath = "assets/images/";
  static String pdfPath = "assets/pdf/";
  static String calculate = "1";
  static String reset = "2";
  static String chart = "3";

  static RowItem getThemeColor(BuildContext context) {
    final ScreenArguments args =
        ModalRoute.of(context).settings.arguments as ScreenArguments;
    return args.rowItem;
  }


  static Future<void> shareApp(BuildContext contexts) async {
    Share.share(S.of(contexts).appName, subject: 'https://flutter.dev/');
  }

  static String getFormattedDate(DateTime now){
    var formatter = new DateFormat('dd MMMM yyyy');
    return formatter.format(now);
  }
  static String getDefaultDate(DateTime now){
      var formatter = new DateFormat('dd/MM/yyyy');
      return formatter.format(now);
  }

  static String getInterstitialAdUnitId() {
    if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/4411468910';
    } else if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/1033173712';
    }
    return "";
  }



  static String getBannerAdUnitId() {
    if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/2934735716';
    } else if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/6300978111';
    }
    return null;
  }


  static launchEmail(String toMailId, String subject, String body) async {
    var url = 'mailto:$toMailId?subject=$subject&body=$body';
    // if (await canLaunch(url)) {
      await launch(url);
    // } else {
    //   throw 'Could not launch $url';
    // }
  }
  static launchURL(String url) async {
    // if (await canLaunch(url)) {
      await launch(url);
    // } else {
    //   throw 'Could not launch $url';
    // }
  }


  static double meterToCm(double meter) {
    return meter * 100;
  }

  static String formatData(double meter) {
    var f =
    new NumberFormat(".##", "en_US");

    return f.format(meter);
  }

  static double kgToPound(double kg) {
    return  (kg * 2.205);
  }

  static double cmToMeter(double v) {
    return v / 100;
  }

  static showToast(String s, BuildContext context) {
    if (s.isNotEmpty) {
      Toast.show(s, context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
    }
  }

  static void meterToInchAndFeet(
      double meter,
      TextEditingController ftController,
      TextEditingController inchController) {
    double inch = (meter * 39.37);
    double ft1 = inch / 12;
    int n = ft1.toInt();
    double in1 = ft1 - n;
    double in2;
    in2 = in1 * 12;

    ftController.text = n.round().toString();
    inchController.text = in2.round().toString();
  }

  static bool check(String s) {
    return s.isNotEmpty && s != null;
  }

  static double feetAndInchToMeter(int feet, int inch) {
    double meter;
    double f1 = (feet / 3.281);
    double i1 = (inch / 39.37);
    meter = f1 + i1;
    return meter;
  }

  static double poundToKg(double pound) {
    return  (pound / 2.205);
  }

}

extension ColorExtension on String {
  toColor() {
    var hexColor = this.replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    if (hexColor.length == 8) {
      return Color(int.parse("0x$hexColor"));
    }
  }
}

///
