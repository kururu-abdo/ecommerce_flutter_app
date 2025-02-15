import 'package:ecommerce_app/features/home/data/models/product.dart';
import 'package:ecommerce_app/repositories/search_repo.dart';

class ProductDetailsModel {
	String? id;
	String? arName;
	String? enName;
	dynamic price;
	String? desc;
	dynamic imageUrl;
	int? inventory;
	bool? isFavourite;
	Map<String,dynamic>? cart;
	List<Variants>? variants;
  	List<ProductModel>? relatedProducts;

	List<ProductImages>? images;

	ProductDetailsModel({this.id, this.arName, this.enName, this.price, this.desc, this.imageUrl, this.inventory, this.isFavourite, this.cart, this.variants, this.images});

	ProductDetailsModel.fromJson(Map<String, dynamic> json) {
		id = json['id'];
		arName = json['ar_name'];
		enName = json['en_name'];
		price = json['price'];
		desc = json['desc'];
		imageUrl = json['image_url'];
		inventory = json['inventory'];
		isFavourite = json['is_favourite'];
		cart = json['cart'];
		if (json['variants'] != null) {
			variants = <Variants>[];
			json['variants'].forEach((v) { variants!.add(Variants.fromJson(v)); });
		}
		if (json['images'] != null) {
			images = <ProductImages>[];
			json['images'].forEach((v) { images!.add(ProductImages.fromJson(v)); });
		}
relatedProducts = <ProductModel>[];
    if (json['related']!=null) {
      relatedProducts = <ProductModel>[];
			json['related'].forEach((v) { relatedProducts!.add(ProductModel.fromJson(v)); });
    }
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = <String, dynamic>{};
		data['id'] = id;
		data['ar_name'] = arName;
		data['en_name'] = enName;
		data['price'] = price;
		data['desc'] = desc;
		data['image_url'] = imageUrl;
		data['inventory'] = inventory;
		data['is_favourite'] = isFavourite;
		if (cart != null) {
      data['cart'] = cart??{};
    }
		if (variants != null) {
      data['variants'] = variants!.map((v) => v.toJson()).toList();
    }
		if (images != null) {
      data['images'] = images!.map((v) => v.toJson()).toList();
    }
		return data;
	}
}



class Variants {
	int? id;
	int? productId;
	String? sku;
	double? price;
	int? stock;
	List<Attributes>? attributes;

	Variants({this.id, this.productId, this.sku, this.price, this.stock, this.attributes});

	Variants.fromJson(Map<String, dynamic> json) {
		id = json['id'];
		productId = json['productId'];
		sku = json['sku'];
		price = json['price'];
		stock = json['stock'];
		if (json['attributes'] != null) {
			attributes = <Attributes>[];
			json['attributes'].forEach((v) { attributes!.add(Attributes.fromJson(v)); });
		}
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = <String, dynamic>{};
		data['id'] = id;
		data['productId'] = productId;
		data['sku'] = sku;
		data['price'] = price;
		data['stock'] = stock;
		if (attributes != null) {
      data['attributes'] = attributes!.map((v) => v.toJson()).toList();
    }
		return data;
	}
}

class Attributes {
	int? id;
	String? attributeName;
	String? value;

	Attributes({this.id, this.attributeName, this.value});

	Attributes.fromJson(Map<String, dynamic> json) {
		id = json['id'];
		attributeName = json['attributeName'];
		value = json['value'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = <String, dynamic>{};
		data['id'] = id;
		data['attributeName'] = attributeName;
		data['value'] = value;
		return data;
	}
}

class ProductImages {
	dynamic id;
	dynamic imageUrl;
dynamic isPrimary;

	ProductImages({this.id, this.imageUrl, this.isPrimary});

	ProductImages.fromJson(Map<String, dynamic> json) {
		id = json['id'];
		imageUrl = json['image_url'];
		isPrimary = json['is_primary'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = <String, dynamic>{};
		data['id'] = id;
		data['image_url'] = imageUrl;
		data['is_primary'] = isPrimary;
		return data;
	}
}
