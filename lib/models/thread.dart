class Thread {
  final String id;
  final String userId;
  final String username;
  final String userAvatar;
  final String text;
  final List<String>? media;
  final DateTime timestamp;
  final int vibes;
  final int waves;
  final int echoes;
  final List<String> tags;
  final String mood;
  final String bgColor;
  final bool hasVibed;
  final bool hasEchoed;

  Thread({
    required this.id,
    required this.userId,
    required this.username,
    required this.userAvatar,
    required this.text,
    this.media,
    required this.timestamp,
    required this.vibes,
    required this.waves,
    required this.echoes,
    required this.tags,
    required this.mood,
    required this.bgColor,
    this.hasVibed = false,
    this.hasEchoed = false,
  });
}