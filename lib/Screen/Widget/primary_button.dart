import 'package:exercise_app/Screen/Widget/text_widget.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {


  final double windowWidth;
  final String buttonTitle;
  final Color color;
  final Function onPressed;
  const PrimaryButton({
    Key? key, //Get windowHeight from DeviceManager
    required this.windowWidth, //Get windowWidth from DeviceManager
    required this.buttonTitle, //Button title
    required this.onPressed,
    required this.color, //Button onPressed
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPressed(); //Call onPressed function
      },
      child: Container(
        height: 50,
        width: windowWidth,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: color,
        ),
        child: Center(
          child: boldtext(buttonTitle,textColor: Colors.white),
        ),
      ),
    );
  }
}
