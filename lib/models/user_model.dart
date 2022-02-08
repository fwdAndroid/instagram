
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String uid;
  String email;
  String bio;
  String username;
  String photoURL;
  List following;
  List followers;

  UserModel(
      {required this.uid,
      required this.email,
      required this.bio,
      required this.photoURL,
      required this.followers,
      required this.following,
      required this.username});

  ///Converting OBject into Json Object
  Map<String, dynamic> toJson() => {
        'username': username,
        'uid': uid,
        'email': email,
        'bio': bio,
        'followers': followers,
        'following': following,
        'photoURL': photoURL
      };

  ///
  static UserModel fromSnap(DocumentSnapshot snaps){
    var snapshot = snaps.data() as Map<String,dynamic>;

    return UserModel(
    username: snapshot['username'],
    uid: snapshot['uid'],
    email: snapshot['email'],
    photoURL: snapshot['photoURL'],
    bio: snapshot['bio'],
    followers: snapshot['followers'],
    following: snapshot['following'],);    
  }    
}
