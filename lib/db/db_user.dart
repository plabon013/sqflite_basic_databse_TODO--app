// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';
//
// import '../model/user_model.dart';
//
// class DBUser {
//   static const String createTableUser = '''create table $tableUser(
//   $tableUserId integer primary key,
//   $tableUserName text,
//   $tableUserPassword text
//   )''';
//
//   static Future<Database> open() async {
//     final rootPath = await getDatabasesPath();
//
//     final dbPath = join(rootPath, 'todo.db');
//
//     return openDatabase(dbPath, version: 1, onCreate: (db, version) {
//       db.execute(createTableUser);
//     });
//   }
//
//   static Future<int> createUser(UserModel userModel) async {
//     final db = await open();
//
//     return db.insert(tableUser, userModel.toMap());
//   }
//
//   static Future<List<UserModel>> getAllUsers() async {
//     final db = await open();
//
//     final List<Map<String, dynamic>> mapList = await db.query(tableUser);
//
//     return List.generate(
//         mapList.length, (index) => UserModel.fromMap(mapList[index]));
//   }
// }
