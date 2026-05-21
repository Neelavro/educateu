import 'package:flutter/material.dart';

enum VideoStatus { watched, inProgress, locked }

class Video {
  final String title;
  final String duration;
  final VideoStatus status;

  const Video({
    required this.title,
    required this.duration,
    required this.status,
  });
}

class VideoModule {
  final String title;
  final int videoCount;
  final String duration;
  final Color accent;
  final List<Video> videos;

  const VideoModule({
    required this.title,
    required this.videoCount,
    required this.duration,
    required this.accent,
    required this.videos,
  });
}
