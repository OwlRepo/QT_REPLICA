import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

class videoListItems extends StatefulWidget {
  @override
  _videoListItemsState createState() => _videoListItemsState();
  final VideoPlayerController videoPlayerController;
  final bool looping;

  videoListItems({
    @required this.videoPlayerController,
    this.looping,
    Key key,
  }) : super(key: key);
}

class _videoListItemsState extends State<videoListItems> {
  ChewieController _chewieController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _chewieController = ChewieController(
      videoPlayerController: widget.videoPlayerController,
      aspectRatio: 16 / 9,
      autoInitialize: true,
      autoPlay: true,
      looping: widget.looping,
      showControlsOnInitialize: false,
      showControls: false,
      errorBuilder: (context, message) {
        return Center(
          child: Text('Loading...'),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Chewie(
      controller: _chewieController,
    );
  }

  
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    widget.videoPlayerController.dispose();
    _chewieController.dispose();
  }
}
