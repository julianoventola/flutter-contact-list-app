import 'package:flutter/material.dart';
import 'package:helioaula/app/domain/entities/contact.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ContactDetailsBack {
  final BuildContext context;
  final Contact contact;

  ContactDetailsBack({this.context})
      : contact = ModalRoute.of(context).settings.arguments;

  goToBack() {
    Navigator.of(context).pop();
  }

  _launchApp(String url, Function(BuildContext context) showModalError) async {
    await canLaunch(url) ? await launch(url) : showModalError(context);
  }

  launchPhone(Function(BuildContext context) showModalError) {
    _launchApp('tel:${contact.telefone}', showModalError);
  }

  launchSMS(Function(BuildContext context) showModalError) {
    _launchApp('sms:${contact.telefone}', showModalError);
  }

  launchMail(Function(BuildContext context) showModalError) {
    _launchApp('mailto:${contact.email}', showModalError);
  }

  launchWhatsApp(Function(BuildContext context) showModalError) {
    _launchApp('whatsapp://send?phone=+55${contact.telefone}', showModalError);
  }
}
