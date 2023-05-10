import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estacionamiento/Pantallas/create_variable.dart';
import 'package:estacionamiento/Repositories/http_requests.dart';
import 'package:estacionamiento/Widget/zone.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage2 extends StatefulWidget {
  const HomePage2({super.key});

  @override
  State<HomePage2> createState() => _HomePage2State();
}

class _HomePage2State extends State<HomePage2> {
  final HttpRequests http = new HttpRequests();
  late bool isAdmin = false;
  late User? user = FirebaseAuth.instance.currentUser;
  List lista = [];
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    getUserData();
    _timer = Timer.periodic(Duration(seconds: 5), (timer) async {
      await getDataUbidots();
    });
  }

  Future<void> getDataUbidots() async {
    try {
      dynamic data = await http.getValues() as List;
      setState(() {
        this.lista = data;
        this.lista = new List.from(this.lista.reversed);
        print(this.lista);
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> getUserData() async {
    FirebaseFirestore.instance
        .collection('users')
        .where('user_id', isEqualTo: user!.uid)
        .get()
        .then((snapshot) => {
              this.isAdmin = snapshot.docs[0].data()['role'] == 'ADMIN',
              print(snapshot.docs[0].data()),
              print(this.isAdmin)
            });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ITESO ParkSense'),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Color.fromARGB(255, 179, 182, 183),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 650,
                //color: Colors.brown,
                margin: EdgeInsets.all(2),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 30,
                      crossAxisSpacing: 5,
                      mainAxisExtent: 300),
                  itemCount: this.lista.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Zone(
                      zoneNumber: index + 1,
                      zonePercentage: this.lista[index]['value'],
                      isAdmin: this.isAdmin,
                      zoneId: this.lista[index]['id'],
                    );
                  },
                ),
              ),
              Visibility(
                  visible: isAdmin,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => CreateVariable())));
                    },
                    child: Text("Crear variable"),
                  )),
              Container(
                width: 150,
                child: ElevatedButton(
                  onPressed: (() async {
                    await FirebaseAuth.instance.signOut();
                  }),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [Text("Cerrar sesion"), Icon(Icons.key)],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
