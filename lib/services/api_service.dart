import 'package:dio/dio.dart';
import 'package:logiology/models/product/product_model.dart';
import 'package:logiology/services/api_endpoints.dart';

class ApiService {
  Future<List<ProductModel>> fetchProducts() async{
    final response = await Dio(BaseOptions()).get(ApiEndpoints.products);

    if(response.statusCode == 200 || response.statusCode == 201){
      final List data = response.data['products'];
      return data.map((e) => ProductModel.fromJson(e)).toList();
    }
    else {
      throw Exception('Failed to load products');
    }
  }

  Future<List> fetchCategoryList() async{
    final response = await Dio(BaseOptions()).get(ApiEndpoints.category);

    if(response.statusCode == 200 || response.statusCode == 201){
      final List data = response.data;
      return data;
    }
    else {
      throw Exception('Failed to load category list');
    }
  }
}