import 'package:flutter/material.dart';

import '../controller/controller.dart';

import '../models/contacts.dart';
import 'home_screen.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchBarController = TextEditingController();
  String query = "";
  Controller controller = Controller();
  List<Contact> contacts = [];

  @override
  void initState() {
    super.initState();
    searchBarController.text = query;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: SearchBar(
          surfaceTintColor: MaterialStatePropertyAll(Colors.white),
          controller: searchBarController,
          hintText: "Rechercher un contact",
          shadowColor:
              MaterialStateProperty.resolveWith((states) => Colors.transparent),
          autoFocus: true,
          onChanged: (value) async {
            setState(() {
              query = value;
            });
            contacts = await controller.researching(query);
          },
        ),
      ),
      backgroundColor: Colors.grey[200],
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             
              Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:
                      contacts.map((ct) => ContactCard(contact: ct)).toList()),
            ],
          ),
        ),
      )),
    );
  }
}
