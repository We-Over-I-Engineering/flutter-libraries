import 'package:flutter/material.dart';
import 'package:weoveri_button/main.dart';

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
          title: const Text('Capsule Buttons'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            WoiCapsuleButton(
              text: 'button'.toUpperCase(),
              onTap: () {},
              width: 200,
            ),
            WoiCapsuleIconButton(
              text: 'Icon button'.toUpperCase(),
              onTap: () {},
              icon: const Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: Icon(
                  Icons.add_link,
                  color: Colors.white,
                ),
              ),
              iconLocation: IconLocation.start,
              width: 200,
            ),
            WoiCapsuleLoadingButton(
              onTap: () {},
              circularProgressIndicator: const CircularProgressIndicator(),
              circularProgressSize: 20,
              width: 200,
            ),
            WoiCapsuleGradientButton(
              onTap: () {},
              width: 200,
              text: 'Gradient Button',
              gradient: const LinearGradient(
                colors: [
                  Colors.red,
                  Colors.green,
                  Colors.blue,
                ],
              ),
            ),
            WoiBaseButton(
              onTap: () {},
              width: 200,
              text: 'Base Button'.toUpperCase(),
              borderRadius: 0,
              icon: const Padding(
                padding: EdgeInsets.only(
                  right: 8,
                ),
                child: Icon(
                  Icons.person,
                  color: Colors.white,
                ),
              ),
            ),
            const Row(),
          ],
        ),
      ),
    );
  }
}
