import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'dart:async';

class Home extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  String status="";
  int _moisture;
  DatabaseReference _moistureRef;
  final databaseReference = FirebaseDatabase.instance.reference();
  final FirebaseDatabase database = FirebaseDatabase();
  StreamSubscription<Event> _moistureSubscription;
  double moistureData;
  DatabaseError _error;
  @override
  bool _isLoading = false;
  void initState() {
    super.initState();
    _moistureRef =
        FirebaseDatabase.instance.reference().child('Data').child('Moisture');
    databaseReference.child('Data').once().then((DataSnapshot snapshot) {
      int moisture = snapshot.value['Moisture'];
      moistureData = moisture.toDouble();
      setState(() {
        if (moistureData != null) {
          _isLoading = true;
        }
      });
    });
    database.setPersistenceEnabled(true);
    _moistureRef.keepSynced(true);
    _moistureSubscription = _moistureRef.onValue.listen((Event event) {
      setState(() {
        _error = null;
        _moisture = (event.snapshot.value) ?? 0;
        print(_moisture);
        
        if(_moisture<500){
          status= "Soil is wet!";
        }
        else if(_moisture>700){
          status="Soil is dry!";
        }
        else{
          status="Adequate amount of moisture!";
        }
      });
    }, onError: (Object o) {
      final DatabaseError error = o;
      setState(() {
        _error = error;
      });
    });
  }
   @override
  void dispose() {
    super.dispose();
    _moistureSubscription.cancel();
  }

//taking the data snapshot.
  @override
  Widget build(BuildContext context) {
    int maxmoisture = 1024;
    return Scaffold(
      appBar: AppBar(
        title: Text('IoT monitoring'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Container(
                height: 300,
                width: 300,
                child: SfRadialGauge(
                  title: GaugeTitle(
                    alignment: GaugeAlignment.near,
                    text: 'SOIL MOISTURE',
                  ),
                  axes: <RadialAxis>[
                    RadialAxis(
                      minimum: 0,
                      maximum: maxmoisture.toDouble(),
                      interval: maxmoisture.toDouble(),
                      showTicks: false,
                      showLabels: true,
                      ranges: [
                        GaugeRange(
                          startValue: 0,
                          endValue: (_moisture!=null)?_moisture.toDouble():0,
                          color: Color(0xff21C58E),
                        ),
                      ],
                      annotations: <GaugeAnnotation>[
                        GaugeAnnotation(
                          widget: Text(
                            '$_moisture',
                            style: TextStyle(
                              color: Color(0xff21C58E),
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Text('$status', style: TextStyle(fontSize:20, fontWeight: FontWeight.bold, color:Color(0xff21C58E)),)
            ],
          ),
        ),
      ),
    );
  }
}
