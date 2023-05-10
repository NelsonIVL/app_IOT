import 'dart:convert';
import 'dart:ffi';
import 'package:http/http.dart' as http;

class HttpRequests {
  Future<dynamic> getValues() async {
    var _endPoint = 'https://industrial.api.ubidots.com/api/v2.0/variables/';
    var _response = await http.get(Uri.parse(_endPoint), headers: {
      'X-Auth-Token': 'BBFF-BSGQqMO7UC03V97wpFtuZ4qr65zwHi',
      'Content-Type': 'application/json'
    });
    if (_response.statusCode == 200) {
      var _content = jsonDecode(_response.body);
      var values = [];

      _content['results'].forEach((item) {
        var newObj = {
          "id": item['id'],
          "value": item['lastValue']['value'] != null
              ? item['lastValue']['value']
              : 0.0
        };
        //print(newObj);
        values.add(newObj);
      });
      return values;
    } else {
      return null;
    }
  }

  Future<dynamic> createVariable(String label, String description) async {
    var _endPoint = 'https://industrial.api.ubidots.com/api/v2.0/variables/';
    var _response = await http.post(Uri.parse(_endPoint),
        headers: {
          'X-Auth-Token': 'BBFF-BSGQqMO7UC03V97wpFtuZ4qr65zwHi',
          'Content-Type': 'application/json'
        },
        body: jsonEncode({
          "label": label,
          "device": "645475acbd6bb4185b1a2e90",
          "description": description
        }));
    if (_response.statusCode == 200) {
      var _content = jsonDecode(_response.body);
      print(_content);
      return _content;
    } else
      return null;
  }

  Future<void> deleteVariable(String id) async {
    var _endPoint =
        'https://industrial.api.ubidots.com/api/v2.0/variables/${id}/';
    var _response = await http.delete(Uri.parse(_endPoint), headers: {
      'X-Auth-Token': 'BBFF-BSGQqMO7UC03V97wpFtuZ4qr65zwHi',
    });
    if (_response.statusCode == 204) {
      print("Variable eliminada");
    }
  }
}
