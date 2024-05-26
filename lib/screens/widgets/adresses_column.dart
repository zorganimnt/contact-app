import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../details_screen.dart';
import 'profile_parameter.dart';

class AdressesColumn extends StatelessWidget {
  const AdressesColumn({
    super.key,
    required this.widget,
    required this.phoneController,
    required this.edit,
    required this.cellController,
    required this.streetNBController, required this.emailController,
  });

  final DetailsScreen widget;
  final TextEditingController phoneController;
  final bool edit;

  final TextEditingController cellController;

  final TextEditingController streetNBController;

  final TextEditingController emailController;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ProfileParameter(
          icon: CupertinoIcons.phone,
          parameterName: 'Numero de téléphone',
          value: widget.contact.phone,
          controller: phoneController,
          edit: edit,
        ),
        const SizedBox(
          height: 10,
        ),
        //showing cell number
     edit? SizedBox():    ProfileParameter(
          icon: CupertinoIcons.envelope,
          parameterName: 'email',
          value: widget.contact.email,
          controller: emailController ,
          edit: edit,
        ),
        const SizedBox(
          height: 10,
        ),
      edit? SizedBox():  ProfileParameter(
            icon: CupertinoIcons.home,
            parameterName:  "Adresse",
            value:
                "${widget.contact.city}, ${widget.contact.city}-${widget.contact.country}",
            controller: streetNBController,
            edit: edit),
      ],
    );
  }
}
