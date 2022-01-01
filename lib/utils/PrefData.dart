  import 'package:shared_preferences/shared_preferences.dart';

class PrefData {
  static String age = "healthAge";
  static String gender = "healthGender";
  static String centimeter = "healthCentimeter";
  static String kilogram = "healthKilogram";
  static String intro = "healthIntro";
  static String height = "healthHeight";
  static String weight = "healthWeight";
  static String click = "healthClick";

  static int defaultAge = 25;
   static double defaultHeight = 1;
   static double defaultWeight = 30;

  static setClick(int s) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(click, s);
  }

  static getClick() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(click) ?? 0;
  }
  static setAge(int s) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(age, s);
  }

  static getAge() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(age) ?? defaultAge;
  }

  static setHeight(double s) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble(height, s);
  }

  static getHeight() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(height) ?? defaultHeight;
  }

  static setWeight(double s) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble(weight, s);
  }

  static getWeight() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(weight) ?? defaultWeight;
  }


  static setGender(int s) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(gender, s);
  }

  static getGender() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(gender) ?? 0;
  }

  static setCM(bool s) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(centimeter, s);
  }

  static getCM() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(centimeter) ?? false;
  }


  static setKG(bool s) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(kilogram, s);
  }

  static getKG() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(kilogram) ?? false;
  }




  static setIntro(bool s) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(intro, s);
  }

  static getIntro() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(intro) ?? true;
  }

}
