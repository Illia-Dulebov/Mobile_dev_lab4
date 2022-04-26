class OrderModel{
  final int id;
  final String orderDate;
  final int userId;
  final String orderStatus;
  final String? createdAt;
  final double? sum;
  final String? updatedAt;


  OrderModel({
    required this.id,
    required this.orderDate,
    required this.userId,
    required this.orderStatus,
    this.createdAt,
    this.sum,
    this.updatedAt,
  });


  factory OrderModel.fromJson(dynamic json) {
    return OrderModel(
      id: json["id"] as int,
      orderDate: json["order_date"],
      userId: json["user_id"] as int,
      orderStatus: json["order_status"],
      createdAt: json["created_at"],
      updatedAt: json["updated_at"],
      sum: json["sum"].toDouble(),
    );
  }


OrderModel copyWith({
  int? id,
  String? orderDate,
  int? userId,
  String? orderStatus,
  String? createdAt,
  String? updatedAt,
  }) {
    return OrderModel(
      id: id ?? this.id,
      orderDate: orderDate ?? this.orderDate,
      userId: userId ?? this.userId,
      orderStatus: orderStatus ?? this.orderStatus,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

}