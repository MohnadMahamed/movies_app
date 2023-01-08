import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:movies_app/movies/presentation/widgets/cutome_text.dart';

class EmptyList extends StatelessWidget {
  final String text;
  const EmptyList({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 110.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/no-result.svg',
                  width: 200.0,
                  height: 200.0,
                ),
                const SizedBox(
                  height: 30.0,
                ),
                CustomeText(
                  text: text.tr,
                  size: 25.0,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
