import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logiology/models/product/product_model.dart';
import 'package:logiology/services/api_service.dart';

class ProductController extends GetxController {
  final productList = <ProductModel>[].obs;
  var isLoading = true.obs;

  final filteredProductsList = <ProductModel>[].obs;

  final categories = [].obs;

  final selectedCategories = <String>[].obs;
  final selectedRatings = <double>[].obs;
  double? minPrice;
  double? maxPrice;

  final searchController = TextEditingController();
  final searchText = ''.obs;

  final searcProductList = <ProductModel>[].obs;

  @override
  void onInit() {
    fetchProductList();
    categoryList();

    debounce(searchText, (_) => searchForProduct(),
        time: const Duration(milliseconds: 400));
    searchController.addListener(() {
      searchText.value = searchController.text;
    });
    super.onInit();
  }

  Future<void> fetchProductList() async {
    try {
      isLoading.value = true;
      final data = await ApiService().fetchProducts();
      productList.value = data;
      filteredProductsList.value = List.from(data);
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch products');
    } finally {
      isLoading(false);
    }
  }

  Future<void> categoryList() async {
    try {
      isLoading.value = true;
      final data = await ApiService().fetchCategoryList();
      categories.value = data;
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch category list');
    } finally {
      isLoading(false);
    }
  }

  Future<void> filteredProducts() async {
    final result = productList.where((product) {
      final filterCategory = selectedCategories.isEmpty ||
          selectedCategories.contains(product.category);

      final filterRating = selectedRatings.isEmpty ||
          selectedRatings.any((rating) => product.rating >= rating);

      final filterPrice = (minPrice == null || product.price >= minPrice!) &&
          (maxPrice == null || product.price <= maxPrice!);

      return filterCategory && filterRating && filterPrice;
    }).toList();

    filteredProductsList.value = result;
  }

  void removeFilter() {
    selectedCategories.clear();
    selectedRatings.clear();
    minPrice = null;
    maxPrice = null;
    filteredProductsList.value = productList;
  }

  Future<void> searchForProduct() async {
    if (searchText.isEmpty) {
      filteredProductsList.value = productList;
    } else {
      filteredProductsList.value = productList.where((product) {
        return product.title
            .toLowerCase()
            .contains(searchText.value.toLowerCase());
      }).toList();
    }
  }
}
