class Episode {
  int _id;
  int _serieId;
  String _description;
  String _imgUrl;

  Episode({required int id, required int serieId, required String description, required imgUrl})
      :_id = id,
        _serieId = serieId,
        _description = description,
        _imgUrl = imgUrl;

  int get id => _id;
  int get serieId => _serieId;
  String get description => _description;
  String get imgUrl => _imgUrl;

  factory Episode.fromJson(Map<String, dynamic> json) {
    return Episode(
        id: json['id'],
        serieId: json['serie_id'],
        description: json['description'],
        imgUrl: json['img_url']
    );
  }
}