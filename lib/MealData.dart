import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'globals.dart';

class MealData<T> {
  final String collection;

  MealData({this.collection});

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> updateMealDataWithMap(mapMeal) {
    DocumentReference mealRef =
        firestore.collection(collection).doc(mapMeal["mealName"]);
    mealRef.set(mapMeal, SetOptions(merge: true));
  }
  Future<void> likeOrDislike(mealName, value) {
    DocumentReference mealRef =
    firestore.collection(collection).doc(mealName);
    mealRef.set({'vote': FieldValue.increment(value)}, SetOptions(merge: true));
  }
  Future<void> like(mealName) {
     likeOrDislike(mealName, 1);
  }
  Future<void> dislike(mealName) {
    likeOrDislike(mealName, -1);
  }
  Stream<List<T>> get mealStream  {

        Query query = firestore.collection(collection);

        Stream<QuerySnapshot> stream = query.snapshots();

        return stream.map(
                (qShot) => qShot.docs.map(
                        (doc) => Global.models[T](doc.data()) as T).toList());

    }

    Future delete(String mealName) async {
    CollectionReference ref = firestore.collection('$collection');
    try {
      await ref
          .doc(mealName)
          .delete();
      return true;
    } catch (e) {
      return e.toString();
    }
  }

/**
    Future<T> getMealData(String mealName) {
    DocumentReference mealRef = firestore.collection(collection).doc(mealName);
    return mealRef.get().then((v) => Global.models[T](v.data()) as T);
    }

    Future<List<T>> getMeals() async {
    Query query = firestore.collection(collection);
    var snapshots = await query.get();
    return snapshots.docs
    .map((doc) => Global.models[T](doc.data()) as T)
    .toList();
    }**/
}
