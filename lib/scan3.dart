import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:flutter_beep/flutter_beep.dart';
import 'package:http/http.dart' as http;

class Scanner extends StatefulWidget {
  final String shift;
  final String btn;
  final String date;
  final String attshift;

  Scanner({this.shift, this.btn, this.date, this.attshift});

  @override
  _ScannerState createState() => _ScannerState();
}

class _ScannerState extends State<Scanner> {
  TextEditingController _textFieldController = TextEditingController();
  String codeDialog;
  String valueText;

  Future<void> _displayTextInputDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Key In IC Number'),
            content: TextField(
              onChanged: (value) {
                setState(() {
                  valueText = value;
                });
              },
              controller: _textFieldController,
              decoration: InputDecoration(hintText: "IC Number"),
            ),
            actions: <Widget>[
              FlatButton(
                color: Colors.red,
                textColor: Colors.white,
                child: Text('CANCEL'),
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                  });
                },
              ),
              FlatButton(
                color: Colors.green,
                textColor: Colors.white,
                child: Text('Submit'),
                onPressed: () {
                  setState(() {
                    codeDialog = valueText;
                    Navigator.pop(context);
                  });
                },
              ),
            ],
          );
        });
  }

  Future getshiftlist() async {
    var url = Uri.parse(
        'https://wikicareer.com.my/api/list_attendance/${widget.shift}');
    var response = await http.get(url, headers: {
      "Authorization":
          "Bearer ${await SharedPref.getStringFromSF(SharedPref.TOKEN)}"
    });

    var jsonData = jsonDecode(response.body)["attendances"];
    List<Shift_list> shiftlist = [];

    for (var u in jsonData) {
      Shift_list shiftlists = Shift_list(
        u['attendance_id'],
        u['user_id'],
        u['user_full_name'],
        u['attendance_check_in'],
        u['attendance_break'],
        u['attendance_break_end'],
        u['attendance_check_out'],
        u['user_ic_no'],
      );
      shiftlist.add(shiftlists);
    }
    print(shiftlist.length);
    return shiftlist;
  }

  Future<attcount> fetch_count() async {
    var url =
        Uri.parse('https://wikicareer.com.my/api/att_count/${widget.shift}');
    var response = await http.get(url, headers: {
      "Authorization":
          "Bearer ${await SharedPref.getStringFromSF(SharedPref.TOKEN)}"
    });

    if (response.statusCode == 200) {
      Map<String, dynamic> responseJson = jsonDecode(response.body);
      return attcount.fromJson(responseJson);
    }
  }

  Barcode result;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController controller;

  // @override
  // void initState() {
  //  super.initState();
  // }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.date} \t SHIFT: ${widget.attshift}'),
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  _displayTextInputDialog(context);
                },
                child: Icon(Icons.more_vert),
              )),
        ],
      ),
      body: Stack(
        children: [
          Column(
            children: <Widget>[
              Expanded(
                child: Container(
                  child: FutureBuilder(
                    future: fetch_count(),
                    builder: (context, snapshot) {
                      if (snapshot.data == null) {
                        return Container(
                          child: Text("No Data"),
                        );
                      } else {
                        if (widget.btn == '1') {
                          return Container(
                            child: Center(
                              child: Text(
                                  'Total Check In : ${snapshot.data.checkin_count}',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 22.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ),
                          );
                        } else if (widget.btn == '2') {
                          return Container(
                            child: Center(
                              child: Text(
                                  'Total Break Start : ${snapshot.data.break_count}',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 22.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ),
                          );
                        } else if (widget.btn == '3') {
                          return Container(
                            child: Center(
                              child: Text(
                                  'Total Break End : ${snapshot.data.breakend_count}',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 22.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ),
                          );
                        } else {
                          return Container(
                            child: Center(
                              child: Text(
                                  'Total Check Out : ${snapshot.data.checkout_count}',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 22.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ),
                          );
                        }
                      }
                    },
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: Stack(
                  children: [
                    QRView(
                      key: qrKey,
                      onQRViewCreated: _onQRViewCreated,
                    ),
                    Center(
                      child: Container(
                        width: 300,
                        height: 300,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.red,
                            width: 4,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 6,
                child: Container(
                  child: FutureBuilder(
                    future: getshiftlist(),
                    builder: (context, snapshot) {
                      if (snapshot.data == null) {
                        return Container(
                          child: Text("Loading"),
                        );
                      } else {
                        //typecasting Object to List
                        var data = (snapshot.data as List<Shift_list>).toList();
                        return ListView.separated(
                            separatorBuilder: (context, index) => Divider(),
                            shrinkWrap: true,
                            reverse: false,
                            itemCount: data.length,
                            itemBuilder: (context, i) {
                              if (widget.btn == '1') {
                                if (data[i].attendance_check_in != null) {
                                  return ListTile(
                                    title:
                                        Text('Name: ${data[i].user_full_name}'
                                            '\n'
                                            'IC: ${data[i].user_ic_no}'),
                                    subtitle: Text(
                                        'Check In: ${data[i].attendance_check_in != null ? data[i].attendance_check_in : 'Not Check IN'}'),
                                  );
                                } else {
                                  return Container(
                                    child: Text("Loading"),
                                  );
                                }
                              } else if (widget.btn == '2') {
                                if (data[i].attendance_check_in != null) {
                                  return ListTile(
                                    title:
                                        Text('Name: ${data[i].user_full_name}'
                                            '\n'
                                            'IC: ${data[i].user_ic_no}'),
                                    subtitle: Text(
                                        'Break Start: ${data[i].attendance_break != null ? data[i].attendance_break : 'Not Break'}'),
                                  );
                                } else {
                                  return Container(
                                    child: Text("Loading"),
                                  );
                                }
                              } else if (widget.btn == '3') {
                                if (data[i].attendance_check_in != null) {
                                  return ListTile(
                                    title:
                                        Text('Name: ${data[i].user_full_name}'
                                            '\n'
                                            'IC: ${data[i].user_ic_no}'),
                                    subtitle: Text(
                                        'Break End: ${data[i].attendance_break_end != null ? data[i].attendance_break_end : 'Not Break End'}'),
                                  );
                                } else {
                                  return Container(
                                    child: Text("Loading"),
                                  );
                                }
                              } else {
                                if (data[i].attendance_check_in != null) {
                                  return ListTile(
                                    title:
                                        Text('Name: ${data[i].user_full_name}'
                                            '\n'
                                            'IC: ${data[i].user_ic_no}'),
                                    subtitle: Text(
                                        'Check Out: ${data[i].attendance_check_out != null ? data[i].attendance_check_out : 'Not Check Out'}'),
                                  );
                                } else {
                                  return Container(
                                    child: Text("Loading"),
                                  );
                                }
                              }
                            });
                      }
                    },
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    var msg;
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async {
      controller.pauseCamera();
      var response =
          await ScanApi.scan(widget.shift, scanData.code, widget.btn);
      print(response);
      result = scanData;
      FlutterBeep.beep();
      setState(() {
        if (widget.btn == '1') {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Check IN"),
                content: SingleChildScrollView(
                  child: ListBody(
                    children: <Widget>[
                      Text('Barcode Type: ${describeEnum(scanData.format)}'),
                      Text('Data: ${scanData.code}'),
                    ],
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    child: Text('Ok'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          ).then((value) => controller.resumeCamera());
        } else if (widget.btn == '2') {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Break Start"),
                content: SingleChildScrollView(
                  child: ListBody(
                    children: <Widget>[
                      Text('Barcode Type: ${describeEnum(scanData.format)}'),
                      Text('Data: ${scanData.code}'),
                    ],
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    child: Text('Ok'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          ).then((value) => controller.resumeCamera());
        } else if (widget.btn == '3') {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Break End"),
                content: SingleChildScrollView(
                  child: ListBody(
                    children: <Widget>[
                      Text('Barcode Type: ${describeEnum(scanData.format)}'),
                      Text('Data: ${scanData.code}'),
                    ],
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    child: Text('Ok'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          ).then((value) => controller.resumeCamera());
        } else if (widget.btn == '4') {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Check Out"),
                content: SingleChildScrollView(
                  child: ListBody(
                    children: <Widget>[
                      Text('Barcode Type: ${describeEnum(scanData.format)}'),
                      Text('Data: ${scanData.code}'),
                    ],
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    child: Text('Ok'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          ).then((value) {
            setState(() {
              msg = value;
            });
          }).then((value) => controller.resumeCamera());
        }
      }
          //  }
          );

      // if (await canLaunch(scanData.format)) {
      //await launch(scanData.code);
      //controller.resumeCamera();
    });
  }
}

class scan_data {
  final String status;

  scan_data({this.status});

  factory scan_data.fromJson(Map<String, dynamic> json) {
    return scan_data(
      status: json['status'],
    );
  }
}
