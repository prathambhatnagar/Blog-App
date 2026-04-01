import 'dart:developer';

import 'package:blog_assignment/data/models/auth/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class FirestoreUserInfoService {
  Future<void> saveUserInfo({
    required String uid,
    required String name,
    required String phone,
    required String email,
  });

  Future<UserModel> getUserInfo({required String uid});
}

class FirestoreUserInfoServiceImpl extends FirestoreUserInfoService {
  final firebseUserStore = FirebaseFirestore.instance.collection('users');

  @override
  Future<UserModel> getUserInfo({required String uid}) async {
    log('getUserInfo');
    final userData = await firebseUserStore.doc(uid).get();
    log('getUserInfo done');
    return UserModel(
      uid: userData['uid'],
      email: userData['email'],
      displayName: userData['name'],
      phone: userData['phone'],
    );
  }

  @override
  Future<void> saveUserInfo({
    required String uid,
    required String name,
    required String phone,
    required String email,
  }) async {
    log('saveUserInfo');
    await firebseUserStore.doc(uid).set({
      'uid': uid,
      'name': name,
      'phone': phone,
      'email': email,
    });
    log('saveUserInfo done');
  }
}
