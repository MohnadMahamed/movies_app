import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:movies_app/core/animation/fade_animation.dart';
import 'package:movies_app/core/theme/app_colors.dart';
import 'package:movies_app/movies/presentation/controllers/app_controller/cubit/app_cubit.dart';
import 'package:movies_app/movies/presentation/controllers/auth_controller/cubit/auth_cubit.dart';
import 'package:movies_app/movies/presentation/widgets/custome_button.dart';
import 'package:movies_app/movies/presentation/widgets/custome_form_field.dart';
import 'package:movies_app/movies/presentation/widgets/custome_static_color_text.dart';
import 'package:movies_app/movies/presentation/widgets/cutome_text.dart';

class RegisterScreen extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  RegisterScreen({super.key});

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
                              height: 30.0,
                            ),
                            FadeAnimation(
                              0.1,
                              child: Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    icon: Icon(
                                      Icons.arrow_back_ios,
                                      color: AppColors.mainAppColors,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 30.0,
                            ),
                            FadeAnimation(
                              0.2,
                              child: CustomeStaticColorText(
                                text: 'Sign Up'.tr,
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
                                    0.3,
                                    child: CustomeFormField(
                                        text: 'Name'.tr,
                                        prefixWidget: const Icon(
                                          Icons.person,
                                          color: Colors.white,
                                        ),
                                        controller:
                                            cubit.registerNameController,
                                        hintText: 'Name hint'.tr,
                                        type: TextInputType.emailAddress,
                                        onTap: (va) {},
                                        onChanged: (s) {},
                                        validator: (String? value) {
                                          if (value!.isEmpty) {
                                            return 'Please Enter your Name'.tr;
                                          }
                                          return null;
                                        }),
                                  ),
                                  FadeAnimation(
                                    0.4,
                                    child: CustomeFormField(
                                        text: 'Email'.tr,
                                        prefixWidget: const Icon(
                                          Icons.email,
                                          color: Colors.white,
                                        ),
                                        controller:
                                            cubit.registerEmailController,
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
                                    0.5,
                                    child: CustomeFormField(
                                        text: 'Password'.tr,
                                        prefixWidget: const Icon(
                                          Icons.lock,
                                          color: Colors.white,
                                        ),
                                        isPassword: cubit.isPasswordRegister,
                                        suffixIcon: IconButton(
                                            onPressed: () {
                                              cubit
                                                  .changRegisterPassVisibility();
                                            },
                                            icon: Icon(
                                              cubit.registerPasswordSuffix,
                                              color: Colors.white,
                                            )),
                                        controller:
                                            cubit.registerPasswordController,
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
                                    0.6,
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
                                    0.7,
                                    child: CustomeButton(
                                        isLoading: state is SingupLoadingState,
                                        backgroudColor:
                                            state is SingupLoadingState
                                                ? AppColors.mainAppColors
                                                    .withOpacity(.4)
                                                : AppColors.mainAppColors,
                                        text: 'Sign Up'.tr,
                                        onTap: () {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            cubit
                                                .createAccountWithEmailAndPassword(
                                                    context);
                                          }
                                          // if (_formKey.currentState!.validate()) {
                                          //   Navigator.push(
                                          //       context,
                                          //       MaterialPageRoute(
                                          //           builder: (context) =>
                                          //               const MoviesScreen()));
                                          // }
                                        }),
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
