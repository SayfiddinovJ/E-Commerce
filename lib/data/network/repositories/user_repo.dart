import 'package:e_commerce/data/network/provider/api_provider.dart';
import 'package:e_commerce/models/universal_response.dart';
import 'package:e_commerce/models/user/user_model.dart';

class UserRepo {
  UserRepo({required this.apiProvider});

  final ApiProvider apiProvider;

  Future<List<UserModel>> getAllUsers({
    required String username,
    required String password,
  }) async {
    UniversalResponse universalResponse = await apiProvider.getAllUsers();
    if (universalResponse.error.isEmpty) {
      return universalResponse.data as List<UserModel>;
    }
    return [];
  }
  Future<List<UserModel>> getUsers() async {
    UniversalResponse universalResponse = await apiProvider.getAllUsers();
    if (universalResponse.error.isEmpty) {
      return universalResponse.data as List<UserModel>;
    }
    return [];
  }
}
