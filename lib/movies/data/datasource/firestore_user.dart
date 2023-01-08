import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movies_app/movies/data/models/user_model.dart';

class FireStoreUser {
  final CollectionReference _userCollectionRef =
      FirebaseFirestore.instance.collection('Users');
  Future<void> addUserToFireStore(UserModel userModel) async {
    return await _userCollectionRef
        .doc(userModel.userId)
        .set(userModel.toJson());
  }

  Future<void> updateUserInfo(UserModel userModel) async {
    await _userCollectionRef.doc(userModel.userId).update(userModel.toJson());
  }

  Future<DocumentSnapshot> getCurrentUser(String uid) async {
    return await _userCollectionRef.doc(uid).get();
  }
}
