import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:movies_app/core/theme/app_colors.dart';
import 'package:movies_app/movies/presentation/controllers/app_controller/app_language.dart';
import 'package:movies_app/movies/presentation/controllers/app_controller/cubit/app_cubit.dart';
import 'package:movies_app/movies/presentation/screens/drawer/drawer_screen.dart';
import 'package:movies_app/movies/presentation/screens/movies_screen/movies_screen.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:movies_app/movies/presentation/widgets/custome_static_color_text.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  Widget buildNoInternetWidget() {
    return Center(
      child: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/wifi.png',
                height: 100,
                width: 100,
              ),
              const SizedBox(height: 15),
              CustomeStaticColorText(
                text: 'check internet'.tr,
                color: Colors.black,
                size: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget showLoadingIndicator() {
    return Center(
      child: SizedBox(
        height: 300.0,
        width: 300.0,
        child: Lottie.asset('assets/json/loading.json'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppLanguageController>(
      builder: (controller) => OfflineBuilder(
        connectivityBuilder: (BuildContext context,
            ConnectivityResult connectivity, Widget child) {
          final bool connected = connectivity != ConnectivityResult.none;
          if (connected) {
            return BlocBuilder<AppCubit, AppState>(
              builder: (context, state) => ZoomDrawer(
                menuScreen: const DrawerScreen(),
                mainScreen: const MoviesScreen(),
                borderRadius: 50,
                showShadow: true,
                isRtl: controller.appLanguage == 'en' ? false : true,
                angle: 0.0,
                slideWidth: 300,
                drawerShadowsBackgroundColor:
                    const Color.fromARGB(255, 66, 82, 199),
                menuBackgroundColor: AppCubit.get(context).isDark
                    ? AppColors.lighBackGroundColor
                    : AppColors.darkBackGroundColor,
                mainScreenTapClose: true,
              ),
            );
          } else {
            return buildNoInternetWidget();
          }
        },
        child: showLoadingIndicator(),
      ),
    );
  }
}
