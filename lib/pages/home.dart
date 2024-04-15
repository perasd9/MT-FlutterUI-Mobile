import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Row(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(40.0, 50.0, 0, 0),
              child: Image(
                  image: AssetImage("assets/images/hamburger.png")
              ),
            )
          ],
        ),
        toolbarHeight: 100.0,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/slika pozadina.png"),
                fit: BoxFit.cover)),
        child: Padding(
          padding: const EdgeInsets.only(left: 40.0),
          child: Container(
            margin: const EdgeInsets.only(bottom: 80.0),
            child : Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  "Goals\nand\nHabits",
                  style: TextStyle(
                      fontSize: 45,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Raleway"
                  ),
                ),

                Container(
                  margin: const EdgeInsets.only(top: 50.0),
                  child : ElevatedButton(

                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.fromLTRB(100.0, 15.0, 100.0, 15.0),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, "/programs");
                      },
                      child: const Text(
                        "START",
                        style: TextStyle(
                            fontFamily: "Raleway",
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF040606)
                        ),
                      )
                  ),
                )
              ],
            ),
          ),
        )
      ),
    );
  }
}
