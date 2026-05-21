enum ModuleStatus { completed, inProgress, locked }

class Module {
  final int number;
  final String title;
  final ModuleStatus status;
  bool isDownloaded;
  final String? lockedMessage;

  Module({
    required this.number,
    required this.title,
    required this.status,
    this.isDownloaded = false,
    this.lockedMessage,
  });
}
