class Video {
  final String id;
  final String videoUrl;
  final String username;
  final String userAvatar;
  final String caption;
  int likes;
  final int comments;
  final int shares;
  bool isLiked;

  Video({
    required this.id,
    required this.videoUrl,
    required this.username,
    required this.userAvatar,
    required this.caption,
    required this.likes,
    required this.comments,
    required this.shares,
    this.isLiked = false,
  });
}