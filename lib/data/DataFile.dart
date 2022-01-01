import 'package:flutter/material.dart';
import 'package:flutter_health_calculator/generated/l10n.dart';

import 'package:flutter_health_calculator/model/RowItem.dart';
import 'package:flutter_health_calculator/utils/ConstantData.dart';

class DataFile {


  static List<RowItem> getCategoryModel(BuildContext context) {
    List<String> titleList = getTitleList(context);
    List<String> descList = getDescList(context);
    List<RowItem> list = [];

    // RowItem model = new RowItem();
    // model.id = 1;
    // model.name = "HairCare";
    // model.image = "cat_img.png";
    // list.add(model);


    for(int i=0;i<titleList.length;i++){
      RowItem model = new RowItem();
      model.id = (i+1);
      model.title = titleList[i];
      model.description = descList[i];
      model.color = getColorList()[i];
      model.pageName = getPageList(context)[i];
      model.resultDesc = getResultDescList(context)[i];
      model.resultText = getResultTextList(context)[i];
      model.pdf = getPdfList(context)[i];
      model.image = getMainIcon(context)[i];
      model.transImage = getTransparentIcon(context)[i];


      list.add(model);
    }

    return list;
  }

  static List<String> getPageList(BuildContext context) {
    return ["IdealWeightPage","BodyMassPage","BodyFatPage","CaloriesWeightPage","WaterIntakePage","HeartRatePage","PregnancyPage",
      "OvulationPage","BloodVolumePage","BloodDonationPage","BloodAlcoholPage","BreathCountPage","BloodPressurePage"];
  }
  static List<String> getPdfList(BuildContext context) {
    return ["ideal_weight_chart.png","chart_new.png","body_fat_chart.png","calorie_chart.png","water_chart.png","heart_chart.png",
      "preg_chart.jpg","ovulation_chart.png","","giving_blood.png","bac.png","",""];
  }


  static List<String> getMainIcon(BuildContext context) {
    return ["ideal_weight_main.png","bmi_icon.png","body_fat.png","calories.png","water_intake.png","heart_rate.png",
      "pregnancy_due_date.png","ovolution.png","blood_volume.png","blood_donation.png","blood_alcohol.png","breath_count.png","blood_pressure.png"];
  }

  static List<String> getTransparentIcon(BuildContext context) {
    return ["ideal_weight_tr.png","transparent_bmi_icon.png","body_fat_tr.png","calories_tr.png","water_intake_tr.png","heart_rate_tr.png",
      "pregnancy_due_date_tr.png","ovolution_tr.png","blood_volume_tr.png","blood_donation_tr.png","blood_alcohol_tr.png",
      "breath_count_tr.png","blood_pressure_tr.png"];
  }



  static List<String> getResultTextList(BuildContext context) {
    return [S.of(context).yourIdealWeightIs,S.of(context).yourBodyMassIndexIs,S.of(context).yourEstimatedBodyFatPercentageIs,
      S.of(context).youEstimatedDailyCaloricNeedIs,S.of(context).yourDailyWaterRequirementIs,S.of(context).yourMaximumHeartRateIs,
      S.of(context).yourExpectedDeliveryDateIs,S.of(context).yourUpcomingMostFertileDaysAre,S.of(context).yourTotalBloodVolumeIs,
      S.of(context).yourNextEligibleDateIs,S.of(context).yourBloodAlcoholContentIs,S.of(context).numberOfBreathsYouHaveTaken,
      S.of(context).yourBloodPressureIs];
  }
  static List<String> getResultDescList(BuildContext context) {
    return [S.of(context).resultDesc1,S.of(context).resultDesc2,S.of(context).resultDesc3,S.of(context).resultDesc4
      ,S.of(context).resultDesc5,S.of(context).resultDesc6,S.of(context).resultDesc7,S.of(context).resultDesc8,"",
      S.of(context).resultDesc10,S.of(context).resultDesc11,"",""];
  }

  static List<String> getTitleList(BuildContext context) {
    return [S.of(context).idealWeight,S.of(context).bodyMassIndex,S.of(context).bodyFat,S.of(context).caloriesForWeightGainloss,S.of(context).waterIntake,S.of(context).targetHeartRate,S.of(context).pregnancyDueDate,S.of(context).ovulationPeriod,S.of(context).bloodVolume,S.of(context).bloodDonation,S.of(context).bloodAlcohol,S.of(context).breathCount,S.of(context).bloodPressure];
  }

  static List<String> getDescList(BuildContext context) {
    return [S.of(context).desc1,S.of(context).desc2,S.of(context).desc3,S.of(context).desc4,S.of(context).desc5,
      S.of(context).desc6,S.of(context).desc7,S.of(context).desc8,S.of(context).desc9,S.of(context).desc9,S.of(context).desc10,S.of(context).desc11,S.of(context).desc12];
  }

  static List<Color> getColorList() {
    return [ConstantData.color1,ConstantData.color2,ConstantData.color3,ConstantData.color4,ConstantData.color5,ConstantData.color6,ConstantData.color7,ConstantData.color8,ConstantData.color9,ConstantData.color10,ConstantData.color11,ConstantData.color12,ConstantData.color13,ConstantData.color14,ConstantData.color15];
  }

}
