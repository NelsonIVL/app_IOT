import 'package:estacionamiento/Repositories/http_requests.dart';
import 'package:flutter/material.dart';

class Zone extends StatelessWidget {
  final int zoneNumber;
  final double zonePercentage;
  final bool isAdmin;
  final String zoneId;

  Zone(
      {super.key,
      required this.zoneNumber,
      required this.zonePercentage,
      required this.isAdmin,
      required this.zoneId});

  final HttpRequests http = new HttpRequests();

  Future<void> deleteVariable() async {
    try {
      await http.deleteVariable(this.zoneId);
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 170,
      height: 400,
      //color: Colors.black,
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Stack(children: [
              Container(
                height: 230,
                width: 140,
                color: Color.fromARGB(255, 89, 126, 248),
              ),
              Positioned(
                top: 25,
                left: 80,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    height: 50,
                    width: 50,
                    color: Colors.white,
                    child: Center(child: Text('${this.zonePercentage * 100}%')),
                  ),
                ),
              ),
              Visibility(
                visible: this.isAdmin,
                child: Positioned(
                    top: 180,
                    left: 90,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        height: 40,
                        width: 40,
                        color: Color.fromARGB(255, 252, 110, 110),
                        child: IconButton(
                            onPressed: () {
                              print("Hola");
                              deleteVariable();
                            },
                            icon: Icon(
                              Icons.delete,
                              color: Color.fromARGB(255, 255, 255, 255),
                            )),
                      ),
                    )),
              )
            ]),
          ),
          SizedBox(
            height: 10,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Container(
              width: 140,
              height: 30,
              color: Color.fromARGB(255, 176, 141, 237),
              child: Center(
                  child: Text(
                'Zone ${zoneNumber}',
                style: TextStyle(color: Colors.white),
              )),
            ),
          ),
        ],
      ),
    );
  }
}
