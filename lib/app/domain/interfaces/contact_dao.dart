import 'package:helioaula/app/domain/entities/contact.dart';

abstract class ContactDAO {
  Future<void> save(Contact contact);
  Future<void> delete(int id);
  Future<List<Contact>> find();
  Future<dynamic> findById(int id);
}
