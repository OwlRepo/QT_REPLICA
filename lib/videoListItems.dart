import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

class VideoListItems extends StatefulWidget {
  @override
  _VideoListItemsState createState() => _VideoListItemsState();
  final VideoPlayerController videoPlayerController;
  final bool looping;

  VideoListItems({
    @required this.videoPlayerController,
    this.looping,
    Key key,
  }) : super(key: key);
}

class _VideoListItemsState extends State<VideoListItems> {
  ChewieController _chewieController;
  @override
  void initState() {
    // TODO: implement initState
    _chewieController = ChewieController(
      videoPlayerController: widget.videoPlayerController,
      aspectRatio: 16/9,
      autoPlay: true,
      autoInitialize: true,
      looping: widget.looping,
      showControls: false,
      errorBuilder: (context, message) {
        return Center(
          child: Text('Loading...'),
        );
      },
    );

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Chewie(
        controller: _chewieController,
      ),
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
