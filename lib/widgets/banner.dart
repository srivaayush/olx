import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class banner extends StatelessWidget {
  const banner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Neumorphic(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height*0.25,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [

                      Text(
                        'CARS',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                      ),
                      SizedBox(height:20),
                    ],
                  ),
                   Neumorphic(
                    child: Image.network('https://firebasestorage.googleapis.com/v0/b/myolx-7f64c.appspot.com/o/icons%2Ficons8-car-64.png?alt=media&token=6d3cbb6d-033c-4070-ab18-53b0584aedfc'),
                  )
                ],
              ),
            ),
            Row(
              children: [
                Expanded(child: NeumorphicButton(
                  onPressed: (){},
                  style: NeumorphicStyle(color: Colors.lightGreen),
                  child: Text('Buy',textAlign: TextAlign.center,
                    style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,

                  ),),

                )),
                SizedBox(width: 20,),
                Expanded(child: NeumorphicButton(
                  onPressed: (){},
                  style: NeumorphicStyle(color: Colors.orangeAccent),
                  child: Text('Sell',textAlign: TextAlign.center,
                    style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),),
                )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
