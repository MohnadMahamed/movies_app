import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:movies_app/core/theme/app_colors.dart';
import 'package:movies_app/movies/presentation/controllers/app_controller/cubit/app_cubit.dart';
import 'package:movies_app/movies/presentation/controllers/auth_controller/cubit/auth_cubit.dart';
import 'package:movies_app/movies/presentation/widgets/custome_static_color_text.dart';
import 'package:movies_app/movies/presentation/widgets/cutome_text.dart';

class UploadImageDialog extends StatelessWidget {
  final BuildContext pageContext;
  final AuthCubit cubit;

  const UploadImageDialog(
      {super.key, required this.pageContext, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) => IconButton(
          onPressed: () {
            final AlertDialog alart = AlertDialog(
              scrollable: true,
              backgroundColor: AppCubit.get(pageContext).isDark
                  ? AppColors.lighBackGroundColor
                  : AppColors.darkBackGroundColor,
              title: CustomeText(
                text: 'Upload Image from ?'.tr,
              ),
              content: Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(30.0)),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: AppColors.mainAppColors.withOpacity(.8)),
                        child: InkWell(
                            onTap: () async {
                              await cubit.pickGalleryImage().then((value) {
                                Navigator.pop(context);
                              });

                              //  controller.deleteProductById(model.productId!, model);
                              // showToast(
                              //     text: 'Task deleted successfully',
                              //     state: ToastStates.error);
                            },
                            child: Center(
                              child: CustomeStaticColorText(
                                text: 'Gallery'.tr,
                                color: Colors.white,
                              ),
                            )),
                      ),
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.blue),
                        child: InkWell(
                            onTap: () async {
                              await cubit.pickCameraImage().then((value) {
                                Navigator.pop(context);
                              });
                            },
                            child: Center(
                              child: CustomeStaticColorText(
                                color: Colors.white,
                                text: 'Camara'.tr,
                              ),
                            )),
                      ),
                    )
                  ],
                ),
              ),
            );
            showDialog(
                context: pageContext,
                barrierDismissible: true,
                builder: (ctx) {
                  return alart;
                });
          },
          icon: const CircleAvatar(
            radius: 22.0,
            child: Icon(
              Icons.camera_alt_outlined,
              size: 20.0,
            ),
          )),
    );
  }
}
