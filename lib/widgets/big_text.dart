import 'package:flutter/widgets.dart';

class BigText extends StatelessWidget {
  final Color? color;
  final String text;
  final double size;
  final TextOverflow overflow;
  const BigText({
    Key? key,
    this.color = const Color.fromARGB(255, 87, 87, 87),
    required this.text,
    this.size = 0,
    this.overflow = TextOverflow.ellipsis
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      overflow: overflow,
      style: TextStyle(
        fontFamily: 'Roboto',
        color: color,
        fontSize: size==0?18:size,
        fontWeight: FontWeight.w800
      ),
    );
  }
}