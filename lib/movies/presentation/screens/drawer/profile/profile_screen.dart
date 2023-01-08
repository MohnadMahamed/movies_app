import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:movies_app/core/animation/fade_animation.dart';
import 'package:movies_app/core/theme/app_colors.dart';
import 'package:movies_app/movies/presentation/controllers/app_controller/app_language.dart';
import 'package:movies_app/movies/presentation/controllers/app_controller/cubit/app_cubit.dart';
import 'package:movies_app/movies/presentation/controllers/auth_controller/cubit/auth_cubit.dart';
import 'package:movies_app/movies/presentation/screens/drawer/profile/bottom_sheet_widget.dart';
import 'package:movies_app/movies/presentation/screens/home/home_screen.dart';
import 'package:movies_app/movies/presentation/widgets/custome_static_color_text.dart';
import 'package:movies_app/movies/presentation/widgets/cutome_text.dart';

class MyProfileScreen extends StatelessWidget {
  MyProfileScreen({super.key});
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit()..onInit(),
      child: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          var cubit = AuthCubit.get(context);
          return SafeArea(
              child: Scaffold(
            key: _scaffoldKey,
            backgroundColor: AppCubit.get(context).isDark
                ? AppColors.lighBackGroundColor
                : AppColors.darkBackGroundColor,
            body: Column(
              children: [
                const SizedBox(height: 10.0),
                BlocProvider(
                  create: (context) => AuthCubit()..onInit(),
                  child: BlocBuilder<AuthCubit, AuthState>(
                      builder: (context, state) {
                    return AuthCubit.get(context).user == null
                        ? const SizedBox()
                        : Column(
                            // mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FadeAnimation(
                                0.1,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 20.0,
                                      right: 20,
                                      left: 20.0,
                                      bottom: 50),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const HomeScreen()));
                                            // Navigator.pop(context);
                                          },
                                          icon: Icon(
                                            Icons.arrow_back_ios,
                                            size: 30.0,
                                            color: AppCubit.get(context).isDark
                                                ? Colors.black54
                                                : Colors.white70,
                                          )),
                                      IconButton(
                                          onPressed: () {
                                            _scaffoldKey.currentState!
                                                .showBottomSheet(
                                                    enableDrag: true,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      side: BorderSide(
                                                          color: AppColors
                                                              .mainAppColors
                                                              .withOpacity(.4),
                                                          width: 1),
                                                      borderRadius:
                                                          const BorderRadius
                                                                  .only(
                                                              topLeft: Radius
                                                                  .circular(40),
                                                              topRight: Radius
                                                                  .circular(
                                                                      40)),
                                                    ),
                                                    backgroundColor: AppCubit
                                                                .get(context)
                                                            .isDark
                                                        ? AppColors
                                                            .lighBackGroundColor
                                                        : AppColors
                                                            .darkBackGroundColor,
                                                    // context: context,
                                                    (context) {
                                              return const BottomSheetWidget();
                                            });
                                          },
                                          icon: Icon(
                                            Icons.edit,
                                            size: 30.0,
                                            color: AppCubit.get(context).isDark
                                                ? Colors.black54
                                                : Colors.white70,
                                          )),
                                    ],
                                  ),
                                ),
                              ),
                              FadeAnimation(
                                0.3,
                                child: CircleAvatar(
                                  radius: 47.0,
                                  child: Container(
                                    height: 90.0,
                                    width: 90.0,
                                    decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius:
                                            BorderRadius.circular(100.0),
                                        image: DecorationImage(
                                          image: cubit.userModel.pic!.isEmpty
                                              ? const AssetImage(
                                                  'assets/images/facebook.png',
                                                )
                                              : cubit.userModel.pic == 'default'
                                                  ? const AssetImage(
                                                      'assets/images/pic_profile.png')
                                                  : NetworkImage(
                                                      cubit.userModel.pic!,
                                                    ) as ImageProvider,
                                          fit: BoxFit.fill,
                                        )),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 50.0,
                              ),
                              FadeAnimation(
                                0.5,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  child: Row(
                                    children: [
                                      CustomeText(
                                        text: '${'Name'.tr} : ',
                                        size: 18.0,
                                      ),
                                      SizedBox(
                                        width: 235,
                                        child: Container(
                                          margin: const EdgeInsets.all(10),
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            color: Colors.red.withOpacity(.4),
                                            border: Border.all(
                                                color: AppColors.mainAppColors),
                                          ),
                                          child: Center(
                                            child: CustomeStaticColorText(
                                              text: cubit.userModel.name!,
                                              size: 20.0,
                                              color:
                                                  AppCubit.get(context).isDark
                                                      ? Colors.black45
                                                      : Colors.white70,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20.0,
                              ),
                              GetBuilder<AppLanguageController>(
                                builder: (controller) => FadeAnimation(
                                  0.6,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0),
                                    child: Row(
                                      children: [
                                        CustomeText(
                                          text: '${'Email'.tr} : ',
                                          size: 18.0,
                                        ),
                                        SizedBox(
                                          width: controller.appLanguage == 'en'
                                              ? 250
                                              : 170,
                                          child: Container(
                                            margin: const EdgeInsets.all(10),
                                            padding: const EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              color: Colors.red.withOpacity(.4),
                                              border: Border.all(
                                                  color:
                                                      AppColors.mainAppColors),
                                            ),
                                            child: Center(
                                              child: CustomeStaticColorText(
                                                text: cubit.userModel.email!,
                                                size: 20.0,
                                                color:
                                                    AppCubit.get(context).isDark
                                                        ? Colors.black45
                                                        : Colors.white70,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                  }),
                ),
              ],
            ),
          ));
        },
      ),
    );
  }
}
