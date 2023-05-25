import 'package:amazon_clone/constants/global_variables.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color? color;
  // final Color? color;
  const CustomButton({
    Key? key,
    required this.text,
    required this.onTap,
    this.color = GlobalVariables.secondaryColor,
    // this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 50),
        backgroundColor: color,
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color == GlobalVariables.secondaryColor ? Colors.white : Colors.black,  //color == null ? Colors.white :
        ),
      ),
    );
  }
}