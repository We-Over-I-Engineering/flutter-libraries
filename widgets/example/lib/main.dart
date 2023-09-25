import 'package:flutter/material.dart';
import 'package:weoveri_flutter_widgets/woi_widgets.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Buttons'),
        ),
        body: Column(
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
            WOITextButton(
              onTap: () {},
              width: 300,
              text: 'Hello There!!!',
              buttonStyle: WOIButtonStyle(
                border: Border.all(
                  width: 4,
                  color: Colors.blue,
                ),
                backgroundColor: Colors.black,
              ),
              textStyle: const TextStyle(
                color: Colors.white,
              ),
              heigth: 50,
            ),
            WOITextButton(
              onTap: () {},
              text: 'Hello There!!!',
              textStyle: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              buttonStyle: WOIButtonStyle(
                gradient: const LinearGradient(
                  colors: [
                    Colors.black,
                    Colors.green,
                    Colors.blue,
                    Colors.orange,
                    Colors.black,
                  ],
                ),
              ),
              width: 300,
            ),
            WOITextButton(
              onTap: () {},
              text: 'Icon button'.toUpperCase(),
              buttonStyle: WOIButtonStyle(
                sideWidget: const Padding(
                  padding: EdgeInsets.only(
                    right: 8.0,
                  ),
                  child: Icon(
                    Icons.add_link,
                    color: Colors.white,
                  ),
                ),
                widgetLocation: WidgetLocation.start,
              ),
              width: 200,
            ),
            WOITextButton(
              onTap: () {},
              text: 'Icon button'.toUpperCase(),
              textStyle: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              buttonStyle: WOIButtonStyle(
                borderRadius: BorderRadius.zero,
                border: Border.all(
                  color: Colors.red,
                  width: 5,
                ),
                gradient: const LinearGradient(
                  colors: [
                    Colors.blue,
                    Colors.green,
                  ],
                ),
                backgroundColor: Colors.blue,
              ),
              width: 200,
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
          ],
        ),
      ),
    );
  }
}
