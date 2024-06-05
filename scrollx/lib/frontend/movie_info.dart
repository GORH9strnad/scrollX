import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scrollx/frontend/scrolling.dart';
import 'package:scrollx/frontend/widgets/video_player_widget.dart';
import 'package:scrollx/logic/episode.dart';
import 'package:scrollx/logic/movie.dart';
import '../backend/backend_connector.dart';
import '../logic/serie.dart';

class MovieInfo extends StatefulWidget {
  final Movie movie;

  const MovieInfo({Key? key, required this.movie}) : super(key: key);

  @override
  State<MovieInfo> createState() => _MovieInfoState();
}

class _MovieInfoState extends State<MovieInfo> {
  BackendConnector _backendConnector = BackendConnector.instance;

  Future<List> _getSeries() async {
    List series = await _backendConnector.getSeriesOfMovie(widget.movie.id);
    return series;
  }

  Future<List> _getEpisodes(int id) async {
    List episodes = await _backendConnector.getEpisodesOfSerie(id);
    return episodes;
  }

  String? dropdownValue;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.movie.name),
      contentPadding: EdgeInsets.all(10),
      content: Container(
        child: FutureBuilder<List>(
          future: _getSeries(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              List<String> seriesDropDown = [];
              List<Serie> series = [];
              if (snapshot.data != null) {
                for (Serie serie in snapshot.data!) {
                  seriesDropDown.add("Series " + serie.order.toString());
                  series.add(serie);
                }
              }
              if (seriesDropDown.isNotEmpty) {
                dropdownValue ??= seriesDropDown[0];
              }
              return Container(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        width: 300,
                        height: 150,
                        child: VideoPlayerWidget(url: series[int.parse(dropdownValue!.substring(dropdownValue!.length - 1, dropdownValue!.length)) - 1].videoUrl),
                      ),
                      Container(
                          margin: EdgeInsets.all(10),
                          child: Text(widget.movie.description)),
                      Container(
                        child: ElevatedButton(
                          style: ButtonStyle(
                              padding: MaterialStateProperty.all(
                                  EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 50))),
                          child: Text(
                            "Continue watching",
                            style: TextStyle(fontSize: 16),
                          ),
                          onPressed: () {},
                        ),
                      ),
                      Container(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: DropdownButton<String>(
                            value: dropdownValue,
                            icon: const Icon(Icons.expand_circle_down),
                            iconSize: 24,
                            elevation: 16,
                            style: const TextStyle(color: Colors.deepPurple),
                            underline: Container(
                              height: 2,
                              color: Colors.deepPurpleAccent,
                            ),
                            onChanged: (String? newValue) {
                              setState(() {
                                dropdownValue = newValue;
                              });
                            },
                            items: seriesDropDown
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      FutureBuilder<List>(
                          future: _getEpisodes(snapshot.data![int.parse(dropdownValue!.substring(dropdownValue!.length - 1, dropdownValue!.length)) - 1].id),
                          builder: (context, snapshot2) {
                            if (snapshot2.connectionState ==
                                ConnectionState.done) {
                              if (snapshot2.hasData) {
                                List<String> descriptions = [];
                                for (Episode episode in snapshot2.data!) {
                                  descriptions.add(episode.description);
                                }
                                return Column(
                                  children: [
                                    for (int i = 0; i < descriptions.length; i++)
                                      Container(
                                        child: GestureDetector(
                                          onTap: () {
                                            Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => Scrolling(
                                                  episode: snapshot2.data![i],
                                                )
                                              )
                                            );
                                          },
                                          child: Container(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Container(
                                                  child: Text(
                                                    (i + 1).toString() + ")",
                                                    style: TextStyle(fontSize: 18),
                                                  ),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.all(10),
                                                  width: 99,
                                                  height: 70,
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      image: NetworkImage(snapshot2.data![i].imgUrl),
                                                      fit: BoxFit.cover
                                                    )
                                                  ),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.all(7),
                                                  width: 125,
                                                  height: 70,
                                                  child: SingleChildScrollView(
                                                    child: Text(
                                                      softWrap: true,
                                                      descriptions[i],
                                                      style:
                                                          TextStyle(fontSize: 12),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                  ],
                                );
                              }
                              return Center(
                                  child: Text(
                                      'No data'));
                            } else if (snapshot2.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                  child:
                                      CircularProgressIndicator()); // returns during loading
                            } else {
                              return Center(
                                  child: Text(
                                      'Failed to load series')); // returns when error
                            }
                          })
                    ],
                  ),
                ),
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else {
              return Center(child: Text('Failed to load series'));
            }
          },
        ),
      ),
      actions: <Widget>[
        ElevatedButton(
          child: Text("Close"),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
