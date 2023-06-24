import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField({
    this.hintText,
    this.onChanged,
    this.textFieldColor,
    this.suffixIcon,
    this.onSubmitted,
    this.controller,
  });

  Widget? suffixIcon;
  String? hintText;
  Function(String)? onChanged;
  Function(String)? onSubmitted;
  Color? textFieldColor;
  TextEditingController? controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextField(

      controller: controller,
      onSubmitted: onSubmitted,
      onChanged: onChanged,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        fillColor: textFieldColor,
        hintText: hintText,
        enabledBorder: OutlineInputBorder(
          borderSide:const BorderSide(
            color: Colors.grey,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
