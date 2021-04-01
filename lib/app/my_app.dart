import 'package:flutter/material.dart';
import 'package:helioaula/app/view/contact_details.dart';
import 'package:helioaula/app/view/contact_form.dart';
import 'package:helioaula/app/view/contact_list.dart';

class MyApp extends StatelessWidget {
  static const HOME = '/';
  static const CONTACT_FORM = '/contact-form';
  static const CONTACT_DETAILS = '/contact-details';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: {
        HOME: (context) => ContactList(),
        CONTACT_FORM: (context) => ContactForm(),
        CONTACT_DETAILS: (context) => ContactDetails()
      },
    );
  }
}
