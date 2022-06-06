/// success : true
/// response : "52|4VvMNumiHve0vlkRXlUQ1ZIYHtScRmG84WF8AL3T"
/// message : "user authenticate successfully"
/// data : {"id":11,"role_id":2,"name":"mysample4","email":"mysample4@mysample.com","avatar":"users/default.png","mobile":"1234567800","email_verified_at":null,"mobile_verified_at":null,"address":"mysample address","status":"1","settings":[],"created_at":"2022-04-15T22:47:25.000000Z","updated_at":"2022-04-16T01:23:21.000000Z"}

class UserLogIn {
  UserLogIn(
    this.success,
    this.response,
    this.message,
    this.data,
  );

  UserLogIn.fromJson(dynamic json) {
    success = json['success'];
    response = json['response'];
    message = json['message'];
    data = (json['data'] != null ? Data.fromJson(json['data']) : null)!;
  }
  late bool success;
  late String response;
  late String message;
  late Data data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['response'] = response;
    map['message'] = message;
    if (data != null) {
      map['data'] = data.toJson();
    }
    return map;
  }
}

/// id : 11
/// role_id : 2
/// name : "mysample4"
/// email : "mysample4@mysample.com"
/// avatar : "users/default.png"
/// mobile : "1234567800"
/// email_verified_at : null
/// mobile_verified_at : null
/// address : "mysample address"
/// status : "1"
/// settings : []
/// created_at : "2022-04-15T22:47:25.000000Z"
/// updated_at : "2022-04-16T01:23:21.000000Z"

class Data {
  Data(
    this.id,
    this.roleId,
    this.name,
    this.email,
    this.avatar,
    this.mobile,
    this.emailVerifiedAt,
    this.mobileVerifiedAt,
    this.address,
    this.status,
    this.createdAt,
    this.updatedAt,
  );

  Data.fromJson(dynamic json) {
    id = json['id'];
    roleId = json['role_id'];
    name = json['name'];
    email = json['email'];
    avatar = json['avatar'];
    mobile = json['mobile'];
    emailVerifiedAt = json['email_verified_at'];
    mobileVerifiedAt = json['mobile_verified_at'];
    address = json['address'];
    status = json['status'];

    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  late int id;
  late int roleId;
  late String name;
  late String email;
  late String avatar;
  late String mobile;
  late dynamic emailVerifiedAt;
  late dynamic mobileVerifiedAt;
  late String address;
  late String status;

  late String createdAt;
  late String updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['role_id'] = roleId;
    map['name'] = name;
    map['email'] = email;
    map['avatar'] = avatar;
    map['mobile'] = mobile;
    map['email_verified_at'] = emailVerifiedAt;
    map['mobile_verified_at'] = mobileVerifiedAt;
    map['address'] = address;
    map['status'] = status;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }
}
