import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:persistance/data/shared_prefs.dart';
import 'package:persistance/model/fontSize.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  int settingColor = 0xff1976d2;
  double fontSize = 16;
  List<int> colors = [
    0xFF455A64,
    0xFFFFC107,
    0xFF673AB7,
    0xFFF57C00,
    0xFF795548
  ];
  SpSettings settings = SpSettings();

  List<FontSize> fontSizes = [
    FontSize("small", 12),
    FontSize("medium", 16),
    FontSize("large", 20),
    FontSize("extra-large", 23),
  ];
  @override
  void initState() {
    // TODO: implement initState
    settings.init().then((value) {
      setState(() {
        settingColor = settings.getColor();
        fontSize = settings.getFontSize();
      });
    });
    // super.iniState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void setColor(int color) {
      setState(() {
        settingColor = color;
        settings.setColor(color);
      });
    }

    var items = [
      'Item 1',
      'Item 2',
      'Item 3',
      'Item 4',
      'Item 5',
    ];

    List<DropdownMenuItem<String>> getDropdownMenuItems() {
      List<DropdownMenuItem<String>> item = [];
      for (FontSize font in fontSizes) {
        item.add(DropdownMenuItem(
            value: font.size.toString(), child: Text(font.name)));
      }
      print(item);
      return item;
    }

    void onchangeSize(String? newSize) {
      settings.setFontSize(double.parse(newSize ?? '14'));
      setState(() {
        fontSize = double.parse(newSize ?? "14");
      });
    }

    return Scaffold(
      appBar:
          AppBar(backgroundColor: Color(settingColor), title: Text("Settings")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            "choose font size for the app",
            style: TextStyle(fontSize: fontSize),
          ),
          // DropdownButton(
          //   // Initial Value
          //   value: fontSize.toString(),

          //   // Array list of items
          //   items: getDropdownMenuItems(),
          //   // After selecting the desired option,it will
          //   // change button value to selected value
          //   onChanged: onchangeSize,
          // ),
          Text("App Main Color"),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () => setColor(colors[0]),
                child: ColorSquare(colors[0]),
              ),
              GestureDetector(
                onTap: () => setColor(colors[1]),
                child: ColorSquare(colors[1]),
              ),
              GestureDetector(
                onTap: () => setColor(colors[2]),
                child: ColorSquare(colors[2]),
              ),
              GestureDetector(
                onTap: () => setColor(colors[3]),
                child: ColorSquare(colors[3]),
              ),
            ],
          )
        ],
      ),
    );
  }

//saves users selecting by setting it
  void setColor(int color) {
    setState(() {
      settingColor = color;
    });
  }
}

class ColorSquare extends StatelessWidget {
  final int? colorCode;
  // ColorSquare(this.colorCode);
  ColorSquare(this.colorCode, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 72,
      height: 72,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          color: Color(colorCode!)),
    );
  }
}
