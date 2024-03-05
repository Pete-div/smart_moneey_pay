import 'package:smartpay/model/network_response.dart';

class LoginRespModel extends  EmptyResponse {
  bool? status;
  String? message;
  Data? data;

  LoginRespModel({this.status, this.message, this.data});

  LoginRespModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data extends  EmptyResponse{
  User? user;
  String? token;

  Data({this.user, this.token});

  Data.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['token'] = token;
    return data;
  }
}

class User extends  EmptyResponse{
  String? id;
  String? fullName;
  String? username;
  String? email;
  String? phone;
  String? phoneCountry;
  String? country;
  String? avatar;

  User(
      {this.id,
      this.fullName,
      this.username,
      this.email,
      this.phone,
      this.phoneCountry,
      this.country,
      this.avatar});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['full_name'];
    username = json['username'];
    email = json['email'];
    phone = json['phone'];
    phoneCountry = json['phone_country'];
    country = json['country'];
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['full_name'] = fullName;
    data['username'] = username;
    data['email'] = email;
    data['phone'] = phone;
    data['phone_country'] = phoneCountry;
    data['country'] = country;
    data['avatar'] = avatar;
    return data;
  }
}
