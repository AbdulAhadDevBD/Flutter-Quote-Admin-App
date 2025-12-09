class MonishiQuoteModel {
  List<Quotes>? quotes;

  MonishiQuoteModel({this.quotes});

  MonishiQuoteModel.fromJson(Map<String, dynamic> json) {
    if (json['quotes'] != null) {
      quotes = <Quotes>[];
      json['quotes'].forEach((v) {
        quotes!.add(new Quotes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.quotes != null) {
      data['quotes'] = this.quotes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Quotes {
  int? id;
  String? monishiId;
  String? monishiName;
  String? quote;
  String? createdAt;

  Quotes(
      {this.id, this.monishiId, this.monishiName, this.quote, this.createdAt});

  Quotes.fromJson(Map<String, dynamic> json) {
    id = int.tryParse(json['id'].toString());
    monishiId = json['monishi_id'];
    monishiName = json['monishi_name'];
    quote = json['quote'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['monishi_id'] = this.monishiId;
    data['monishi_name'] = this.monishiName;
    data['quote'] = this.quote;
    data['created_at'] = this.createdAt;
    return data;
  }
}
