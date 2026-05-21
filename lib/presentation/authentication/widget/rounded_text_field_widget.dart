import 'package:educateu/core/textstyles.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';

class RoundedTextField extends StatefulWidget {
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
  State<RoundedTextField> createState() => _RoundedTextFieldState();
}

class _RoundedTextFieldState extends State<RoundedTextField> {
  late bool _obscure;

  @override
  void initState() {
    super.initState();
    _obscure = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      onChanged: widget.onChanged,
      onSubmitted: widget.onSubmitted,
      keyboardType: widget.keyboardType,
      obscureText: _obscure,
      readOnly: widget.readOnly,
      enabled: widget.enabled,
      maxLines: widget.maxLines,
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: AppTextStyles.bodyMedium.copyWith(color: widget.textColor),
        prefixIcon: widget.icon != null
            ? HeroIcon(widget.icon!, size: widget.iconSize, color: widget.iconColor)
            : null,
        suffixIcon: widget.suffixIcon != null
            ? GestureDetector(
          onTap: widget.obscureText // only toggle if field is a password field
              ? () => setState(() => _obscure = !_obscure)
              : null,
          child: HeroIcon(
            _obscure ? widget.suffixIcon! : HeroIcons.eyeSlash,
            size: widget.iconSize,
            color: widget.iconColor,
          ),
        )
            : null,
        filled: true,
        fillColor: widget.backgroundColor,
        contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}