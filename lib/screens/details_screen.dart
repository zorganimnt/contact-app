import 'package:dac_test/screens/home_screen.dart';
import 'package:dac_test/screens/widgets/profile_parameter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../main.dart';
import '../models/contacts.dart';
import 'widgets/adresses_column.dart';
import 'widgets/edit_adress.dart';
import 'widgets/edit_email.dart';
import 'widgets/picture_name.dart';

class DetailsScreen extends StatefulWidget {
  final Contact contact;
  const DetailsScreen({super.key, required this.contact});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  bool edit = false;
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController firstController = TextEditingController();
  TextEditingController lastController = TextEditingController();
  TextEditingController cellController = TextEditingController();
  TextEditingController streetNBController = TextEditingController();
  TextEditingController birthController = TextEditingController();
  TextEditingController streetNController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(size: 18),
        title: Text(
          widget.contact.name,
          style: TextStyle(fontSize: 16),
        ),
        elevation: 0.4,
        scrolledUnderElevation: 0.6,
        shadowColor: Colors.grey,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const SizedBox(
                  height: 30,
                ),
                //picture container, name and email
                PictureName(widget: widget),
                const SizedBox(
                  height: 30,
                ),
                //showing textfield for name and email case editing true
                edit
                    ? EditNameEmail(
                        widget: widget,
                        firstController: firstController,
                        edit: edit,
                        lastController: lastController,
                        emailController: emailController,
                      )
                    : const SizedBox(),
                //showing tel, cell, others address
                AdressesColumn(
                    widget: widget,
                    phoneController: phoneController,
                    edit: edit,
                    cellController: cellController,
                    emailController: emailController,
                    streetNBController: streetNBController),
                edit
                    ? EditAddress(
                        widget: widget,
                        streetNController: streetNController,
                        edit: edit,
                        cityController: cityController,
                        countryController: countryController)
                    : const SizedBox(),
                const SizedBox(
                  height: 10,
                ),

                edit
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  edit = false;
                                });
                              },
                              child: Text(
                                "Annuler",
                                style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              )),
                          ElevatedButton(
                              onPressed: () {
                                savingModification(context);
                              },
                              child: Text(
                                "Enregistrer",
                                style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ))
                        ],
                      )
                    : Column(
                        children: [
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.teal,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: InkWell(
                                onTap: () => modification(),
                                child: Center(
                                  child: Text(
                                    "Modifier",
                                    style: GoogleFonts.poppins(
                                        fontSize: 14, color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.redAccent,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: InkWell(
                                onTap: () {
                                  dbhelper.delete(widget.contact.id, database);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const HomeScreen()),
                                  );
                                },
                                child: Center(
                                  child: Text(
                                    "Supprimer",
                                    style: GoogleFonts.poppins(
                                        fontSize: 14, color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void savingModification(BuildContext context) {
    return setState(() {
      edit = false;
      Contact ct = Contact(
          name: firstController.text,
          email: emailController.text,
          id: widget.contact.id,
          country: countryController.text,
          city: cityController.text,
          phone: phoneController.text,
          imageUrl: widget.contact.imageUrl);
      dbhelper.update(ct, database);
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => DetailsScreen(
                  contact: ct,
                )),
      );
    });
  }

  void modification() {
    return setState(() {
      edit = true;
      phoneController = TextEditingController(text: widget.contact.phone);
      cellController = TextEditingController(text: widget.contact.phone);
      emailController = TextEditingController(text: widget.contact.email);
      firstController = TextEditingController(text: widget.contact.name);
      cityController = TextEditingController(text: widget.contact.city);
      countryController = TextEditingController(text: widget.contact.country);
    });
  }
}
