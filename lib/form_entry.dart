// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// class InputForm extends StatefulWidget {
//   const InputForm({super.key});

//   @override
//   _InputFormState createState() => _InputFormState();
// }

// class _InputFormState extends State<InputForm> {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController _kodeObatController = TextEditingController();
//   final TextEditingController _namaObatController = TextEditingController();

//   @override
//   void dispose() {
//     _kodeObatController.dispose();
//     _namaObatController.dispose();
//     super.dispose();
//   }

//   void _simpanData() {
//     if (_formKey.currentState!.validate()) {
//       CollectionReference colref =
//           FirebaseFirestore.instance.collection('obat');
//       colref.add({
//         'kode_obat': _kodeObatController.text,
//         'nama_obat': _namaObatController.text,
//       }).then((value) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Data berhasil disimpan')),
//         );
//         Navigator.pushNamed(context, '/detail', arguments: {
//           'kode_obat': _kodeObatController.text,
//           'nama_obat': _namaObatController.text,
//         });
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Input Data Obat'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: <Widget>[
//               TextFormField(
//                 controller: _kodeObatController,
//                 decoration: const InputDecoration(labelText: 'Kode Obat'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Kode obat harus diisi';
//                   }
//                   return null;
//                 },
//               ),
//               TextFormField(
//                 controller: _namaObatController,
//                 decoration: const InputDecoration(labelText: 'Nama Obat'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Nama obat harus diisi';
//                   }
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: _simpanData,
//                 child: const Text('SIMPAN'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class DetailPage extends StatelessWidget {
//   const DetailPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final Map<String, dynamic> args =
//         ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Detail Obat'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('Kode Obat: ${args['kode_obat']}'),
//             Text('Nama Obat: ${args['nama_obat']}'),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class ListPage extends StatelessWidget {
//   const ListPage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Daftar Obat'),
//       ),
//       body: Column(
//         children: [
//           // Widget daftar obat
//           ElevatedButton(
//             onPressed: () {
//               // Navigasi ke EditForm dengan menyediakan argument doc
//               Navigator.pushNamed(context, '/edit', arguments: {
//                 'id': '1', // Contoh id, sesuaikan dengan data yang diperlukan
//                 'kode_obat': '123',
//                 'nama_obat': 'Obat ABC',
//               });
//             },
//             child: const Text('Edit Obat'),
//           ),
//         ],
//       ),
//     );
//   }
// }


// class EditForm extends StatefulWidget {
//   final DocumentSnapshot doc;
//   const EditForm({super.key, required this.doc});

//   @override
//   _EditFormState createState() => _EditFormState();
// }

// class _EditFormState extends State<EditForm> {
//   final _formKey = GlobalKey<FormState>();
//   late TextEditingController _kodeObatController;
//   late TextEditingController _namaObatController;

//   @override
//   void initState() {
//     _kodeObatController =
//         TextEditingController(text: widget.doc['kode_obat'] as String);
//     _namaObatController =
//         TextEditingController(text: widget.doc['nama_obat'] as String);
//     super.initState();
//   }

//   @override
//   void dispose() {
//     _kodeObatController.dispose();
//     _namaObatController.dispose();
//     super.dispose();
//   }

//   void _updateData() {
//     if (_formKey.currentState!.validate()) {
//       FirebaseFirestore.instance.collection('obat').doc(widget.doc.id).update({
//         'kode_obat': _kodeObatController.text,
//         'nama_obat': _namaObatController.text,
//       }).then((value) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Data berhasil diperbarui')),
//         );
//         Navigator.pop(context);
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Edit Data Obat'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: <Widget>[
//               TextFormField(
//                 controller: _kodeObatController,
//                 decoration: const InputDecoration(labelText: 'Kode Obat'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Kode obat harus diisi';
//                   }
//                   return null;
//                 },
//               ),
//               TextFormField(
//                 controller: _namaObatController,
//                 decoration: const InputDecoration(labelText: 'Nama Obat'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Nama obat harus diisi';
//                   }
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: _updateData,
//                 child: const Text('UPDATE'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
