class User {
  final String bio;
  final String displayName;
  final String email;
  final String lastSeen;
  final String photoURL;
  final String uid;
  User({this.bio, this.displayName, this.email, this.lastSeen, this.photoURL, this.uid, });
  factory User.fromMap(Map data){
      return User(
        bio: data['bio']?? 'empty'
      );
  }
}