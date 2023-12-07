import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../infrasctructure/datasources/actor_moviedb_datasource.dart';
import '../../../infrasctructure/repositories/actor_repository_impl.dart';

//Readyonly provider => its immutable, query purpose
final actorsRepositoryProvider = Provider((ref) {
  return ActorRepositoryImpl(ActorMovieDbDatasource());
});
