import '../../../models/user_model.dart';

abstract class UserRepository {
  Future<List<UserModel>> getListUserModels();
  Future<UserModel> RegistUser(UserModel user);

}

