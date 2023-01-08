import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:movies_app/core/animation/fade_animation.dart';
import 'package:movies_app/core/theme/app_colors.dart';
import 'package:movies_app/movies/data/datasource/cashe_helper.dart';
import 'package:movies_app/movies/presentation/controllers/app_controller/cubit/app_cubit.dart';
import 'package:movies_app/movies/presentation/screens/home/home_screen.dart';
import 'package:movies_app/movies/presentation/widgets/custome_button.dart';
import 'package:movies_app/movies/presentation/widgets/custome_static_color_text.dart';
import 'package:movies_app/movies/presentation/widgets/cutome_text.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BordingModel {
  final String image;
  final String title;
  final String body;

  BordingModel({required this.image, required this.title, required this.body});
}

class OnBoradingScreen extends StatefulWidget {
  const OnBoradingScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<OnBoradingScreen> createState() => _OnBoradingScreenState();
}

class _OnBoradingScreenState extends State<OnBoradingScreen> {
  var boardController = PageController();

  List<BordingModel> boarding = [
    BordingModel(
      image: 'assets/json/on_boarding1.json',
      title: 'Trying to join Movie DB?',
      body:
          'You can know which films are currently shown, the most popular and the top rated',
    ),
    BordingModel(
      image: 'assets/json/on_boarding2.json',
      title: 'Go And Explore It Now!',
      body:
          'You can also search for any movie and put it in your favorites list if you have an account',
    ),
  ];
  bool isLast = false;

  void submit() {
    CacheHelper.putBoolean(key: 'onBoarding', value: true).then((value) {
      if (value) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const HomeScreen()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            Align(
              alignment: Alignment.topRight,
              child: FadeAnimation(
                .7,
                child: CustomeButton(
                  width: 100,
                  height: 50,
                  text: 'Skip',
                  onTap: () {
                    submit();
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Expanded(
              child: PageView.builder(
                onPageChanged: (int index) {
                  if (index == boarding.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                physics: const BouncingScrollPhysics(),
                controller: boardController,
                itemBuilder: (context, index) =>
                    buildBoardingItem(boarding[index]),
                itemCount: boarding.length,
              ),
            ),
            const SizedBox(height: 20.0),
            FadeAnimation(
              1.9,
              child: Row(
                children: [
                  SmoothPageIndicator(
                    controller: boardController,
                    count: boarding.length,
                    effect: ExpandingDotsEffect(
                      dotColor: Colors.grey,
                      dotHeight: 10,
                      expansionFactor: 2,
                      dotWidth: 15,
                      spacing: 8,
                      activeDotColor: AppColors.mainAppColors,
                    ),
                  ),
                  const Spacer(),
                  FloatingActionButton(
                    backgroundColor: AppColors.mainAppColors,
                    onPressed: () {
                      if (isLast) {
                        submit();
                      } else {
                        boardController.nextPage(
                          duration: const Duration(
                            milliseconds: 750,
                          ),
                          curve: Curves.fastLinearToSlowEaseIn,
                        );
                      }
                    },
                    child: const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(BordingModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Center(
              child: FadeAnimation(
                1,
                child: SizedBox(
                  height: 400.0,
                  // width: 500.0,
                  child: Lottie.asset(model.image, fit: BoxFit.contain),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20.0),
          FadeAnimation(
            1.3,
            child: CustomeStaticColorText(
              text: model.title,
              size: 23.0,
              maxLines: 2,
              color: AppCubit.get(context).isDark ? Colors.black : Colors.white,
            ),
          ),
          const SizedBox(height: 10.0),
          FadeAnimation(
            1.6,
            child: CustomeText(
              text: model.body,
              maxLines: 4,
            ),
          ),
        ],
      );
}
