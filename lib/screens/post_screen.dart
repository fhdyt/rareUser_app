import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class PostScreen extends StatefulWidget {
  final String url;
  static const routeName = '/post-screen';
  const PostScreen({required this.url, super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  late VideoPlayerController _controller;
  ChewieController? _chewieController;

  @override
  void initState() {
    super.initState();
    _initPlayer();
  }

  Future<void> _initPlayer() async {
    _controller = VideoPlayerController.network(widget.url);
    await _controller.initialize();
    _createChewieController();
    setState(() {});
    // _chewieController = ChewieController(
    //   videoPlayerController: _controller,
    //   aspectRatio: _controller.value.aspectRatio,
    //   autoInitialize: true,
    //   autoPlay: true,
    //   looping: true,
    //   errorBuilder: (context, errorMessage) {
    //     return Center(
    //       child: Text(
    //         errorMessage,
    //         style: TextStyle(color: Colors.white),
    //       ),
    //     );
    //   },
    // );
  }

  void _createChewieController() {
    _chewieController = ChewieController(
      videoPlayerController: _controller,
      aspectRatio: _controller.value.aspectRatio,
      autoInitialize: true,
      autoPlay: true,
      looping: true,
      errorBuilder: (context, errorMessage) {
        return Center(
          child: Text(
            errorMessage,
            style: TextStyle(color: Colors.white),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff1A1A1A),
        appBar: AppBar(
          backgroundColor: Color(0xff1A1A1A),
          elevation: 0,
          iconTheme: IconThemeData(
            color: Color(0xfff7f7f7),
          ),
        ),
        body: _chewieController != null
            ? Container(
                child: Chewie(
                  controller: _chewieController!,
                ),
              )
            : Center(
                child: CircularProgressIndicator(
                  color: Color(0xfff7f7f7),
                ),
              ));
  }
}
