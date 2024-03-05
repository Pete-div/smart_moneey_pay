// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

class EmptyResponse extends Equatable {
  @override
  List<Object?> get props => [];
}

class SuccessResponse extends EmptyResponse {
  bool? success;
  String? message;

  SuccessResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    return data;
  }
}

class ErrorResponse extends EmptyResponse {
  bool? success;
  String? message;
  String? error;

  ErrorResponse({this.success, this.message, this.error});

  ErrorResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    data['error'] = error;
    return data;
  }
}
