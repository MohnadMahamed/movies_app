import 'package:flutter/material.dart';
import 'package:movies_app/core/theme/app_colors.dart';
import 'package:movies_app/movies/presentation/widgets/custome_static_color_text.dart';

class CustomeButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final double? width;
  final double? height;
  final bool? isPadding;
  final bool isLoading;
  final Color? backgroudColor;

  const CustomeButton(
      {super.key,
      required this.text,
      required this.onTap,
      this.width = 0,
      this.height = 0,
      this.isPadding = true,
      this.isLoading = false,
      this.backgroudColor});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        // margin: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: backgroudColor ?? AppColors.mainAppColors,
          borderRadius: BorderRadius.circular(50.0),
        ),
        width: width == 0 ? double.infinity : width,
        height: height == 0 ? 60 : height,
        child: Center(
          child: isLoading
              ? const CircularProgressIndicator()
              : CustomeStaticColorText(
                  text: text,
                  size: 20,
                  color: Colors.white,
                ),
        ),
      ),
    );
  }
}
