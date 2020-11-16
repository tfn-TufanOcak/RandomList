import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'ProfileUser.dart';
import 'ProfileUserData.dart';
import 'globals.dart';

class AuthService {
  final GoogleSignIn _googleSignIn = GoogleSignIn(hostedDomain: "");

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final ListData profileUserData = Global.profileUserRef;


  Future<ProfileUser> googleSignIn() async {
    try {
      GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
      GoogleSignInAuthentication googleAuth =
      await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      ProfileUser profileUser = await getProfileUser(credential);
      return profileUser;
    } catch (error, stackTrace) {
      return null;
    }
  }

  Future<ProfileUser> getProfileUser(AuthCredential credential) async {
    UserCredential userCredential =
    await _auth.signInWithCredential(credential);
    User user = userCredential.user;
    ProfileUser profileUser;
    profileUser = await profileUserData.getUserData(user.uid);
    if (profileUser == null) {
      profileUser = new ProfileUser(
          uid: user.uid,
          displayName: user.displayName,
          photoUrl: user.photoURL);

      Global.profileUserRef.updateList({
        "uid": user.uid,
        "displayName": user.displayName,
        "photoUrl": user.photoURL
      });
    }

    return profileUser;
  }


  Future<void> signOut() {
    return _auth.signOut();
  }
}