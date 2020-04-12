//packages
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:googlesignin/Models/userModel.dart';
import 'package:googlesignin/Services/auth.dart';
//root
class DatabaseServices{

  final Firestore _db = Firestore.instance  ;
  final String uid;
  DatabaseServices({this.uid});


//Get single document as stream for current user
  Stream<User> DataStream(String user){
    return _db.collection('user')
        .document(user)
        .snapshots()
        .map((snap) => User.fromMap(snap.data));
  }

  Future<void> updateUserBio( bio) async {
    AuthService user = new AuthService();
    await user.getCurrentUserId().then((value) =>  Firestore.instance.collection('user').document(value).setData({
    'bio': bio
    }, merge: true));


  }
}