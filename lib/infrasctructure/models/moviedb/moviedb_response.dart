import 'movie_moviedb.dart';

class MovieDbResponse {
  final Dates? dates;
  final int page;
  final List<MovieMovieDb> movieMovieDbs;
  final int totalPages;
  final int totalMovieMovieDbs;

  MovieDbResponse({
    required this.dates,
    required this.page,
    required this.movieMovieDbs,
    required this.totalPages,
    required this.totalMovieMovieDbs,
  });

  factory MovieDbResponse.fromJson(Map<String, dynamic> json) =>
      MovieDbResponse(
        dates: json['dates'] ? Dates.fromJson(json["dates"]) : null,
        page: json["page"],
        movieMovieDbs: List<MovieMovieDb>.from(
            json["MovieMovieDbs"].map((x) => MovieMovieDb.fromJson(x))),
        totalPages: json["total_pages"],
        totalMovieMovieDbs: json["total_MovieMovieDbs"],
      );

  Map<String, dynamic> toJson() => {
        "dates": dates == null ? null : dates!.toJson(),
        "page": page,
        "MovieMovieDbs":
            List<dynamic>.from(movieMovieDbs.map((x) => x.toJson())),
        "total_pages": totalPages,
        "total_MovieMovieDbs": totalMovieMovieDbs,
      };
}

class Dates {
  final DateTime maximum;
  final DateTime minimum;

  Dates({
    required this.maximum,
    required this.minimum,
  });

  factory Dates.fromJson(Map<String, dynamic> json) => Dates(
        maximum: DateTime.parse(json["maximum"]),
        minimum: DateTime.parse(json["minimum"]),
      );

  Map<String, dynamic> toJson() => {
        "maximum":
            "${maximum.year.toString().padLeft(4, '0')}-${maximum.month.toString().padLeft(2, '0')}-${maximum.day.toString().padLeft(2, '0')}",
        "minimum":
            "${minimum.year.toString().padLeft(4, '0')}-${minimum.month.toString().padLeft(2, '0')}-${minimum.day.toString().padLeft(2, '0')}",
      };
}
