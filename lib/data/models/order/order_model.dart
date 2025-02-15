import 'dart:developer';

class OrderModel {
  int? id;
  int? userId;
  double? total_amount;
  DateTime? createdAt;
    DateTime? updatedAt;


  OrderModel(
      {this.id,
      this.userId,
      this.total_amount,
      this.createdAt,
      this.updatedAt,
      }
      );

  OrderModel.fromJson(Map<String, dynamic> json) {
  log(json.toString());

    id =int.parse( json['id']);
    userId =int.parse( json['user_id']);
    total_amount = double.parse(json['total_amount']);
    createdAt = DateTime.parse(json['created_at']);
    // updatedAt = DateTime.parse(json['updated_at']);
       


  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['total_amount'] = total_amount;
    
    return data;
  }
}
