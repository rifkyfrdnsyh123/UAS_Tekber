import 'package:apk_firebase/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const DashboardPage(),
        '/input': (context) => const InputForm(),
        '/detail': (context) => const DetailPage(),
        '/list': (context) => const ListPage(),
        '/detail_only': (context) => const DetailOnlyPage(),
      },
    );
  }
}

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 52, 116, 255),
        title: Text(
          'Apotek06653',
          style: TextStyle(
            fontFamily: 'Pacifico',
            fontSize: 25,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildMenuButton(
                  context,
                  Icons.add_circle,
                  'Input Obat',
                  '/input',
                ),
                _buildMenuButton(
                  context,
                  Icons.assignment,
                  'Data Obat',
                  '/detail_only',
                ),
                _buildMenuButton(
                  context,
                  Icons.edit,
                  'Edit Obat',
                  '/list',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuButton(
      BuildContext context, IconData icon, String label, String route) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushNamed(context, route);
      },
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(20),
        backgroundColor: Colors.grey[300],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 50),
          SizedBox(height: 10),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

class InputForm extends StatefulWidget {
  const InputForm({Key? key}) : super(key: key);

  @override
  _InputFormState createState() => _InputFormState();
}

class _InputFormState extends State<InputForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _kodeObatController = TextEditingController();
  final TextEditingController _namaObatController = TextEditingController();

  @override
  void dispose() {
    _kodeObatController.dispose();
    _namaObatController.dispose();
    super.dispose();
  }

  void _simpanData() {
    if (_formKey.currentState!.validate()) {
      CollectionReference colref =
          FirebaseFirestore.instance.collection('obat');
      colref.add({
        'kode_obat': _kodeObatController.text,
        'nama_obat': _namaObatController.text,
      }).then((value) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Data berhasil disimpan')),
        );
        Navigator.pushNamed(context, '/detail', arguments: {
          'kode_obat': _kodeObatController.text,
          'nama_obat': _namaObatController.text,
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 52, 116, 255),
        title: const Text('Input Data Obat'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  TextFormField(
                    controller: _kodeObatController,
                    decoration: const InputDecoration(labelText: 'Kode Obat'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Kode obat harus diisi';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _namaObatController,
                    decoration: const InputDecoration(labelText: 'Nama Obat'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Nama obat harus diisi';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _simpanData,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Color.fromARGB(255, 255, 255, 255),
                      backgroundColor: Colors.blue,
                    ),
                    child: const Text(
                      'SIMPAN',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class DetailPage extends StatelessWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 52, 116, 255),
        title: const Text('Detail Obat'),
        actions: [
          IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Kode Obat: ${args['kode_obat']}',
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 10),
                Text(
                  'Nama Obat: ${args['nama_obat']}',
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ListPage extends StatelessWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 52, 116, 255),
        title: const Text('Daftar Obat'),
      ),
      body: Container(
        color: Colors.grey[200],
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('obat').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Center(
                child: Text('Terjadi kesalahan'),
              );
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            final data = snapshot.requireData;

            return ListView.builder(
              itemCount: data.size,
              itemBuilder: (context, index) {
                final doc = data.docs[index];
                return Card(
                  color: Colors.white,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(doc['nama_obat']),
                        subtitle: Text(doc['kode_obat']),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EditForm(doc: doc),
                                  ),
                                );
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                FirebaseFirestore.instance
                                    .collection('obat')
                                    .doc(doc.id)
                                    .delete();
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/input');
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }
}

class EditForm extends StatefulWidget {
  final DocumentSnapshot doc;
  const EditForm({super.key, required this.doc});

  @override
  _EditFormState createState() => _EditFormState();
}

class _EditFormState extends State<EditForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _kodeObatController;
  late TextEditingController _namaObatController;

  @override
  void initState() {
    _kodeObatController = TextEditingController(text: widget.doc['kode_obat']);
    _namaObatController = TextEditingController(text: widget.doc['nama_obat']);
    super.initState();
  }

  @override
  void dispose() {
    _kodeObatController.dispose();
    _namaObatController.dispose();
    super.dispose();
  }

  void _updateData() {
    if (_formKey.currentState!.validate()) {
      FirebaseFirestore.instance.collection('obat').doc(widget.doc.id).update({
        'kode_obat': _kodeObatController.text,
        'nama_obat': _namaObatController.text,
      }).then((value) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Data berhasil diperbarui')),
        );
        Navigator.pop(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Data Obat'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _kodeObatController,
                decoration: const InputDecoration(labelText: 'Kode Obat'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Kode obat harus diisi';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _namaObatController,
                decoration: const InputDecoration(labelText: 'Nama Obat'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama obat harus diisi';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _updateData,
                child: const Text('UPDATE'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DetailOnlyPage extends StatelessWidget {
  const DetailOnlyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 52, 116, 255),
        title: const Text('Data Obat'),
      ),
      body: Container(
        color: Colors.grey[200],
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('obat').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Center(
                child: Text('Terjadi kesalahan'),
              );
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            final data = snapshot.requireData;

            return ListView.builder(
              itemCount: data.size,
              itemBuilder: (context, index) {
                final doc = data.docs[index];
                return Card(
                  color: Colors.white,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(doc['nama_obat']),
                        subtitle: Text(doc['kode_obat']),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
