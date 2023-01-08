import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies_app/core/theme/app_colors.dart';
import 'package:movies_app/movies/presentation/controllers/app_controller/cubit/app_cubit.dart';
import 'package:rolling_switch/rolling_switch.dart';

class ModeWidget extends StatelessWidget {
  const ModeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) => RollingSwitch.icon(
        onChanged: (b) {
          AppCubit.get(context).changeAppMode();
        },
        rollingInfoRight: RollingIconInfo(
          icon: Icons.light_mode,
          iconColor: AppColors.mainAppColors,
          backgroundColor: Colors.grey,
          text: Text(
            AppCubit.get(context).isDark ? 'Light'.tr : 'Dark'.tr,
            style: GoogleFonts.cairo(
              color: Colors.black87,
              fontSize: 12,
            ),
          ),
        ),
        rollingInfoLeft: RollingIconInfo(
          icon: Icons.dark_mode,
          iconColor: Colors.black,
          backgroundColor: Colors.black,
          text: Text(
            AppCubit.get(context).isDark ? 'Light'.tr : 'Dark'.tr,
            style: GoogleFonts.cairo(
              color: Colors.white70,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }
}
