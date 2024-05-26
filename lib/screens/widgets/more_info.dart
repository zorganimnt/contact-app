import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../models/contacts.dart';

class MoreInformation extends StatelessWidget {
  final Contact contact;
  const MoreInformation({
    super.key,
    required this.contact,
  });

  Future<void> _lauchGmail(String email) async {
    final Uri url = Uri(scheme: 'mailto', path: email);
    if (!await launchUrl(url)) {
      //await launchUrl(url);
      throw 'Could not lauch $url';
    }
  }

  Future<void> _lauchPhone(String number) async {
    final Uri url = Uri(scheme: 'tel', path: number);
    if (!await launchUrl(url)) {
      //await launchUrl(url);
      throw 'Could not lauch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 70, right: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${contact.phone}",
            style: GoogleFonts.montserrat(fontSize: 15, fontWeight: FontWeight.bold),
          ),
            Text(
            "${contact.email}",
            style: GoogleFonts.montserrat(fontSize: 15),
          ),
          Text(
            "${contact.city}, ${contact.country}",
            style: GoogleFonts.montserrat(fontSize: 15),
          ),
         
          Padding(
            padding: const EdgeInsets.symmetric(vertical :8.0),
            child: Divider( color: Colors.grey[300], thickness: 1,),
          ),
          
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    _lauchPhone(contact.phone);
                  },
                  child: const Icon(
                    CupertinoIcons.phone_circle,
                    size: 30,
                    color: Colors.teal,
                  ),
                ),
                InkWell(
                  onTap: () {
                    _lauchGmail(contact.email);
                  },
                  child: const Icon(
                   CupertinoIcons.envelope_circle,
                    size: 30,
                    color: Colors.teal,
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: const Icon(
                  CupertinoIcons.location_circle,
                    size: 30,
                    color: Colors.teal,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
