import 'package:flutter/material.dart';

import '../models/contact_model.dart';

class ContactProvider extends ChangeNotifier{
  List<ContactModel> contactList = [];
  addContact(ContactModel contactModel){
    contactList.add(contactModel);
    notifyListeners();

  }
  getAllContacts(){
    this.contactList = contactList;
    notifyListeners();
}

}
