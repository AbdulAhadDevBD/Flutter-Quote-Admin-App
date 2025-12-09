class MonishiModel {
  int? id;
  String? name;
  String? image;
  String? createdAt;

  MonishiModel({this.id, this.name, this.image, this.createdAt});

  factory MonishiModel.fromJson(Map<String, dynamic> json) {
    return MonishiModel(
      id: int.tryParse(json['id'].toString()),
      name: json['name'] as String?,
      image: json['image'] as String?,
      createdAt: json['created_at'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "image": image,
      "created_at": createdAt,
    };
  }
}
