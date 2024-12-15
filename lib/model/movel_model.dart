class Movie {
  Movie({
    this.id,
    this.title,
    this.posterURL,
    this.imdbId,
    this.isFavorite = false,
  });

  Movie.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int?;
    title = json['title'] as String?;
    posterURL = json['posterURL'] as String?;
    imdbId = json['imdbId'] as String?;
    isFavorite = (json['isFavorite'] ?? 0) == 1;
  }

  int? id;
  String? title;
  String? posterURL;
  String? imdbId;
  bool? isFavorite;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['posterURL'] = posterURL;
    data['imdbId'] = imdbId;
    data['isFavorite'] = isFavorite;
    return data;
  }
}
