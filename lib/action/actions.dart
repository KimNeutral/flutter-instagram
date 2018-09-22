export 'article_action.dart';
export 'story_action.dart';

import 'package:dgsw_sns/model/models.dart';

class LoadMemberAction {
  final Member member;

  LoadMemberAction(this.member);

  @override
  String toString() {
    return 'LoadMemberAction{member: $member}';
  }
}

class LoadMemberFailedAction {}

