import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foocafe_flutter_firebase_chat/helpers/constants.dart';
import 'package:foocafe_flutter_firebase_chat/models/app_user.dart';

class DatabaseService {
  Future<AppUser> getUser(String userId) async {
    DocumentSnapshot userDoc = await usersRef.doc(userId).get();
    return AppUser.fromDoc(userDoc);
  }

  Future<List<AppUser>> searchUsers(String currentUserId, String name) async {
    QuerySnapshot usersSnap =
        await usersRef.where('name', isGreaterThanOrEqualTo: name).get();
    List<AppUser> users = [];
    for (var doc in usersSnap.docs) {
      AppUser user = AppUser.fromDoc(doc);
      if (user.id != currentUserId) {
        users.add(user);
      }
    }
    return users;
  }

  Future<List<AppUser>> getAllUsers(String currentUserId) async {
    QuerySnapshot userSnapshot = await usersRef.get();
    List<AppUser> users = [];
    for (var doc in userSnapshot.docs) {
      AppUser user = AppUser.fromDoc(doc);
      if (user.id != currentUserId) users.add(user);
    }
    return users;
  }

  static void updateUser(AppUser user) {
    usersRef.doc(user.id).update({
      'name': user.name,
      'profileImageUrl': user.profileImageUrl,
      'bio': user.bio,
    });
  }
}
