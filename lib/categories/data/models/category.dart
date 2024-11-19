import 'dart:developer';

class Category {
  final String id;
  final String nameAr;
   final String nameEn;

  Category({required this.id, 
 required this.nameAr,
  required this.nameEn,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    log(json.toString());
    return Category(
      id: json['id'].toString(),
      nameAr: json['ar_name'],
      nameEn: json['en_name'],
    );
  }
}