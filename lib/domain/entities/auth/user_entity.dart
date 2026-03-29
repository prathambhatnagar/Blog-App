class UserEntity {
  UserEntity({
    required this.uid,
    required this.email,
    this.displayName,
    this.profileUrl,
  });

  String uid;
  String email;
  String? displayName;
  String? profileUrl;
}
