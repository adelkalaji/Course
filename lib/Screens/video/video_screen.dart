// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:flutter_application_3/config/config.dart';
import 'package:flutter_application_3/controller/video.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: use_key_in_widget_constructors
class VideoListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(VideosApiController.Videos.elementAt(0).videoName!),
      ),
      body: ListView(
        children: <Widget>[
          VideoListItem(
              videoUrl:
                  'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4'),
          VideoListItem(
              videoUrl:
                  'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4'),
          VideoListItem(
              videoUrl:
                  'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4'),
        ],
      ),
    );
  }
}

class VideoListItem extends StatelessWidget {
  final String videoUrl;

  // ignore: use_key_in_widget_constructors
  VideoListItem({required this.videoUrl});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text('Video Title'),
      onTap: () {
        launchUrl(Uri.http(Config.localhost, 'uploads/mm.mp4'));
      },
    );
  }
}

class VideoScreen extends StatelessWidget {
  final String videoUrl;

  // ignore: use_key_in_widget_constructors
  VideoScreen({required this.videoUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // ignore: prefer_interpolation_to_compose_strings
        title: Text(Config.image + "mm.mp4"),
      ),
      body: Column(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 16 / 9, // Set the aspect ratio according to your video
            child: VideoPlayer("${Config.image}mm.mp4"),
          ),
          CommentSection(),
        ],
      ),
    );
  }
}

class VideoPlayer extends StatelessWidget {
  final String videoUrl;

  // ignore: use_key_in_widget_constructors
  VideoPlayer(this.videoUrl);

  @override
  Widget build(BuildContext context) {
    // Implement the video player widget here using a package like chewie or video_player
    return Container(
      color: Colors.grey, // Placeholder for the video player
    );
  }
}

// ignore: use_key_in_widget_constructors
class CommentSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: <Widget>[
          CommentItem(comment: 'This is a great video!'),
          CommentItem(comment: 'I love it!'),
          // Add more comments here
        ],
      ),
    );
  }
}

class CommentItem extends StatelessWidget {
  final String comment;

  // ignore: use_key_in_widget_constructors
  CommentItem({required this.comment});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(comment),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              // Implement edit comment functionality
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              // Implement delete comment functionality
            },
          ),
        ],
      ),
    );
  }
}
