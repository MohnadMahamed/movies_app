import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:movies_app/movies/data/datasource/local_storage.dart';

class AppLanguageController extends GetxController {
  var appLanguage = 'en';
  @override
  void onInit() async {
    super.onInit();
    AppLocalStorage localStorage = AppLocalStorage();
    // ignore: unnecessary_null_comparison
    appLanguage = await (localStorage.languageSelected) == null
        ? 'en'
        : await localStorage.languageSelected;
    Get.updateLocale(Locale(appLanguage));
    update();
  }

  void chooseLanguage(String languageType) {
    AppLocalStorage localStorage = AppLocalStorage();
    if (appLanguage == languageType) {
      return;
    } else if (languageType == 'en') {
      appLanguage = 'en';
      localStorage.saveAppLanguage('en');
    } else {
      appLanguage = 'ar';
      localStorage.saveAppLanguage('ar');
    }
    update();
  }

  void changeLanguage() {
    AppLocalStorage localStorage = AppLocalStorage();
    if (appLanguage == 'ar') {
      appLanguage = 'en';
      localStorage.saveAppLanguage('en');
      Get.updateLocale(const Locale('en'));
    } else {
      appLanguage = 'ar';
      localStorage.saveAppLanguage('ar');
      Get.updateLocale(const Locale('ar'));
    }
    update();
  }
}
