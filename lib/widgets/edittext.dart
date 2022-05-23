import 'package:flutter/material.dart';
import 'package:juicy_spot/utils/custom_colors.dart';

// ignore: must_be_immutable
class EditText extends StatelessWidget {
  String? placeholder, helperText;
  Widget? suffixIcon;
  Widget? prefixIcon;
  EdgeInsets? contentPadding;
  int? maxLines, maxLength, minLines;
  bool? readOnly, obsecureText;
  TextEditingController? controller;
  Color? borderColor, textColor;
  Function? onChanged, onSubmitted, onTab;
  TextInputAction? textInputAction;
  TextInputType? keyboardType;
  double? width, height, fontSize;
  TextAlign? textAlign;
  bool isMaxNull;

  EditText({
    Key? key,
    required this.placeholder,
    required this.controller,
    this.helperText,
    this.suffixIcon,
    this.prefixIcon,
    this.contentPadding,
    this.maxLines,
    this.minLines,
    this.maxLength,
    this.fontSize,
    this.readOnly,
    this.obsecureText = false,
    this.borderColor,
    this.textColor,
    this.onChanged,
    this.onSubmitted,
    this.onTab,
    this.textInputAction,
    this.keyboardType,
    this.textAlign,
    this.width,
    this.height,
    this.isMaxNull = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: TextStyle(color: textColor ?? editTextColor, fontSize: fontSize),
      keyboardType: keyboardType,
      maxLines: isMaxNull ? null : maxLines ?? 1,
      minLines: minLines,
      maxLength: maxLength,
      readOnly: readOnly ?? false,
      obscureText: obsecureText ?? false,
      cursorColor: textColor ?? editTextColor,
      decoration: InputDecoration(
        counterText: "",
        counter: null,
        contentPadding: contentPadding,
        border: UnderlineInputBorder(
            borderSide: BorderSide(
          color: borderColor ?? editTextColor,
        )),
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: borderColor ?? editTextColor)),
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: borderColor ?? editTextColor)),
        labelText: placeholder ?? 'Enter Here',
        labelStyle: const TextStyle(color: editTextColor),
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
      ),
    );
  }
}
