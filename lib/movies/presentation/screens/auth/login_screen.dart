import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:movies_app/core/animation/fade_animation.dart';
import 'package:movies_app/core/theme/app_colors.dart';
import 'package:movies_app/movies/presentation/controllers/app_controller/app_language.dart';
import 'package:movies_app/movies/presentation/controllers/app_controller/cubit/app_cubit.dart';
import 'package:movies_app/movies/presentation/controllers/auth_controller/cubit/auth_cubit.dart';
import 'package:movies_app/movies/presentation/screens/auth/register_screen.dart';
import 'package:movies_app/movies/presentation/widgets/custome_button.dart';
import 'package:movies_app/movies/presentation/widgets/custome_form_field.dart';
import 'package:movies_app/movies/presentation/widgets/custome_static_color_text.dart';
import 'package:movies_app/movies/presentation/widgets/cutome_text.dart';

class LoginScreen extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  LoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          var cubit = AuthCubit.get(context);
          return SafeArea(
            child: Scaffold(
              body: Stack(
                children: [
                  Image.asset(
                    'assets/images/back.jpg',
                    height: MediaQuery.of(context).size.height,
                    width: double.infinity,
                    fit: BoxFit.fitHeight,
                  ),
                  SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Container(
                        height: MediaQuery.of(context).size.height,
                        width: double.infinity,
                        padding: const EdgeInsets.all(20.0),
                        decoration: BoxDecoration(
                            color: AppCubit.get(context).isDark
                                ? AppColors.lighBackGroundColor.withOpacity(.8)
                                : AppColors.darkBackGroundColor
                                    .withOpacity(.8)),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 50.0,
                            ),
                            FadeAnimation(
                              0.1,
                              child: CustomeStaticColorText(
                                text: 'Sign In'.tr,
                                color: AppColors.mainAppColors,
                                size: 30.0,
                              ),
                            ),
                            const SizedBox(
                              height: 30.0,
                            ),
                            Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  FadeAnimation(
                                    0.2,
                                    child: CustomeFormField(
                                        text: 'Email'.tr,
                                        prefixWidget: const Icon(
                                          Icons.email,
                                          color: Colors.white,
                                        ),
                                        controller: cubit.loginEmailController,
                                        hintText: 'Email hint'.tr,
                                        type: TextInputType.emailAddress,
                                        onTap: (va) {},
                                        onChanged: (s) {},
                                        validator: (String? value) {
                                          if (value!.isEmpty) {
                                            return 'Please Enter your Email'.tr;
                                          }
                                          return null;
                                        }),
                                  ),
                                  FadeAnimation(
                                    0.3,
                                    child: CustomeFormField(
                                        text: 'Password'.tr,
                                        prefixWidget: const Icon(
                                          Icons.lock,
                                          color: Colors.white,
                                        ),
                                        isPassword: cubit.isPassword,
                                        suffixIcon: IconButton(
                                          onPressed: () {
                                            cubit.changLogingPassVisibility();
                                          },
                                          icon: Icon(
                                            cubit.passwordSuffix,
                                            color: Colors.white,
                                          ),
                                        ),
                                        controller:
                                            cubit.loginPasswordController,
                                        hintText: 'Password hint'.tr,
                                        type: TextInputType.visiblePassword,
                                        onTap: (va) {},
                                        onChanged: (s) {},
                                        validator: (String? value) {
                                          if (value!.isEmpty) {
                                            return 'Please Enter your Password'
                                                .tr;
                                          }
                                          return null;
                                        }),
                                  ),
                                  FadeAnimation(
                                    0.4,
                                    child: Align(
                                        alignment: Alignment.bottomRight,
                                        child: CustomeText(
                                          text: 'Forget Password'.tr,
                                          size: 15.0,
                                        )),
                                  ),
                                  const SizedBox(
                                    height: 15.0,
                                  ),
                                  FadeAnimation(
                                    0.5,
                                    child: CustomeButton(
                                        isLoading: state is LoginLoadingState,
                                        backgroudColor:
                                            state is LoginLoadingState
                                                ? AppColors.mainAppColors
                                                    .withOpacity(.4)
                                                : AppColors.mainAppColors,
                                        text: 'Login'.tr,
                                        onTap: () {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            cubit.signInWithEmailAndPassword(
                                                context);
                                          }
                                        }),
                                  ),
                                  const SizedBox(
                                    height: 20.0,
                                  ),
                                  FadeAnimation(0.6,
                                      child: CustomeText(text: 'or'.tr)),
                                  const SizedBox(
                                    height: 20.0,
                                  ),
                                  FadeAnimation(0.7,
                                      child:
                                          CustomeText(text: 'Sign in with'.tr)),
                                  const SizedBox(
                                    height: 30.0,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 80.0),
                                    child: FadeAnimation(
                                      0.8,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          GetBuilder<AppLanguageController>(
                                            builder: (controller) => InkWell(
                                              onTap: () {
                                                // controller.changeLanguage();
                                              },
                                              child: SizedBox(
                                                height: 50.0,
                                                width: 50.0,
                                                child: Image.asset(
                                                    'assets/images/facebook.png'),
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              cubit.googleSignInMethod(context);
                                              // AppCubit.get(context).changeAppMode();
                                              // AppLocalStorage localStorage =
                                              //     AppLocalStorage();

                                              // AppCubit.get(context).changeAppMode(
                                              //     await localStorage.modeNow);
                                              // if (await localStorage.modeNow == true) {
                                              //   localStorage.saveAppMode(false);
                                              // } else {
                                              //   (localStorage.saveAppMode(true));
                                              // }

                                              // print(await localStorage.modeNow);
                                              // print(
                                              //     'isDaaaaaaaaaaaaaaaaaark : ${AppCubit.get(context).isDark} ');
                                            },
                                            child: SizedBox(
                                              height: 50.0,
                                              width: 50.0,
                                              child: Image.asset(
                                                  'assets/images/google.png'),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 30.0,
                                  ),
                                  FadeAnimation(0.9,
                                      child: CustomeText(text: 'Do not'.tr)),
                                  const SizedBox(
                                    height: 5.0,
                                  ),
                                  FadeAnimation(
                                    1.0,
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    RegisterScreen()));
                                      },
                                      child: CustomeText(
                                        text: 'Sign Up'.tr,
                                        size: 22,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
