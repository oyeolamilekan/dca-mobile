class Plan {
  late String id;
  late String user;
  late Market market;
  late String name;
  late String amount;
  late bool isActive;
  late String schedule;
  late String createdAt;
  late String updatedAt;
  late int iV;

  Plan(
      {required this.id,
      required this.user,
      required this.market,
      required this.name,
      required this.amount,
      required this.isActive,
      required this.schedule,
      required this.createdAt,
      required this.updatedAt,
      required this.iV});

  Plan.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    user = json['user'];
    market = Market.fromJson(json['market']);
    name = json['name'];
    amount = json['amount'].toString();
    isActive = json['isActive'];
    schedule = json['schedule'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['user'] = user;
    data['market'] = market.toJson();
    data['name'] = name;
    data['amount'] = amount;
    data['isActive'] = isActive;
    data['schedule'] = schedule;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }

  static List<Plan> resolveList(List<dynamic>? data) {
    if (data == null) return [];
    final items = data.map((item) => Plan.fromJson(item));
    return List<Plan>.from(items);
  }
}

class Market {
  late String id;
  late String name;
  late String baseUnit;
  late String quoteUnit;
  late String createdAt;
  late String updatedAt;
  late int iV;

  Market(
      {required this.id,
      required this.name,
      required this.baseUnit,
      required this.quoteUnit,
      required this.createdAt,
      required this.updatedAt,
      required this.iV});

  Market.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
    baseUnit = json['base_unit'];
    quoteUnit = json['quote_unit'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['name'] = name;
    data['base_unit'] = baseUnit;
    data['quote_unit'] = quoteUnit;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}
