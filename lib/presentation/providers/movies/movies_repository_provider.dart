import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies_release/infrasctructure/datasources/moviedb_datasource.dart';
import 'package:movies_release/infrasctructure/repositories/movie_repository_impl.dart';

//Readyonly provider => its immutable, query purpose
final movieRepositoryProvider = Provider((ref) {
  return MovieRepositoryImpl(MoviedbDatasource());
});
