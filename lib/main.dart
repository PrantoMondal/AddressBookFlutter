import 'package:addressbook/pages/contact_details_page.dart';
import 'package:addressbook/pages/contact_list_page.dart';
import 'package:addressbook/pages/new_contact_page.dart';
import 'package:addressbook/providers/contact_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => ContactProvider() .. getAllContacts(),
    child: const MyApp(),));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: ContactListPage.routeName,
      routes: {
        ContactListPage.routeName:(context)=>ContactListPage(),
        NewContactPage.routeName:(context)=>NewContactPage(),
        ContactDetailsPage.routeName:(context)=>ContactDetailsPage(),
      },
    );
  }
}
