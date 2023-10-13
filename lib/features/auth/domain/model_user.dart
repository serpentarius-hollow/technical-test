class User {
  final String username;

  User({
    required this.username,
  });

  @override
  String toString() {
    return '{ username: $username }';
  }
}
