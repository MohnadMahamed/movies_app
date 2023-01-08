// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:movies_app/core/services/services_lacator.dart';
import 'package:movies_app/core/theme/dark_theme.dart';
import 'package:movies_app/core/theme/light_theme.dart';
import 'package:movies_app/core/utils/app_string.dart';
import 'package:movies_app/core/utils/lang/translation.dart';
import 'package:movies_app/movies/data/datasource/cashe_helper.dart';
import 'package:movies_app/movies/presentation/controllers/app_controller/app_language.dart';
import 'package:movies_app/movies/presentation/controllers/app_controller/cubit/app_cubit.dart';
import 'package:movies_app/movies/presentation/controllers/auth_controller/cubit/auth_cubit.dart';
import 'package:movies_app/movies/presentation/controllers/auth_controller/local_user_storage.dart';
import 'package:movies_app/movies/presentation/controllers/search/search_cubit.dart';
import 'package:movies_app/movies/presentation/screens/splash_screen/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  await Firebase.initializeApp();

  ServicesLocator().init();
  await GetStorage.init();
  // AppLocalStorage localStorage = AppLocalStorage();
  // bool? isDark = await localStorage.modeNow;
  bool? isDark = CacheHelper.getData(key: 'isDark');
  Get.lazyPut(() => LocalUserStorageData());
  // Get.lazyPut(() => ProfileViewModel());

  runApp(MyApp(
    isDark: isDark,
  ));
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  bool? isDark;
  MyApp({
    Key? key,
    this.isDark,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AppCubit()..changeAppMode(fromShared: isDark),
          ),
          BlocProvider(create: (context) => AuthCubit()..onInit()),
          BlocProvider(
            create: (context) => SearchCubit(sl())..checkForFocusNode(),
          ),
        ],
        child: GetBuilder<LocalUserStorageData>(
          init: Get.find<LocalUserStorageData>(),
          builder: (controller) => BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) => BlocBuilder<AppCubit, AppState>(
              builder: (context, state) => GetBuilder<AppLanguageController>(
                init: AppLanguageController(),
                builder: (controller) => GetMaterialApp(
                  title: AppString.appName,
                  debugShowCheckedModeBanner: false,
                  translations: Translation(),
                  locale: Locale(controller.appLanguage),
                  fallbackLocale: const Locale('en'),

                  // theme: ThemeData.dark().copyWith(
                  //   scaffoldBackgroundColor: Color.fromARGB(255, 26, 14, 14),
                  // ),
                  theme: lightTheme,
                  darkTheme: darkTheme,
                  themeMode: AppCubit.get(context).isDark
                      ? ThemeMode.light
                      : ThemeMode.dark,
                  home: const SplashScreen(),
                ),
              ),
            ),
          ),
        ));
  }
}
