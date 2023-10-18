import '../../../models/universal_response.dart';
import '../provider/api_provider.dart';

class CategoryRepo {
  CategoryRepo({required this.apiProvider});

  final ApiProvider apiProvider;

  Future<List<String>> getAllCategories() async {
    UniversalResponse universalResponse = await apiProvider.getAllCategories();
    if (universalResponse.error.isEmpty) {
      return universalResponse.data as List<String>;
    }
    print(universalResponse.error);
    return [];
  }
}
