import 'package:dart_json_mapper/annotations.dart';

@jsonSerializable
class ArticleDeleteData {
  int status;
  String message;

  ArticleDeleteData({this.status, this.message});

  @override
  String toString() {
    return 'ArticleDeleteData{status: $status, message: $message}';
  }
}