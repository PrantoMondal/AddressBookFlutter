import 'dart:io';

import 'package:flutter/material.dart';

import '../models/contact_model.dart';

class ContactDetailsPage extends StatefulWidget {
  static const String routeName = '/contact_details';
  const ContactDetailsPage({Key? key}) : super(key: key);

  @override
  State<ContactDetailsPage> createState() => _ContactDetailsPageState();
}

class _ContactDetailsPageState extends State<ContactDetailsPage> {
  late ContactModel contact;

  @override
  void didChangeDependencies() {
    contact = ModalRoute.of(context)!.settings.arguments as ContactModel;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(contact.name),
      ),
      body: ListView(
        children: [
          contact.image == null? Image.asset('images/person.png',width: double.maxFinite,height: 250,fit: BoxFit.cover,) :
          Image.file(File(contact.image!),width: double.maxFinite,height: 250,fit: BoxFit.cover),
        ],
      ),
    );
  }
}
