import 'package:flutter/material.dart';

class RateUs extends StatelessWidget {
  static const String id = 'rate_us';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   leading: IconButton(
        //     icon: Icon(Icons.arrow_back, color: Colors.white),
        //     onPressed: () => Navigator.of(context).pop(),
        //   ),
        // ),
        //backgroundColor: Colors.green,
        body: ListView(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.1,
              decoration: new BoxDecoration(
                borderRadius: new BorderRadius.vertical(
                  bottom: Radius.elliptical(350.0, 20.0),
                ),
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/images/bandeira.jpeg')),
              ),
            ),
            Positioned(
              //left: 10.0,
              top: 20,
              child: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ],
        ),
      ],
    ));
  }
}
