class LiveStream {
  final String id;
  final String streamUrl;
  final String username;
  final String userAvatar;
  final String title;
  final int viewers;
  final String thumbnailUrl;
  final String category;

  LiveStream({
    required this.id,
    required this.streamUrl,
    required this.username,
    required this.userAvatar,
    required this.title,
    required this.viewers,
    required this.thumbnailUrl,
    required this.category,
  });
}