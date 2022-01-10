import 'package:tiktok/model/feed_model.dart';

class FeedResponse {
  final List<FeedModel> feeds;
  final String error;

  FeedResponse(this.feeds, this.error);

  FeedResponse.fromJson(Map<String, dynamic> json)
      : feeds =
            (json["videos"] as List).map((i) => FeedModel.fromJson(i)).toList(),
        error = "";

  FeedResponse.withError(String errorValue)
      : feeds = [],
        error = errorValue;
}
