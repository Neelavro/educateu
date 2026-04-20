import 'package:educateu/core/textstyles.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';

class RoundedTextField extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;

  final String hintText;
  final HeroIcons? icon;
  final HeroIcons? suffixIcon;

  final TextInputType keyboardType;

  final Color backgroundColor;
  final Color iconColor;
  final Color textColor;

  final double iconSize;

  final bool obscureText;
  final bool readOnly;
  final bool enabled;

  final int maxLines;

  const RoundedTextField({
    super.key,
    required this.controller,
    this.onChanged,
    this.onSubmitted,
    this.hintText = "",
    this.icon = HeroIcons.archiveBox,
    this.suffixIcon,
    this.keyboardType = TextInputType.text,
    this.backgroundColor = const Color(0xFFF5F5F5),
    this.iconColor = Colors.black,
    this.textColor = Colors.black,
    this.iconSize = 20,
    this.obscureText = false,
    this.readOnly = false,
    this.enabled = true,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      keyboardType: keyboardType,
      obscureText: obscureText,
      readOnly: readOnly,
      enabled: enabled,
      maxLines: maxLines,

      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: AppTextStyles.bodyMedium.copyWith(color: textColor),


        prefixIcon:icon != null? HeroIcon(
          icon!,
          size: iconSize,
          color: iconColor,
        ): null,

        suffixIcon: suffixIcon != null
            ? HeroIcon(
          suffixIcon!,
          size: iconSize,
          color: iconColor,
        )
            : null,

        filled: true,
        fillColor: backgroundColor,

        contentPadding: const EdgeInsets.symmetric(
          vertical: 0,
          horizontal: 12,
        ),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),

      ),
    );
  }
}
