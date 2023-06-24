import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  CustomIconButton({this.iconText, this.onTap});

  String? iconText;
  VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        width: double.infinity,
        child: Center(
          child: Text(
            iconText!,
            style:const TextStyle(color: Colors.black, fontSize: 18),
          ),
        ),
      ),
    );
  }
}
