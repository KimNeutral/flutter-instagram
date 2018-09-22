import 'package:dart_json_mapper/annotations.dart';

@jsonSerializable
class Member {
  String id;
  String pw;
  String name;
  String nickname;
  String webSite;
  String bio;
  String email;
  String mobile;
  String profileImage;

  @JsonProperty(ignore: true)
  List<Member> followers;

  @JsonProperty(ignore: true)
  List<Member> following;


  Member({this.id, this.pw, this.name, this.nickname, this.webSite, this.bio,
      this.email, this.mobile, this.profileImage});

  bool get isStoryRemain {

  }

  @override
  String toString() {
    return 'Member{id: $id, pw: $pw, name: $name, nickname: $nickname, webSite: $webSite, bio: $bio, email: $email, mobile: $mobile, profileImage: $profileImage, followers: $followers, following: $following}';
  }
}