import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  CustomTextFormField(
      {this.hintText,
      this.labelText,
      this.onChanged,
      this.emailValidation,
      this.passwordValidation,
      this.textFieldColor,
      this.suffixIcon,
      this.onFieldSubmitted,
      this.obscureText=false,this.suffixOnPressed});
  Function()? suffixOnPressed;
  IconData? suffixIcon=Icons.add ;
  Widget? suffixIconn ;
  String? hintText;
  String? labelText;
  bool? obscureText;
  Function? emailValidation;
  Function? passwordValidation;
  Function(String)? onChanged;
  Function(String)? onFieldSubmitted;
  Color? textFieldColor;
  TextEditingController controller = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void initState() {
    obscureText = true;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText!,
      controller: controller,
      onFieldSubmitted: onFieldSubmitted,
      validator: (data) {
        if (data!.isEmpty) {
          return 'field is required';
        }
      },
      onChanged: onChanged,
      decoration: InputDecoration(
        suffixIcon: suffixIconn,

        fillColor: textFieldColor,
        hintText: hintText,
        labelText: labelText,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
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