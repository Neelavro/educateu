import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/colors.dart';
import '../../../core/textstyles.dart';
import '../models/lesson.dart';

class CommentTile extends StatelessWidget {
  final DiscussionComment comment;
  final VoidCallback onReply;
  final bool isReply;

  const CommentTile({
    super.key,
    required this.comment,
    required this.onReply,
    this.isReply = false,
  });

  @override
  Widget build(BuildContext context) {
    final avatarColor =
        isReply ? const Color(0xFFC15B7E) : const Color(0xFF3A5A7A);

    final tile = Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 16,
          backgroundColor: avatarColor,
          child: const Icon(Icons.person, size: 16, color: Colors.white),
        ),
        SizedBox(width: 3.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    comment.author,
                    style: AppTextStyles.titleSmallEmphasized
                        .copyWith(color: AppColors.textPrimary),
                  ),
                  SizedBox(width: 2.w),
                  Text(
                    comment.timeAgo,
                    style: AppTextStyles.bodySmall
                        .copyWith(color: AppColors.textTertiary),
                  ),
                ],
              ),
              SizedBox(height: 0.5.h),
              Text(
                comment.body,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                  height: 1.45,
                ),
              ),
              if (!isReply) ...[
                SizedBox(height: 1.25.h),
                Row(
                  children: [
                    InkWell(
                      onTap: onReply,
                      child: Row(
                        children: [
                          const Icon(Icons.reply,
                              size: 16, color: AppColors.bgInfo),
                          SizedBox(width: 1.w),
                          Text(
                            'Reply',
                            style: AppTextStyles.labelLargeEmphasized
                                .copyWith(color: AppColors.bgInfo),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 4.5.w),
                    const Icon(Icons.thumb_up_outlined,
                        size: 15, color: AppColors.textSecondary),
                    SizedBox(width: 1.25.w),
                    Text(
                      '${comment.likes}',
                      style: AppTextStyles.labelLargeEmphasized
                          .copyWith(color: AppColors.textSecondary),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ],
    );

    if (comment.replies.isEmpty) return tile;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        tile,
        SizedBox(height: 1.75.h),
        Padding(
          padding: EdgeInsets.only(left: 8.w),
          child: Container(
            padding: EdgeInsets.all(1.5.h),
            decoration: BoxDecoration(
              color: AppColors.bgSecondary,
              borderRadius: BorderRadius.circular(12),
            ),
            child: CommentTile(
              comment: comment.replies.first,
              onReply: () {},
              isReply: true,
            ),
          ),
        ),
      ],
    );
  }
}
