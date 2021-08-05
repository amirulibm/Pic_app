import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:t1/model/shift_model.dart';
import 'package:t1/scan.dart';
import 'package:t1/scan2.dart';

class DetailScreen extends StatefulWidget {
  final Shift item;

  const DetailScreen({Key? key, required this.item}) : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  var item;

  String _scanBarcode = 'scan';

  @override
  void initState() {
    super.initState();
  }

  /*Future<void> startBarcodeScanStream() async {
    FlutterBarcodeScanner.getBarcodeStreamReceiver(
            '#ff6666', 'Cancel', true, ScanMode.BARCODE)!
        .listen((barcode) => print(barcode));
  }

  Future<void> scanQR_in() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  Future<void> scanQR_out() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  Future<void> scanQR_break_start() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  Future<void> scanQR_break_end() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }*/

  @override
  Widget build(BuildContext context) {
    // Use the Todo to create the UI.
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "${widget.item.attendance_syif_date}"), //'item.job_events_name'),
      ),
      body: new Column(
        children: <Widget>[
          new Card(
            child: new Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text('Scan result : $_scanBarcode\n',
                    style: TextStyle(fontSize: 20)),
                const ListTile(
                  title: const Text('PIC Scan'),
                  subtitle: const Text('Scan result :'),
                ),
              ],
            ),
          ),
          new GestureDetector(
            child: new Card(
              child: ListTile(
                title: Text('Attendant Check In'),
                subtitle: Text('press'),
                trailing: Icon(Icons.crop_free_sharp),
                isThreeLine: true,
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Scanner()),
              );
            },
          ),
          new GestureDetector(
            child: new Card(
              child: ListTile(
                title: Text('Break Start'),
                subtitle: Text('press'),
                trailing: Icon(Icons.crop_free_sharp),
                isThreeLine: true,
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Scanner()),
              );
            },
          ),
          new GestureDetector(
            child: new Card(
              child: ListTile(
                title: Text('Break End'),
                subtitle: Text('press'),
                trailing: Icon(Icons.crop_free_sharp),
                isThreeLine: true,
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Scanner()),
              );
            },
          ),
          new GestureDetector(
            child: new Card(
              child: ListTile(
                title: Text('Attendant Check Out'),
                subtitle: Text('press'),
                trailing: Icon(Icons.crop_free_sharp),
                isThreeLine: true,
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Scanner()),
              );
            },
          ),
        ],
      ),
    );
  }
}
