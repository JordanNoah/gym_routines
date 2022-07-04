import 'package:gym_routines/model/machine.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class MachinesDatabase {
  static final MachinesDatabase instance = MachinesDatabase._init();

  static Database? _database;
  MachinesDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('machines.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NO NULL';
    const intType = 'INTEGER NO NULL';
    await db.execute('''
      CREATE TABLE $tableMachines (
        ${NoteFields.id} $idType,
        ${NoteFields.name} $textType,
        ${NoteFields.type} $intType
      )      
    ''');
  }

  Future<Machine> create(Machine machine) async {
    final db = await instance.database;

    final id = await db.insert(tableMachines, machine.toJson());
    return machine.copy(id: id);
  }

  Future<Machine> readMachine(int id) async {
    final db = await instance.database;

    final maps = await db.query(tableMachines,
        columns: NoteFields.values,
        where: '${NoteFields.id} = ?',
        whereArgs: [id]);

    if (maps.isNotEmpty) {
      return Machine.fromJson(maps.first);
    } else {
      throw Exception('ID $id NOT FOUND');
    }
  }

  Future<List<Machine>> readAllMachines() async {
    final db = await instance.database;

    final orderBy = '${NoteFields.id} ASC';
    final result = await db.query(tableMachines, orderBy: orderBy);

    return result.map((json) => Machine.fromJson(json)).toList();
  }

  Future<int> update(Machine machine) async {
    final db = await instance.database;

    return db.update(tableMachines, machine.toJson(),
        where: '${NoteFields.id} = ?', whereArgs: [machine.id]);
  }

  Future<int> delete(int? id) async {
    final db = await instance.database;

    return await db
        .delete(tableMachines, where: '${NoteFields.id} = ?', whereArgs: [id]);
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
