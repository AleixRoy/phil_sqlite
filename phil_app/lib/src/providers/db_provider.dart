import 'dart:io';
import 'package:phil_app/src/models/employee_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  static Database? _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database?> get database async {
    // If database exists, return database
    if (_database != null) return _database;

    // If database don't exists, create one
    _database = await initDB();

    return _database;
  }

  // Create the database and the Employee table
  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'phil_manager.db');

    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE Phil("
          "id INTEGER PRIMARY KEY, "
          "life TEXT, "
          "img TEXT, "
          "name TEXT)");
    });
  }
  

  // Insert employee on database
  createEmployee(Employee newEmployee) async {
    await deleteAllEmployees();
    final db = await database;
    final res = await db?.insert('Phil', newEmployee.toJson());

    return res;
  }

  // Delete all employees
  Future<int?> deleteAllEmployees() async {
    final db = await database;
    final res = await db?.rawDelete('DELETE FROM Phil');

    return res;
  }

  

  Future<List<Employee?>> getAllEmployees() async {
    final db = await database;
    final res = await db?.rawQuery("SELECT * FROM Phil");

    List<Employee> list =
        res!.isNotEmpty ? res.map((c) => Employee.fromJson(c)).toList() : [];

    return list;
  }

  addTodo(name, img, life) async {
    await insertTodo(name, img, life);
    getAllEmployees();
  }

  Future insertTodo(name, img, life) => insertNewEmployee(name, img, life);

   addname(name) async {
    await deletename(name);
    getAllEmployees();
  }

  Future deletename(name) => deleteSpecificEmployee(name);
  
  addTodoUpdate(name, img, life) async {
    await insertTodo(name, img, life);
    getAllEmployees();
  }

  Future updateTodo(name, img, life, namePS) => updateEmployee(name, img, life, namePS);

  insertNewEmployee(name, img, life) async {
    final db = await database;
    db?.rawInsert('INSERT INTO Phil(name, img, life) VALUES(' + '"' + name + '"' + ',' + '"' +img+ '"' + ',' + '"' + life + '"' + ')');
  }

   deleteSpecificEmployee(name) async {
    final db = await database;
    db?.rawDelete('DELETE FROM Phil WHERE name = ' + '"' + name + '"');
  }

  updateEmployee(name, img, life, namePS) async {
    final db = await database;
    db?.rawUpdate('UPDATE Phil SET name =' +
     '"' + name + '"' ', img = ' + '"' + img + 
     '"' + ', life = ' + '"' + 
     life + '"' 'WHERE name = ' + '"' + namePS + '"');
  }
}
