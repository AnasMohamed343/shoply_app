import 'package:path/path.dart';
import 'package:shoply/constants.dart';
import 'package:shoply/model/cart_product_model.dart';
import 'package:sqflite/sqflite.dart';

class CartDatabaseHelper {
  CartDatabaseHelper._();
  static final CartDatabaseHelper db = CartDatabaseHelper._();
  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await initDB();
    return _database;
  }

  initDB() async {
    String path = join(await getDatabasesPath(), 'CartProduct.db');
    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
      CREATE TABLE $kTableCartProduct(
      $kColumnName TEXT NOT NULL,
      $kColumnImage TEXT NOT NULL,
      $kColumnPrice TEXT NOT NULL,
      $kColumnQuantity INTEGER NOT NULL,
       $kColumnProductId TEXT NOT NULL)
      ''');
    });
  }

  insert(CartProductModel cartProductModel) async {
    var dbClient = await database;
    return await dbClient?.insert(kTableCartProduct, cartProductModel.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<CartProductModel>?> getAllProduct() async {
    var dbClient = await database;
    List<Map<String, Object?>>? maps = await dbClient?.query(kTableCartProduct);
    List<CartProductModel>? list = maps?.isNotEmpty == true
        ? maps?.map((product) => CartProductModel.fromJson(product)).toList()
        : [];
    return list;
  }

  updateProduct(CartProductModel cartProductModel) async {
    var dbClient = await database;
    return await dbClient?.update(kTableCartProduct, cartProductModel.toJson(),
        where: '$kColumnProductId = ?',
        whereArgs: [cartProductModel.productId]);
  }

  deleteProduct(String productId) async {
    var dbClient = await database;
    return await dbClient?.delete(kTableCartProduct,
        where: '$kColumnProductId = ?', whereArgs: [productId]);
  }
}
