import 'package:estacionamiento/Pantallas/home_page2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';

class LogIn extends StatelessWidget {
  const LogIn({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        initialData: FirebaseAuth.instance.currentUser,
        builder: ((context, snapshot) {
          if (!snapshot.hasData) {
            return SignInScreen(
              showAuthActionSwitch: false,
              subtitleBuilder: (context, action) {
                return Padding(
                  padding: EdgeInsets.all(1),
                  child:
                      Text("Bienvenido a la app de estacionamiento del ITESO"),
                );
              },
              headerBuilder: (context, constraints, shrinkOffset) {
                return Padding(
                  padding: EdgeInsets.all(20),
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Container(
                      height: 1,
                      //color: Colors.black,
                      child: Image.asset(
                        './assets/images/Logo_Iteso.png',
                        height: 100,
                      ),
                    ),
                  ),
                );
              },
              footerBuilder: (context, action) {
                return Padding(
                  padding: EdgeInsets.all(20),
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Center(
                        child: Text(
                      "La mejor manera de encontrar lugar",
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    )),
                  ),
                );
              },
              providerConfigs: [EmailProviderConfiguration()],
            );
          }
          return HomePage2();
        }));
  }
}
