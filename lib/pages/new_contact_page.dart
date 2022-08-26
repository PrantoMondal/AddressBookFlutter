import 'dart:io';

import 'package:addressbook/models/contact_model.dart';
import 'package:addressbook/providers/contact_provider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class NewContactPage extends StatefulWidget {
  static const String routeName = '/new_contact';

  const NewContactPage({Key? key}) : super(key: key);

  @override
  State<NewContactPage> createState() => _NewContactPageState();
}

class _NewContactPageState extends State<NewContactPage> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();
  final webController = TextEditingController();
  String? dob;
  String? imagePath;
  String genderGroupValue = 'Male';
  ImageSource source = ImageSource.camera;

  @override
  void didChangeDependencies() {
    //nameController.text = 'Default';
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    addressController.dispose();
    webController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Contact'),
        actions: [IconButton(onPressed: _saveContact, icon: Icon(Icons.save))],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          TextField(
            keyboardType: TextInputType.name,
            controller: nameController,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.person),
                fillColor: Colors.blue.shade50,
                filled: true,
                labelText: 'Full Name'),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            keyboardType: TextInputType.phone,
            controller: phoneController,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.phone),
                fillColor: Colors.blue.shade50,
                filled: true,
                labelText: 'Phone'),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            keyboardType: TextInputType.emailAddress,
            controller: emailController,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.email),
                fillColor: Colors.blue.shade50,
                filled: true,
                labelText: 'Email'),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            keyboardType: TextInputType.streetAddress,
            controller: addressController,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.location_city),
                fillColor: Colors.blue.shade50,
                filled: true,
                labelText: 'Street Address'),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            keyboardType: TextInputType.url,
            controller: webController,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.web),
                filled: true,
                fillColor: Colors.blue.shade50,
                labelText: 'Website'),
          ),
          SizedBox(
            height: 10,
          ),
          Card(
            color: Colors.blue.shade50,
            elevation: 8,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: const Text(
                    'Select Gender',
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Radio<String>(
                        value: 'Male',
                        groupValue: genderGroupValue,
                        onChanged: (value) {
                          setState(() {
                            genderGroupValue = value!;
                          });
                        }),
                    const Text('Male'),
                    SizedBox(
                      width: 7,
                    ),
                    Radio<String>(
                        value: 'Female',
                        groupValue: genderGroupValue,
                        onChanged: (value) {
                          setState(() {
                            genderGroupValue = value!;
                          });
                        }),
                    const Text('Female'),
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Chip(label: Text(dob == null ? 'No date chosen' : dob!)),
              TextButton(
                  onPressed: _showDatePickerDialog,
                  child: const Text('Select Date of Birth')),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Card(
                elevation: 10,
                child: imagePath == null
                    ? Image.asset(
                        'images/person.png',
                        width: 100,
                        height: 120,
                        fit: BoxFit.cover,
                      )
                    : Image.file(
                        File(imagePath!),
                        width: 100,
                        height: 120,
                        fit: BoxFit.cover,
                      ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton.icon(
                      onPressed: () {
                        source = ImageSource.camera;
                        _getImage();
                      },
                      icon: Icon(Icons.camera_alt),
                      label: const Text('Capture')),
                  TextButton.icon(
                      onPressed: () {
                        source = ImageSource.gallery;
                        _getImage();
                      },
                      icon: Icon(Icons.photo),
                      label: const Text('Gallery')),
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  void _showDatePickerDialog() async {
    DateTime? selectedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1922),
        lastDate: DateTime.now());

    if (selectedDate != null) {
      setState(() {
        dob = DateFormat('dd/MM/yyyy').format(selectedDate);
      });
    }
  }

  void _getImage() async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        imagePath = pickedFile.path;
      });
    }
  }

  void _saveContact() {
    final contact = ContactModel(
      name: nameController.text,
      mobile: phoneController.text,
      email: emailController.text,
      streetAddress: addressController.text,
      website: webController.text,
      dob: dob,
      image: imagePath,
      gender: genderGroupValue,
    );
    //contactListDB.add(contact);
    Provider.of<ContactProvider>(context,listen: false).addContact(contact);
    Navigator.pop(context);
  }
}
