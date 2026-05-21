import 'package:flutter/material.dart';

class AssignmentCard extends StatelessWidget {
  final String month;
  final String day;
  final String title;
  final String subtitle;
  final bool isUrgent;

  const AssignmentCard({
    super.key,
    required this.month,
    required this.day,
    required this.title,
    required this.subtitle,
    this.isUrgent = false,
  });

  @override
  Widget build(BuildContext context) {
    final circleBg = isUrgent ? const Color(0xFFFCE4E4) : const Color(0xFFE5E7EB);
    final circleText = isUrgent ? const Color(0xFFB91C1C) : const Color(0xFF374151);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F6F8),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Date circle
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: circleBg,
              shape: BoxShape.circle,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  month,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: circleText,
                    height: 1.1,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  day,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: circleText,
                    height: 1.1,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          // Title + subtitle
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF0F172A),
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF6B7280),
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
          // Urgent badge
          if (isUrgent) ...[
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFFB91C1C),
                borderRadius: BorderRadius.circular(100),
              ),
              child: const Text(
                'URGENT',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}