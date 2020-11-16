import 'package:random_list/ProfileUser.dart';
import 'package:random_list/ProfileUserData.dart';

class Global {
  static ProfileUser currentSessionUser = new ProfileUser();

  static final Map models = {

    ProfileUser: (data) => ProfileUser.fromMap(data),

  };


  static final ListData<ProfileUser> profileUserRef =
  ListData<ProfileUser>(collection: 'users');
}
