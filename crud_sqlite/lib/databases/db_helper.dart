import 'package:crud_sqlite/models/mhs.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';

class DbHelper {
  static final DbHelper _instance = DbHelper._internal();
  static Database? _database;

  //inisialisasi beberapa variabel yang dibutuhkan
  final String tableNama = 'tableMhs';
  final String columnId = 'id';
  final String columnNPM = 'npm';
  final String columnNama = 'nama';
  final String columnEmail = 'email';
  final String columnAlamat = 'alamat';
  final String columnNohandpone = 'no_handpone';

  DbHelper._internal();
  factory DbHelper() => _instance;

  //cek apakah database ada
  Future<Database?> get _db async {
    if (_database != null) {
      return _database;
    }
    _database = await _initDb();
    return _database;
  }

  Future<Database?> _initDb() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'mhs.db');

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  //membuat tabel dan field-fieldnya
  Future<void> _onCreate(Database db, int version) async {
    var sql = "CREATE TABLE $tableNama($columnId INTEGER PRIMARY KEY, "
        "$columnNPM TEXT,"
        "$columnNama TEXT,"
        "$columnEmail TEXT,"
        "$columnAlamat TEXT"
        "$columnNohandpone TEXT)";
    await db.execute(sql);
  }

  //insert ke database
  Future<int?> saveMhs(MHS mhs) async {
    var dbClient = await _db;
    return await dbClient!.insert(tableNama, mhs.toMap());
  }

  //read database
  Future<List?> getAllMhs() async {
    var dbClient = await _db;
    var result = await dbClient!.query(tableNama, columns: [
      columnId,
      columnNPM,
      columnNama,
      columnEmail,
      columnAlamat,
      columnNohandpone
    ]);

    return result.toList();
  }

  //update database
  Future<int?> updateMhs(MHS mhs) async {
    var dbClient = await _db;
    return await dbClient!.update(tableNama, mhs.toMap(),
        where: '$columnId = ?', whereArgs: [mhs.id]);
  }

  //hapus database
  Future<int?> deleteMhs(int id) async {
    var dbClient = await _db;
    return await dbClient!
        .delete(tableNama, where: '$columnId = ?', whereArgs: [id]);
  }
}
