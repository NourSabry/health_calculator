// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values

class S {
  S();
  
  static S current;
  
  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name); 
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      S.current = S();
      
      return S.current;
    });
  } 

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Health Calculator`
  String get appName {
    return Intl.message(
      'Health Calculator',
      name: 'appName',
      desc: '',
      args: [],
    );
  }

  /// `Health\nCalculator`
  String get healthncalculator {
    return Intl.message(
      'Health\nCalculator',
      name: 'healthncalculator',
      desc: '',
      args: [],
    );
  }

  /// `Ideal Weight`
  String get idealWeight {
    return Intl.message(
      'Ideal Weight',
      name: 'idealWeight',
      desc: '',
      args: [],
    );
  }

  /// `Body Mass Index`
  String get bodyMassIndex {
    return Intl.message(
      'Body Mass Index',
      name: 'bodyMassIndex',
      desc: '',
      args: [],
    );
  }

  /// `Body Fat`
  String get bodyFat {
    return Intl.message(
      'Body Fat',
      name: 'bodyFat',
      desc: '',
      args: [],
    );
  }

  /// `Calories for Weight Gain/Loss`
  String get caloriesForWeightGainloss {
    return Intl.message(
      'Calories for Weight Gain/Loss',
      name: 'caloriesForWeightGainloss',
      desc: '',
      args: [],
    );
  }

  /// `Breath Count`
  String get breathCount {
    return Intl.message(
      'Breath Count',
      name: 'breathCount',
      desc: '',
      args: [],
    );
  }

  /// `Blood Alcohol`
  String get bloodAlcohol {
    return Intl.message(
      'Blood Alcohol',
      name: 'bloodAlcohol',
      desc: '',
      args: [],
    );
  }

  /// `Blood Donation`
  String get bloodDonation {
    return Intl.message(
      'Blood Donation',
      name: 'bloodDonation',
      desc: '',
      args: [],
    );
  }

  /// `Blood Volume`
  String get bloodVolume {
    return Intl.message(
      'Blood Volume',
      name: 'bloodVolume',
      desc: '',
      args: [],
    );
  }

  /// `Ovulation Period`
  String get ovulationPeriod {
    return Intl.message(
      'Ovulation Period',
      name: 'ovulationPeriod',
      desc: '',
      args: [],
    );
  }

  /// `Pregnancy Due Date`
  String get pregnancyDueDate {
    return Intl.message(
      'Pregnancy Due Date',
      name: 'pregnancyDueDate',
      desc: '',
      args: [],
    );
  }

  /// `Target Heart Rate`
  String get targetHeartRate {
    return Intl.message(
      'Target Heart Rate',
      name: 'targetHeartRate',
      desc: '',
      args: [],
    );
  }

  /// `Water Intake`
  String get waterIntake {
    return Intl.message(
      'Water Intake',
      name: 'waterIntake',
      desc: '',
      args: [],
    );
  }

  /// `Blood Pressure`
  String get bloodPressure {
    return Intl.message(
      'Blood Pressure',
      name: 'bloodPressure',
      desc: '',
      args: [],
    );
  }

  /// `Weight that is believed to be maximally healthful for a person`
  String get desc1 {
    return Intl.message(
      'Weight that is believed to be maximally healthful for a person',
      name: 'desc1',
      desc: '',
      args: [],
    );
  }

  /// `Shows whether people have the right weight for their height`
  String get desc2 {
    return Intl.message(
      'Shows whether people have the right weight for their height',
      name: 'desc2',
      desc: '',
      args: [],
    );
  }

  /// `A measure of fitness level of an individual`
  String get desc3 {
    return Intl.message(
      'A measure of fitness level of an individual',
      name: 'desc3',
      desc: '',
      args: [],
    );
  }

  /// `Calculate your daily calorie requirements for weight gain/loss`
  String get desc4 {
    return Intl.message(
      'Calculate your daily calorie requirements for weight gain/loss',
      name: 'desc4',
      desc: '',
      args: [],
    );
  }

  /// `How much water should you drink each day?`
  String get desc5 {
    return Intl.message(
      'How much water should you drink each day?',
      name: 'desc5',
      desc: '',
      args: [],
    );
  }

  /// `Pulse rate to target during aerobic exercise based on age`
  String get desc6 {
    return Intl.message(
      'Pulse rate to target during aerobic exercise based on age',
      name: 'desc6',
      desc: '',
      args: [],
    );
  }

  /// `Calculates the pregnancy due date of your baby`
  String get desc7 {
    return Intl.message(
      'Calculates the pregnancy due date of your baby',
      name: 'desc7',
      desc: '',
      args: [],
    );
  }

  /// `Calculates your most fertile days`
  String get desc8 {
    return Intl.message(
      'Calculates your most fertile days',
      name: 'desc8',
      desc: '',
      args: [],
    );
  }

  /// `Volume of blood of any individual`
  String get desc9 {
    return Intl.message(
      'Volume of blood of any individual',
      name: 'desc9',
      desc: '',
      args: [],
    );
  }

  /// `Level of alcohol content in blood`
  String get desc10 {
    return Intl.message(
      'Level of alcohol content in blood',
      name: 'desc10',
      desc: '',
      args: [],
    );
  }

  /// `Calculate the number of breaths you have taken so far (i.e.,since your birth).`
  String get desc11 {
    return Intl.message(
      'Calculate the number of breaths you have taken so far (i.e.,since your birth).',
      name: 'desc11',
      desc: '',
      args: [],
    );
  }

  /// `Calculates BP value`
  String get desc12 {
    return Intl.message(
      'Calculates BP value',
      name: 'desc12',
      desc: '',
      args: [],
    );
  }

  /// `Enter age`
  String get enterAge {
    return Intl.message(
      'Enter age',
      name: 'enterAge',
      desc: '',
      args: [],
    );
  }

  /// `Enter Height`
  String get enterHeight {
    return Intl.message(
      'Enter Height',
      name: 'enterHeight',
      desc: '',
      args: [],
    );
  }

  /// `FT`
  String get ft {
    return Intl.message(
      'FT',
      name: 'ft',
      desc: '',
      args: [],
    );
  }

  /// `IN`
  String get inch {
    return Intl.message(
      'IN',
      name: 'inch',
      desc: '',
      args: [],
    );
  }

  /// `Calculate`
  String get calculate {
    return Intl.message(
      'Calculate',
      name: 'calculate',
      desc: '',
      args: [],
    );
  }

  /// `Reset`
  String get reset {
    return Intl.message(
      'Reset',
      name: 'reset',
      desc: '',
      args: [],
    );
  }

  /// `Ideal Weight Chart`
  String get idealWeightChart {
    return Intl.message(
      'Ideal Weight Chart',
      name: 'idealWeightChart',
      desc: '',
      args: [],
    );
  }

  /// `Male`
  String get male {
    return Intl.message(
      'Male',
      name: 'male',
      desc: '',
      args: [],
    );
  }

  /// `Female`
  String get female {
    return Intl.message(
      'Female',
      name: 'female',
      desc: '',
      args: [],
    );
  }

  /// `Centimeter`
  String get centimeter {
    return Intl.message(
      'Centimeter',
      name: 'centimeter',
      desc: '',
      args: [],
    );
  }

  /// `Foot`
  String get foot {
    return Intl.message(
      'Foot',
      name: 'foot',
      desc: '',
      args: [],
    );
  }

  /// `CM`
  String get cm {
    return Intl.message(
      'CM',
      name: 'cm',
      desc: '',
      args: [],
    );
  }

  /// `Please enter valid values`
  String get pleaseEnterValidValues {
    return Intl.message(
      'Please enter valid values',
      name: 'pleaseEnterValidValues',
      desc: '',
      args: [],
    );
  }

  /// `You must be over 153 cm to calculate ideal weight`
  String get youMustBeOver153CmToCalculateIdealWeight {
    return Intl.message(
      'You must be over 153 cm to calculate ideal weight',
      name: 'youMustBeOver153CmToCalculateIdealWeight',
      desc: '',
      args: [],
    );
  }

  /// `Your ideal weight is`
  String get yourIdealWeightIs {
    return Intl.message(
      'Your ideal weight is',
      name: 'yourIdealWeightIs',
      desc: '',
      args: [],
    );
  }

  /// `lbs`
  String get lbs {
    return Intl.message(
      'lbs',
      name: 'lbs',
      desc: '',
      args: [],
    );
  }

  /// `kg`
  String get kg {
    return Intl.message(
      'kg',
      name: 'kg',
      desc: '',
      args: [],
    );
  }

  /// `The three most popular formulas for calculating ideal weight are the Devine, Robinson and Miller formulas.\n\nWeight in lbs (kg)`
  String get resultDesc1 {
    return Intl.message(
      'The three most popular formulas for calculating ideal weight are the Devine, Robinson and Miller formulas.\n\nWeight in lbs (kg)',
      name: 'resultDesc1',
      desc: '',
      args: [],
    );
  }

  /// `Enter Weight`
  String get enterWeight {
    return Intl.message(
      'Enter Weight',
      name: 'enterWeight',
      desc: '',
      args: [],
    );
  }

  /// `BMI Chart`
  String get bmiChart {
    return Intl.message(
      'BMI Chart',
      name: 'bmiChart',
      desc: '',
      args: [],
    );
  }

  /// `Kilogram`
  String get kilogram {
    return Intl.message(
      'Kilogram',
      name: 'kilogram',
      desc: '',
      args: [],
    );
  }

  /// `Pounds`
  String get pounds {
    return Intl.message(
      'Pounds',
      name: 'pounds',
      desc: '',
      args: [],
    );
  }

  /// `Your Body Mass Index is`
  String get yourBodyMassIndexIs {
    return Intl.message(
      'Your Body Mass Index is',
      name: 'yourBodyMassIndexIs',
      desc: '',
      args: [],
    );
  }

  /// `Under weight`
  String get underWeight {
    return Intl.message(
      'Under weight',
      name: 'underWeight',
      desc: '',
      args: [],
    );
  }

  /// `Normal Weight`
  String get normalWeight {
    return Intl.message(
      'Normal Weight',
      name: 'normalWeight',
      desc: '',
      args: [],
    );
  }

  /// `Over Weight`
  String get overWeight {
    return Intl.message(
      'Over Weight',
      name: 'overWeight',
      desc: '',
      args: [],
    );
  }

  /// `Morbid Obese`
  String get morbidObese {
    return Intl.message(
      'Morbid Obese',
      name: 'morbidObese',
      desc: '',
      args: [],
    );
  }

  /// `Obese class one`
  String get obeseClassOne {
    return Intl.message(
      'Obese class one',
      name: 'obeseClassOne',
      desc: '',
      args: [],
    );
  }

  /// `Obese class two`
  String get obeseClassTwo {
    return Intl.message(
      'Obese class two',
      name: 'obeseClassTwo',
      desc: '',
      args: [],
    );
  }

  /// `Extremely under weight`
  String get extremelyUnderWeight {
    return Intl.message(
      'Extremely under weight',
      name: 'extremelyUnderWeight',
      desc: '',
      args: [],
    );
  }

  /// `Understand your BMI result`
  String get understandYourBmiResult {
    return Intl.message(
      'Understand your BMI result',
      name: 'understandYourBmiResult',
      desc: '',
      args: [],
    );
  }

  /// `Underweight`
  String get underweightHeader {
    return Intl.message(
      'Underweight',
      name: 'underweightHeader',
      desc: '',
      args: [],
    );
  }

  /// `Being underweight could be a sign you're not eating enough or you may be ill. If you're underweight, a doctor can help.`
  String get underweightDesc {
    return Intl.message(
      'Being underweight could be a sign you\'re not eating enough or you may be ill. If you\'re underweight, a doctor can help.',
      name: 'underweightDesc',
      desc: '',
      args: [],
    );
  }

  /// `Healthy weight`
  String get healthyWeightHeader {
    return Intl.message(
      'Healthy weight',
      name: 'healthyWeightHeader',
      desc: '',
      args: [],
    );
  }

  /// `Keep up the good work! For tips on maintaining a healthy weight, check out the food and diet and fitness sections.`
  String get healthWeightDesc {
    return Intl.message(
      'Keep up the good work! For tips on maintaining a healthy weight, check out the food and diet and fitness sections.',
      name: 'healthWeightDesc',
      desc: '',
      args: [],
    );
  }

  /// `Overweight`
  String get overweightHeader {
    return Intl.message(
      'Overweight',
      name: 'overweightHeader',
      desc: '',
      args: [],
    );
  }

  /// `The best way to lose weight if you're overweight is through a combination of diet and exercise. The BMI calculator will give you a personal calorie allowance to help you achieve a healthy weight safely.`
  String get overweightHeaderDesc {
    return Intl.message(
      'The best way to lose weight if you\'re overweight is through a combination of diet and exercise. The BMI calculator will give you a personal calorie allowance to help you achieve a healthy weight safely.',
      name: 'overweightHeaderDesc',
      desc: '',
      args: [],
    );
  }

  /// `Obese`
  String get obese {
    return Intl.message(
      'Obese',
      name: 'obese',
      desc: '',
      args: [],
    );
  }

  /// `The best way to lose weight if you're obese is through a combination of diet and exercise, and, in some cases, medicines. See a doctor for help and advice.`
  String get obeseHeader {
    return Intl.message(
      'The best way to lose weight if you\'re obese is through a combination of diet and exercise, and, in some cases, medicines. See a doctor for help and advice.',
      name: 'obeseHeader',
      desc: '',
      args: [],
    );
  }

  /// `To find your BMI, locate where your height and weight intersect; your BMI is listed in the square`
  String get resultDesc2 {
    return Intl.message(
      'To find your BMI, locate where your height and weight intersect; your BMI is listed in the square',
      name: 'resultDesc2',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Your profile saved successfullty`
  String get yourProfileSavedSuccessfullty {
    return Intl.message(
      'Your profile saved successfullty',
      name: 'yourProfileSavedSuccessfullty',
      desc: '',
      args: [],
    );
  }

  /// `Inches`
  String get inches {
    return Intl.message(
      'Inches',
      name: 'inches',
      desc: '',
      args: [],
    );
  }

  /// `Waist`
  String get enterWaist {
    return Intl.message(
      'Waist',
      name: 'enterWaist',
      desc: '',
      args: [],
    );
  }

  /// `Neck`
  String get enterNeck {
    return Intl.message(
      'Neck',
      name: 'enterNeck',
      desc: '',
      args: [],
    );
  }

  /// `Body Fat Chart`
  String get bodyFatChart {
    return Intl.message(
      'Body Fat Chart',
      name: 'bodyFatChart',
      desc: '',
      args: [],
    );
  }

  /// `ForeArm`
  String get forearm {
    return Intl.message(
      'ForeArm',
      name: 'forearm',
      desc: '',
      args: [],
    );
  }

  /// `Wrist`
  String get wrist {
    return Intl.message(
      'Wrist',
      name: 'wrist',
      desc: '',
      args: [],
    );
  }

  /// `Hip`
  String get hip {
    return Intl.message(
      'Hip',
      name: 'hip',
      desc: '',
      args: [],
    );
  }

  /// `As you can see below, you have the body fat percentage chart for women and now men (below) that you need to input the numbers from your measurements using calipers.`
  String get resultDesc3 {
    return Intl.message(
      'As you can see below, you have the body fat percentage chart for women and now men (below) that you need to input the numbers from your measurements using calipers.',
      name: 'resultDesc3',
      desc: '',
      args: [],
    );
  }

  /// `Estimated Calorie Needs per Day, by Age, Sex, and Physical Activity Level`
  String get resultDesc4 {
    return Intl.message(
      'Estimated Calorie Needs per Day, by Age, Sex, and Physical Activity Level',
      name: 'resultDesc4',
      desc: '',
      args: [],
    );
  }

  /// `This chart shows the requirement of water in a day by a person as per his/her weight.\n\nMultiply your weight in kg by 2.2 to get your weight in lbs using the calculator above.`
  String get resultDesc5 {
    return Intl.message(
      'This chart shows the requirement of water in a day by a person as per his/her weight.\n\nMultiply your weight in kg by 2.2 to get your weight in lbs using the calculator above.',
      name: 'resultDesc5',
      desc: '',
      args: [],
    );
  }

  /// `When you monitor your heart rate during physical exercise and stay within your target heart rate zone, you reap the most health benefits and lessen your risk of injury.`
  String get resultDesc6 {
    return Intl.message(
      'When you monitor your heart rate during physical exercise and stay within your target heart rate zone, you reap the most health benefits and lessen your risk of injury.',
      name: 'resultDesc6',
      desc: '',
      args: [],
    );
  }

  /// `The three most popular formulas for calculating ideal weight are the Devine, Robinson and Miller formulas.\n\nWeight in lbs (kg)`
  String get resultDesc7 {
    return Intl.message(
      'The three most popular formulas for calculating ideal weight are the Devine, Robinson and Miller formulas.\n\nWeight in lbs (kg)',
      name: 'resultDesc7',
      desc: '',
      args: [],
    );
  }

  /// `The purpose of this cycle is to prepare the body for pregnancy, and if this does not occur then bleeding occurs (the period), and your cycle starts over again.`
  String get resultDesc8 {
    return Intl.message(
      'The purpose of this cycle is to prepare the body for pregnancy, and if this does not occur then bleeding occurs (the period), and your cycle starts over again.',
      name: 'resultDesc8',
      desc: '',
      args: [],
    );
  }

  /// `Essential % of fat`
  String get essentialOfFat {
    return Intl.message(
      'Essential % of fat',
      name: 'essentialOfFat',
      desc: '',
      args: [],
    );
  }

  /// `Typical Athlete`
  String get typicalAthlete {
    return Intl.message(
      'Typical Athlete',
      name: 'typicalAthlete',
      desc: '',
      args: [],
    );
  }

  /// `Physically Fit`
  String get physicallyFit {
    return Intl.message(
      'Physically Fit',
      name: 'physicallyFit',
      desc: '',
      args: [],
    );
  }

  /// `Acceptable`
  String get acceptable {
    return Intl.message(
      'Acceptable',
      name: 'acceptable',
      desc: '',
      args: [],
    );
  }

  /// `Your estimated body fat percentage is`
  String get yourEstimatedBodyFatPercentageIs {
    return Intl.message(
      'Your estimated body fat percentage is',
      name: 'yourEstimatedBodyFatPercentageIs',
      desc: '',
      args: [],
    );
  }

  /// `Assessment:`
  String get assessment {
    return Intl.message(
      'Assessment:',
      name: 'assessment',
      desc: '',
      args: [],
    );
  }

  /// `To stay healthy:`
  String get toStayHealthy {
    return Intl.message(
      'To stay healthy:',
      name: 'toStayHealthy',
      desc: '',
      args: [],
    );
  }

  /// `Category`
  String get category {
    return Intl.message(
      'Category',
      name: 'category',
      desc: '',
      args: [],
    );
  }

  /// `Women`
  String get women {
    return Intl.message(
      'Women',
      name: 'women',
      desc: '',
      args: [],
    );
  }

  /// `Men`
  String get men {
    return Intl.message(
      'Men',
      name: 'men',
      desc: '',
      args: [],
    );
  }

  /// `Daily Calorie Chart`
  String get dailyCalorieChart {
    return Intl.message(
      'Daily Calorie Chart',
      name: 'dailyCalorieChart',
      desc: '',
      args: [],
    );
  }

  /// `Sedentary`
  String get sedentary {
    return Intl.message(
      'Sedentary',
      name: 'sedentary',
      desc: '',
      args: [],
    );
  }

  /// `Very Hard`
  String get veryHard {
    return Intl.message(
      'Very Hard',
      name: 'veryHard',
      desc: '',
      args: [],
    );
  }

  /// `Hard`
  String get hard {
    return Intl.message(
      'Hard',
      name: 'hard',
      desc: '',
      args: [],
    );
  }

  /// `Moderate`
  String get moderate {
    return Intl.message(
      'Moderate',
      name: 'moderate',
      desc: '',
      args: [],
    );
  }

  /// `Little`
  String get little {
    return Intl.message(
      'Little',
      name: 'little',
      desc: '',
      args: [],
    );
  }

  /// `Target Weight`
  String get targetWeight {
    return Intl.message(
      'Target Weight',
      name: 'targetWeight',
      desc: '',
      args: [],
    );
  }

  /// `Loss Weight`
  String get lossWeight {
    return Intl.message(
      'Loss Weight',
      name: 'lossWeight',
      desc: '',
      args: [],
    );
  }

  /// `Gain Weight`
  String get gainWeight {
    return Intl.message(
      'Gain Weight',
      name: 'gainWeight',
      desc: '',
      args: [],
    );
  }

  /// `Week`
  String get week {
    return Intl.message(
      'Week',
      name: 'week',
      desc: '',
      args: [],
    );
  }

  /// `calories`
  String get calories {
    return Intl.message(
      'calories',
      name: 'calories',
      desc: '',
      args: [],
    );
  }

  /// `calories/day`
  String get caloriesday {
    return Intl.message(
      'calories/day',
      name: 'caloriesday',
      desc: '',
      args: [],
    );
  }

  /// `are needed to achieve your target weight`
  String get cal1 {
    return Intl.message(
      'are needed to achieve your target weight',
      name: 'cal1',
      desc: '',
      args: [],
    );
  }

  /// `This will be the number of calories you can eat everyday and maintain current weight.`
  String get cal2 {
    return Intl.message(
      'This will be the number of calories you can eat everyday and maintain current weight.',
      name: 'cal2',
      desc: '',
      args: [],
    );
  }

  /// `In order to lose weight, you will need to take in fewer calories or have to burn more calories than this result.`
  String get cal3 {
    return Intl.message(
      'In order to lose weight, you will need to take in fewer calories or have to burn more calories than this result.',
      name: 'cal3',
      desc: '',
      args: [],
    );
  }

  /// `To gain weight, you will need to take in more calories than this result.`
  String get cal4 {
    return Intl.message(
      'To gain weight, you will need to take in more calories than this result.',
      name: 'cal4',
      desc: '',
      args: [],
    );
  }

  /// `Average Calories`
  String get averageCalories {
    return Intl.message(
      'Average Calories',
      name: 'averageCalories',
      desc: '',
      args: [],
    );
  }

  /// `Maintain Weight`
  String get maintainWeight {
    return Intl.message(
      'Maintain Weight',
      name: 'maintainWeight',
      desc: '',
      args: [],
    );
  }

  /// `Food Calories List`
  String get foodCaloriesList {
    return Intl.message(
      'Food Calories List',
      name: 'foodCaloriesList',
      desc: '',
      args: [],
    );
  }

  /// `You estimated daily caloric need is`
  String get youEstimatedDailyCaloricNeedIs {
    return Intl.message(
      'You estimated daily caloric need is',
      name: 'youEstimatedDailyCaloricNeedIs',
      desc: '',
      args: [],
    );
  }

  /// `Your daily water requirement is`
  String get yourDailyWaterRequirementIs {
    return Intl.message(
      'Your daily water requirement is',
      name: 'yourDailyWaterRequirementIs',
      desc: '',
      args: [],
    );
  }

  /// `Glasses`
  String get glasses {
    return Intl.message(
      'Glasses',
      name: 'glasses',
      desc: '',
      args: [],
    );
  }

  /// `Take 2 – 3 glasses of water additionally if you exercise or if your environmental conditions are hot.`
  String get take23GlassesOfWaterAdditionallyIfYouExercise {
    return Intl.message(
      'Take 2 – 3 glasses of water additionally if you exercise or if your environmental conditions are hot.',
      name: 'take23GlassesOfWaterAdditionallyIfYouExercise',
      desc: '',
      args: [],
    );
  }

  /// `Daily water intake chart`
  String get dailyWaterIntakeChart {
    return Intl.message(
      'Daily water intake chart',
      name: 'dailyWaterIntakeChart',
      desc: '',
      args: [],
    );
  }

  /// `Enter Resting Heart Rate`
  String get enterRestingHeartRate {
    return Intl.message(
      'Enter Resting Heart Rate',
      name: 'enterRestingHeartRate',
      desc: '',
      args: [],
    );
  }

  /// `Target Heart Rate Chart`
  String get targetHeartRateChart {
    return Intl.message(
      'Target Heart Rate Chart',
      name: 'targetHeartRateChart',
      desc: '',
      args: [],
    );
  }

  /// `Your maximum heart rate is`
  String get yourMaximumHeartRateIs {
    return Intl.message(
      'Your maximum heart rate is',
      name: 'yourMaximumHeartRateIs',
      desc: '',
      args: [],
    );
  }

  /// `beats/minute`
  String get beatsminute {
    return Intl.message(
      'beats/minute',
      name: 'beatsminute',
      desc: '',
      args: [],
    );
  }

  /// `Choose the 1st day of your last menstrual period`
  String get chooseThe1stDayOfYourLastMenstrualPeriod {
    return Intl.message(
      'Choose the 1st day of your last menstrual period',
      name: 'chooseThe1stDayOfYourLastMenstrualPeriod',
      desc: '',
      args: [],
    );
  }

  /// `Date chosen:`
  String get dateChosen {
    return Intl.message(
      'Date chosen:',
      name: 'dateChosen',
      desc: '',
      args: [],
    );
  }

  /// `Choose Date`
  String get chooseDate {
    return Intl.message(
      'Choose Date',
      name: 'chooseDate',
      desc: '',
      args: [],
    );
  }

  /// `Pregnancy Weight Gain Chart`
  String get pregnancyWeightGainChart {
    return Intl.message(
      'Pregnancy Weight Gain Chart',
      name: 'pregnancyWeightGainChart',
      desc: '',
      args: [],
    );
  }

  /// `Pregnancy Food Guide`
  String get pregnancyFoodGuide {
    return Intl.message(
      'Pregnancy Food Guide',
      name: 'pregnancyFoodGuide',
      desc: '',
      args: [],
    );
  }

  /// `Your expected delivery date is`
  String get yourExpectedDeliveryDateIs {
    return Intl.message(
      'Your expected delivery date is',
      name: 'yourExpectedDeliveryDateIs',
      desc: '',
      args: [],
    );
  }

  /// `The due date calculation is based on the average 28-day cycle.`
  String get theDueDateCalculationIsBasedOnTheAverage28day {
    return Intl.message(
      'The due date calculation is based on the average 28-day cycle.',
      name: 'theDueDateCalculationIsBasedOnTheAverage28day',
      desc: '',
      args: [],
    );
  }

  /// `Menstrual Cycle Calendar`
  String get menstrualCycleCalendar {
    return Intl.message(
      'Menstrual Cycle Calendar',
      name: 'menstrualCycleCalendar',
      desc: '',
      args: [],
    );
  }

  /// `This calculation is based on the average 28-day cycle.`
  String get thisCalculationIsBasedOnTheAverage28dayCycle {
    return Intl.message(
      'This calculation is based on the average 28-day cycle.',
      name: 'thisCalculationIsBasedOnTheAverage28dayCycle',
      desc: '',
      args: [],
    );
  }

  /// `Your upcoming most fertile days are`
  String get yourUpcomingMostFertileDaysAre {
    return Intl.message(
      'Your upcoming most fertile days are',
      name: 'yourUpcomingMostFertileDaysAre',
      desc: '',
      args: [],
    );
  }

  /// `Your total blood volume is`
  String get yourTotalBloodVolumeIs {
    return Intl.message(
      'Your total blood volume is',
      name: 'yourTotalBloodVolumeIs',
      desc: '',
      args: [],
    );
  }

  /// `Liters`
  String get liters {
    return Intl.message(
      'Liters',
      name: 'liters',
      desc: '',
      args: [],
    );
  }

  /// `Choose the date of last donation`
  String get chooseTheDateOfLastDonation {
    return Intl.message(
      'Choose the date of last donation',
      name: 'chooseTheDateOfLastDonation',
      desc: '',
      args: [],
    );
  }

  /// `Can i donate?`
  String get canIDonate {
    return Intl.message(
      'Can i donate?',
      name: 'canIDonate',
      desc: '',
      args: [],
    );
  }

  /// `Eligibility to donate`
  String get eligibilityToDonate {
    return Intl.message(
      'Eligibility to donate',
      name: 'eligibilityToDonate',
      desc: '',
      args: [],
    );
  }

  /// `Your next eligible date is`
  String get yourNextEligibleDateIs {
    return Intl.message(
      'Your next eligible date is',
      name: 'yourNextEligibleDateIs',
      desc: '',
      args: [],
    );
  }

  /// `You should be in good health and atleast 17 years old with a body weight of 50 kg or 110 pounds.`
  String get youShouldBeInGoodHealthAndAtleast17Years {
    return Intl.message(
      'You should be in good health and atleast 17 years old with a body weight of 50 kg or 110 pounds.',
      name: 'youShouldBeInGoodHealthAndAtleast17Years',
      desc: '',
      args: [],
    );
  }

  /// `‣ Male donors could be eligible to give blood at a maximum frequency of every 12 weeks (4 times per year) but normally less often.\n\n‣ Female donors could be eligible to give blood at a maximum frequency of every 16 weeks (3 times per year) but normally less often.\n\n‣ Women between the ages of 17 and 19 who weigh less than 10 stone 3lbs (65kg) and whose height is below 5 feet 6 inches (168cm) need to have their blood volume estimated before giving blood. Please see the chart below. If your blood volume is within the shaded area you will be unable to donate until after your 20th birthday.`
  String get donate1 {
    return Intl.message(
      '‣ Male donors could be eligible to give blood at a maximum frequency of every 12 weeks (4 times per year) but normally less often.\n\n‣ Female donors could be eligible to give blood at a maximum frequency of every 16 weeks (3 times per year) but normally less often.\n\n‣ Women between the ages of 17 and 19 who weigh less than 10 stone 3lbs (65kg) and whose height is below 5 feet 6 inches (168cm) need to have their blood volume estimated before giving blood. Please see the chart below. If your blood volume is within the shaded area you will be unable to donate until after your 20th birthday.',
      name: 'donate1',
      desc: '',
      args: [],
    );
  }

  /// `Blood Volume Chart`
  String get bloodVolumeChart {
    return Intl.message(
      'Blood Volume Chart',
      name: 'bloodVolumeChart',
      desc: '',
      args: [],
    );
  }

  /// `The most accurate way to measure your Blood Alcohol Concentration (BAC) or alcohol level is to use a breathalyzer, but sometimes one is not readily available. In cases like this, use the charts below to plan for how many drinks you should limit yourself to.\n\nMultiply your weight in kg by 2.2 to get your weight in lbs using the calculator above.`
  String get resultDesc10 {
    return Intl.message(
      'The most accurate way to measure your Blood Alcohol Concentration (BAC) or alcohol level is to use a breathalyzer, but sometimes one is not readily available. In cases like this, use the charts below to plan for how many drinks you should limit yourself to.\n\nMultiply your weight in kg by 2.2 to get your weight in lbs using the calculator above.',
      name: 'resultDesc10',
      desc: '',
      args: [],
    );
  }

  /// `You should not give blood if:`
  String get el1 {
    return Intl.message(
      'You should not give blood if:',
      name: 'el1',
      desc: '',
      args: [],
    );
  }

  /// `‣ You are a male donor with less than 12 weeks interval between donations.\n\n‣ You are a female donor with less than 16 weeks interval between donations.\n\n‣ You have a sore throat, chesty cough or active cold sore. You can donate once you are feeling well (end of a cold is OK) and the cold sore is dry and healing.\n\n‣ You are currently taking antibiotics or you have just finished a course within the last 7 days or have had an infection in the last 2 weeks.\n\n‣ You have had hepatitis or jaundice in the last 12 months.\n\n‣ You have had a tattoo, semi-permanent make up or any cosmetic treatments that involves skin piercing in the last 12 months.\n\n‣ You have had acupuncture in the last 12 months, unless this was done within the NHS or by a qualified Healthcare Professional registered with a statutory body.\n\n‣ A member of your family (parent, brother, sister or child) has suffered with CJD (Creutzfeld-Jakob Disease).\n\n‣ You have ever received human pituitary extract (which was used in some growth hormone or fertility treatments before 1985)\n\n‣ You have received blood or think you may have received blood during the course of any medical treatment or procedure anywhere in the world since 1 January 1980.`
  String get el2 {
    return Intl.message(
      '‣ You are a male donor with less than 12 weeks interval between donations.\n\n‣ You are a female donor with less than 16 weeks interval between donations.\n\n‣ You have a sore throat, chesty cough or active cold sore. You can donate once you are feeling well (end of a cold is OK) and the cold sore is dry and healing.\n\n‣ You are currently taking antibiotics or you have just finished a course within the last 7 days or have had an infection in the last 2 weeks.\n\n‣ You have had hepatitis or jaundice in the last 12 months.\n\n‣ You have had a tattoo, semi-permanent make up or any cosmetic treatments that involves skin piercing in the last 12 months.\n\n‣ You have had acupuncture in the last 12 months, unless this was done within the NHS or by a qualified Healthcare Professional registered with a statutory body.\n\n‣ A member of your family (parent, brother, sister or child) has suffered with CJD (Creutzfeld-Jakob Disease).\n\n‣ You have ever received human pituitary extract (which was used in some growth hormone or fertility treatments before 1985)\n\n‣ You have received blood or think you may have received blood during the course of any medical treatment or procedure anywhere in the world since 1 January 1980.',
      name: 'el2',
      desc: '',
      args: [],
    );
  }

  /// `You may not give blood if:`
  String get el3 {
    return Intl.message(
      'You may not give blood if:',
      name: 'el3',
      desc: '',
      args: [],
    );
  }

  /// `‣ You have had a serious illness or major surgery in the past or are currently on medication. The reason you are taking medication may prevent you from giving blood.\n\n‣ You have had complicated dental work. Simple fillings as OK after 24 hours; simple extractions are OK after 7 days.\n\n‣ You have been in contact with an infectious disease or have been given certain immunisation in the last 4 weeks.\n\n‣ You are presently on a hospital waiting list or undergoing medical tests.\n\n‣ You have got or had any heart conditions.\n\n‣ You do not weigh over 7stone 12lbs (50kgs). Please note, if you are female and aged between 17 and 19 years, weigh less than 10stone 3lbs (65kgs) and are less than 5’6” (168cm) in height, we need to confirm your estimated blood volume is over 3500ml.`
  String get el4 {
    return Intl.message(
      '‣ You have had a serious illness or major surgery in the past or are currently on medication. The reason you are taking medication may prevent you from giving blood.\n\n‣ You have had complicated dental work. Simple fillings as OK after 24 hours; simple extractions are OK after 7 days.\n\n‣ You have been in contact with an infectious disease or have been given certain immunisation in the last 4 weeks.\n\n‣ You are presently on a hospital waiting list or undergoing medical tests.\n\n‣ You have got or had any heart conditions.\n\n‣ You do not weigh over 7stone 12lbs (50kgs). Please note, if you are female and aged between 17 and 19 years, weigh less than 10stone 3lbs (65kgs) and are less than 5’6” (168cm) in height, we need to confirm your estimated blood volume is over 3500ml.',
      name: 'el4',
      desc: '',
      args: [],
    );
  }

  /// `You should never give blood if:`
  String get el5 {
    return Intl.message(
      'You should never give blood if:',
      name: 'el5',
      desc: '',
      args: [],
    );
  }

  /// `‣ You have ever had syphilis, HTLV (Human T Cell lymphotropic Virus), HIV or Hepatitis C.\n\n‣ You are a man who has had anal or oral sex with another man with or without a condom.\n\n‣ You’ve ever worked as a commercial sex worker.\n\n‣ You’ve ever injected yourself with drugs – even once.`
  String get el6 {
    return Intl.message(
      '‣ You have ever had syphilis, HTLV (Human T Cell lymphotropic Virus), HIV or Hepatitis C.\n\n‣ You are a man who has had anal or oral sex with another man with or without a condom.\n\n‣ You’ve ever worked as a commercial sex worker.\n\n‣ You’ve ever injected yourself with drugs – even once.',
      name: 'el6',
      desc: '',
      args: [],
    );
  }

  /// `You should not give blood for 12 months after sex with:`
  String get el8 {
    return Intl.message(
      'You should not give blood for 12 months after sex with:',
      name: 'el8',
      desc: '',
      args: [],
    );
  }

  /// `‣ A man who has sex with another man (if you’re a female).\n\n‣ A commercial sex worker.\n\n‣ Anyone who has ever injected themselves with drugs.\n\n‣ Anyone with haemophilia or a related blood clotting disorder who has received clotting factor concentrates.\n\n‣ Anyone of any race, who has been sexually active in parts of the world where AIDS/HIV is very common. This includes countries in Africa.`
  String get el9 {
    return Intl.message(
      '‣ A man who has sex with another man (if you’re a female).\n\n‣ A commercial sex worker.\n\n‣ Anyone who has ever injected themselves with drugs.\n\n‣ Anyone with haemophilia or a related blood clotting disorder who has received clotting factor concentrates.\n\n‣ Anyone of any race, who has been sexually active in parts of the world where AIDS/HIV is very common. This includes countries in Africa.',
      name: 'el9',
      desc: '',
      args: [],
    );
  }

  /// `Pregnancy`
  String get el10 {
    return Intl.message(
      'Pregnancy',
      name: 'el10',
      desc: '',
      args: [],
    );
  }

  /// `‣ You should not give blood if you are pregnant or you are a woman who has had a baby in the last 6 months.\n\n‣ You can donate if you are breast feeding.\n\n‣ If you have had a miscarriage or termination before 12 weeks it may be possible for you to donate.`
  String get el11 {
    return Intl.message(
      '‣ You should not give blood if you are pregnant or you are a woman who has had a baby in the last 6 months.\n\n‣ You can donate if you are breast feeding.\n\n‣ If you have had a miscarriage or termination before 12 weeks it may be possible for you to donate.',
      name: 'el11',
      desc: '',
      args: [],
    );
  }

  /// `Drink's Alcohol Level`
  String get drinksAlcoholLevel {
    return Intl.message(
      'Drink\'s Alcohol Level',
      name: 'drinksAlcoholLevel',
      desc: '',
      args: [],
    );
  }

  /// `Volume Drink`
  String get volumeDrink {
    return Intl.message(
      'Volume Drink',
      name: 'volumeDrink',
      desc: '',
      args: [],
    );
  }

  /// `Day`
  String get day {
    return Intl.message(
      'Day',
      name: 'day',
      desc: '',
      args: [],
    );
  }

  /// `Minute`
  String get minute {
    return Intl.message(
      'Minute',
      name: 'minute',
      desc: '',
      args: [],
    );
  }

  /// `Hour`
  String get hour {
    return Intl.message(
      'Hour',
      name: 'hour',
      desc: '',
      args: [],
    );
  }

  /// `Ounce`
  String get ounce {
    return Intl.message(
      'Ounce',
      name: 'ounce',
      desc: '',
      args: [],
    );
  }

  /// `ml`
  String get ml {
    return Intl.message(
      'ml',
      name: 'ml',
      desc: '',
      args: [],
    );
  }

  /// `cup`
  String get cup {
    return Intl.message(
      'cup',
      name: 'cup',
      desc: '',
      args: [],
    );
  }

  /// `Time passed`
  String get timePassed {
    return Intl.message(
      'Time passed',
      name: 'timePassed',
      desc: '',
      args: [],
    );
  }

  /// `input a number. Ex(5 for 5%)`
  String get inputANumberEx5For5 {
    return Intl.message(
      'input a number. Ex(5 for 5%)',
      name: 'inputANumberEx5For5',
      desc: '',
      args: [],
    );
  }

  /// `Blood Alcohol Chart`
  String get bloodAlcoholChart {
    return Intl.message(
      'Blood Alcohol Chart',
      name: 'bloodAlcoholChart',
      desc: '',
      args: [],
    );
  }

  /// `Your blood Alcohol Content is`
  String get yourBloodAlcoholContentIs {
    return Intl.message(
      'Your blood Alcohol Content is',
      name: 'yourBloodAlcoholContentIs',
      desc: '',
      args: [],
    );
  }

  /// `The most accurate way to measure your Blood Alcohol Concentration (BAC) or alcohol level is to use a breathalyzer, but sometimes one is not readily available. In cases like this, use the charts below to plan for how many drinks you should limit yourself to.\n\nMultiply your weight in kg by 2.2 to get your weight in lbs using the calculator above.`
  String get resultDesc11 {
    return Intl.message(
      'The most accurate way to measure your Blood Alcohol Concentration (BAC) or alcohol level is to use a breathalyzer, but sometimes one is not readily available. In cases like this, use the charts below to plan for how many drinks you should limit yourself to.\n\nMultiply your weight in kg by 2.2 to get your weight in lbs using the calculator above.',
      name: 'resultDesc11',
      desc: '',
      args: [],
    );
  }

  /// `Choose your birth date`
  String get chooseYourBirthDate {
    return Intl.message(
      'Choose your birth date',
      name: 'chooseYourBirthDate',
      desc: '',
      args: [],
    );
  }

  /// `Number of breaths you have taken`
  String get numberOfBreathsYouHaveTaken {
    return Intl.message(
      'Number of breaths you have taken',
      name: 'numberOfBreathsYouHaveTaken',
      desc: '',
      args: [],
    );
  }

  /// `Enter Value`
  String get enterValue {
    return Intl.message(
      'Enter Value',
      name: 'enterValue',
      desc: '',
      args: [],
    );
  }

  /// `Diastolic blood pressure`
  String get diastolicBloodPressure {
    return Intl.message(
      'Diastolic blood pressure',
      name: 'diastolicBloodPressure',
      desc: '',
      args: [],
    );
  }

  /// `Systolic blood pressure`
  String get systolicBloodPressure {
    return Intl.message(
      'Systolic blood pressure',
      name: 'systolicBloodPressure',
      desc: '',
      args: [],
    );
  }

  /// `Hypertensive Crisis`
  String get hypertensiveCrisis {
    return Intl.message(
      'Hypertensive Crisis',
      name: 'hypertensiveCrisis',
      desc: '',
      args: [],
    );
  }

  /// `High Blood Pressure (Stage 2)`
  String get highBloodPressureStage2 {
    return Intl.message(
      'High Blood Pressure (Stage 2)',
      name: 'highBloodPressureStage2',
      desc: '',
      args: [],
    );
  }

  /// `High Blood Pressure (Stage 1)`
  String get highBloodPressureStage1 {
    return Intl.message(
      'High Blood Pressure (Stage 1)',
      name: 'highBloodPressureStage1',
      desc: '',
      args: [],
    );
  }

  /// `Prehypertension`
  String get prehypertension {
    return Intl.message(
      'Prehypertension',
      name: 'prehypertension',
      desc: '',
      args: [],
    );
  }

  /// `Normal`
  String get normal {
    return Intl.message(
      'Normal',
      name: 'normal',
      desc: '',
      args: [],
    );
  }

  /// `Low`
  String get low {
    return Intl.message(
      'Low',
      name: 'low',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Ok`
  String get ok {
    return Intl.message(
      'Ok',
      name: 'ok',
      desc: '',
      args: [],
    );
  }

  /// `Your blood pressure is`
  String get yourBloodPressureIs {
    return Intl.message(
      'Your blood pressure is',
      name: 'yourBloodPressureIs',
      desc: '',
      args: [],
    );
  }

  /// `Share`
  String get share {
    return Intl.message(
      'Share',
      name: 'share',
      desc: '',
      args: [],
    );
  }

  /// `Privacy policy`
  String get privacyPolicy {
    return Intl.message(
      'Privacy policy',
      name: 'privacyPolicy',
      desc: '',
      args: [],
    );
  }

  /// `feedback`
  String get feedback {
    return Intl.message(
      'feedback',
      name: 'feedback',
      desc: '',
      args: [],
    );
  }

  /// `Did this app hurt you physically ?`
  String get didThisAppHurtYouPhysically {
    return Intl.message(
      'Did this app hurt you physically ?',
      name: 'didThisAppHurtYouPhysically',
      desc: '',
      args: [],
    );
  }

  /// `That's not really cool man`
  String get thatsNotReallyCoolMan {
    return Intl.message(
      'That\'s not really cool man',
      name: 'thatsNotReallyCoolMan',
      desc: '',
      args: [],
    );
  }

  /// `Well, it's average.`
  String get wellItsAverage {
    return Intl.message(
      'Well, it\'s average.',
      name: 'wellItsAverage',
      desc: '',
      args: [],
    );
  }

  /// `This is cool, like this app.`
  String get thisIsCoolLikeThisApp {
    return Intl.message(
      'This is cool, like this app.',
      name: 'thisIsCoolLikeThisApp',
      desc: '',
      args: [],
    );
  }

  /// `Great ! <3`
  String get great3 {
    return Intl.message(
      'Great ! <3',
      name: 'great3',
      desc: '',
      args: [],
    );
  }

  /// `Format`
  String get format {
    return Intl.message(
      'Format',
      name: 'format',
      desc: '',
      args: [],
    );
  }

  /// `Rate Us`
  String get rateUs {
    return Intl.message(
      'Rate Us',
      name: 'rateUs',
      desc: '',
      args: [],
    );
  }

  /// `Personal Data`
  String get personalData {
    return Intl.message(
      'Personal Data',
      name: 'personalData',
      desc: '',
      args: [],
    );
  }

  /// `Let us know you better and speed up your results.`
  String get persnoalDesc {
    return Intl.message(
      'Let us know you better and speed up your results.',
      name: 'persnoalDesc',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get next {
    return Intl.message(
      'Next',
      name: 'next',
      desc: '',
      args: [],
    );
  }

  /// `Gender`
  String get gender {
    return Intl.message(
      'Gender',
      name: 'gender',
      desc: '',
      args: [],
    );
  }

  /// `Weight`
  String get weight {
    return Intl.message(
      'Weight',
      name: 'weight',
      desc: '',
      args: [],
    );
  }

  /// `Height`
  String get height {
    return Intl.message(
      'Height',
      name: 'height',
      desc: '',
      args: [],
    );
  }

  /// `Done`
  String get done {
    return Intl.message(
      'Done',
      name: 'done',
      desc: '',
      args: [],
    );
  }

  /// `Select Gender`
  String get selectGender {
    return Intl.message(
      'Select Gender',
      name: 'selectGender',
      desc: '',
      args: [],
    );
  }

  /// `Please select your gender`
  String get pleaseSelectYourGender {
    return Intl.message(
      'Please select your gender',
      name: 'pleaseSelectYourGender',
      desc: '',
      args: [],
    );
  }

  /// `You need to create a new basic profile with height.`
  String get youNeedToCreateANewBasicProfileWithHeight {
    return Intl.message(
      'You need to create a new basic profile with height.',
      name: 'youNeedToCreateANewBasicProfileWithHeight',
      desc: '',
      args: [],
    );
  }

  /// `You need to create a new basic profile with weight.`
  String get youNeedToCreateANewBasicProfileWithWeight {
    return Intl.message(
      'You need to create a new basic profile with weight.',
      name: 'youNeedToCreateANewBasicProfileWithWeight',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profile {
    return Intl.message(
      'Profile',
      name: 'profile',
      desc: '',
      args: [],
    );
  }

  /// `Setting`
  String get setting {
    return Intl.message(
      'Setting',
      name: 'setting',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    if (locale != null) {
      for (var supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}