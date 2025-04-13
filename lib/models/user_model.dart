class UserModel {
  String id;
  String name;
  String email;
  int coins;
  List<String> achievements;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.coins = 0,
    this.achievements = const [],
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      coins: json['coins'] as int? ?? 0,
      achievements: List<String>.from(json['achievements'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'coins': coins,
      'achievements': achievements,
    };
  }

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    int? coins,
    List<String>? achievements,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      coins: coins ?? this.coins,
      achievements: achievements ?? this.achievements,
    );
  }
} 