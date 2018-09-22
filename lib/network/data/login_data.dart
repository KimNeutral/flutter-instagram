import 'package:dart_json_mapper/annotations.dart';
import 'package:dgsw_sns/model/member.dart';

@jsonSerializable
class LoginData {
  int status;
  String message;
  Member data;

  LoginData({this.status, this.message, this.data});

  @override
  String toString() {
    return 'LoginData{status: $status, message: $message, data: $data}';
  }
}