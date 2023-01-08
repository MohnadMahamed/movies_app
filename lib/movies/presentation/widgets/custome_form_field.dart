import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/movies/presentation/controllers/app_controller/cubit/app_cubit.dart';
import 'package:movies_app/movies/presentation/widgets/cutome_text.dart';

class CustomeFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String text;
  final TextInputType type;
  final Widget? prefixWidget;
  final Widget? suffixIcon;
  final void Function(String) onTap;
  final void Function(String) onChanged;
  final String? Function(String?) validator;
  final Color textColor;
  final bool? isPassword;

  const CustomeFormField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.type,
    required this.onTap,
    required this.onChanged,
    required this.validator,
    this.textColor = Colors.white,
    this.prefixWidget,
    this.suffixIcon,
    this.isPassword = false,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: CustomeText(
              text: text,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 90,
            // width: Dimensions.width30 * 9,
            child: TextFormField(
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: AppCubit.get(context).isDark
                      ? Colors.black54
                      : Colors.white70),
              controller: controller,
              obscureText: isPassword!,
              keyboardType: type,
              onChanged: onChanged,
              validator: (T) => validator(T),
              // onSubmitted: onTap,
              decoration: InputDecoration(
                hintText: hintText,
                prefixIcon: prefixWidget,
                suffixIcon: suffixIcon,
                hintStyle: TextStyle(
                    color: AppCubit.get(context).isDark
                        ? Colors.black45
                        : Colors.white70,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
                filled: true,
                // fillColor: Colors.amber,
                fillColor: Colors.red.withOpacity(.6),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide:
                      const BorderSide(width: 0.0, color: Colors.transparent),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
