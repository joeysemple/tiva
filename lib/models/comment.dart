class Comment {
  final String id;
  final String userId;
  final String username;
  final String userAvatar;
  final String text;
  final DateTime timestamp;
  final int likes;
  bool isLiked;

  Comment({
    required this.id,
    required this.userId,
    required this.username,
    required this.userAvatar,
    required this.text,
    required this.timestamp,
    this.likes = 0,
    this.isLiked = false,
  });
}