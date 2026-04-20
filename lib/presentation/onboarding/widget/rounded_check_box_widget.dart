

import 'package:flutter/material.dart';

import '../../../core/colors.dart';

class RoundedCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?> onChanged;
  final Color activeColor;
  final Color borderColor;
  final double size;

  const RoundedCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
    this.activeColor = Colors.blue,
    this.borderColor = Colors.grey,
    this.size = 22,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onChanged(!value),
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: value ? activeColor : AppColors.bgTertiary,
          borderRadius: BorderRadius.circular(6), // rounded corners
          border: Border.all(
            color: borderColor,
          ),
        ),
        child: value
            ? const Icon(
          Icons.check,
          size: 16,
          color: Colors.white,
        )
            : null,
      ),
    );
  }
}
