import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:scrollx/frontend/movie_info.dart';
import '../backend/backend_connector.dart';
import 'nav_bar.dart';

class ContinueWatching extends StatefulWidget {
  const ContinueWatching({super.key});

  @override
  State<ContinueWatching> createState() => _ContinueWatchingState();
}

class _ContinueWatchingState extends State<ContinueWatching> {

  BackendConnector _backendConnector = BackendConnector.instance;

  Future<List> _getMovies() async {
    List movies = await _backendConnector.getAllMovies();
    return movies;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavBar(),
      appBar: AppBar(
        title: const Text(
          'Continue watching',
        ),
        centerTitle: true,
      ),
      body: Container(
        child: FutureBuilder<List>(
          future: _getMovies(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return ListView(
                children: snapshot.data!.map<Widget>((movie) {
                  return InkWell(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return MovieInfo(movie: movie);
                          }
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.blueAccent
                      ),
                      child: Column(
                        children: [
                          Container(
                            child: Container(
                              margin: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: Colors.white
                              ),
                              child: Container(
                                width: 300,
                                height: 150,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(snapshot.data![0].imgUrl),
                                        fit: BoxFit.cover
                                    )
                                ),
                              ),
                            ),
                          ),
                          Container(
                            child: Text(
                              movie.name,
                              style: TextStyle(
                                  fontSize: 32
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }).toList(),
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else {
              return Center(child: Text('Failed to load movies'));
            }
          },
        ),
      ),
    );
  }
}