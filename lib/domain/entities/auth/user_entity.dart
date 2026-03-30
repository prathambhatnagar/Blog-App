class UserEntity {
  const UserEntity({
    required this.uid,
    required this.email,
    this.displayName,
    this.profileUrl,
  });

  final String uid;
  final String email;
  final String? displayName;
  final String? profileUrl;
}
