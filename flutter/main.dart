//
// demo classic bluetooth to pico w btstack spp_counter.c
// flutter create your_project
// cd your_project
// flutter pub add flutter_bluetooth_serial
//
// add to android/app/src/main/AndroidManifest.xml
// <uses-permission android:name="android.permission.BLUETOOTH_SCAN" />   
// <uses-permission android:name="android.permission.BLUETOOTH_ADMIN" />
// <uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION"/>
// tested on pixel 4 android 13
// goto settings and give app location permissions

import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

final TextStyle statStyle = TextStyle(fontSize:34,fontWeight:FontWeight.bold);
final TextStyle myStyle = TextStyle(fontSize:40, color: Colors.green, fontWeight:FontWeight.bold);

void main() { runApp(const MyApp()); }

class MyApp extends StatelessWidget {
const MyApp({super.key});

@override Widget build(BuildContext context) {
return MaterialApp(title: 'bluetooth classic',
theme: ThemeData(primarySwatch: Colors.blue),
home: const MyHomePage(title: 'Flutter Demo Home Page'));}}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();}

class _MyHomePageState extends State<MyHomePage> {

late BluetoothConnection connection;
String inputData = "not connected";
final Uint8List toggle = Uint8List.fromList([0x74, 0x74]);
  
void connect() async {
  try {
    connection = await BluetoothConnection.toAddress("28:CD:C1:01:54:E7"); // use nrf connect from google playstore to find id
    connection!.input!.listen((Uint8List data) {
        setState(() {
          inputData = ascii.decode(data);});
    }).onDone(() {
        print('Disconnected by remote request');
    });}
    
  catch (exception) { print(exception.toString()); }}

@override Widget build(BuildContext context) {
return Scaffold(appBar: AppBar(title: Text('bluetooth classic demo')),

body: Center(child: Column(children:[
      
  SizedBox(height: 50.0),
        
  Text('button status: ', style: statStyle),
  Text('$inputData', style: myStyle),
        
  SizedBox(height: 50.0),
        
  ElevatedButton(child: Text('toggle blue led',style:statStyle),
    onPressed:() => connection.output.add(toggle)),
])),
        
floatingActionButton: FloatingActionButton(onPressed: connect,
  child: const Icon(Icons.bluetooth)));}}
