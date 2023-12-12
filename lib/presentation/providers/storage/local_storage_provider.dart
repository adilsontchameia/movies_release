//Readyonly provider => its immutable, query purpose

import '../../../infrasctructure/datasources/isar_datasource.dart';
import '../../../infrasctructure/repositories/local_storage_repository_impl.dart';
import '../providers.dart';

final localStorageRepositoryProvider = Provider((ref) {
  return LocalStorageRepositoryImpl(IsarDatasource());
});
