import 'package:flutter/material.dart';

class NextSessionCard extends StatelessWidget {
  const NextSessionCard({
    super.key,
    required this.dateTimeLabel,
    this.label = 'Next Session',
    this.icon = Icons.calendar_today_outlined,
  });

  final String dateTimeLabel;
  final String label;
  final IconData icon;

  static const Color _bg = Color(0xFFF1F5F9);
  static const Color _iconColor = Color(0xFF111827);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: _bg,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(icon, size: 22, color: _iconColor),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  height: 16 / 11,
                  letterSpacing: 0.5,
                  color: Color(0xFF44474E),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                dateTimeLabel,
                style: const TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  height: 20 / 14,
                  letterSpacing: 0.1,
                  color: Color(0xFF191C1D),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
