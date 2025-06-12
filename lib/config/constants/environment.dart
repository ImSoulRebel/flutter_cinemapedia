import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static String themovieDBKey = dotenv.env['THEMOVIEDB_KEY'] ?? 'Key not found';
  static String defaultLanguage = 'es-ES';
}
