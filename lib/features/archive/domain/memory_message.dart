/// Model representing a voice memory message in the archive.
class MemoryMessage {
  final String id;
  final String title;
  final String sender;
  final String relationship;
  final String date;
  final String duration;
  final String preview;
  final String fullText;
  final bool isDemo;

  const MemoryMessage({
    required this.id,
    required this.title,
    required this.sender,
    required this.relationship,
    required this.date,
    required this.duration,
    required this.preview,
    required this.fullText,
    this.isDemo = true,
  });
}
