/// This is a basic implementation of a local storage datasource using Isar.
/// It provides methods to get favourite movies, check if a movie is favourite,
/// and toggle a movie as favourite.
/// Note: Changed for Drift implementation (see lib/config/database/database.dart)

// import 'package:flutter_cinemapedia/domain/datasources/local_storage_datasource.dart';
// import 'package:flutter_cinemapedia/domain/entities/movie_entity.dart';
// import 'package:isar/isar.dart';
// import 'package:path_provider/path_provider.dart';

// class IsarLocalStorageDatasource extends LocalStorageDatasource {
//   late Future<Isar> db;

//   IsarLocalStorageDatasource() {
//     db = openDB();
//   }

//   Future<Isar> openDB() async {
//     ///  PATH donde almacenaremos la base de datos
//     final dir = await getApplicationDocumentsDirectory();

//     if (Isar.instanceNames.isEmpty) {
//       return await Isar.open(
//         [MovieEntitySchema],
//         inspector: true,
//         directory: dir.path,
//       );
//     }
//     return Future.value(Isar.getInstance());
//   }

//   /// Paginado
//   @override
//   Future<List<MovieEntity>> getFavouritesMovies({
//     int limit = 10,
//     int offset = 0,
//   }) async {
//     final isar = await db;

//     return await isar.movieEntitys
//         .where()
//         .offset(offset)
//         .limit(limit)
//         .findAll();
//   }

//   @override
//   Future<bool> isMovieFavourite(int movieId) async {
//     final isar = await db;

//     final isFavouriteMovie =
//         await isar.movieEntitys.filter().idEqualTo(movieId).findFirst();

//     return isFavouriteMovie != null;
//   }

//   @override
//   Future<void> toggleFavourite(MovieEntity movie) async {
//     final isar = await db;

//     final favouriteMovie =
//         await isar.movieEntitys.filter().idEqualTo(movie.id).findFirst();

//     if (favouriteMovie != null) {
//       /// Transacción con BBDD
//       isar.writeTxnSync(
//         /// Borrar
//         () => isar.movieEntitys.deleteSync(favouriteMovie.isarId!),
//       );
//       return;
//     }

//     /// Insertar
//     isar.writeTxnSync(() => isar.movieEntitys.putSync(movie));
//   }

//   // @override
//   // Future<List<MovieEntity>> loadMovies({int limit = 10, offset = 0}) async {
//   //   final isar = await db;

// ignore_for_file: dangling_library_doc_comments

//   //   return isar.movieEntitys.where().offset(offset).limit(limit).findAll();
//   // }
// }
