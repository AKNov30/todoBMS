// lib/utils/color_util.dart
import 'dart:math';
import 'dart:ui';

class ColorUtil {
  static final List<Color> colorList = [
    const Color(0xff0D7A5C),
    const Color(0xffFB9A2B),
    const Color(0xff355389),
    const Color(0xffF7A491),
    const Color(0xff3CB189),
    const Color.fromARGB(255, 160, 13, 62),
    const Color.fromARGB(255, 30, 11, 114),
  ];

  static Color getRandomColor() {
    final random = Random();
    return colorList[random.nextInt(colorList.length)];
  }
}
