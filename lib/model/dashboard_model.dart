import 'package:smartpay/model/network_response.dart';

class DashboardResModel extends EmptyResponse {
  bool? status;
  String? message;
  UserData? data;

  DashboardResModel({this.status, this.message, this.data});

  DashboardResModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new UserData.fromJson(json['data']) : null;
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

class UserData extends EmptyResponse  {
  String? secret;

  UserData({this.secret});

  UserData.fromJson(Map<String, dynamic> json) {
    secret = json['secret'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['secret'] = secret;
    return data;
  }
}
