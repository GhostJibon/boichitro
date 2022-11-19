
// import 'package:dhanshirisapp/db/recent_db/recent_data.dart';
// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';

// class RecentDatabase {
//   static final RecentDatabase instance = RecentDatabase._init();
//   static Database? _database;
//   RecentDatabase._init();

//   Future<Database> get database async {
//     if (_database != null) return _database!;
//     _database = await _initDB('recent.db');
//     return _database!;
//   }

//   Future<Database> _initDB(String filePath) async {
//     final dbPath = await getDatabasesPath();
//     final path = join(dbPath, filePath);
//     return await openDatabase(path, version: 1, onCreate: _createDB);
//   }

//   Future _createDB(Database db, int version) async {
//     final idType = 'INTEGER PRIMARY KEY';
//     final textType = 'TEXT NOT NULL';
//     final boolType = 'BOOLEAN NOT NULL';
//     final integerType = 'INTEGER NOT NULL';

//     await db.execute('''
// CREATE TABLE $tableNotes( 
//   ${RecentFields.book_id} $integerType, 
//   ${RecentFields.pagenumber} $integerType,
//   ${RecentFields.title} $textType,
//   ${RecentFields.time} $textType,
//   ${RecentFields.book_details} $textType
//   )
// ''');
//   }

//   Future<Recent> create(Recent note) async {
//     final db = await instance.database;

//     // final json = note.toJson();
//     // final columns =
//     //     '${NoteFields.title}, ${NoteFields.description}, ${NoteFields.time}';
//     // final values =
//     //     '${json[NoteFields.title]}, ${json[NoteFields.description]}, ${json[NoteFields.time]}';
//     // final id = await db
//     //     .rawInsert('INSERT INTO table_name ($columns) VALUES ($values)');

//     final id = await db.insert(tableNotes, note.toJson());
//     return note.copy(book_id: id);
//   }

//   Future<Recent> readNote(int id) async {
//     final db = await instance.database;
//     final maps = await db.query(
//       tableNotes,
//       columns: RecentFields.values,
//       where: '${RecentFields.book_id} = ?',
//       whereArgs: [id],
//     );
//     if (maps.isNotEmpty) {
//       return Recent.fromJson(maps.first);
//     } else {
//       throw Exception('ID $id not found');
//     }
//   }

//   Future<List<Recent>> readAllNotes() async {
//     final db = await instance.database;

//     final orderBy = '${RecentFields.time} ASC';
//     // final result =
//     //     await db.rawQuery('SELECT * FROM $tableNotes ORDER BY $orderBy');
//     final result = await db.query(tableNotes, orderBy: orderBy);
//     return result.map((json) => Recent.fromJson(json)).toList();
//   }

//   Future<int> update(Recent note) async {
//     final db = await instance.database;
//     return db.update(
//       tableNotes,
//       note.toJson(),
//       where: '${RecentFields.book_id} = ?',
//       whereArgs: [note.book_id],
//     );
//   }

//   Future<int> delete(int id) async {
//     final db = await instance.database;
//     return await db.delete(
//       tableNotes,
//       where: '${RecentFields.book_id} = ?',
//       whereArgs: [id],
//     );
//   }

//   Future close() async {
//     final db = await instance.database;
//     db.close();
//   }
// }
