import 'package:helioaula/app/database/sqlite/connection.dart';
import 'package:helioaula/app/domain/entities/contact.dart';
import 'package:helioaula/app/domain/interfaces/contact_dao.dart';
import 'package:sqflite/sqflite.dart';

class ContactDAOImpl implements ContactDAO {
  Database _db;

  @override
  Future<void> delete(int id) async {
    _db = await SqLiteConnection.get();
    var sql = 'DELETE FROM contact WHERE id=?';
    _db.rawDelete(sql, [id]);
  }

  @override
  Future<List<Contact>> find() async {
    _db = await SqLiteConnection.get();
    List<Map<String, dynamic>> resultado = await _db.query('contact');
    List<Contact> lista = List.generate(resultado.length, (index) {
      var linha = resultado[index];
      return Contact(
        id: linha['id'],
        nome: linha['nome'],
        telefone: linha['telefone'],
        email: linha['email'],
        urlAvatar: linha['url_avatar'],
      );
    });
    return lista;
  }

  @override
  Future<void> save(Contact contact) async {
    _db = await SqLiteConnection.get();
    var sql;
    if (contact.id == null) {
      sql =
          'INSERT INTO contact(nome, telefone, email, url_avatar) VALUES (?,?,?,?)';
      _db.rawInsert(sql, [
        contact.nome,
        contact.telefone,
        contact.email,
        contact.urlAvatar != null ? contact.urlAvatar : '',
      ]);
    } else {
      sql =
          'UPDATE contact SET nome=?, telefone=?, email=?, url_avatar=? WHERE id=?';
      _db.rawUpdate(sql, [
        contact.nome,
        contact.telefone,
        contact.email,
        contact.urlAvatar,
        contact.id
      ]);
    }
  }

  @override
  Future<dynamic> findById(int id) async {
    _db = await SqLiteConnection.get();
    List<Map<String, dynamic>> resultado = await _db.query(
      'contact',
      where: 'id=?',
      whereArgs: [id],
    );
    if (resultado.length > 0) {
      return resultado;
    }
    return null;
  }
}
