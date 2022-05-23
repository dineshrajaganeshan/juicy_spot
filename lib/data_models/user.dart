class User {
  late String mobileNo;
  late String mailId;
  late String address;
  late String name;
  late String? imagePath;

  User(
    this.mobileNo,
    this.name,
    this.mailId,
    this.address,
    this.imagePath,
  );

  User.fromJson(dynamic json) {
    mobileNo = json["mobile"];
    name = json["name"];
    mailId = json["email"];
    address = json["address"];
    imagePath = json["avatar"];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map["mobile"] = mobileNo;
    map["name"] = name;
    map["email"] = mailId;
    map["address"] = address;
    map["avatar"] = imagePath;
    return map;
  }
}
