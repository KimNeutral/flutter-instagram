import 'package:dart_json_mapper/annotations.dart';
import 'package:dgsw_sns/model/models.dart';


@jsonSerializable
class ArticlePostData {
  int status;
  String message;
  Article data;

  ArticlePostData({this.status, this.message, this.data});

  @override
  String toString() {
    return 'ArticlePostData{status: $status, message: $message, data: $data}';
  }


}