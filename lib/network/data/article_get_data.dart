import 'package:dart_json_mapper/annotations.dart';
import 'package:dgsw_sns/model/models.dart';


@jsonSerializable
class ArticleGetData {
  int status;
  String message;
  List<Article> data;

  ArticleGetData({this.status, this.message, this.data});

  @override
  String toString() {
    return 'ArticleGetData{status: $status, message: $message, data: $data}';
  }


}