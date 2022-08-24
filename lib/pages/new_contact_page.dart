import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewContactPage extends StatefulWidget {
  static const String routeName = '/new_contact';

  const NewContactPage({Key? key}) : super(key: key);

  @override
  State<NewContactPage> createState() => _NewContactPageState();
}

class _NewContactPageState extends State<NewContactPage> {
  final nameController = TextEditingController();
  String? dob;
  String? imagePath;

  @override
  void didChangeDependencies() {
    //nameController.text = 'Default';
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Contact'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          TextField(
            keyboardType: TextInputType.name,
            controller: nameController,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.person),
                filled: true,
                labelText: 'Full Name'),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                  onPressed: _showDatePickerDialog,
                  child: const Text('Select Date of Birth')),
              Chip(label: Text(dob == null ? 'No date chosen' : dob!))
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
                      onPressed: () {},
                      icon: Icon(Icons.camera_alt),
                      label: const Text('Capture')),
                  TextButton.icon(
                      onPressed: () {},
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
}
