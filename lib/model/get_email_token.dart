import 'package:smartpay/model/network_response.dart';

class GetEmailTokenResModel extends EmptyResponse {
  bool? status;
  String? message;
  AuthToken? data;

  GetEmailTokenResModel({this.status, this.message, this.data});

  GetEmailTokenResModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new AuthToken.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class AuthToken extends EmptyResponse {
  String? token;

  AuthToken({this.token});

  AuthToken.fromJson(Map<String, dynamic> json) {
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    return data;
  }
}
