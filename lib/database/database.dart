import 'package:path/path.dart';
import 'package:pocs/models/project.dart';
import 'package:sqflite/sqflite.dart';

class ProjectsDatabase {
  // Create a new database

  static final ProjectsDatabase instance = ProjectsDatabase._init();

  static Database? _database;

  ProjectsDatabase._init();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    } else {
      _database = await _initDb("projects.db");
      return _initDb("projects.db");
    }
  }

  Future<Database> _initDb(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDb);
  }

  Future _createDb(Database db, int version) async {
    const idType = "INTEGER PRIMARY KEY AUTOINCREMENT";
    const textType = "TEXT NOT NULL";
    const integerType = "INTEGER NOT NULL";
    await db.execute('''
    CREATE TABLE $tableProjects (
    ${ProjectFields.id} $idType,
    ${ProjectFields.projectName} $textType,
    ${ProjectFields.projectDescription} $textType,
    ${ProjectFields.projectTechStack} $textType,
    ${ProjectFields.projectStatus} $textType,
    ${ProjectFields.projectGithubLink} $textType,
    ${ProjectFields.projectResourceLink} $textType,
    ${ProjectFields.projectCompletionDate} $textType,
    ${ProjectFields.priority} $integerType,
    )
    ''');
  }

  Future<Project> insertProject(Project project) async {
    final db = await instance.database;
    final id = await db.insert(tableProjects, project.toMap());
    return project.copy(id);
  }

  Future<List<Project>> getProject(int id) async {
    const orderBy = '${ProjectFields.priority} ASC';
    final db = await instance.database;
    final result = await db.query(
      tableProjects,
      orderBy: orderBy,
    );

    return result.map((json) => Project.fromJson(json)).toList();
  }

  Future<int> updateProject(Project project) async {
    final db = await instance.database;
    return db.update(
      tableProjects,
      project.toMap(),
      where: '${ProjectFields.id} = ?',
      whereArgs: [project.id],
    );
  }

  Future<int> delete(int id) async{
    final db = await instance.database;

    return await db.delete(
      tableProjects,
      where: '${ProjectFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
