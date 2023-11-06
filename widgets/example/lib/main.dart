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
  int currentIndex = 0;
  int currentStepperIndex = 0;

  void updateCurrentIndex(int index) {
    currentIndex = index;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: updateCurrentIndex,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              label: 'BASIC',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home_max,
              ),
              label: 'COMPLEX',
            )
          ],
        ),
        appBar: AppBar(
          title: Text(
            'Widgets'.toUpperCase(),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: currentIndex == 1 ? complexWidgets() : simpleWidgets(),
      ),
    );
  }

  Widget simpleWidgets() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        //----------Capsule Button-------------
        SizedBox(
          width: 250,
          child: WOITextButton(
            text: 'Submit'.toUpperCase(),
            buttonStyle: WOIButtonStyle(
              prefixWidget: const SizedBox(
                child: Icon(
                  Icons.link,
                  color: Colors.white,
                  size: 20,
                ),
              ),
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

        //----------CheckBox-------------//
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
      ],
    );
  }

  Widget complexWidgets() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        //----------Text Field-------------//
        const Padding(
          padding: EdgeInsets.all(20),
          child: WOITextField(
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xff007EDA),
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(6),
              ),
            ),
            labelText: 'Email Address',
            helperText: 'Make sure it is valid',
            hintText: 'Placeholder Text',
            prefixIcon: Icon(
              Icons.email_outlined,
              color: Color(0xff007EDA),
            ),
            hintTextStyle: TextStyle(
              color: Color(0xffB6A8A8),
              fontSize: 18,
            ),
          ),
        ),
        //----------Steppers-------------//
        stepperWidget(),
        stepperButtons(),
      ],
    );
  }

  Widget stepperWidget() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: WOIHorizontalTextIconStepper(
        activeStateIndex: currentStepperIndex,
        textItemsList: [
          'Text 1',
          'Text 2',
        ],
      ),
      /* WOIHorizontalTextIconStepper.counterText(
        textItemsList: const [
          'User info',
          'Account info',
          'Review',
        ],
        subtextList: const [
          'Details here',
          'Details here',
          'Details here',
        ],
        subtextStyle: const TextStyle(
          fontSize: 11,
        ),
        textStyle: const TextStyle(
          fontSize: 13,
        ),
        counterTextStyle: const TextStyle(
          fontSize: 14,
        ),
        activeStateIndex: currentStepperIndex,
        inactiveColor: Colors.grey,
        activeColor: Colors.black,
        completedColor: Colors.black,
      ), */
      /* WOIHorizontalTextIconStepper.icons(
        activeStateIndex: currentStepperIndex,
        iconData: const [
          Icons.home,
          Icons.person,
          Icons.close,
        ],
      ), */
      /* WOIHorizontalTextIconStepper.icons(
        activeStateIndex: currentStepperIndex,
        backgroundDecorator: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.circular(12),
        ),
        iconData: const [
          Icons.home,
          Icons.person,
          Icons.close,
        ],
        inactiveSeparatorWidget: Container(
          height: 2,
          color: Colors.grey,
        ),
        activeSeparatorWidget: Container(
          height: 2,
          color: Colors.black,
        ),
        inactiveIconTheme: IconStepperItemStyle(
          iconThemeData: const IconThemeData(
            color: Colors.grey,
          ),
        ),
        activeIconTheme: IconStepperItemStyle(
          iconThemeData: const IconThemeData(
            color: Colors.black,
          ),
          boxDecoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.black,
            ),
          ),
        ),
        completedIconTheme: IconStepperItemStyle(
          iconThemeData: const IconThemeData(
            color: Colors.white,
          ),
          boxDecoration: const BoxDecoration(
            color: Colors.black,
            shape: BoxShape.circle,
          ),
        ),
        itemsPadding: const EdgeInsets.all(15),
      ), */
    );
  }

  Widget stepperButtons() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Expanded(
            child: WOITextButton(
              text: "Previous",
              heigth: 50,
              onTap: () {
                if (currentStepperIndex < 0) {
                  return;
                }
                currentStepperIndex--;
                setState(() {});
              },
            ),
          ),
          Container(
            width: 20,
          ),
          Expanded(
            child: WOITextButton(
              text: "Next",
              heigth: 50,
              onTap: () {
                if (currentStepperIndex >= 3) {
                  return;
                }
                setState(() {
                  currentStepperIndex++;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
