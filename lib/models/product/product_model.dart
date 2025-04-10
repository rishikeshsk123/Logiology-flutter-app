import 'package:json_annotation/json_annotation.dart';


part 'product_model.g.dart';

@JsonSerializable()
class ProductModel {
	int id;
	String title;
	String description;
	String? category;
	double price;
	double? discountPercentage;
	double rating;
	int? stock;
	List<String>? tags;
	String? brand;
	String? sku;
	int? weight;
	List<String>? images;
	String thumbnail;

	ProductModel({
		required this.id, 
		required this.title, 
		required this.description, 
		this.category, 
		required this.price, 
		this.discountPercentage, 
		required this.rating, 
		this.stock, 
		this.tags, 
		this.brand, 
		this.sku, 
		this.weight, 
		
		this.images, 
		required this.thumbnail, 
	});

	factory ProductModel.fromJson(Map<String, dynamic> json) {
		return _$ProductModelFromJson(json);
	}

	Map<String, dynamic> toJson() => _$ProductModelToJson(this);
}
