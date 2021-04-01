import 'package:flutter/material.dart';
import 'package:helioaula/app/domain/entities/contact.dart';
import 'package:helioaula/app/view/contact_details_back.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ContactDetails extends StatelessWidget {
  showModalError(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              FaIcon(FontAwesomeIcons.exclamationCircle),
              SizedBox(
                width: 10,
              ),
              Text('Alerta!'),
            ],
          ),
          content: Text('Não foi possivel encontrar um app compativel'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Ok',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var _back = ContactDetailsBack(context: context);
    Contact contact = _back.contact;

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        var width = constraints.biggest.width;
        var radius = width / 3;
        //var height = constraints.biggest.height;

        return Scaffold(
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.arrow_back),
            onPressed: () {
              _back.goToBack();
            },
          ),
          body: ListView(
            padding: EdgeInsets.all(48),
            children: [
              (Uri.tryParse(contact.urlAvatar).isAbsolute
                  ? CircleAvatar(
                      child: ClipOval(
                        child: Image.network(
                          contact.urlAvatar,
                        ),
                      ),
                      radius: radius,
                    )
                  : CircleAvatar(
                      child: Icon(
                        Icons.person,
                        size: width / 2,
                      ),
                      radius: radius,
                    )),
              Container(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Center(
                  child: Text(
                    '${contact.nome}',
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                ),
              ),
              Card(
                child: ListTile(
                  title: Text('Telefone'),
                  subtitle: Text('${contact.telefone}'),
                  trailing: Container(
                    width: width / 4,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          color: Colors.blue,
                          icon: Icon(Icons.message),
                          onPressed: () {
                            _back.launchSMS(showModalError);
                            //launchApp('sms:${contact.telefone}', context);
                          },
                        ),
                        IconButton(
                          color: Colors.yellow,
                          icon: Icon(Icons.phone),
                          onPressed: () {
                            _back.launchPhone(showModalError);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Card(
                child: ListTile(
                    title: Text('E-mail'),
                    subtitle: Text('${contact.email}'),
                    trailing: Container(
                      width: width / 4,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            color: Colors.red,
                            icon: FaIcon(FontAwesomeIcons.at),
                            onPressed: () {
                              _back.launchMail(showModalError);
                            },
                          ),
                          IconButton(
                            color: Colors.green,
                            icon: FaIcon(FontAwesomeIcons.whatsapp),
                            onPressed: () {
                              _back.launchWhatsApp((context) => null)(
                                  showModalError);
                            },
                          ),
                        ],
                      ),
                    )),
              ),
            ],
          ),
        );
      },
    );
  }
}
