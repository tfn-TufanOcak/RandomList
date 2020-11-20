class Meal {

  String mealName;
  String recipe;
  Meal({this.mealName, this.recipe});

  Map<String, dynamic> toMap() {
    return {
      'mealName': this.mealName,
      'recipe': this.recipe,
    };
  }
  factory Meal.fromMap(Map data) {
    if (data == null) {
      return null;
    }
    Meal meal = Meal( mealName: data['mealName'], recipe: data['recipe'] );
    return meal;
  }
  Meal.fromJson(Map<String, dynamic> json) {

    mealName = json['mealName'];
    recipe = json['recipe'];
  }
}