import 'package:flutter/material.dart';
import 'package:scrollx/backend/backend_connector.dart';
import 'package:scrollx/frontend/widgets/video_player_widget.dart';
import 'package:scrollx/logic/scroll.dart';
import '../logic/episode.dart';

class Scrolling extends StatefulWidget {
  final Episode episode;

  const Scrolling({Key? key, required this.episode}) : super(key: key);

  @override
  State<Scrolling> createState() => _ScrollingState();
}

class _ScrollingState extends State<Scrolling> {
  final _controller = PageController();

  BackendConnector _backendConnector = BackendConnector.instance;

  Future<List> _getScrolls() async {
    List scrolls = await _backendConnector.getScrollsOfEpisode(widget.episode.id);
    return scrolls;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
          future: _getScrolls(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                List<Scroll> scrolls = [];
                for (Scroll scroll in snapshot.data!) {
                  scrolls.add(scroll);
                }
                return PageView(
                  controller: _controller,
                  scrollDirection: Axis.vertical,
                  children: [
                    for (int i = 0; i < snapshot.data!.length; i++)
                      Scaffold(
                        body: Align(
                          alignment: Alignment.bottomCenter,
                          child: VideoPlayerWidget(
                            url: scrolls[i].scrollUrl,
                          ),
                        ),
                      )
                  ],
                );
              } else {
                return Center(child: Text('No data'));
              }
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else {
              return Center(child: Text('Failed to load series'));
            }
            },
        ));
  }
}
