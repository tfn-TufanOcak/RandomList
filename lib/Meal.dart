import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Meal {

  String mealName;
  String recipe;
  String vote;
  Meal({this.mealName, this.recipe,this.vote});

  Map<String, dynamic> toMap() {
    return {
      'mealName': this.mealName,
      'recipe': this.recipe,
      'vote':this.vote,
    };
  }
  factory Meal.fromMap(Map data) {
    if (data == null) {
      return null;
    }
    Meal meal = Meal( mealName: data['mealName'], recipe: data['recipe'] ,vote: data['vote']);
    return meal;
  }
  Meal.fromJson(Map<String, dynamic> json) {

    mealName = json['mealName'];
    recipe = json['recipe'];
    vote=json['vote'];
  }
}