import 'package:addressbook/models/contact_model.dart';
import 'package:addressbook/pages/contact_details_page.dart';
import 'package:addressbook/pages/new_contact_page.dart';
import 'package:addressbook/providers/contact_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ContactListPage extends StatefulWidget {
  static const String routeName = '/';

  const ContactListPage({Key? key}) : super(key: key);

  @override
  State<ContactListPage> createState() => _ContactListPageState();
}

class _ContactListPageState extends State<ContactListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact List'),
      ),
      body: Consumer<ContactProvider>(
        builder: (context, provider, _) => ListView.builder(
          itemCount: provider.contactList.length,
          itemBuilder: (context, index) {
            final contact = provider.contactList[index];
            return Dismissible(
              key: UniqueKey(),
              direction: DismissDirection.endToStart,
              background: Container(
                alignment: Alignment.centerRight,
                color: Colors.red,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ),
              ),
              confirmDismiss: showConfirmationDialog,
              child: Card(
                elevation: 8,
                child: ListTile(
                  onTap: () => Navigator.pushNamed(
                      context, ContactDetailsPage.routeName,
                      arguments: contact),
                  leading: CircleAvatar(
                    child: Text(contact.name.substring(0, 2).toUpperCase()),
                  ),
                  title: Text(contact.name),
                  trailing: IconButton(
                    icon: Icon(contact.favourite
                        ? Icons.favorite
                        : Icons.favorite_border),
                    onPressed: () {
                      provider.updateFavorite(index);
                    },
                  ),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, NewContactPage.routeName),
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<bool?> showConfirmationDialog(DismissDirection direction) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text('Delete'),
              content: const Text('Are you Sure to delete this item?'),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context, false);
                    },
                    child: const Text('Cancel')),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context, true);
                    },
                    child: Text('Yes'))
              ],
            ));
  }
}
