import 'package:flutter/material.dart';
import 'package:weoveri_flutter_widgets/woi_widgets.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with TickerProviderStateMixin {
  bool switchValue = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Widgets'.toUpperCase(),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body:
            //----------Icon Button-------------
            Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //----------Capsule Button-------------
            SizedBox(
              width: 250,
              child: WOITextButton(
                text: 'Submit'.toUpperCase(),
                buttonStyle: WOIButtonStyle(
                  sideWidget: const CircularProgressIndicator(),
                  sideWidgetSize: 20,
                  textMargin: const EdgeInsets.only(
                    left: 8,
                  ),
                ),
                textStyle: const TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
            ),
            //----------Parallalogram Button-------------
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                WOIParallalogramButton(
                  text: "Parallalogram Button".toUpperCase(),
                  tiltSide: TiltSide.right,
                  buttonColor: Colors.black,
                  onPressed: () {},
                  gradient: const LinearGradient(
                    colors: [
                      Colors.black,
                      Colors.blue,
                      Colors.green,
                    ],
                  ),
                ),
              ],
            ),

            //----------Icon Button-------------
            WOIIconButton(
              size: 45,
              borderRadius: BorderRadius.circular(100),
              backgroundColor: Colors.black,
              border: Border.all(
                color: Colors.red,
                width: 3,
              ),
              child: const Icon(
                Icons.percent,
                color: Colors.white,
              ),
              onTap: () {},
            ),

            //----------Switch Button-------------//
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                WOISwitchButton(
                  value: switchValue,
                  onChanged: (bool isSelected) {
                    switchValue = isSelected;
                    setState(() {});
                  },
                ),
              ],
            ),

            //----------Radio Buttons-------------//
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                WOIRadioButton(
                  isSelected: switchValue,
                  onTap: (bool isSelected) {
                    switchValue = isSelected;
                    setState(() {});
                  },
                  border: Border.all(
                    color: Colors.green,
                    width: 2,
                  ),
                  selectedBorder: Border.all(
                    color: Colors.black,
                  ),
                  selectedFillColor: Colors.black,
                  size: 30,
                  innerPadding: const EdgeInsets.all(3),
                  duration: const Duration(
                    milliseconds: 1,
                  ),
                ),
              ],
            ),

            //----------Radio Buttons-------------//
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                WOICheckBox(
                  isChecked: switchValue,
                  onTap: (bool isSelected) {
                    switchValue = isSelected;
                    setState(() {});
                  },
                ),
              ],
            ),

            //----------Text Field-------------//
            WOITextField(),
          ],
        ),
      ),
    );
  }
}
