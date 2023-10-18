import '../../../models/universal_response.dart';
import '../../local/storage_repository.dart';
import '../provider/api_provider.dart';

class LoginRepo {
  LoginRepo({required this.apiProvider});

  final ApiProvider apiProvider;

  Future<bool> loginUser({
    required String username,
    required String password,
  }) async {
    UniversalResponse universalResponse =
        await apiProvider.loginUser(username: username, password: password);
    if (universalResponse.error.isEmpty) {
      await StorageRepository.putString(
          "token", universalResponse.data as String);
      await StorageRepository.putString("username", username);
      await StorageRepository.putString("password", password);
      return true;
    }
    return false;
  }
}
