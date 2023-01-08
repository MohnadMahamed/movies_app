import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:movies_app/core/theme/app_colors.dart';
import 'package:movies_app/movies/data/datasource/cashe_helper.dart';
import 'package:movies_app/movies/presentation/controllers/app_controller/cubit/app_cubit.dart';
import 'package:movies_app/movies/presentation/screens/home/home_screen.dart';
import 'package:movies_app/movies/presentation/screens/on_boarding/on_boarding_screen.dart';
import 'package:movies_app/movies/presentation/widgets/custome_static_color_text.dart';
import 'package:movies_app/movies/presentation/widgets/cutome_text.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;

  _startDelay() {
    _timer = Timer(const Duration(seconds: 5), _goNext);
  }

  _goNext() async {
    bool onborading = CacheHelper.getData(key: 'onBoarding') ?? false;

    if (onborading == true) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomeScreen()));
    } else {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const OnBoradingScreen()));
    }
  }

  @override
  void initState() {
    // Timer(const Duration(seconds: 4), () {
    //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
    //     return const HomeScreen();
    //   }));
    // });
    super.initState();
    _startDelay();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppCubit.get(context).isDark
            ? AppColors.lighBackGroundColor
            : AppColors.darkBackGroundColor,
        body: Stack(
          children: [
            SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: SizedBox(
                height: 200.0,
                width: 200.0,
                child: Lottie.asset('assets/json/action.json'),
              ),
            ),
            Positioned(
              bottom: 10,
              left: 5,
              right: 5,
              child: Column(
                children: [
                  CustomeStaticColorText(
                    text: 'Movie DB',
                    size: 30,
                    color: AppColors.mainAppColors.withOpacity(.8),
                  ),
                  SizedBox(
                    height: 140.0,
                    width: 140.0,
                    child: Lottie.asset('assets/json/loading.json'),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const CustomeText(
                    text: 'Created By Mohnad Mahamed',
                    size: 20,
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
