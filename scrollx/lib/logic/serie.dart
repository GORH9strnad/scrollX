class Serie {
  int _id;
  int _movieId;
  int _order;
  String _videoUrl;

  Serie({required int id, required int movieId, required int order, required videoUrl})
      :_id = id,
        _movieId = movieId,
        _order = order,
        _videoUrl = videoUrl;

  int get id => _id;
  int get movieId => _movieId;
  int get order => _order;
  String get videoUrl => _videoUrl;

  factory Serie.fromJson(Map<String, dynamic> json) {
    return Serie(
      id: json['id'],
      movieId: json['movie_id'],
      order: json['order'],
      videoUrl: json['video_url']
    );
  }
}