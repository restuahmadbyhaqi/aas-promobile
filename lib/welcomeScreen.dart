import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class WelcomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context){
    return Material(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 1.6,
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 1.6,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 74, 80, 239),
                    borderRadius: BorderRadius.only(bottomRight: Radius.circular(70)),
                  ),
                  child: Center(
                    child: Image.asset("alquran.png", scale: 0.8),
                  ),
                ),
                Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Text(
                  "IslamHub",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                    wordSpacing: 2,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child:Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height /2.666,
                padding: EdgeInsets.only(top: 40, bottom: 30),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 74, 80, 239),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child:Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height /2.666,
                padding: EdgeInsets.only(top: 40, bottom: 30),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(70),
                  ),
                ),
                child: Column(
                  children: [
                    Text(
                      "Hallo User",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                        wordSpacing: 2,
                      ),
                      ),
                      SizedBox(height: 15),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 35),
                        child: Text(
                          "Mari Belajar Agama, Insyaallah Berkah di Setiap Langkah",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 17,
                            color: Colors.black.withOpacity(0.6),
                          ),
                        ),
                      ),
                      SizedBox(height: 60),
                      Material(
                        color: Color.fromARGB(255, 74, 80, 239),
                        borderRadius: BorderRadius.circular(10),
                        child: InkWell(
                          onTap: (){},
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 5, horizontal: 60),
                              child: Text(
                                "Get Start",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1,
                                ),
                              ),
                          )
                        ),
                      )
                  ],
                )
              ),
            ),
          ],
        ),
      ),
    );
  }
}