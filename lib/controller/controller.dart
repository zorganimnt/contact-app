import 'package:dio/dio.dart';

import '../constants.dart';
import '../main.dart';
import '../models/contacts.dart';

class Controller {
  final dio = Dio();

  Future fetchData() async {
    List<Contact> listContact = [];
    listContact = await dbhelper.getContact(database);
    return listContact;
  }

  Future researching(String query) async {
    List<Contact> listContact = [];
    int? dbsize = await dbhelper.size(database);
    if (dbsize! > 0) {
      listContact = await dbhelper.researchContact(query, database);

      return listContact;
    }
  }
}
