
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
}
