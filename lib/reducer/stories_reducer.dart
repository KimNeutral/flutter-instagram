import 'package:dgsw_sns/action/story_action.dart';
import 'package:redux/redux.dart';
import 'package:dgsw_sns/model/story.dart';

final storiesReducer = combineReducers<List<Story>>([
  TypedReducer<List<Story>, AddStoryAction>(_addStory),
  TypedReducer<List<Story>, UpdateStoryAction>(_updateStory),
  TypedReducer<List<Story>, DeleteStoryAction>(_deleteStory),
  TypedReducer<List<Story>, LoadStoriesAction>(_setLoadedStories),
  TypedReducer<List<Story>, LoadStoriesFailedAction>(_setLoadFailedStories),
]);

List<Story> _addStory(List<Story> state, AddStoryAction action) {
  return List.from(state)..add(action.story);
}

List<Story> _updateStory(List<Story> state, UpdateStoryAction action) {
  return state.map((s) => s.id == action.id ? action.updatedStory : s).toList();
}

List<Story> _deleteStory(List<Story> state, DeleteStoryAction action) {
  return state.where((s) => s.id != action.id).toList();
}

List<Story> _setLoadedStories(List<Story> state, LoadStoriesAction action) {
  return action.stories;
}

List<Story> _setLoadFailedStories(List<Story> state, LoadStoriesFailedAction action) {
  return [];
}