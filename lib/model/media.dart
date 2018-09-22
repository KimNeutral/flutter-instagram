import 'package:dart_json_mapper/annotations.dart';
import 'package:dgsw_sns/model/member.dart';


enum MediaType {
  PHOTO, VIDEO
}

@jsonSerializable
class Media {
  int id;
  int typeId;
  String mediaUrl;

  Media({this.id, this.typeId, this.mediaUrl});

  @override
  String toString() {
    return 'Media{id: $id, typeId: $typeId, mediaUrl: $mediaUrl}';
  }
}
