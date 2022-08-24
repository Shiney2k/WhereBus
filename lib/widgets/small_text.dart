import 'package:flutter/widgets.dart';

class SmallText extends StatelessWidget {
  final Color? color;
  final String text;
  final double size;
  final double height;
  const SmallText(
      {Key? key,
      this.color = const Color.fromARGB(255, 188, 188, 188),
      required this.text,
      this.size = 0,
      this.height=1.2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          fontFamily: 'Roboto',
          color: color,
          fontSize: size==0?16:size,
          height: height,
          fontWeight: FontWeight.w600)
    );
  }
}
