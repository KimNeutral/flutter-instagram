import 'package:dgsw_sns/model/member.dart';

enum MediaType {
  PHOTO, VIDEO
}

class Media {
  int idx;
  MediaType type;
  Member author;
  String mediaUrl;
}
