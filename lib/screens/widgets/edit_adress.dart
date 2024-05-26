import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../details_screen.dart';
import 'profile_parameter.dart';

class EditAddress extends StatelessWidget {
  const EditAddress({
    super.key,
    required this.widget,
    required this.streetNController,
    required this.edit,
    required this.cityController,
    required this.countryController,
  });

  final DetailsScreen widget;
  final TextEditingController streetNController;
  final bool edit;

  final TextEditingController cityController;

  final TextEditingController countryController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
      
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
      ],
    );
  }
}
