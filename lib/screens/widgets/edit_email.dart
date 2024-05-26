import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../details_screen.dart';
import 'profile_parameter.dart';

class EditNameEmail extends StatelessWidget {
  const EditNameEmail({
    super.key,
    required this.widget,
    required this.firstController,
    required this.edit,
    required this.lastController,
    required this.emailController,
  });

  final DetailsScreen widget;
  final TextEditingController firstController;
  final bool edit;
  final TextEditingController emailController;
  final TextEditingController lastController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
         ProfileParameter(
                          icon: CupertinoIcons.profile_circled,
                          parameterName: "Nom et prénom",
                          value: "",
                          controller: firstController,
                          edit: edit),
       SizedBox(height: 10,),
        ProfileParameter(
                          icon: CupertinoIcons.envelope,
          parameterName: 'Email',
          value: widget.contact.phone,
          controller: emailController,
          edit: edit,
        ),
      ],
    );
  }
}
