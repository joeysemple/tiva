import 'package:flutter/material.dart';
import '../themes/app_theme.dart';
import '../models/live_stream.dart';

class LiveScreen extends StatefulWidget {
  const LiveScreen({super.key});

  @override
  State<LiveScreen> createState() => _LiveScreenState();
}

class _LiveScreenState extends State<LiveScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Sample live streams data
  final List<LiveStream> _liveStreams = [
    LiveStream(
      id: '1',
      streamUrl: 'stream_url',
      username: 'gamer123',
      userAvatar: 'https://picsum.photos/200',
      title: '🎮 Epic Fortnite Gameplay',
      viewers: 1234,
      thumbnailUrl: 'https://picsum.photos/800/1200',
      category: 'Gaming',
      country: 'US',
    ),
    LiveStream(
      id: '2',
      streamUrl: 'stream_url',
      username: 'musiclover',
      userAvatar: 'https://picsum.photos/201',
      title: '🎵 Live Acoustic Session',
      viewers: 567,
      thumbnailUrl: 'https://picsum.photos/800/1201',
      category: 'Music',
      country: 'UK',
    ),
    LiveStream(
      id: '3',
      streamUrl: 'stream_url',
      username: 'chef_mike',
      userAvatar: 'https://picsum.photos/202',
      title: '🍳 Cooking Italian Delights',
      viewers: 890,
      thumbnailUrl: 'https://picsum.photos/800/1202',
      category: 'Cooking',
      country: 'IT',
    ),
    LiveStream(
      id: '4',
      streamUrl: 'stream_url',
      username: 'gamer_kr',
      userAvatar: 'https://picsum.photos/203',
      title: '🎮 Korean Gaming Stream',
      viewers: 456,
      thumbnailUrl: 'https://picsum.photos/800/1203',
      category: 'Gaming',
      country: 'KR',
    ),
    LiveStream(
      id: '5',
      streamUrl: 'stream_url',
      username: 'french_artist',
      userAvatar: 'https://picsum.photos/204',
      title: '🎨 Live Art Creation',
      viewers: 789,
      thumbnailUrl: 'https://picsum.photos/800/1204',
      category: 'Art',
      country: 'FR',
    ),
  ];

  // Countries by continent
  final Map<String, List<Map<String, String>>> _countriesByContinents = {
    'Asia': [
      {'name': 'Japan', 'flag': '🇯🇵'},
      {'name': 'South Korea', 'flag': '🇰🇷'},
      {'name': 'China', 'flag': '🇨🇳'},
      {'name': 'India', 'flag': '🇮🇳'},
      {'name': 'Singapore', 'flag': '🇸🇬'},
    ],
    'Europe': [
      {'name': 'United Kingdom', 'flag': '🇬🇧'},
      {'name': 'Germany', 'flag': '🇩🇪'},
      {'name': 'France', 'flag': '🇫🇷'},
      {'name': 'Italy', 'flag': '🇮🇹'},
      {'name': 'Spain', 'flag': '🇪🇸'},
    ],
    'North America': [
      {'name': 'United States', 'flag': '🇺🇸'},
      {'name': 'Canada', 'flag': '🇨🇦'},
      {'name': 'Mexico', 'flag': '🇲🇽'},
    ],
    'South America': [
      {'name': 'Brazil', 'flag': '🇧🇷'},
      {'name': 'Argentina', 'flag': '🇦🇷'},
      {'name': 'Colombia', 'flag': '🇨🇴'},
    ],
    'Africa': [
      {'name': 'South Africa', 'flag': '🇿🇦'},
      {'name': 'Nigeria', 'flag': '🇳🇬'},
      {'name': 'Egypt', 'flag': '🇪🇬'},
    ],
  };

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  String _getCountryCode(String countryName) {
    switch (countryName) {
      case 'United States':
        return 'US';
      case 'United Kingdom':
        return 'UK';
      case 'South Korea':
        return 'KR';
      case 'Italy':
        return 'IT';
      case 'France':
        return 'FR';
      default:
        return '';
    }
  }

  List<LiveStream> _getFilteredStreams([String? country]) {
    if (country == null) return _liveStreams;
    return _liveStreams.where((stream) => stream.country == country).toList();
  }

  Widget _buildLiveStreamGrid({String? country}) {
    final filteredStreams = country != null 
        ? _getFilteredStreams(country) 
        : _liveStreams;

    if (filteredStreams.isEmpty) {
      return Center(
        child: Text(
          country != null 
            ? 'No live streams in this country' 
            : 'No live streams available',
          style: const TextStyle(color: Colors.white),
        ),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.6,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: filteredStreams.length,
      itemBuilder: (context, index) {
        final stream = filteredStreams[index];
        return _buildLiveStreamCard(stream);
      },
    );
  }

  Widget _buildLiveStreamCard(LiveStream stream) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.network(
              stream.thumbnailUrl,
              height: 180,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  stream.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 12,
                      backgroundImage: NetworkImage(stream.userAvatar),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '@${stream.username}',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(
                      Icons.remove_red_eye,
                      size: 16,
                      color: Colors.white70,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${stream.viewers} viewers',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildExploreCountries() {
    return SingleChildScrollView(
      child: Column(
        children: _countriesByContinents.entries.map((continent) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  continent.key,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 4,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: continent.value.length,
                  itemBuilder: (context, index) {
                    final country = continent.value[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => CountryStreamsScreen(
                              countryName: country['name']!,
                              countryCode: _getCountryCode(country['name']!),
                            ),
                            settings: RouteSettings(
                              arguments: _liveStreams,
                            ),
                          ),
                        );
                      },
                      child: Row(
                        children: [
                          Text(
                            country['flag']!,
                            style: const TextStyle(fontSize: 24),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            country['name']!,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              const Divider(color: Colors.white24, height: 32),
            ],
          );
        }).toList(),
      ),
    );
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
                  'Live',
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
                      Tab(text: 'Nearby'),
                      Tab(text: 'Popular'),
                      Tab(text: 'Explore'),
                      Tab(text: 'Game'),
                      Tab(text: 'Other'),
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
            _buildLiveStreamGrid(),
            _buildLiveStreamGrid(),
            _buildExploreCountries(),
            _buildLiveStreamGrid(),
            _buildLiveStreamGrid(),
          ],
        ),
      ),
    );
  }
}

class CountryStreamsScreen extends StatelessWidget {
  final String countryName;
  final String countryCode;

  const CountryStreamsScreen({
    super.key, 
    required this.countryName, 
    required this.countryCode,
  });

  @override
  Widget build(BuildContext context) {
    final List<LiveStream> liveStreams = ModalRoute.of(context)!.settings.arguments as List<LiveStream>;
    
    final filteredStreams = liveStreams.where((stream) => stream.country == countryCode).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Live Streams in $countryName'),
      ),
      body: filteredStreams.isEmpty
        ? Center(
            child: Text(
              'No live streams in $countryName',
              style: const TextStyle(color: Colors.white),
            ),
          )
        : GridView.builder(
            padding: const EdgeInsets.all(8),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.6,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemCount: filteredStreams.length,
            itemBuilder: (context, index) {
              final stream = filteredStreams[index];
              return _buildLiveStreamCard(stream);
            },
          ),
    );
  }

  Widget _buildLiveStreamCard(LiveStream stream) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.network(
              stream.thumbnailUrl,
              height: 180,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  stream.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 12,
                      backgroundImage: NetworkImage(stream.userAvatar),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '@${stream.username}',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(
                      Icons.remove_red_eye,
                      size: 16,
                      color: Colors.white70,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${stream.viewers} viewers',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}