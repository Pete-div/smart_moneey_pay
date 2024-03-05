import 'package:smartpay/model/network_response.dart';

class VerifyEmailRespModel extends EmptyResponse{
  bool? status;
  String? message;
  UserEmail? data;

  VerifyEmailRespModel({this.status, this.message, this.data});

  VerifyEmailRespModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new UserEmail.fromJson(json['data']) : null;
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

class UserEmail extends EmptyResponse{
  String? email;

  UserEmail({this.email});

  UserEmail.fromJson(Map<String, dynamic> json) {
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = email;
    return data;
  }
}
