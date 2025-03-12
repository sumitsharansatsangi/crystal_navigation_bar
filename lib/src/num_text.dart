import 'package:flutter/widgets.dart';
import 'dart:math';

class NumText extends StatelessWidget {
  final int number;
  final TextStyle? style;

  const NumText({super.key, required this.number, this.style});

  String _formatNumber(int num) {
    if (num < 100) return num.toString(); // No conversion for numbers < 100
    final List<String> suffixes = ["", "K", "M", "B", "T"];
    int index = (log(num) / log(1000)).floor();
    double shortNumber = num / pow(1000, index);
    return "${shortNumber.toStringAsFixed(shortNumber >= 10 ? 0 : 1)}${suffixes[index]}+";
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _formatNumber(number),
      textAlign: TextAlign.center,
      style:
          style ?? const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
    );
  }
}
