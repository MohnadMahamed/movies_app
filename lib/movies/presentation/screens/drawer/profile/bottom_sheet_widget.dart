import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:movies_app/core/animation/fade_animation.dart';
import 'package:movies_app/core/theme/app_colors.dart';
import 'package:movies_app/movies/presentation/controllers/app_controller/cubit/app_cubit.dart';
import 'package:movies_app/movies/presentation/controllers/auth_controller/cubit/auth_cubit.dart';
import 'package:movies_app/movies/presentation/screens/drawer/profile/upload_image_dialog.dart';
import 'package:movies_app/movies/presentation/widgets/custome_button.dart';
import 'package:movies_app/movies/presentation/widgets/custome_form_field.dart';

class BottomSheetWidget extends StatelessWidget {
  const BottomSheetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(builder: (context, state) {
      var cubit = AuthCubit.get(context);
      return BlocProvider(
          create: (context) => AuthCubit()..onInit(),
          child: cubit.user == null
              ? const SizedBox()
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Container(
                      // width: MediaQuery.of(context).size.width * .9,

                      color: AppCubit.get(context).isDark
                          ? AppColors.lighBackGroundColor
                          : AppColors.darkBackGroundColor,

                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 20.0, right: 20.0, bottom: 15),
                        child: Column(
                          children: [
                            // const SizedBox(height: 10.0),

                            FadeAnimation(
                              0.1,
                              child: Icon(
                                Icons.linear_scale_sharp,
                                size: 30.0,
                                color: AppCubit.get(context).isDark
                                    ? Colors.black54
                                    : Colors.white70,
                              ),
                            ),

                            const SizedBox(height: 10.0),

                            FadeAnimation(
                              0.3,
                              child: Stack(
                                children: [
                                  CircleAvatar(
                                    // backgroundImage: FileImage(

                                    //     AuthCubit.get(context)

                                    //         .file! as File),

                                    radius: 42,

                                    child: Container(
                                      height: 80.0,
                                      width: 80.0,
                                      decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius:
                                              BorderRadius.circular(100.0),
                                          image: DecorationImage(
                                            image: cubit.file != null
                                                ? FileImage(cubit.imageFile!)
                                                : cubit.userModel.pic!.isEmpty
                                                    ? const AssetImage(
                                                        'assets/images/facebook.png',
                                                      )
                                                    : cubit.userModel.pic ==
                                                            'default'
                                                        ? const AssetImage(
                                                            'assets/images/pic_profile.png')
                                                        : NetworkImage(
                                                            cubit
                                                                .userModel.pic!,
                                                          ) as ImageProvider,
                                            fit: BoxFit.fill,
                                          )),
                                    ),
                                  ),
                                  Positioned(
                                    right: -10,
                                    bottom: -10,
                                    child: UploadImageDialog(
                                      pageContext: context,
                                      cubit: cubit,
                                    ),
                                  )
                                ],
                              ),
                            ),

                            const SizedBox(
                              height: 20.0,
                            ),

                            FadeAnimation(
                              0.5,
                              child: CustomeFormField(
                                  controller: cubit.updateNameController,
                                  hintText: cubit.userModel.name!,
                                  type: TextInputType.name,
                                  onTap: (value) {},
                                  onChanged: (value) {},
                                  validator: (value) {
                                    return '';
                                  },
                                  text: 'Name'.tr),
                            ),

                            FadeAnimation(
                              0.7,
                              child: CustomeFormField(
                                  controller: cubit.updateEmailController,
                                  hintText: cubit.userModel.email!,
                                  type: TextInputType.emailAddress,
                                  onTap: (value) {},
                                  onChanged: (value) {},
                                  validator: (value) {
                                    return '';
                                  },
                                  text: 'Email'.tr),
                            ),

                            FadeAnimation(
                              0.9,
                              child: CustomeButton(
                                  isLoading:
                                      state is UpdateUserDataLoadingState,
                                  backgroudColor: state
                                          is UpdateUserDataLoadingState
                                      ? AppColors.mainAppColors.withOpacity(.4)
                                      : AppColors.mainAppColors,
                                  text: 'Update'.tr,
                                  onTap: () {
                                    cubit.updateUserData();
                                  }),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ));
    });
  }
}
