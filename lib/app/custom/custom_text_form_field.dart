import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    super.key,
    this.hintText,
    this.labelText,
    this.keyboardType,
    this.obscureText,
    this.maxLine,
    this.suffixIcon,
    this.prefixIcon,
    this.controller,
    this.focusNode,
    this.inputFormatters,
    this.readOnly = false,
    this.onTap,
    this.onChanged,
    this.onSaved,
    this.validator,
    this.outLine = false,
    this.fillColor,
    this.style,
    this.onFieldSubmitted,
    this.textInputAction,
  });

  final String? hintText;
  final TextStyle? style;
  final String? labelText;
  final TextInputType? keyboardType;
  final bool? obscureText;
  final bool outLine;
  final int? maxLine;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final List<TextInputFormatter>? inputFormatters;
  final bool readOnly;
  final Function()? onTap;
  final Function(String)? onChanged;
  final Function(String?)? onSaved;
  final String? Function(String?)? validator;
  final Function(String)? onFieldSubmitted;
  final Color? fillColor;
  final TextInputAction? textInputAction;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textInputAction: widget.textInputAction,
      onFieldSubmitted: widget.onFieldSubmitted,
      controller: widget.controller,
      focusNode: widget.focusNode,
      obscureText: widget.obscureText ?? false,
      obscuringCharacter: '●',
      maxLines: widget.maxLine ?? 1,
      keyboardType: widget.keyboardType,
      inputFormatters: widget.inputFormatters,
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: Get.textTheme.bodyMedium!.copyWith(
          color: Colors.grey,
          fontWeight: FontWeight.w400,
        ),
        labelText: widget.labelText,
        labelStyle: Theme.of(context).textTheme.titleSmall!.copyWith(
              color: Colors.black,
            ),
        border: Theme.of(context).inputDecorationTheme.border,
        errorStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
              color: Colors.red,
            ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(
            color: Colors.red,
            width: 1,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(
            color: Colors.transparent,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(
            color: Colors.grey.shade800,
            width: 0.5,
          ),
        ),
        fillColor: widget.fillColor ?? (Colors.grey.withOpacity(0.2)),
        filled: true,
        suffixIcon: Padding(
          padding: const EdgeInsets.only(right: 0),
          child: widget.suffixIcon,
        ),
        prefixIcon: widget.prefixIcon,
        prefixStyle: const TextStyle(fontSize: 10),
      ),
      style: widget.style ??
          Get.textTheme.titleMedium!.copyWith(
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
      readOnly: widget.readOnly,
      onTap: widget.onTap,
      onChanged: widget.onChanged,
      onSaved: widget.onSaved,
      validator: widget.validator,
      onTapOutside: (event) {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus?.unfocus();
        }
      },
    );
  }
}
