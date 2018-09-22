import 'package:dart_json_mapper/annotations.dart';
import 'package:dgsw_sns/model/media.dart';
import 'package:dgsw_sns/model/member.dart';

@jsonSerializable
class Story {
  String id;
  Member member;
  Media media;
  bool isRead;

  Story({this.id, this.member, this.media, this.isRead});
}