import 'package:flutter/material.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:tiktok/bloc/feed_bloc.dart';
import 'package:tiktok/elements/error_element.dart';
import 'package:tiktok/elements/loader.dart';
import 'package:tiktok/model/feed_model.dart';
import 'package:tiktok/model/feed_response.dart';
import 'package:video_player/video_player.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    feedBloc.getFeeds();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<FeedResponse>(
      stream: feedBloc.subject.stream,
      builder: (context, AsyncSnapshot<FeedResponse> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.error != "" && snapshot.data!.error.isNotEmpty) {
            return buildErrorWidget(snapshot.data!.error);
          }
          return _buildFeedWidget(snapshot.data!);
        } else if (snapshot.hasError) {
          return buildErrorWidget("Error");
        } else {
          return buildLoadingWidget();
        }
      },
    ));
  }

  Widget _buildFeedWidget(FeedResponse data) {
    List<FeedModel> feeds = data.feeds;
    return PageView.builder(
        scrollDirection: Axis.vertical,
        itemCount: feeds.length,
        itemBuilder: (context, index) {
          return SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: [
                VideoWidget(url: feeds[index].videos[0].link),
                Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.black,
                        Colors.transparent,
                        Colors.transparent,
                        Colors.black.withOpacity(0.15)
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: const [0, 0, 0.6, 1],
                    ),
                  ),
                ),
                Positioned(
                  left: 12.0,
                  bottom: 32.0,
                  child: SafeArea(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "@" + feeds[index].user.name,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                                color: Colors.white),
                          ),
                          const SizedBox(
                            width: 5.0,
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 12.0,
                      ),
                      Text(
                        feeds[index].user.url,
                        style: const TextStyle(color: Colors.white),
                      )
                    ],
                  )),
                ),
                Positioned(
                    right: 12.0,
                    bottom: 50.0,
                    child: Column(
                      children: [
                        Container(
                          height: 40.0,
                          width: 40.0,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(width: 1.0, color: Colors.white),
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: NetworkImage(feeds[index].image),
                                  fit: BoxFit.cover)),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(EvaIcons.heart,
                                size: 35.0, color: Colors.white)),
                        const SizedBox(
                          height: 10.0,
                        ),
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(EvaIcons.messageCircle,
                                size: 35.0, color: Colors.white)),
                        const SizedBox(
                          height: 10.0,
                        ),
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(EvaIcons.undo,
                                size: 35.0, color: Colors.white))
                      ],
                    ))
              ],
            ),
          );
        });
  }
}

class VideoWidget extends StatefulWidget {
  final String url;

  const VideoWidget({Key? key, required this.url}) : super(key: key);

  @override
  _VideoWidgetState createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  late VideoPlayerController videoPlayerController;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    videoPlayerController = VideoPlayerController.network(widget.url);

    _initializeVideoPlayerFuture = videoPlayerController.initialize().then((_) {
      setState(() {});
    });
    videoPlayerController.setLooping(true);
    videoPlayerController.play();
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializeVideoPlayerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return videoPlayerController.value.isInitialized
              ? SizedBox.expand(
                  child: FittedBox(
                    fit: BoxFit.cover,
                    child: SizedBox(
                      width: videoPlayerController.value.size.width,
                      height: videoPlayerController.value.size.height,
                      child: VideoPlayer(videoPlayerController),
                    ),
                  ),
                )
              : Container();
        } else {
          return Container();
        }
      },
    );
  }
}
