import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:messproject/scannerpage.dart';


class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF82DBD8), Color(0xFF3BACB6)],
              begin: Alignment.centerRight,
              end: Alignment.centerLeft,
              tileMode: TileMode.clamp,
            ),
          ),
          //child: Drawer(),
        ),
      ),
      drawer: Drawer(
          backgroundColor: Colors.teal.shade50,
          child: Column(
            children:  [
              SizedBox(height: 100,),
              InkWell(
                onTap: () {
                  Navigator.push(context,MaterialPageRoute(builder: (context) => DashboardPage()));
                },
                child: Row(
                  children: [
                    SizedBox(width: 20,),
                    Icon(Icons.home, color: Colors.black45,),
                    SizedBox(width: 30,),
                    Text("Dashboard", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black54),),
                  ],
                ),
              ),
              SizedBox(height: 20,),
              InkWell(
                onTap: () {
                  Navigator.push(context,MaterialPageRoute(builder: (context) => ScannerPage()));
                },
                child: Row(
                  children: [
                    SizedBox(width: 20,),
                    Icon(Icons.qr_code_scanner_rounded, color: Colors.black45,),
                    SizedBox(width: 30,),
                    Text("Scan", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black54),),
                  ],
                ),
              ),
              SizedBox(height: 20,),
              InkWell(
                onTap: () {
                  Navigator.push(context,MaterialPageRoute(builder: (context) => ScannerPage()));
                },
                child: Row(
                  children: [
                    SizedBox(width: 20,),
                    Icon(Icons.history_rounded, color: Colors.black45,),
                    SizedBox(width: 30,),
                    Text("Tiffin History", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black54),),
                  ],
                ),
              ),
              SizedBox(height: 20,),
              InkWell(
                onTap: () {
                  Navigator.push(context,MaterialPageRoute(builder: (context) => ScannerPage()));
                },
                child: Row(
                  children: [
                    SizedBox(width: 20,),
                    Icon(Icons.password, color: Colors.black45,),
                    SizedBox(width: 30,),
                    Text("Change Password", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black54),),
                  ],
                ),
              ),
            ],
          )
      ),
      body: SizedBox.expand(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 100,),
            InkWell(
                  onTap: () {
                    Navigator.push(context,MaterialPageRoute(builder: (context) => ScannerPage()));
                  },
                  child: Container(
                    height: 200, width: 150,
                    decoration: BoxDecoration(
                      color: Color(0xFF68A7AD),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        Text("Please scan!", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
                        Icon(Icons.qr_code_scanner_rounded, color: Colors.white, size: 100,),
                      ],
                    ),
                  ),
                ),
          ],
        ),
      ),

    );
  }
}
