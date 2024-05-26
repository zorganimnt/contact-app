import 'dart:io';

import 'package:dac_test/models/image_cloud.dart';
import 'package:dac_test/screens/widgets/profile_parameter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../main.dart';
import '../models/contacts.dart';
import 'details_screen.dart';
import 'home_screen.dart';

class AddContact extends StatefulWidget {
  const AddContact({super.key});

  @override
  State<AddContact> createState() => _AddContactState();
}

class _AddContactState extends State<AddContact> {
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
  bool edit = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        iconTheme: IconThemeData(size: 18),
        title: Text(
          "Ajouter un contact",
          style: TextStyle(fontSize: 16),
        ),
        elevation: 0.4,
        scrolledUnderElevation: 0.6,
        shadowColor: Colors.grey,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 2),
                    ]),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Séléctionner image profile"),
                      SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          pickImage();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(color: Colors.grey[400]!),
                              image: image != null
                                  ? DecorationImage(
                                      image: FileImage(
                                        image!,
                                      ),
                                      fit: BoxFit.cover)
                                  : null),
                          height: 100,
                          width: double.infinity,
                          child: Center(
                            child: Icon(
                              CupertinoIcons.photo_camera,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 2),
                    ]),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ProfileParameter(
                          icon: CupertinoIcons.profile_circled,
                          parameterName: "Nom et prénom",
                          value: "",
                          controller: firstController,
                          edit: edit),
                      const SizedBox(
                        height: 10,
                      ),
                      ProfileParameter(
                        icon: CupertinoIcons.phone,
                        parameterName: 'Numero de téléphone',
                        value: "",
                        controller: phoneController,
                        edit: edit,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ProfileParameter(
                        icon: CupertinoIcons.envelope,
                        parameterName: 'Email',
                        value: "",
                        controller: emailController,
                        edit: edit,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ProfileParameter(
                          icon: CupertinoIcons.home,
                          parameterName: "Ville",
                          value: "",
                          controller: cityController,
                          edit: edit),
                      const SizedBox(
                        height: 10,
                      ),
                      ProfileParameter(
                          icon: CupertinoIcons.flag,
                          parameterName: "Pays",
                          value: "",
                          controller: countryController,
                          edit: edit),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.teal,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: InkWell(
                            onTap: () => addingContact(context),
                            child: Center(
                              child: Text(
                                "Enregistrer",
                                style: GoogleFonts.poppins(
                                    fontSize: 14, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void addingContact(BuildContext context) async {
    final imageUrl = await UploadApi.uplaodImg(image);
    print(imageUrl); 
    int? size = await dbhelper.size(database);
    return setState(() {
      Contact ct = Contact(
          name: firstController.text,
          email: emailController.text,
          id: size!,
          country: countryController.text,
          city: cityController.text,
          phone: phoneController.text,
          imageUrl: imageUrl);
      dbhelper.insertContact(ct, database);
      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => DetailsScreen(
                  contact: ct,
                )),
      );
    });
  }

  File? image;

  Future<void> pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        image = File(pickedFile.path);
      });
    }
  }
}
