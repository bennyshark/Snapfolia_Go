import 'package:flutter/material.dart';
import 'scan_page.dart';

class home_page extends StatelessWidget {
  const home_page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            height: 35,
            color: Colors.black,
            ),
          SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Text("Snapfolia Go", style: TextStyle(fontSize: 22, color: Colors.black, fontWeight: FontWeight.w600),),
                SizedBox(
                  width: 165,
                ),
                Icon(Icons.menu, size: 35, color: Colors.black,)
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: Container(
              height: 520,
                width: 315,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.lightBlue.shade200),

                child: Column(
                  children: [
                    Container(
                      color: Colors.grey.shade500,
                      height: 60,
                      width: 320,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.menu_book_outlined, size: 40,),
                            SizedBox(
                              width: 10,
                            ),
                            Text("Guide", style: TextStyle(
                              fontSize: 28, color: Colors.white
                            ),),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 200),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(Icons.arrow_back_ios_new, size: 30, color: Colors.black54,),
                          Icon(Icons.arrow_forward_ios_outlined, size: 30, color: Colors.black54),
                        ],
                      ),
                    ),

                  ],
                )),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
             // Icon(Icons.menu_book_sharp, size: 80,),
              GestureDetector(
              onTap: () {
    Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => ScanPage()),
    );
    },
      child: Icon(
        Icons.linked_camera_outlined,
        size: 90,
        color: Colors.black,
      ),
    ),
              //Icon(Icons.info, size: 80,)
            ],
          )
        ],
      ),
    );
  }
}
