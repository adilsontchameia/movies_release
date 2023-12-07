import 'package:dio/dio.dart';

import 'environment.dart';

class AppConstants {
  static String movieImageBaseUrl = 'https://image.tmdb.org/t/p/w500/';
  static String notFoundImageUrl =
      'https://memories-app-redis.netlify.app/static/media/nopost.09eb101fbe5ce1b12f92.png';
  static Dio dio = Dio(BaseOptions(
    baseUrl: 'https://api.themoviedb.org/3',
    queryParameters: {
      'api_key': Environment.theMovieDbKey,
      'language': 'pt-PT',
    },
  ));
}
