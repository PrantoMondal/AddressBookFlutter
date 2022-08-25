import 'dart:io';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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
    contact = ModalRoute
        .of(context)!
        .settings
        .arguments as ContactModel;
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
          contact.image == null
              ? Image.asset(
            'images/person.png',
            width: double.maxFinite,
            height: 250,
            fit: BoxFit.fitHeight,
          )
              : Image.file(File(contact.image!),
              width: double.maxFinite, height: 250, fit: BoxFit.fitHeight),
          ListTile(
            title: Text(contact.mobile),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.call),
                  onPressed: _callPerson,
                ),
                IconButton(
                  icon: Icon(Icons.sms),
                  onPressed: _smsContact,
                )
              ],
            ),
          ),
          ListTile(
            title: Text(contact.email == null || contact.email!.isEmpty ?'Unavailable' : contact.email!),
            trailing: IconButton(
              icon: Icon(contact.email == null? Icons.edit : Icons.email),
              onPressed: _mailContact,
            )
              
          )
        ],
      ),
    );
  }

  void _callPerson() async {
    final uri = Uri.parse('tel:${contact.mobile}');
    if(await canLaunchUrl(uri)){
      await launchUrl(uri);
    }
    else{
      throw 'Can not launch url';
    }
  }

  void _smsContact() async {
    final uri = Uri.parse('sms:${contact.mobile}');
    if(await canLaunchUrl(uri)){
      await launchUrl(uri);
    }
    else{
      throw 'Can not launch url';
    }
  }

  void _mailContact() async{
    final uri = Uri.parse('mailto:${contact.email}');
    if(await canLaunchUrl(uri)){
      await launchUrl(uri);
    }
    else{
      throw 'Can not launch url';
    }
  }
}
