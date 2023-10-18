import 'package:e_commerce/models/universal_response.dart';

import '../../../models/product/product_model.dart';
import '../provider/api_provider.dart';

class ProductRepo {
  ProductRepo({required this.apiProvider});

  final ApiProvider apiProvider;

  Future<List<ProductModel>> getAllProducts() async {
    UniversalResponse universalResponse = await apiProvider.getAllProducts();
    if (universalResponse.error.isEmpty) {
      return universalResponse.data as List<ProductModel>;
    }
    return [];
  }

  Future<List<ProductModel>> getProductsByLimit(int limit) async {
    UniversalResponse universalResponse =
        await apiProvider.getProductsByLimit(limit: limit);
    if (universalResponse.error.isEmpty) {
      return universalResponse.data as List<ProductModel>;
    }
    return [];
  }

  Future<ProductModel?> addProduct(ProductModel productModel) async {
    UniversalResponse universalResponse =
        await apiProvider.addProduct(productModel);
    if (universalResponse.error.isEmpty) {
      return universalResponse.data as ProductModel;
    }
    return null;
  }

  Future<ProductModel?> updateProduct(ProductModel productModel) async {
    UniversalResponse universalResponse =
        await apiProvider.productUpdate(productModel);
    if (universalResponse.error.isEmpty) {
      return universalResponse.data as ProductModel;
    }
    return null;
  }

  Future<ProductModel?> deleteProduct(int id) async {
    UniversalResponse universalResponse = await apiProvider.deleteProduct(id);
    if (universalResponse.error.isEmpty) {
      return universalResponse.data as ProductModel;
    }
    return null;
  }

  Future<List<ProductModel>> getSortedProducts(String sort) async {
    UniversalResponse universalResponse = await apiProvider.sortProducts(sort);
    if (universalResponse.error.isEmpty) {
      return universalResponse.data as List<ProductModel>;
    }
    return [];
  }

  Future<List<ProductModel>> getProductsByCategory(
      String category, String sort) async {
    UniversalResponse universalResponse =
        await apiProvider.getProductsByCategory(category: category, sort: sort);
    if (universalResponse.error.isEmpty) {
      return universalResponse.data as List<ProductModel>;
    }
    return [];
  }
}
