import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:movies_app/core/animation/fade_animation.dart';
import 'package:movies_app/core/network/api_constances.dart';
import 'package:movies_app/core/theme/app_colors.dart';
import 'package:movies_app/movies/presentation/controllers/app_controller/cubit/app_cubit.dart';
import 'package:movies_app/movies/presentation/controllers/auth_controller/cubit/auth_cubit.dart';
import 'package:movies_app/movies/presentation/screens/drawer/favourite/empty_list.dart';
import 'package:movies_app/movies/presentation/screens/movie_detail/movie_detail_screen.dart';
import 'package:movies_app/movies/presentation/widgets/custome_button.dart';
import 'package:movies_app/movies/presentation/widgets/custome_static_color_text.dart';
import 'package:movies_app/movies/presentation/widgets/cutome_text.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  deleteAlert({context, model}) {
    final AlertDialog alart = AlertDialog(
        scrollable: true,
        title: CustomeText(
          text: 'You wanaa delete?'.tr,
        ),
        content: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(300.0)),
          child: BlocProvider(
            create: (context) => AuthCubit()..onInit(),
            child: BlocBuilder<AuthCubit, AuthState>(
              builder: (context, state) => Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.red),
                      child: InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                            AuthCubit.get(context).removeFromFavourite(
                                model.id, model.title, model.backdropPath);
                          },
                          // AuthCubit.get(context)
                          //     .removeFromFavourite(
                          //         AuthCubit.get(
                          //                 context)
                          //             .userModel
                          //             .fav[index]
                          //             .id,
                          //         AuthCubit.get(
                          //                 context)
                          //             .userModel
                          //             .fav[index]
                          //             .title,
                          //         AuthCubit.get(
                          //                 context)
                          //             .userModel
                          //             .fav[index]
                          //             .backdropPath);,
                          // () {
                          //   Navigator.pop(context);
                          //   // controller.deleteProductById(model.productId!, model);
                          //   // showToast(
                          //   //     text: 'Task deleted successfully',
                          //   //     state: ToastStates.error);
                          // },
                          child: Center(
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 4.0,
                                ),
                                const Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
                                const SizedBox(
                                  height: 2.0,
                                ),
                                CustomeText(
                                  text: 'Delete'.tr,
                                ),
                                const SizedBox(
                                  height: 4.0,
                                ),
                              ],
                            ),
                          )),
                    ),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.blue),
                      child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Center(
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 5.0,
                                ),
                                const Icon(
                                  Icons.cancel,
                                  color: Colors.white,
                                ),
                                const SizedBox(
                                  height: 2.0,
                                ),
                                Text('Cancel'.tr,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 15.0,
                                    )),
                                const SizedBox(
                                  height: 5.0,
                                ),
                              ],
                            ),
                          )),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (ctx) {
          return alart;
        });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit()..onInit(),
      child: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          var cubit = AuthCubit.get(context);
          return SafeArea(
            child: Scaffold(
              backgroundColor: AppCubit.get(context).isDark
                  ? AppColors.lighBackGroundColor
                  : AppColors.darkBackGroundColor,
              body: Column(
                children: [
                  const SizedBox(
                    height: 0.0,
                  ),
                  BlocProvider(
                      create: (context) => AuthCubit()..onInit(),
                      child: BlocBuilder<AuthCubit, AuthState>(
                          builder: (context, state) {
                        // var cubit = AuthCubit.get(context);

                        return AuthCubit.get(context).user == null
                            ? const SizedBox()
                            : Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 10.0,
                                    ),
                                    FadeAnimation(
                                      .1,
                                      child: Row(
                                        children: [
                                          IconButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              icon: Icon(
                                                Icons.arrow_back_ios,
                                                size: 30.0,
                                                color:
                                                    AppCubit.get(context).isDark
                                                        ? Colors.black54
                                                        : Colors.white70,
                                              )),
                                          Expanded(
                                            child: Center(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 3.0),
                                                child: CustomeText(
                                                  text: 'Favourites Movies'.tr,
                                                  size: 25.0,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 30.0,
                                    ),
                                    (cubit.userModel.fav.length == 0)
                                        ? const EmptyList(
                                            text: 'No Favourites Movies',
                                          )
                                        : Column(
                                            children: [
                                              SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    .7,
                                                child: SingleChildScrollView(
                                                  physics:
                                                      const BouncingScrollPhysics(),
                                                  child: ListView.separated(
                                                      shrinkWrap: true,
                                                      physics:
                                                          const NeverScrollableScrollPhysics(),
                                                      itemBuilder:
                                                          (context, index) {
                                                        return FadeAnimation(
                                                          0.3 * index,
                                                          child: Dismissible(
                                                              key: ValueKey(cubit
                                                                      .userModel
                                                                      .fav[
                                                                  index]['id']),
                                                              confirmDismiss:
                                                                  (direction) async {
                                                                final AlertDialog
                                                                    alart =
                                                                    AlertDialog(
                                                                  backgroundColor: AppCubit.get(
                                                                              context)
                                                                          .isDark
                                                                      ? AppColors
                                                                          .lighBackGroundColor
                                                                      : AppColors
                                                                          .darkBackGroundColor,
                                                                  scrollable:
                                                                      true,
                                                                  title:
                                                                      CustomeText(
                                                                    text:
                                                                        'You wanaa delete?'
                                                                            .tr,
                                                                  ),
                                                                  content:
                                                                      Container(
                                                                    decoration: BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(300.0)),
                                                                    child: Row(
                                                                      children: [
                                                                        Expanded(
                                                                          child:
                                                                              Container(
                                                                            decoration:
                                                                                BoxDecoration(borderRadius: BorderRadius.circular(10.0), color: Colors.red),
                                                                            child: InkWell(
                                                                                onTap: () {
                                                                                  Navigator.of(context).pop();
                                                                                  cubit.removeFromFavourite(cubit.userModel.fav[index]['id'], cubit.userModel.fav[index]['title'], cubit.userModel.fav[index]['posterPath']);
                                                                                },
                                                                                child: Center(
                                                                                  child: Column(
                                                                                    children: [
                                                                                      const SizedBox(
                                                                                        height: 4.0,
                                                                                      ),
                                                                                      const Icon(
                                                                                        Icons.delete,
                                                                                        color: Colors.white,
                                                                                      ),
                                                                                      const SizedBox(
                                                                                        height: 2.0,
                                                                                      ),
                                                                                      CustomeStaticColorText(
                                                                                        color: Colors.white,
                                                                                        text: 'Delete'.tr,
                                                                                      ),
                                                                                      const SizedBox(
                                                                                        height: 4.0,
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                )),
                                                                          ),
                                                                        ),
                                                                        const SizedBox(
                                                                          width:
                                                                              10.0,
                                                                        ),
                                                                        Expanded(
                                                                          child:
                                                                              Container(
                                                                            decoration:
                                                                                BoxDecoration(borderRadius: BorderRadius.circular(10.0), color: Colors.blue),
                                                                            child: InkWell(
                                                                                onTap: () {
                                                                                  Navigator.pop(context);
                                                                                },
                                                                                child: Center(
                                                                                  child: Column(
                                                                                    children: [
                                                                                      const SizedBox(
                                                                                        height: 5.0,
                                                                                      ),
                                                                                      const Icon(
                                                                                        Icons.cancel,
                                                                                        color: Colors.white,
                                                                                      ),
                                                                                      const SizedBox(
                                                                                        height: 2.0,
                                                                                      ),
                                                                                      CustomeStaticColorText(
                                                                                        color: Colors.white,
                                                                                        text: 'Cancel'.tr,
                                                                                      ),
                                                                                      const SizedBox(
                                                                                        height: 5.0,
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                )),
                                                                          ),
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ),
                                                                );
                                                                return await showDialog(
                                                                    context:
                                                                        context,
                                                                    barrierDismissible:
                                                                        true,
                                                                    builder:
                                                                        (ctx) {
                                                                      return alart;
                                                                    });
                                                              },
                                                              background:
                                                                  Container(
                                                                decoration: BoxDecoration(
                                                                    color: AppColors
                                                                        .mainAppColors
                                                                        .withOpacity(
                                                                            .8),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            30)),
                                                                child: Row(
                                                                    children: [
                                                                      const SizedBox(
                                                                        width:
                                                                            10.0,
                                                                      ),
                                                                      CustomeStaticColorText(
                                                                        color: Colors
                                                                            .white,
                                                                        text: 'Delete'
                                                                            .tr,
                                                                      ),
                                                                      const SizedBox(
                                                                        width:
                                                                            5,
                                                                      ),
                                                                      const Icon(
                                                                        Icons
                                                                            .delete_rounded,
                                                                        size:
                                                                            25.0,
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                      const Spacer(),
                                                                      CustomeStaticColorText(
                                                                        color: Colors
                                                                            .white,
                                                                        text: 'Delete'
                                                                            .tr,
                                                                      ),
                                                                      const SizedBox(
                                                                        width:
                                                                            5,
                                                                      ),
                                                                      const Icon(
                                                                        Icons
                                                                            .delete_rounded,
                                                                        size:
                                                                            25.0,
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                      const SizedBox(
                                                                        width:
                                                                            10.0,
                                                                      ),
                                                                    ]),
                                                              ),
                                                              child: SizedBox(
                                                                child: InkWell(
                                                                  onTap: () {
                                                                    Navigator.push(
                                                                        context,
                                                                        MaterialPageRoute(
                                                                            builder: (context) =>
                                                                                MovieDetailScreen(fromFavScreen: true, id: cubit.userModel.fav[index]['id'])));
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    // height: 100,
                                                                    // width: 100,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: AppColors
                                                                          .mainAppColors
                                                                          .withOpacity(
                                                                              .3),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              30),
                                                                    ),
                                                                    child: Row(
                                                                      children: [
                                                                        Padding(
                                                                          padding:
                                                                              const EdgeInsets.all(8.0),
                                                                          child:
                                                                              Container(
                                                                            height:
                                                                                90.0,
                                                                            width:
                                                                                90.0,
                                                                            // padding: const EdgeInsets.all(5),
                                                                            clipBehavior:
                                                                                Clip.antiAlias,
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              borderRadius: BorderRadius.circular(50),
                                                                            ),
                                                                            child:
                                                                                CachedNetworkImage(
                                                                              imageUrl: ApiConstance.imageUrl(cubit.userModel.fav[index]['posterPath']),
                                                                              fit: BoxFit.fill,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Expanded(
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.symmetric(horizontal: 8.0),
                                                                            child:
                                                                                CustomeText(maxLines: 3, text: cubit.userModel.fav[index]['title']),
                                                                          ),
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              )),
                                                        );
                                                      },
                                                      separatorBuilder:
                                                          (context, index) =>
                                                              const SizedBox(
                                                                height: 15,
                                                              ),
                                                      itemCount: cubit.userModel
                                                          .fav.length),
                                                ),
                                              ),
                                              FadeAnimation(
                                                0.1,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 10.0),
                                                  child: CustomeButton(
                                                      text:
                                                          'Delete All Favourite'
                                                              .tr,
                                                      onTap: () {
                                                        cubit
                                                            .removeFavouriteList();
                                                      }),
                                                ),
                                              )
                                            ],
                                          ),
                                  ],
                                ),
                              );
                      }))
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

List dymmy = [
  {
    'id': 14,
    'title': 'Avatr Movie',
    'back': '/xFPoCs4MM6UsysZyJ9eiwU9YnGS.jpg'
  },
  {'id': 14, 'title': '207 Movie', 'back': '/xFPoCs4MM6UsysZyJ9eiwU9YnGS.jpg'},
  {
    'id': 14,
    'title': 'Batman Movie',
    'back': '/xFPoCs4MM6UsysZyJ9eiwU9YnGS.jpg'
  },
  {
    'id': 14,
    'title': 'Spider Movie',
    'back': '/xFPoCs4MM6UsysZyJ9eiwU9YnGS.jpg'
  }
];
