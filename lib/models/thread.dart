class Thread {
  final String id;
  final String userId;
  final String username;
  final String userAvatar;
  final String text;
  final List<String>? media;
  final DateTime timestamp;
  int vibes; // Made mutable to allow dynamic updates
  final int waves;
  final int echoes;
  final List<String> tags;
  final String mood;
  final String bgColor;
  bool hasVibed; // Made mutable to allow dynamic updates
  final bool hasEchoed;

  Thread({
    required this.id,
    required this.userId,
    required this.username,
    required this.userAvatar,
    required this.text,
    this.media,
    required this.timestamp,
    this.vibes = 0, // Default to 0
    required this.waves,
    required this.echoes,
    required this.tags,
    required this.mood,
    required this.bgColor,
    this.hasVibed = false, // Default to false
    this.hasEchoed = false,
  });
}
