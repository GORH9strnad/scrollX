import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:scrollx/logic/episode.dart';
import 'package:scrollx/logic/scroll.dart';
import '../logic/movie.dart';
import '../logic/serie.dart';

class BackendConnector {

  BackendConnector._private();

  static final BackendConnector _instance = BackendConnector._private();

  static BackendConnector get instance => _instance;

  Future<List> getAllMovies() async {
    final response = await http.get(Uri.parse('http://172.20.10.3:5000/get-all-movies'));

    if (response.statusCode == 200) {
      List<dynamic> jsonData = jsonDecode(response.body);
      List<Movie> movies = jsonData.map((json) => Movie.fromJson(json)).toList();
      return movies;
    } else {
      throw Exception('Failed to load movies');
    }
  }

  Future<List> getSeriesOfMovie(int movieId) async {
    final response = await http.post(
      Uri.parse('http://172.20.10.3:5000/get-series-of-movie'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, int>{
        'movie_id': movieId,
      }),
    );

    if (response.statusCode == 200) {
      List<dynamic> jsonData = jsonDecode(response.body);
      List<Serie> series = jsonData.map((json) => Serie.fromJson(json)).toList();
      return series;
    } else {
      throw Exception('Failed to load series' + response.statusCode.toString());
    }
  }

  Future<List> getEpisodesOfSerie(int serieId) async {
    final response = await http.post(
      Uri.parse('http://172.20.10.3:5000/get-episodes-of-serie'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, int>{
        'serie_id': serieId,
      }),
    );

    if (response.statusCode == 200) {
      List<dynamic> jsonData = jsonDecode(response.body);
      List<Episode> episodes = jsonData.map((json) => Episode.fromJson(json)).toList();
      return episodes;
    } else {
      throw Exception('Failed to load series' + response.statusCode.toString());
    }
  }

  Future<List> getScrollsOfEpisode(int episodeId) async {
    final response = await http.post(
      Uri.parse('http://172.20.10.3:5000/get-scrolls-of-episode'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, int>{
        'episode_id': episodeId,
      }),
    );

    if (response.statusCode == 200) {
      List<dynamic> jsonData = jsonDecode(response.body);
      List<Scroll> scrolls = jsonData.map((json) => Scroll.fromJson(json)).toList();
      return scrolls;
    } else {
      throw Exception('Failed to load series' + response.statusCode.toString());
    }
  }

}
