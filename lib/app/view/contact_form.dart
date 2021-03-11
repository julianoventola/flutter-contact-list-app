import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import './contact_form_back.dart';

class ContactForm extends StatelessWidget {
  final _form = GlobalKey<FormState>();
  //const ContactForm({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    TextEditingController urlController = TextEditingController();

    var _back = ContactFormBack(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Cadastro de contato'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              _form.currentState.validate();
              _form.currentState.save();
              if (_back.isValid) {
                _back.save();
                Navigator.of(context).pop();
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Form(
            key: _form,
            child: Column(
              children: [
                formField(
                  labelText: 'Nome',
                  controller:
                      _back.contact.nome == null ? nameController : null,
                  initialValue: _back.contact.nome,
                  validator: _back.validateName,
                  onSaved: (newValue) => _back.contact.nome = newValue,
                ),
                formField(
                  labelText: 'E-mail',
                  keyboardType: TextInputType.emailAddress,
                  controller:
                      _back.contact.email == null ? emailController : null,
                  initialValue: _back.contact.email,
                  validator: _back.validatEmail,
                  onSaved: (newValue) => _back.contact.email = newValue,
                ),
                formField(
                  labelText: 'Telefone',
                  hintText: '(99) 9 9999-9999',
                  mask: '(##) # ####-####',
                  keyboardType: TextInputType.number,
                  controller:
                      _back.contact.telefone == null ? phoneController : null,
                  initialValue: _back.contact.telefone,
                  validator: _back.validatePhone,
                  onSaved: (newValue) => _back.contact.telefone = newValue,
                ),
                formField(
                  labelText: 'Link da Foto',
                  hintText: 'http://www.site.com/foto',
                  controller:
                      _back.contact.urlAvatar == null ? urlController : null,
                  initialValue: _back.contact.urlAvatar,
                  onSaved: (newValue) => _back.contact.urlAvatar = newValue,
                ),
              ],
            )),
      ),
      floatingActionButton: _back.contact.nome == null
          ? FloatingActionButton(
              onPressed: () {
                nameController.clear();
                emailController.clear();
                phoneController.clear();
                urlController.clear();
              },
              child: Icon(
                Icons.delete,
              ),
            )
          : null,
    );
  }
}

Widget formField({
  @required String labelText,
  String hintText,
  String mask,
  TextInputType keyboardType,
  TextEditingController controller,
  dynamic initialValue,
  String Function(String) validator,
  void Function(String) onSaved,
}) {
  MaskTextInputFormatter masked;
  if (mask != null) {
    masked = MaskTextInputFormatter(
      mask: mask,
    );
  }

  return TextFormField(
    validator: validator,
    onSaved: onSaved,
    initialValue: initialValue,
    controller: controller,
    inputFormatters: mask != null ? [masked] : [],
    keyboardType: keyboardType,
    decoration: InputDecoration(
      labelText: labelText,
      hintText: hintText,
    ),
  );
}
