import 'package:dac_test/controller/controller.dart';
import 'package:dac_test/screens/details_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/contacts.dart';
import 'add_contact.dart';
import 'widgets/more_info.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController searchBarController = TextEditingController();
    List<Contact> contacts = [];
    Controller controller = Controller();
    return RefreshIndicator(
       onRefresh: () async {
                await controller.fetchData(); 
              },
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          iconTheme: IconThemeData(size: 18),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/searchPage');
                },
                icon: Icon(CupertinoIcons.search))
          ],
          surfaceTintColor: Colors.white,
          elevation: 0.7,
          title: Text(
            "Acceuil",
            style: TextStyle(fontSize: 16),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FutureBuilder(
                    future: controller.fetchData(),
                    builder: (context, snapshot) {
                      if (snapshot.data == null) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: Colors.blueAccent,
                          ),
                        );
                      } else {
                        contacts = snapshot.data;
                        return Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: contacts
                                .map((ct) => ContactCard(contact: ct))
                                .toList());
                      }
                    })
              ],
            ),
          ),
        ),
        //button for adding contact
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddContact()),
            );
          },
          backgroundColor: Colors.teal,
          child: const Icon(
            CupertinoIcons.person_add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class ContactCard extends StatefulWidget {
  const ContactCard({
    super.key,
    required this.contact,
  });
  final Contact contact;

  @override
  State<ContactCard> createState() => _ContactCardState();
}

class _ContactCardState extends State<ContactCard> {
  bool moreInfo = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 2),
            ]),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DetailsScreen(
                          contact: widget.contact,
                        )),
              );
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //profil picture, name and dropdown row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.all(25.0),
                            child: Container(),
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(180),
                            color: Colors.grey[300],
                            image: DecorationImage(
                                image: widget.contact.imageUrl == ""
                                    ? NetworkImage(
                                        "https://www.prolandscapermagazine.com/wp-content/uploads/2022/05/blank-profile-photo.png")
                                    : NetworkImage(widget.contact.imageUrl),
                                fit: BoxFit.fill),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        //user name
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 3,
                          child: Text(
                            "${widget.contact.name}",
                            style: GoogleFonts.poppins(fontSize: 16),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    //allowing more information or less using a dropdown or dropup
                    moreInfo
                        ? IconButton(
                            onPressed: () {
                              setState(() {
                                moreInfo = false;
                              });
                            },
                            icon: const Icon(
                              CupertinoIcons.chevron_up,
                              size: 20,
                              color: Colors.black87,
                            ),
                          )
                        : IconButton(
                            onPressed: () {
                              setState(() {
                                moreInfo = true;
                              });
                            },
                            icon: const Icon(
                              CupertinoIcons.chevron_down,
                              size: 20,
                              color: Colors.black87,
                            ),
                          )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                // adresse and phone number
                moreInfo
                    ? MoreInformation(
                        contact: widget.contact,
                      )
                    : const SizedBox()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
