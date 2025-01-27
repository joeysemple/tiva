class User {
  final String? id;
  final String? username;
  final String? email;
  final String? photoUrl;
  final String? bio;
  final List<String> followers;
  final List<String> following;
  final bool isAnonymous;
  final DateTime? createdAt;

  User({
    this.id,
    this.username,
    this.email,
    this.photoUrl,
    this.bio,
    this.followers = const [],
    this.following = const [],
    this.isAnonymous = true,
    this.createdAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String?,
      username: json['username'] as String?,
      email: json['email'] as String?,
      photoUrl: json['photoUrl'] as String?,
      bio: json['bio'] as String?,
      followers: List<String>.from(json['followers'] ?? []),
      following: List<String>.from(json['following'] ?? []),
      isAnonymous: json['isAnonymous'] ?? true,
      createdAt: json['createdAt'] != null 
          ? DateTime.parse(json['createdAt'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'photoUrl': photoUrl,
      'bio': bio,
      'followers': followers,
      'following': following,
      'isAnonymous': isAnonymous,
      'createdAt': createdAt?.toIso8601String(),
    };
  }

  User copyWith({
    String? id,
    String? username,
    String? email,
    String? photoUrl,
    String? bio,
    List<String>? followers,
    List<String>? following,
    bool? isAnonymous,
    DateTime? createdAt,
  }) {
    return User(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      photoUrl: photoUrl ?? this.photoUrl,
      bio: bio ?? this.bio,
      followers: followers ?? this.followers,
      following: following ?? this.following,
      isAnonymous: isAnonymous ?? this.isAnonymous,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}