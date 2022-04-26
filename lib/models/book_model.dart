class BookModel {
  final int id;
  final int categorySubjectId;
  final int classId;
  final String name;
  final int bookNumber;
  final int pageNumber;
  final int publishingYear;
  final int publishingHouseId;
  final String author;
  final double price;
  final double? sailPrice;
  final String image;
  final String? createdAt;
  final String? updatedAt;
  final String description;
  final int popularityCoefficient;

  factory BookModel.fromJson(dynamic json) {
    return BookModel(
      id: json["id"] as int,
      categorySubjectId: json["subject_id"] as int,
      classId: json["class_id"] as int,
      name: json["name"] as String,
      bookNumber: json["book_number"] as int,
      pageNumber: json["page_number"] as int,
      publishingYear: json["publishing_year"] as int,
      publishingHouseId: json["publishing_house_id"] as int,
      author: json["author"] as String,
      price: json["price"].toDouble(),
      sailPrice: json["sail_price"] == null || json["sail_price"] == 'null'
          ? null
          : json["sail_price"].toDouble(),
      image: json["image"] as String,
      createdAt: json["created_at"],
      updatedAt: json["updated_at"],
      description: json["description"] as String,
      popularityCoefficient: json["popularity_coefficient"] as int,
    );
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["subject_id"] = categorySubjectId;
    data["class_id"] = classId;
    data["name"] = name;
    data["book_number"] = bookNumber;
    data["page_number"] = pageNumber;
    data["publishing_year"] = publishingYear;
    data["publishing_house_id"] = publishingHouseId;
    data["author"] = author;
    data["price"] = price;
    data["sail_price"] = sailPrice;
    data["image"] = image;
    data["created_at"] = createdAt;
    data["updated_at"] = updatedAt;
    data["description"] = description;
    data["popularity_coefficient"] = popularityCoefficient;
    return data;
  }

  BookModel copyWith({
    int? id,
    int? categorySubjectId,
    int? classId,
    String? name,
    int? bookNumber,
    int? pageNumber,
    int? publishingYear,
    int? publishingHouseId,
    String? author,
    double? price,
    double? sailPrice,
    String? image,
    String? createdAt,
    String? updatedAt,
    String? description,
    int? popularityCoefficient,
  }) {
    return BookModel(
      id: id ?? this.id,
      categorySubjectId: categorySubjectId ?? this.categorySubjectId,
      classId: classId ?? this.classId,
      name: name ?? this.name,
      bookNumber: bookNumber ?? this.bookNumber,
      pageNumber: pageNumber ?? this.pageNumber,
      publishingYear: publishingYear ?? this.publishingYear,
      publishingHouseId: publishingHouseId ?? this.publishingHouseId,
      author: author ?? this.author,
      price: price ?? this.price,
      sailPrice: sailPrice ?? this.sailPrice,
      image: image ?? this.image,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      description: description ?? this.description,
      popularityCoefficient:
          popularityCoefficient ?? this.popularityCoefficient,
    );
  }

  @override
  // ignore: override_on_non_overriding_member
  List<Object?> get props => [
        id,
        categorySubjectId,
        classId,
        name,
        bookNumber,
        pageNumber,
        publishingYear,
        publishingHouseId,
        author,
        price,
        sailPrice,
        image,
        createdAt,
        updatedAt,
        description,
        popularityCoefficient
      ];

  const BookModel({
    required this.id,
    required this.categorySubjectId,
    required this.classId,
    required this.name,
    required this.bookNumber,
    required this.pageNumber,
    required this.publishingYear,
    required this.publishingHouseId,
    required this.author,
    required this.price,
    required this.sailPrice,
    required this.image,
    this.createdAt,
    this.updatedAt,
    required this.description,
    required this.popularityCoefficient,
  });
}
