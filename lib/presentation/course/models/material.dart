class MaterialFile {
  final String title;
  final String fileType;
  final String fileSize;

  const MaterialFile({
    required this.title,
    required this.fileType,
    required this.fileSize,
  });

  String get meta => '$fileType • $fileSize';
}

class RequiredReading {
  final String title;
  final String description;
  final String readTime;

  const RequiredReading({
    required this.title,
    required this.description,
    required this.readTime,
  });
}

class ExternalResource {
  final String title;
  final String url;

  const ExternalResource({required this.title, required this.url});
}
