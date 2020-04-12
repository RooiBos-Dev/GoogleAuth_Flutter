import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();
String photo;
String email;
String name;

class AuthService {
  Future<String> signInWithGoogle() async {
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
    await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final AuthResult authResult = await _auth.signInWithCredential(credential);
    final FirebaseUser user = authResult.user;

    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await _auth.currentUser();
    //await DatabaseServices(uid: currentUser.uid).updateUserBio(bio);
    assert(user.uid == currentUser.uid);


    email = currentUser.email;
    name = currentUser.displayName;
    photo = currentUser.photoUrl;

  }
  Future <void>signOutGoogle() async {
    await googleSignIn.signOut();

    print("User Sign Out");
  }
  Future<String>getCurrentUserId()async{
    String uid = (await _auth.currentUser()).uid;
    return uid;
  }

}

