import 'package:educateu/core/textstyles.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';

class RoundedDropdown<T> extends StatelessWidget {
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?>? onChanged;

  final String hintText;
  final HeroIcons? icon;

  final Color backgroundColor;
  final Color iconColor;
  final Color textColor;

  final double iconSize;

  final bool enabled;

  const RoundedDropdown({
    super.key,
    required this.value,
    required this.items,
    this.onChanged,
    this.hintText = "",
    this.icon = HeroIcons.archiveBox,
    this.backgroundColor = const Color(0xFFF5F5F5),
    this.iconColor = Colors.black,
    this.textColor = Colors.black,
    this.iconSize = 20,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      value: value,
      onChanged: enabled ? onChanged : null,
      isDense: true,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: AppTextStyles.bodyMedium.copyWith(color: textColor),

        filled: true,
        fillColor: backgroundColor,

        contentPadding: const EdgeInsets.symmetric(
          vertical: 0,
          horizontal: 5,
        ),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
      icon: HeroIcon(
        HeroIcons.chevronDown,
        size: iconSize,
        color: iconColor,
      ),
      dropdownColor: backgroundColor,
      style: AppTextStyles.bodyMedium.copyWith(color: textColor),
      items: items,
    );
  }
}