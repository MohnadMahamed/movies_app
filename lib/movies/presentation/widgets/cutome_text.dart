import 'package:flutter/material.dart';

class CustomeText extends StatelessWidget {
  final String text;
  final double? size;
  final double height;
  final int maxLines;
  const CustomeText(
      {Key? key,
      required this.text,
      this.size = 0,
      this.height = 1.1,
      this.maxLines = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text,
        maxLines: maxLines == 0 ? 2 : maxLines,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.bodyText1!.copyWith(
              height: height,
              fontWeight: FontWeight.bold,
              fontSize: size == 0 ? 18 : size,
            ));
  }
}
