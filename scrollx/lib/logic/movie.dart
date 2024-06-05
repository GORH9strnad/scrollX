class Movie {
  int _id;
  String _name;
  String _description;
  String _imgUrl;

  Movie({required int id, required String name, required String description, required imgUrl})
      : _id = id,
        _name = name,
        _description = description,
        _imgUrl = imgUrl;

  int get id => _id;
  String get name => _name;
  String get description => _description;
  String get imgUrl => _imgUrl;

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      imgUrl: json['img_url']

    );
  }
}