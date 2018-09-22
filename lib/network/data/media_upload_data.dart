import 'package:dart_json_mapper/annotations.dart';
import 'package:dgsw_sns/model/media.dart';

@jsonSerializable
class MediaUploadData {
  int status;
  String message;
  Media data;

  MediaUploadData({this.status, this.message, this.data});

  @override
  String toString() {
    return 'MediaUploadData{status: $status, message: $message, data: $data}';
  }
}