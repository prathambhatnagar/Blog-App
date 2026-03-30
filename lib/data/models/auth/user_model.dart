import 'package:blog_assignment/domain/entities/auth/user_entity.dart';

class UserModel {
  UserModel({
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

extension UserModelx on UserModel {
  UserEntity toUserEntity() {
    return UserEntity(
      uid: uid,
      email: email,
      displayName: displayName,
      profileUrl: profileUrl,
    );
  }
}
