import 'dart:js';

import 'package:flutter/material.dart';

import '../models/contact_model.dart';

class ContactProvider extends ChangeNotifier{
  List<ContactModel> contactList = [];
  addContact(ContactModel contactModel){
    contactList.add(contactModel);
    notifyListeners();

  }
  getAllContacts(){
    this.contactList = contactListDB;
    notifyListeners();
}
  void updateFavorite(int index) {
    contactList[index].favourite = !contactList[index].favourite;
    notifyListeners();
  }
  deleteContact(int index){
    contactList.removeAt(index);
    notifyListeners();
  }


}
