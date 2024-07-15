import 'package:apk_firebase/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main(List<String> args) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(tampilkan());
}

class tampilkan extends StatefulWidget {
  @override
  State<tampilkan> createState() => _tampilkanState();
}

class _tampilkanState extends State<tampilkan> {
  final corref = FirebaseFirestore.instance.collection('Obat');

  late List<Map<String, dynamic>> listdata = [];

  _tampildata() async {
    final data = await corref.get();
    data.docs.forEach((element) {
      listdata.add(element.data());
    });
    setState(() {
      listdata;
    });
  }

  @override
  void initState() {
    super.initState();
    _tampildata();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            backgroundColor: Color.fromARGB(255, 52, 116, 255),
            title: Text('LISTVIEW'),
          ),
          body: ListView.builder(
            itemCount: listdata.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  title: Text(listdata[index]['kode_brg']),
                  subtitle: Text(listdata[index]['nama_brg']),
                  trailing:
                      IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
                ),
              );
            },
          )),
    );
  }
}
