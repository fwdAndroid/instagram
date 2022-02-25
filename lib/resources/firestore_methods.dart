import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram/models/post_model.dart';
import 'package:instagram/resources/storage_methods.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethods {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  //Upload PostImage to Firestore
  Future<String> uploadPosts(Uint8List file, String description, String uid,
      String username, String profileImage) async {
    String res = "Some Error";
    try {
      String photoUrl =
          await StorageMethods().uploadImageToStorage("postImages", file, true);

      String postId = Uuid().v1();
      PostModel postModel = PostModel(
          description: description,
          uid: uid,
          username: username,
          postId: postId,
          datePublished: DateTime.now(),
          postUrl: photoUrl,
          profileImage: profileImage,
          likes: []);

      ///Uploading Post To Firebase
      _firebaseFirestore
          .collection('posts')
          .doc(postId)
          .set(postModel.toJson());
      res = 'Sucessfully Uploaded in Firebase';
    } catch (e) {
      res = e.toString();
    }

    return res;
  }

  ///Likes Post
  Future<void> likePosts(String postId, String uid, List likes) async {
    try {
      if (likes.contains(uid)) {
        await _firebaseFirestore.collection('posts').doc(postId).update({
          "likes": FieldValue.arrayRemove([uid])
        });
      } else {
        await _firebaseFirestore.collection('posts').doc(postId).update({
          "likes": FieldValue.arrayUnion([uid])
        });
      }
    } catch (E) {
      print(E.toString());
    }
  }

  //Comment Post
  Future<void> postComment(String postid, String text, String uid,String name,String profilePic) async {
    try {
      if(
        text.isEmpty      ){
          String commentID = Uuid().v1();
          await _firebaseFirestore.collection('posts').doc(postid).collection('comments').doc(commentID).set({
            'profilePic' : profilePic,
            'name':name,
            'text':text,
            'commentId':commentID,
            'datePublished':DateTime.now() 
          });
        }else{
          print('Text is Empty');
        }
    } catch (e) {
      print(e.toString());
    }
  }
}
