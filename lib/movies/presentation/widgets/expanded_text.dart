import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies_app/core/theme/app_colors.dart';
import 'package:movies_app/movies/presentation/widgets/custome_static_color_text.dart';
import 'package:movies_app/movies/presentation/widgets/cutome_text.dart';

class ExpandableTextWidget extends StatefulWidget {
  final String text;
  const ExpandableTextWidget({Key? key, required this.text}) : super(key: key);

  @override
  State<ExpandableTextWidget> createState() => _ExpandableTextWidgetState();
}

class _ExpandableTextWidgetState extends State<ExpandableTextWidget> {
  late String firstHalf;
  late String secondHalf;

  bool hiddenText = true;

  double textHeight = 120.0;

  @override
  void initState() {
    super.initState();
    if (widget.text.length > textHeight) {
      firstHalf = widget.text.substring(0, textHeight.toInt());
      secondHalf =
          widget.text.substring(textHeight.toInt() + 1, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: secondHalf.isEmpty
          ? CustomeText(
              text: firstHalf,
              maxLines: 3,
            )
          : Column(
              children: [
                CustomeText(
                    height: 1,
                    maxLines: 15,
                    text: hiddenText
                        ? ('$firstHalf...')
                        : (firstHalf + secondHalf)),
                InkWell(
                  onTap: () {
                    setState(() {
                      hiddenText = !hiddenText;
                    });
                  },
                  child: Row(
                    children: [
                      CustomeStaticColorText(
                        text: hiddenText ? 'Show more'.tr : 'Show less'.tr,
                        color: AppColors.mainAppColors,
                      ),
                      Icon(
                        hiddenText
                            ? Icons.arrow_drop_down
                            : Icons.arrow_drop_up,
                        size: 30,
                        color: AppColors.mainAppColors,
                      )
                    ],
                  ),
                )
              ],
            ),
    );
  }
}
