class Scroll {
  int _id;
  int _episodeId;
  String _scrollUrl;

  Scroll({required int id, required int episodeId, required String scrollUrl})
      :_id = id,
        _episodeId = episodeId,
        _scrollUrl = scrollUrl;

  int get id => _id;
  int get episodeId => _episodeId;
  String get scrollUrl => _scrollUrl;

  factory Scroll.fromJson(Map<String, dynamic> json) {
    return Scroll(
        id: json['id'],
        episodeId: json['episode_id'],
        scrollUrl: json['scroll_url']
    );
  }
}