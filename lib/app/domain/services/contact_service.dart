import 'package:get_it/get_it.dart';
import 'package:helioaula/app/domain/entities/contact.dart';
import 'package:helioaula/app/domain/exception/domain_layer_exception.dart';
import 'package:helioaula/app/domain/interfaces/contact_dao.dart';

class ContactService {
  var _dao = GetIt.I.get<ContactDAO>();

  save(Contact contact) {
    validateName(contact.nome);
    validateEmail(contact.email);
    validatePhone(contact.telefone);
    _dao.save(contact);
  }

  remove(int id) {
    _dao.delete(id);
  }

  Future<List<Contact>> find() {
    return _dao.find();
  }

  validateName(String name) {
    var min = 3;
    var max = 40;

    if (name == null) {
      throw new DomainLayerException(
        cause: 'O nome é obrigatório',
      );
    } else if (name.length < min) {
      throw new DomainLayerException(
        cause: 'O nome deve ter mais de $min letras',
      );
    } else if (name.length > max) {
      throw new DomainLayerException(
        cause: 'O nome deve ter no máximo $max letras',
      );
    }
  }

  validateEmail(String email) {
    var min = 10;
    var max = 80;

    if (email == null) {
      throw new DomainLayerException(
        cause: 'O email é obrigatório',
      );
    } else if (!email.contains('@')) {
      throw new DomainLayerException(
        cause: 'Formato de email inválido, faltando @.',
      );
    } else if (email.length < min) {
      throw new DomainLayerException(
        cause: 'O email deve ter mais de $min letras',
      );
    } else if (email.length > max) {
      throw new DomainLayerException(
        cause: 'O email deve ter no máximo $max letras',
      );
    }
  }

  validatePhone(String phone) {
    // Formato (99) 9 9999-9999
    var format = RegExp(r'\([1-9]{2}\) [9] [0-9]{4}\-[0-9]{4}$');

    if (phone == null) {
      throw new DomainLayerException(
        cause: 'O telefone é obrigatório',
      );
    } else if (!format.hasMatch(phone)) {
      throw new DomainLayerException(
        cause: 'Formato de telefone inválido, esperado: (##) 9 ####-####',
      );
    }
  }
}
