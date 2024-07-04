class User {
  final String userId;
  final String email;
  final String name;
  final String? image;

  User({
    required this.userId,
    required this.email,
    required this.name,
    this.image,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['user_id'],
      email: json['email'],
      name: json['name'],
      image: json['image'],
    );
  }
}
