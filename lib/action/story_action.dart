import 'package:dgsw_sns/model/story.dart';

class LoadStoriesAction {
  final List<Story> stories;

  LoadStoriesAction(this.stories);

  @override
  String toString() {
    return 'LoadStoriesAction{stories: $stories}';
  }
}

class LoadStoriesFailedAction {}

class AddStoryAction {
  final Story story;

  AddStoryAction(this.story);

  @override
  String toString() {
    return 'AddStoryAction{story: $story}';
  }
}

class UpdateStoryAction {
  final String id;
  final Story updatedStory;

  UpdateStoryAction(this.id, this.updatedStory);

  @override
  String toString() {
    return 'UpdateStoryAction{id: $id, updatedStory: $updatedStory}';
  }
}

class DeleteStoryAction {
  final String id;

  DeleteStoryAction(this.id);

  @override
  String toString() {
    return 'DeleteStoryAction{id: $id}';
  }
}