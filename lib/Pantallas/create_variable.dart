import 'package:estacionamiento/Repositories/http_requests.dart';
import 'package:flutter/material.dart';

class CreateVariable extends StatefulWidget {
  const CreateVariable({super.key});

  @override
  State<CreateVariable> createState() => _CreateVariableState();
}

class _CreateVariableState extends State<CreateVariable> {
  final HttpRequests http = new HttpRequests();
  final TextEditingController labelController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  Future<void> createVariable() async {
    try {
      await http.createVariable(
          labelController.text, descriptionController.text);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 179, 182, 183),
      appBar: AppBar(title: Text("Nueva Variable a Ubidots")),
      body: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            height: 500,
            width: 300,
            color: Color.fromARGB(255, 254, 255, 255),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    controller: labelController,
                    decoration: InputDecoration(
                      labelText: 'Label',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    controller: descriptionController,
                    decoration: InputDecoration(
                      labelText: 'Descripcion',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                    onPressed: () {
                      createVariable();
                      //print(descriptionController.text);
                      //print(labelController.text);
                      Navigator.pop(context);
                    },
                    child: Text("Crear Variable"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
