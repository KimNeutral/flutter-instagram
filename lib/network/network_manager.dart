import 'dart:async';
import 'dart:collection';
import 'dart:io';
import 'package:dgsw_sns/model/models.dart';
import 'package:dgsw_sns/network/data/datas.dart';
import 'package:dio/dio.dart';
import 'package:dart_json_mapper/json_mapper.dart';
import 'dart:convert';
import 'package:path/path.dart';

class NetworkManager {
  static const String $BASE_URL = "http://10.80.161.206:8080";

  final Options _opt = Options(
    baseUrl: $BASE_URL
  );

  Dio _createClient() => Dio(_opt);

  Future<LoginData> login(String id, String pw) async {
    var response = await _createClient().post("/auth/login", data: '{"id": "$id", "pw": "$pw"}');
    var jsonStr = json.encode(response.data);
    print(jsonStr);

    LoginData data = JsonMapper.deserialize<LoginData>(jsonStr);
    return data;
  }

  Future<Article> getArticle(String id) async {

  }

  Future<ArticlePostData> postArticle(Article article) async {
    var articleJson = JsonMapper.serialize(article);

    var response = await _createClient().post("/articles", data: articleJson);
    var jsonStr = json.encode(response.data);
    print(jsonStr);

    ArticlePostData data = JsonMapper.deserialize<ArticlePostData>(jsonStr);
    return data;
  }

  Future<ArticleUpdateData> updateArticle(Article article) async {
    var articleJson = JsonMapper.serialize(article);

    var response = await _createClient().put("/articles", data: articleJson);
    var jsonStr = json.encode(response.data);
    print(jsonStr);

    ArticleUpdateData data = JsonMapper.deserialize<ArticleUpdateData>(jsonStr);
    return data;
  }

  Future<ArticleDeleteData> deleteArticle(String id) async {
    var response = await _createClient().delete("/articles/$id");
    var jsonStr = json.encode(response.data);
    print(jsonStr);

    ArticleDeleteData data = JsonMapper.deserialize<ArticleDeleteData>(jsonStr);
    return data;
  }

  Future<ArticleUpdateData> likeArticle(String articleId, String memberId, bool doLike) async {
    var response = await _createClient().put("/articles/$articleId/favorite?memberId=$memberId&doLike=$doLike");
    var jsonStr = json.encode(response.data);
    print(jsonStr);

    ArticleUpdateData data = JsonMapper.deserialize<ArticleUpdateData>(jsonStr);
    return data;
  }

  Future<ArticleGetData> getArticles() async {
    Response<Map<String, dynamic>> response = await _createClient().get("/articles");
    var jsonStr = json.encode(response.data);
    print(jsonStr);

    ArticleGetData data = JsonMapper.deserialize<ArticleGetData>(jsonStr);

    return data;
  }

  Future<MediaUploadData> uploadImage(File image) async {
    var formData = FormData.from({
      'file1': new UploadFileInfo(image, basename(image.path))
    });
    var response = await _createClient().post("/media/upload", data: formData);
    var jsonStr = json.encode(response.data);
    print(jsonStr);

    MediaUploadData data = JsonMapper.deserialize<MediaUploadData>(jsonStr);
    return data;
  }
}