import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:helioaula/app/domain/entities/contact.dart';
import 'package:helioaula/app/my_app.dart';
import 'package:helioaula/app/view/contact_list_back.dart';

class ContactList extends StatelessWidget {
  final _back = ContactListBack();

  @override
  Widget build(BuildContext context) {
    ContactListBack().refreshContactList();
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Contatos'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              _back.goToForm(context: context);
            },
          ),
        ],
      ),
      body: Observer(
        builder: (BuildContext context) {
          return FutureBuilder(
            future: _back.list,
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (!snapshot.hasData) {
                return Scaffold(
                  appBar: AppBar(
                    title: Text('Lista de Contatos'),
                    actions: [
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          // Navigator.of(context).pushNamed(MyApp.CONTACT_FORM);
                          _back.goToForm(context: context);
                        },
                      ),
                    ],
                  ),
                  body: Container(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                );
              } else {
                List<Contact> lista = snapshot.data;
                return ListView.builder(
                  itemCount: lista.length,
                  itemBuilder: (BuildContext context, int index) {
                    var contato = lista[index];
                    return ListTile(
                      onTap: () {
                        _back.goToDetails(context, contato);
                      },
                      title: Text('${contato.nome}'),
                      subtitle: Text(contato.telefone),
                      leading: circleAvatar(contato.urlAvatar),
                      trailing: Container(
                        width: 100,
                        child: Row(
                          children: [
                            iconEditButton(() {
                              _back.goToForm(
                                context: context,
                                contact: contato,
                              );
                            }),
                            iconRemoveButton(
                              context,
                              () {
                                _back.remove(contato.id);
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
            },
          );
        },
      ),
    );
  }
}

CircleAvatar circleAvatar(String url) {
  if (Uri.tryParse(url).isAbsolute) {
    return CircleAvatar(backgroundImage: NetworkImage(url));
  } else {
    return CircleAvatar(child: Icon(Icons.person));
  }
}

Widget iconEditButton(Function onPressed) {
  return IconButton(
    icon: Icon(
      Icons.edit,
      color: Colors.yellow,
    ),
    onPressed: onPressed,
  );
}

Widget iconRemoveButton(BuildContext context, Function onPressed) {
  return IconButton(
    icon: Icon(
      Icons.delete,
      color: Colors.red,
    ),
    onPressed: () {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Excluir'),
              content: Text('Deseja excluir contato?'),
              actions: [
                TextButton(
                  onPressed: onPressed,
                  child: Text(
                    'Sim',
                    style: TextStyle(
                      color: Colors.green,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Não',
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            );
          });
    },
  );
}
