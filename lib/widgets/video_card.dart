import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:tiva/models/video.dart';
import 'package:tiva/models/comment.dart';
import 'package:tiva/themes/app_theme.dart';
import 'package:tiva/widgets/comments_sheet.dart';

class VideoCard extends StatefulWidget {
  final Video video;
  final bool isActive;

  const VideoCard({
    super.key,
    required this.video,
    required this.isActive,
  });

  @override
  State<VideoCard> createState() => _VideoCardState();
}

class _VideoCardState extends State<VideoCard> {
  late VideoPlayerController _controller;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }

  void _initializeVideo() async {
    try {
      _controller = VideoPlayerController.network(widget.video.videoUrl)
        ..initialize().then((_) {
          if (mounted) {
            setState(() {
              _isInitialized = true;
            });
            if (widget.isActive) {
              _controller.play();
              _controller.setLooping(true);
            }
          }
        });
    } catch (e) {
      debugPrint('Error initializing video: $e');
    }
  }

  @override
  void didUpdateWidget(VideoCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isActive && !_controller.value.isPlaying) {
      _controller.play();
    } else if (!widget.isActive && _controller.value.isPlaying) {
      _controller.pause();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (_isInitialized)
            GestureDetector(
              onTap: () {
                if (_controller.value.isPlaying) {
                  _controller.pause();
                } else {
                  _controller.play();
                }
              },
              child: VideoPlayer(_controller),
            )
          else
            const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            ),
          // Removed `const` here
          _VideoOverlay(video: widget.video),
        ],
      ),
    );
  }
}

class _VideoOverlay extends StatefulWidget {
  final Video video;

  const _VideoOverlay({required this.video});

  @override
  State<_VideoOverlay> createState() => _VideoOverlayState();
}

class _VideoOverlayState extends State<_VideoOverlay> {
  final List<Comment> _comments = [
    Comment(
      id: '1',
      userId: 'user1',
      username: 'john_doe',
      userAvatar: 'https://picsum.photos/200',
      text: 'This is amazing! 🔥',
      timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
      likes: 42,
      isLiked: true,
    ),
    Comment(
      id: '2',
      userId: 'user2',
      username: 'jane_smith',
      userAvatar: 'https://picsum.photos/201',
      text: 'Great content! Keep it up 👏',
      timestamp: DateTime.now().subtract(const Duration(hours: 2)),
      likes: 24,
    ),
  ];

  void _showComments(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => SizedBox(
        height: MediaQuery.of(context).size.height * 0.8,
        child: CommentsSheet(
          comments: _comments,
          onAddComment: (String text) {
            setState(() {
              _comments.add(
                Comment(
                  id: DateTime.now().toString(),
                  userId: 'current_user',
                  username: 'current_user',
                  userAvatar: 'https://picsum.photos/203',
                  text: text,
                  timestamp: DateTime.now(),
                  likes: 0,
                ),
              );
            });
          },
        ),
      ),
    );
  }

  String _formatNumber(int number) {
    if (number >= 1000000) {
      return '${(number / 1000000).toStringAsFixed(1)}M';
    } else if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(1)}K';
    }
    return number.toString();
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    Color color = Colors.white,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Icon(icon, size: 32, color: color),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '@${widget.video.username}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.video.caption,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Column(
                children: [
                  _buildActionButton(
                    icon: Icons.favorite,
                    label: _formatNumber(widget.video.likes),
                    color: widget.video.isLiked ? AppTheme.accentColor : Colors.white,
                  ),
                  const SizedBox(height: 20),
                  _buildActionButton(
                    icon: Icons.comment,
                    label: _formatNumber(_comments.length),
                    onTap: () => _showComments(context),
                  ),
                  const SizedBox(height: 20),
                  _buildActionButton(
                    icon: Icons.reply,
                    label: _formatNumber(widget.video.shares),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
