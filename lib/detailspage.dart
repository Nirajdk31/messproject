import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Container(
      padding: const EdgeInsets.only(top: 10, bottom: 10, right: 8, left: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey.shade300,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:  const [
          Text("Scan qr code: ", style: TextStyle(fontSize: 15),),
          SizedBox(height: 10,),
          Text("Username: ", style: TextStyle(fontSize: 15),),
          SizedBox(height: 10,),
          Text("Recharge Id: ", style: TextStyle(fontSize: 15),),
          SizedBox(height: 10,),
          Text("Total tiffin count: ", style: TextStyle(fontSize: 15),),
          SizedBox(height: 10,),
          Text("Available tiffin count: ", style: TextStyle(fontSize: 15),),
          SizedBox(height: 10,),
          Text("Recharge date: ", style: TextStyle(fontSize: 15),),
          SizedBox(height: 10,),
          Text("Expiry date: ", style: TextStyle(fontSize: 15),),
        ],
      ),
    ),
        ),
    );
  }
}
