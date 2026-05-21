
class ProfilePhoto {
  final String path;
  final String mimetype;
  final int size;
  final String originalname;

  ProfilePhoto({
    required this.path,
    required this.mimetype,
    required this.size,
    required this.originalname,
  });

  factory ProfilePhoto.fromJson(Map<String, dynamic> json) {
    return ProfilePhoto(
      path: json['path'] ?? '',
      mimetype: json['mimetype'] ?? '',
      size: json['size'] ?? 0,
      originalname: json['originalname'] ?? '',
    );
  }
}