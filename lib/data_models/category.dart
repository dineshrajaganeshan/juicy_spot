class Category {
  late int id;
  late int order;
  late String name;

  Category(
    this.id,
    this.order,
    this.name,
  );

  Category.fromJson(dynamic json) {
    id = json["id"];
    order = json["order"];
    name = json["name"];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map["id"] = id;
    map["order"] = order;
    map["name"] = name;
    return map;
  }
}
