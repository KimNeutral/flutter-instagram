import 'package:dart_json_mapper/annotations.dart';
import 'package:dgsw_sns/model/models.dart';


@jsonSerializable
class ArticleUpdateData {
  int status;
  String message;
  Article data;

  ArticleUpdateData({this.status, this.message, this.data});

  @override
  String toString() {
    return 'ArticleUpdateData{status: $status, message: $message, data: $data}';
  }


}