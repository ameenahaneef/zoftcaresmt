import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:zoftcares_mt/core/constants/endpoints.dart';

class VersionService {
  Future<String> fetchVersion() async {
    final url = Uri.parse(Endpoints.versionUrl);
    final response = await http.get(url);
    print(response.statusCode);
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final version = jsonResponse['data']['version'];
      return version;
    } else {
      throw Exception('Failed to load version data');
    }
  }
}
