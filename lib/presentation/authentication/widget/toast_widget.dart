import 'package:flutter/material.dart';

class ToastWidget extends StatelessWidget {
  final String message;
  final bool isSuccess;

  const ToastWidget({required this.message, required this.isSuccess});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isSuccess ? const Color(0xFF0F4C35) : const Color(0xFF4C0F0F),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: isSuccess
                    ? const Color(0xFF10B981).withOpacity(0.2)
                    : const Color(0xFFEF4444).withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(
                isSuccess ? Icons.check_rounded : Icons.error_outline_rounded,
                color: isSuccess ? const Color(0xFF10B981) : const Color(0xFFEF4444),
                size: 18,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    isSuccess ? 'Success' : 'Failed',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    message,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}