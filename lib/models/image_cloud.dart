import 'dart:convert'; // For jsonDecode and other JSON operations
import 'package:http/http.dart' as http; // For making HTTP requests

class UploadApi {
  static Future<String> uplaodImg(path) async {
    final url = Uri.parse('https://api.cloudinary.com/v1_1/dup2nxjbx/upload');
    final request = http.MultipartRequest('POST', url)
      ..fields['upload_preset'] = 'zlc5oubr'
      ..files.add(await http.MultipartFile.fromPath('file', path.path));
    final response = await request.send();
    if (response.statusCode == 200) {
      final responseData = await response.stream.toBytes();
      final responseString = String.fromCharCodes(responseData);
      final jsonMap = jsonDecode(responseString);
      return jsonMap['url'];
    }
    return "";
  }
}
