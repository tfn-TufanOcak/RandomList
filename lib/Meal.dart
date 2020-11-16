class Meal {

  String mealName;

  Meal({this.mealName});

  Map<String, dynamic> toMap() {
    return {
      'mealName': this.mealName,
    };
  }
  factory Meal.fromMap(Map data) {
    if (data == null) {
      return null;
    }
    Meal meal = Meal( mealName: data['mealName'] );
    return meal;
  }
  Meal.fromJson(Map<String, dynamic> json) {

    mealName = json['mealName'];

  }
}