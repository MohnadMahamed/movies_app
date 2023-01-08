import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies_app/core/theme/app_colors.dart';
import 'package:movies_app/movies/presentation/controllers/app_controller/app_language.dart';
import 'package:rolling_switch/rolling_switch.dart';

class LanguageWidget extends StatelessWidget {
  const LanguageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppLanguageController>(
      builder: (controller) => RollingSwitch.icon(
        onChanged: (b) {
          controller.changeLanguage();
        },
        rollingInfoRight: RollingIconInfo(
          icon: Icons.language,
          iconColor: AppColors.mainAppColors,
          backgroundColor: Colors.grey,
          text: Text(
            controller.appLanguage == 'en' ? 'English' : 'العربية',
            style: GoogleFonts.cairo(
              color: Colors.black87,
              fontSize: 12,
            ),
          ),
        ),
        rollingInfoLeft: RollingIconInfo(
          icon: Icons.language,
          iconColor: AppColors.mainAppColors,
          backgroundColor: AppColors.mainAppColors,
          text: Text(
            controller.appLanguage == 'en' ? 'English' : 'العربية',
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
