import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:http/http.dart' as http;

import 'dashboard.dart';

class ScannerPage extends StatefulWidget {
   const ScannerPage({Key? key}) : super(key: key);

   @override
   State<ScannerPage> createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {

  TextEditingController adminqrcode = TextEditingController();
  TextEditingController text = TextEditingController();
  TextEditingController custid = TextEditingController();
  TextEditingController tottifcnt = TextEditingController();
  TextEditingController avbtifcnt = TextEditingController();
  TextEditingController recdate = TextEditingController();
  TextEditingController expdate = TextEditingController();

  Future login(String username,String password)async{
    var url = "https://softerp.in/tiffin_test/api/add_scan.php";
    var response = await http.post(Uri.parse(url),body: {
      "adminqrcode" : adminqrcode.text,
      "text" : text.text,
      "custid" : custid.text,
      "tot_tiffin_count" : tottifcnt.text,
      "available_tiffin_count" : avbtifcnt.text,
      "recharge_dt" : recdate.text,
      "expirydate" : expdate.text,
    });
    var data = json.decode(response.body);

  }


  final GlobalKey _globalKey = GlobalKey();
  bool showScanner = false;

  @override
  void initState() {
    super.initState();
  }

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
      Navigator.push(context,MaterialPageRoute(builder: (context) => DashboardPage()));
    } else {
      const Text('Wrong qr, scan again');
    }
  }


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
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 10,),
            // MaterialButton(
            //     textColor: Colors.black,
            //     elevation: 5,
            //     color: Colors.cyan.shade100,
            //     onPressed: () {
            //       setState(() {
            //         showScanner = true;
            //       });
            //       _globalKey.currentState!.activate();
            //     },
            //     child: const Text("Scan QR Code",)
            // ),
            // showScanner ?
            // SizedBox(
            //   height: 300,
            //   width: 300,
            //   child: QRView(
            //     key: _globalKey,
            //     onQRViewCreated: qr,
            //   ),
            // ) :
            // Container(),
            Center(
              child: SizedBox(
                height: 300, width: 300,
                child: QRView(
                  key: _globalKey,
                  onQRViewCreated: qr,
                  cameraFacing: CameraFacing.back,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: (){

              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF68A7AD),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
              ),
              child: const Text('Scan',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 60),
              decoration: BoxDecoration(
                color: Colors.teal.shade50,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Scan qr code :", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black),),
                  SizedBox(height: 10,),
                  Container(
                    height: 30,
                    width: 150,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      border: Border.all(color: Colors.black26),
                      borderRadius: BorderRadius.circular(5)
                    ),
                    child: (barcode != null) ? Text('${barcode!.code}', style: TextStyle(fontWeight: FontWeight.bold),) : const Text(''),
                  ),
                  SizedBox(height: 7,),
                  Container(
                    height: 30,
                    width: 150,
                    decoration: BoxDecoration(
                        //color: Colors.grey.shade300,
                        border: Border.all(color: Colors.black26),
                        borderRadius: BorderRadius.circular(5)
                    ),
                    child: TextFormField(
                      controller: custid,
                      enabled: false,
                    ),
                  ),
                  SizedBox(height: 7,),
                  Container(
                    height: 30,
                    width: 150,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        border: Border.all(color: Colors.black26),
                        borderRadius: BorderRadius.circular(5)
                    ),
                    child: Text(''),
                  ),
                  SizedBox(height: 20,),
                  Text("Total tiffin count :", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black),),
                  SizedBox(height: 10,),
                  Container(
                    height: 30,
                    width: 150,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        border: Border.all(color: Colors.black26),
                        borderRadius: BorderRadius.circular(5)
                    ),
                    child: Text(''),
                  ),
                  SizedBox(height: 20,),
                  Text("Available tiffin count :", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black),),
                  SizedBox(height: 10,),
                  Container(
                    height: 30,
                    width: 150,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        border: Border.all(color: Colors.black26),
                        borderRadius: BorderRadius.circular(5)
                    ),
                    child: Text(''),
                  ),
                  SizedBox(height: 20,),
                  Text("Recharge date :", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black),),
                  SizedBox(height: 10,),
                  Container(
                    height: 30,
                    width: 150,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        border: Border.all(color: Colors.black26),
                        borderRadius: BorderRadius.circular(5)
                    ),
                    child: Text(''),
                  ),
                  SizedBox(height: 20,),
                  Text("Expiry date:", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black),),
                  SizedBox(height: 10,),
                  Container(
                    height: 30,
                    width: 150,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        border: Border.all(color: Colors.black26),
                        borderRadius: BorderRadius.circular(5)
                    ),
                    child: Text(''),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
