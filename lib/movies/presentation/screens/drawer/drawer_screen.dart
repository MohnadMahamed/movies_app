import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:movies_app/core/theme/app_colors.dart';
import 'package:movies_app/movies/presentation/screens/components/language_widget.dart';
import 'package:movies_app/movies/presentation/screens/components/mode_widget.dart';
import 'package:movies_app/movies/presentation/screens/drawer/favourite/favourite_screen.dart';
import 'package:movies_app/movies/presentation/controllers/app_controller/cubit/app_cubit.dart';
import 'package:movies_app/movies/presentation/controllers/auth_controller/cubit/auth_cubit.dart';
import 'package:movies_app/movies/presentation/screens/auth/login_screen.dart';
import 'package:movies_app/movies/presentation/screens/drawer/profile/profile_screen.dart';
import 'package:movies_app/movies/presentation/widgets/custome_static_color_text.dart';
import 'package:movies_app/movies/presentation/widgets/cutome_text.dart';
import 'package:url_launcher/url_launcher.dart';

class DrawerScreen extends StatelessWidget {
  const DrawerScreen({Key? key}) : super(key: key);
  Widget buildDrawerListItem(
      {required IconData leadingIcon,
      required String title,
      Widget? trailing,
      Function()? onTap,
      Color? color}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: ListTile(
          leading: Icon(
            leadingIcon,
            color: color ?? AppColors.mainAppColors,
          ),
          title: CustomeText(text: title),
          trailing: trailing ??
              Icon(
                Icons.arrow_right,
                color: AppColors.mainAppColors,
              ),
          onTap: onTap),
    );
  }

  Widget buildDrawerListItemDivider() {
    return const Divider(
      height: 0,
      thickness: 1,
      indent: 18,
      endIndent: 24,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit()..onInit(),
      child: BlocBuilder<AuthCubit, AuthState>(builder: (context, state) {
        var cubit = AuthCubit.get(context);
        return BlocBuilder<AppCubit, AppState>(
          builder: (context, state) => SafeArea(
            child: Scaffold(
              // key: _scaffoldKey,
              backgroundColor: AppCubit.get(context).isDark
                  ? AppColors.lighBackGroundColor
                  : AppColors.darkBackGroundColor,
              body: Padding(
                padding: const EdgeInsets.only(
                    top: 30.0, bottom: 30.0, left: 10.0, right: 10.0),
                child: BlocBuilder<AuthCubit, AuthState>(
                  builder: (context, state) => Column(
                    children: [
                      cubit.user == null
                          ? Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    right: 10.0, left: 10.0),
                                child: Container(
                                  // padding: const EdgeInsets.symmetric(
                                  //   vertical: 70.0,
                                  // ),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50.0),
                                      color: Colors.red.withOpacity(.8)),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Center(
                                          child: CustomeStaticColorText(
                                        text: 'Welcome'.tr,
                                        size: 30.0,
                                        color: Colors.white70,
                                      )),
                                      const SizedBox(
                                        height: 30.0,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      LoginScreen()));
                                        },
                                        child: CustomeStaticColorText(
                                          text: 'Sing In Now'.tr,
                                          size: 20.0,
                                          color: Colors.white70,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          : Expanded(
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 2.0),
                                      child: Container(
                                        padding: const EdgeInsets.only(
                                            top: 30.0, bottom: 20),
                                        decoration: BoxDecoration(
                                            color: AppColors.mainAppColors
                                                .withOpacity(.3),
                                            borderRadius:
                                                BorderRadius.circular(50.0)),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            CircleAvatar(
                                              radius: 42.0,
                                              child: Container(
                                                height: 80.0,
                                                width: 80.0,
                                                decoration: BoxDecoration(
                                                    color: Colors.red,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100.0),
                                                    image: DecorationImage(
                                                      image: cubit.userModel
                                                              .pic!.isEmpty
                                                          ? const AssetImage(
                                                              'assets/images/facebook.png',
                                                            )
                                                          : cubit.userModel
                                                                      .pic ==
                                                                  'default'
                                                              ? const AssetImage(
                                                                  'assets/images/pic_profile.png')
                                                              : NetworkImage(
                                                                  cubit
                                                                      .userModel
                                                                      .pic!,
                                                                ) as ImageProvider,
                                                      fit: BoxFit.fill,
                                                    )),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 20.0,
                                            ),
                                            Center(
                                              child: SizedBox(
                                                width: 200,
                                                child: CustomeText(
                                                  text: cubit.userModel.name!,
                                                  size: 20.0,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 2.0,
                                            ),
                                            Center(
                                              child: SizedBox(
                                                width: 200,
                                                child: CustomeText(
                                                  text: cubit.userModel.email!,
                                                  size: 18.0,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10.0,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                buildDrawerListItem(
                                                  leadingIcon: Icons.person,
                                                  title: 'My Profile'.tr,
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                MyProfileScreen()));
                                                  },
                                                ),
                                                buildDrawerListItemDivider(),
                                                buildDrawerListItem(
                                                    leadingIcon: Icons.favorite,
                                                    title: 'My Fav Movies'.tr,
                                                    onTap: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  const FavouriteScreen()));
                                                    }),
                                                buildDrawerListItemDivider(),
                                                // buildDrawerListItem(
                                                //     leadingIcon: Icons.settings,
                                                //     title: 'Settings'),
                                                // buildDrawerListItemDivider(),
                                                InkWell(
                                                  child: buildDrawerListItem(
                                                      leadingIcon: Icons.help,
                                                      title: 'Help'.tr,
                                                      onTap: () async {
                                                        await launchUrl(
                                                          Uri(
                                                            scheme: 'mailto',
                                                            path:
                                                                'mohnadmahamed7777@gmail.com',
                                                          ),
                                                        );
                                                      }),
                                                ),
                                                buildDrawerListItemDivider(),
                                                buildDrawerListItem(
                                                  leadingIcon: Icons.logout,
                                                  title: 'Logout'.tr,
                                                  onTap: () async {
                                                    await cubit.signOut();
                                                    // Navigator.of(context).pushReplacementNamed(loginScreen);
                                                  },
                                                  color: Colors.red,
                                                  trailing: const SizedBox(),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      const LanguageWidget(),
                      const SizedBox(
                        height: 30.0,
                      ),
                      const ModeWidget()
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
