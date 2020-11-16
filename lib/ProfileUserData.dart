import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:random_list/globals.dart';

class ListData<T> {
  final String collection;

  ListData({this.collection});

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> updateList(mapList) {
    DocumentReference userRef =
        firestore.collection(collection).doc(mapList["uid"]);
    userRef.set(mapList, SetOptions(merge: true));
  }

  Future<T> getUserData(String uid) {
    DocumentReference userRef = firestore.collection(collection).doc(uid);
    return userRef.get().then((v) => Global.models[T](v.data()) as T);
  }


}
