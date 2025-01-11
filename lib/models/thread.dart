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
  final int waves;
  final int echoes;
  final List<String> tags;
  final String mood;
  final String bgColor;
  bool hasVibed;
  final bool hasEchoed;
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
    required this.waves,
    required this.echoes,
    required this.tags,
    required this.mood,
    required this.bgColor,
    this.hasVibed = false,
    this.hasEchoed = false,
    this.comments = const [],
  });
}
