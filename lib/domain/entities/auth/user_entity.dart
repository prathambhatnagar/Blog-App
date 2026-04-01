class UserEntity {
  const UserEntity({
    required this.uid,
    required this.email,
    this.displayName,
    this.profileUrl,
    this.phone,
  });

  final String uid;
  final String email;
  final String? displayName;
  final String? profileUrl;
  final String? phone;
}
