import 'package:dgsw_sns/model/app_state.dart';
import 'package:dgsw_sns/model/models.dart';

List<Article> articlesSelector(AppState state) => state.articles;

Member memberSelector(AppState state) => state.member;