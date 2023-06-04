import 'package:flutter/material.dart';
import 'package:take_drug/Common/config/config.dart';

class customTextFieldRegsiterPage extends StatelessWidget {
  final TextEditingController? textEditingController;
  bool? isSecure = true;
  final TextInputType? textInputType;
  bool? enabledEdit = true;
  final String? hint;
  final Widget? prefixIcon;
  final Widget? suffixIcon;

  customTextFieldRegsiterPage({
    super.key,
    this.enabledEdit,
    this.isSecure,
    this.textEditingController,
    this.textInputType,
    this.hint,
    this.prefixIcon,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(9),
        color: takeDrug.whiteOne,
      ),
      child: TextField(
        controller: textEditingController,
        obscureText: isSecure!,
        cursorColor: takeDrug.SecondaryColor,
        keyboardType: textInputType,
        enabled: enabledEdit,
        decoration: InputDecoration(
          filled: true,
          isCollapsed: false,
          isDense: true,
          suffixStyle: TextStyle(color: takeDrug.SecondaryColor),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(30),
          ),
          hintText: hint,
          hintStyle: const TextStyle(fontSize: 12),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(30),
          ),
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }
}
