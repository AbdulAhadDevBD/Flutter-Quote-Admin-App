class QuotesModel {
  int? id;
  int? categoryId;
  String? categoryName;
  String? quoteText;
  String? createdAt;

  QuotesModel({
    this.id,
    this.categoryId,
    this.categoryName,
    this.quoteText,
    this.createdAt,
  });

  QuotesModel.fromJson(Map<String, dynamic> json) {
    id = int.tryParse(json['id'].toString());
    categoryId = int.tryParse(json['category_id'].toString());
    categoryName = json['category_name'];
    quoteText = json['quote_text'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'category_id': categoryId,
      'category_name': categoryName,
      'quote_text': quoteText,
      'created_at': createdAt,
    };
  }
}
