import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:http/http.dart' as http;

import 'detailspage.dart';

class HomePage extends StatefulWidget {
   const HomePage({Key? key}) : super(key: key);

   @override
   State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final GlobalKey _globalKey = GlobalKey();
  //int _counter = 100;
  //int temp = 0;
  bool show_Scanner = false;

  @override
  void initState() {
    super.initState();
  }

  // void _decrementCounter() {
  //   setState(() {
  //     _counter--;
  //     show_Scanner = false;
  //   });
  // }

  QRViewController? controller;
  Barcode? barcode;

  void qr(QRViewController controller) async {
    this.controller = controller;
    controller.scannedDataStream.listen((barcode) {
      this.barcode = barcode;
      controller.stopCamera();
    });
    // controller.scannedDataStream.listen((result) {
    //   setState(() {
    //     this.result = result;
    //     controller.stopCamera();
    //   });
    // });
  }

  Future scanned(String text) async {
    var url = "https://softerp.in/tiffin_test/api/add_scan.php";
    var response = await http.post(Uri.parse(url),
        body: {
          "text": barcode.toString(),
        });
    var data = json.decode(response.body);
    if (data['Status_code'] =="200") {
      Navigator.push(context,MaterialPageRoute(builder: (context) => DetailsPage()));
    } else {
      Text('Wrong qr, scan again');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFCCCCFF), Color(0xFFD8BFD8)],
              begin: Alignment.centerRight,
              end: Alignment.centerLeft,
              tileMode: TileMode.clamp,
            ),
          ),
          //child: Drawer(),
        ),
      ),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          MaterialButton(
              textColor: Colors.black,
              elevation: 5,
              color: Colors.cyan.shade100,
              onPressed: () {
                setState(() {
                  show_Scanner = true;
                });
                _globalKey.currentState!.activate();
              },
              child: const Text("Scan QR Code",)
          ),
          show_Scanner ?
          SizedBox(
            height: 300,
            width: 300,
            child: QRView(
              key: _globalKey,
              onQRViewCreated: qr,
            ),
          ) :
          Container(),
          Center(
            child: (barcode != null) ? Text('${barcode!.code}') : Text('scan a code'),
          ),
          ElevatedButton(
            onPressed: (){
              Navigator.push(context,MaterialPageRoute(builder: (context) => DetailsPage()));
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple.shade300,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
            ),
            child: const Text('Scan',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }
}
