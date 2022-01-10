import 'package:dio/dio.dart';
import 'package:tiktok/model/feed_response.dart';

class UserRepository {
  final String apiKey =
      "563492ad6f917000010000014e4c2d1ca31c4dc885a5369653c6f6b4";
  static String mainUrl = "https://api.pexels.com";
  final Dio _dio = Dio();
  var getFeed = '$mainUrl/videos/search';

  Future<FeedResponse> getFeeds() async {
    var params = {
      "api_key": apiKey,
      "language": "en-US",
      "query": "dancing",
      "page": 1,
      "size": "small",
      "orientation ": "portrait"
    };
    try {
      _dio.interceptors
          .add(InterceptorsWrapper(onRequest: (options, handler) async {
        options.headers["Authorization"] = apiKey;
        _dio.interceptors.requestLock.unlock();
        return handler.next(options);
      }));
      Response response = await _dio.get(getFeed, queryParameters: params);
      return FeedResponse.fromJson(response.data);
    } catch (error) {
      return FeedResponse.withError("$error");
    }
  }
}
