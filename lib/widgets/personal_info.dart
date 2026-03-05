import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class PersonalInfo extends StatelessWidget {
  const PersonalInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Desarrollador de la App",
            style: GoogleFonts.arimo(
              fontSize: 30,
              fontWeight: FontWeight(700),
              fontStyle: FontStyle.italic,
            ),
          ),
          Center(
            child: Container(
              padding: EdgeInsets.only(
                top: 10,
                left: 20,
                right: 20,
                bottom: 20,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
              child: Column(
                children: [
                  Text("Foto"),
                  SizedBox(
                    width: 200,
                    height: 200,
                    child: Image(
                      image: AssetImage('assets/images/Foto_Personal_2.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: 10, height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "NOMBRE:\nCORREO:",
                        style: GoogleFonts.arimo(fontWeight: FontWeight(700)),
                      ),
                      Text(
                        "César Antonio Aybar Vargas\nantonio_c1723@hotmail.com",
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Center(
            child: Container(
              margin: EdgeInsets.only(top: 20),
              padding: EdgeInsets.only(
                top: 10,
                left: 20,
                right: 20,
                bottom: 20,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
              child: Column(
                children: [
                  Text("Medios de Contacto"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {
                          launchUrl(
                            Uri.parse(
                              'https://do.linkedin.com/in/c%C3%A9sar-aybar-834959388',
                            ),
                          );
                        },
                        child: Column(
                          children: [Icon(Icons.business), Text("LinkedIn")],
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          launchUrl(
                            Uri.parse('https://wa.me/qr/W5RDXCZAYLLHG1'),
                          );
                        },
                        child: Column(
                          children: [
                            Icon(Icons.phone_android_rounded),
                            Text("WhatsApp"),
                          ],
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          launchUrl(Uri.parse('https://github.com/CesarAntIT'));
                        },
                        child: Column(
                          children: [Icon(Icons.code), Text("GitHub")],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
