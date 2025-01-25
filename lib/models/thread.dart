import 'comment.dart';

class Thread {
  final String id;
  final String userId;
  final String username;
  final String userAvatar;
  final String text;
  final List<String>? media;
  final DateTime timestamp;
  int vibes;
  int waves;
  int echoes;           // Made mutable
  final List<String> tags;
  final String mood;
  final String bgColor;
  bool hasVibed;
  bool hasEchoed;       // Made mutable
  final List<Comment> comments;

  Thread({
    required this.id,
    required this.userId,
    required this.username,
    required this.userAvatar,
    required this.text,
    this.media,
    required this.timestamp,
    this.vibes = 0,
    this.waves = 0,
    this.echoes = 0,
    required this.tags,
    required this.mood,
    required this.bgColor,
    this.hasVibed = false,
    this.hasEchoed = false,
    this.comments = const [],
  });
}
