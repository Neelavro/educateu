import 'package:educateu/core/textstyles.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';

class StatCardWidget extends StatelessWidget {
  final HeroIcons icon;
  final HeroIconStyle iconStyle;
  final Color iconColor;
  final String topText;
  final Color topTextColor;
  final String bottomText;
  final Color bottomTextColor;
  final backgroundColor;

  const StatCardWidget({
    super.key,
    required this.icon,
    this.iconStyle = HeroIconStyle.solid,
    required this.iconColor,
    required this.topText,
    required this.topTextColor,
    required this.bottomText,
    required this.bottomTextColor,
    required this.backgroundColor
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 82.048,
      height: 91.164,
      constraints: const BoxConstraints(minWidth: 86.048),
      padding: const EdgeInsets.fromLTRB(12, 12, 4, 12),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: const Offset(0, 0.456),
            blurRadius: 0.912,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HeroIcon(icon, style: iconStyle, color: iconColor, size: 22),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                topText,
                style: AppTextStyles.labelLargeEmphasized.copyWith(color: topTextColor),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                bottomText,
                style: AppTextStyles.labelSmallEmphasized.copyWith(color: bottomTextColor),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
