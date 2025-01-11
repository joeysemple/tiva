import 'package:flutter/material.dart';
import 'package:tiva/themes/app_theme.dart';
import 'package:tiva/models/video.dart';
import 'package:tiva/models/live_stream.dart';
import 'package:tiva/widgets/video_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late PageController _pageController;
  int _currentVideoIndex = 0;

  final List<Video> _videos = [
    Video(
      id: '1',
      videoUrl: 'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
      username: 'user1',
      userAvatar: 'avatar_url',
      caption: 'This is an awesome video! #trending #viral',
      likes: 1234,
      comments: 321,
      shares: 100,
    ),
    Video(
      id: '2',
      videoUrl: 'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
      username: 'user2',
      userAvatar: 'avatar_url',
      caption: 'Another cool video 🔥 #fun #amazing',
      likes: 8765,
      comments: 432,
      shares: 200,
    ),
  ];

  final List<LiveStream> _liveStreams = [
    LiveStream(
      id: '1',
      streamUrl: 'stream_url',
      username: 'gamer123',
      userAvatar: 'https://picsum.photos/200',
      title: '🎮 Playing Fortnite with fans! Join now!',
      viewers: 1234,
      thumbnailUrl: 'https://picsum.photos/800/1200',
      category: 'Gaming',
      country: 'US', // Added country parameter
    ),
    LiveStream(
      id: '2',
      streamUrl: 'stream_url',
      username: 'musiclover',
      userAvatar: 'https://picsum.photos/201',
      title: '🎵 Live Music Session - Taking Requests',
      viewers: 567,
      thumbnailUrl: 'https://picsum.photos/800/1201',
      category: 'Music',
      country: 'UK', // Added country parameter
    ),
    LiveStream(
      id: '3',
      streamUrl: 'stream_url',
      username: 'chef_mike',
      userAvatar: 'https://picsum.photos/202',
      title: '🍳 Cooking Italian Dinner - Live Tutorial',
      viewers: 890,
      thumbnailUrl: 'https://picsum.photos/800/1202',
      category: 'Cooking',
      country: 'IT', // Added country parameter
    ),
  ];

  void _handleLike(int index) {
    setState(() {
      _videos[index].isLiked = !_videos[index].isLiked;
      _videos[index].likes += _videos[index].isLiked ? 1 : -1;
    });
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this, initialIndex: 1);
    _pageController = PageController();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              floating: true,
              pinned: true,
              snap: false,
              centerTitle: false,
              title: const Padding(
                padding: EdgeInsets.only(left: 4, top: 12),
                child: Text(
                  'TIVA',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.5,
                  ),
                ),
              ),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(42),
                child: Container(
                  height: 42,
                  alignment: Alignment.centerLeft,
                  child: TabBar(
                    controller: _tabController,
                    isScrollable: true,
                    tabAlignment: TabAlignment.start,
                    indicatorSize: TabBarIndicatorSize.label,
                    dividerColor: Colors.transparent,
                    indicatorColor: AppTheme.accentColor,
                    indicatorWeight: 3,
                    labelPadding: const EdgeInsets.symmetric(horizontal: 12),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    tabs: const [
                      Tab(text: 'Live'),
                      Tab(text: 'For You'),
                      Tab(text: 'Following'),
                    ],
                  ),
                ),
              ),
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: [
            _buildLiveSection(),
            _buildVideoFeed(),
            _buildVideoFeed(),
          ],
        ),
      ),
    );
  }

  Widget _buildVideoFeed() {
    return PageView.builder(
      controller: _pageController,
      scrollDirection: Axis.vertical,
      onPageChanged: (index) {
        setState(() {
          _currentVideoIndex = index;
        });
      },
      itemCount: _videos.length,
      itemBuilder: (context, index) {
        return VideoCard(
          video: _videos[index],
          isActive: _currentVideoIndex == index,
          onLike: () => _handleLike(index),
        );
      },
    );
  }

  Widget _buildLiveSection() {
    return PageView.builder(
      scrollDirection: Axis.vertical,
      itemCount: _liveStreams.length,
      itemBuilder: (context, index) {
        return Container(
          color: Colors.black,
          child: Stack(
            children: [
              // Full screen background image
              Positioned.fill(
                child: Image.network(
                  _liveStreams[index].thumbnailUrl,
                  fit: BoxFit.cover,
                ),
              ),
              // Gradient overlay
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withOpacity(0.2),
                        Colors.black.withOpacity(0.6),
                      ],
                    ),
                  ),
                ),
              ),
              // Live badge & viewer count
              Positioned(
                top: 48,
                left: 16,
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 4),
                          const Text(
                            'LIVE',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.remove_red_eye,
                            color: Colors.white,
                            size: 16,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${_liveStreams[index].viewers}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // User info at bottom
              Positioned(
                left: 16,
                right: 16,
                bottom: 32,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 24,
                          backgroundImage: NetworkImage(_liveStreams[index].userAvatar),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '@${_liveStreams[index].username}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                _liveStreams[index].category,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      _liveStreams[index].title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}