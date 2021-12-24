import 'dart:core';
import 'package:shared_preferences/shared_preferences.dart';
import "dart:async";

class SpSettings {
  final String fontSizeKey = 'font_size';
  final String colorKey = 'color';
  static late SharedPreferences _sp;
  // creating a variable that reps an instance of the SP class...
  // to make the instances always persistences across all screen
  static SpSettings? _instance;

//here the internal checks if the
//instances is cachesd so it can easily fetch from the catch memory

  SpSettings._internal();
  //note: the fatory key word gives you
  // the choice of what to call that the construct will returns
  factory SpSettings() {
    _instance ??= SpSettings._internal();
    return _instance as SpSettings;
  }

  Future init() async {
    _sp = await SharedPreferences.getInstance();
  }

  Future setColor(int color) {
    return _sp.setInt(colorKey, color);
  }

  int getColor() {
    int? color = _sp.getInt(colorKey);
    color ??= 0xff1976d2;
    return color;
  }

  Future setFontSize(double size) {
    return _sp.setDouble(fontSizeKey, size);
  }

  double getFontSize() {
    double? fontSize = _sp.getDouble(fontSizeKey);
    fontSize ??= 14;
    return fontSize;
  }
}
