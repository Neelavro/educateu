import 'package:flutter/material.dart';

enum LessonStatus { watched, inProgress, locked }

class VideoLesson {
  final String title;
  final String duration;
  final LessonStatus status;

  const VideoLesson({
    required this.title,
    required this.duration,
    required this.status,
  });
}

class LessonModule {
  final String title;
  final Color accentColor;
  final String meta;
  final List<VideoLesson> lessons;

  const LessonModule({
    required this.title,
    required this.accentColor,
    required this.meta,
    required this.lessons,
  });
}

class LessonNote {
  final String timestamp;
  final String body;
  final Color accentColor;

  const LessonNote({
    required this.timestamp,
    required this.body,
    required this.accentColor,
  });
}

class DiscussionComment {
  final String author;
  final String timeAgo;
  final String body;
  final int likes;
  final List<DiscussionComment> replies;

  const DiscussionComment({
    required this.author,
    required this.timeAgo,
    required this.body,
    this.likes = 0,
    this.replies = const [],
  });
}
