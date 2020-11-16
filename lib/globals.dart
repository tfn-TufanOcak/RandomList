import 'package:random_list/Meal.dart';
import 'package:random_list/ProfileUser.dart';
import 'package:random_list/ProfileUserData.dart';

import 'MealData.dart';

class Global {
  static ProfileUser currentSessionUser = new ProfileUser();

  static final Map models = {

    ProfileUser: (data) => ProfileUser.fromMap(data),
    Meal: (data) => Meal.fromMap(data),
  };


  static final ListData<ProfileUser> profileUserRef =  ListData<ProfileUser>(collection: 'users');
  static final MealData<Meal> mealRef =  MealData<Meal>(collection: 'meals');

}
