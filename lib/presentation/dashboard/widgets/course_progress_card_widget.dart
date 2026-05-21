
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';

class CourseProgressCard extends StatelessWidget {
  final String name;
  final String subtitle;
  final String percentage;

  const CourseProgressCard({
    super.key,
    required this.name,
    required this.subtitle,
    required this.percentage,
  });

  @override
  Widget build(BuildContext context) {
    final progress =
    ((double.tryParse(percentage.replaceAll('%', '').trim()) ?? 0) / 100)
        .clamp(0.0, 1.0);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: const Border(
          left: BorderSide(color: Color(0xFF014751), width: 2),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Top row — flex space-between, center-aligned, stretched
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: const BoxDecoration(
                  color: Color(0xFFF1F2F4),
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: HeroIcon(
                    HeroIcons.bookOpen,
                    size: 22,
                    color: Color(0xFF111827),
                    style: HeroIconStyle.solid,
                  ),
                ),
              ),
              Text(
                '$percentage%',
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFFCBB4F1),
                  height: 1,
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Text(
            name,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Color(0xFF6B7280),
            ),
          ),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 10,
              backgroundColor: const Color(0xFFE5E7EB),
              valueColor:
              const AlwaysStoppedAnimation<Color>(Color(0xFFA855F7)),
            ),
          ),
        ],
      ),
    );
  }
}