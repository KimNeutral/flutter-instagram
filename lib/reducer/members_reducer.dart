import 'package:dgsw_sns/action/actions.dart';
import 'package:redux/redux.dart';
import 'package:dgsw_sns/model/models.dart';

final membersReducer = combineReducers<Member>([
  TypedReducer<Member, LoadMemberAction>(_loadMember),
  TypedReducer<Member, LoadMemberFailedAction>(_loadMemberFailed),
]);

Member _loadMember(Member state, LoadMemberAction action) {
  state = action.member;
  return state;
}

Member _loadMemberFailed(Member state, LoadMemberFailedAction action) {
  return null;
}