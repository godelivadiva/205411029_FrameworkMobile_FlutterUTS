import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

/* Class Pet befungsi untuk mendefinisikan property dari masing-masing pet yang
didalamnya menampung name, gender, age, dan imageUrl */
class Pet {
  final String name;
  final String gender;
  final double age;
  final String imageUrl;

  Pet({required this.name, required this.gender, required this.age, required this.imageUrl});
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pet Care',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: const MyHomePage(title: 'Pet Care'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String name = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        /* Merubah warna background Appbar dengan gradasi, menggunakan
        flexibleSpace dan BoxDecoration */
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[
                    Colors.grey,
                    Colors.blue
                  ])
          ),
        ),
      ),
      // Stack widget untuk membuat content berada di atas layer background
      body: Stack(
        children: [
          // menambahkan background
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/pet-background.jpg'), // define background's location
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Untuk hold content position ketika orientasi berubah
          Center(
            child: Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: mainLayout(),
            ),
          ),
        ],
      ),
    );
  }

  Widget mainLayout() {
    return Column(
      mainAxisSize: MainAxisSize.min, // membuat widget column memiliki ketinggian minimal
      children: [
        // untuk membuat box dengan tinggi 20
        SizedBox(
            height: 20,
        ),
        // menambahkan text dengan stylingnya
        Text(
          'Welcome to Pet Care',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 20),
        /* Textfield digunakan untuk input text */
        TextField(
          decoration: InputDecoration(
            hintText: 'Enter your name',
          ),
          onChanged: (value) {
            // memberikan value untuk variabel nama sesuai dengan yang diinput
            setState(() {
              name = value;
            });
          },
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              child: Text('Submit'),
              onPressed: () {
                // Membuat kondisi untuk memastikan nama harus diisi
                if (name == null || name.isEmpty) {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('Maaf'),
                        content: Text('Nama tidak boleh kosong'),
                      );
                    },
                  );
                } else { // jika berhasil akan diarahkan ke halaman Pet
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PetListScreen()),
                  );
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('Hello, $name!'),
                        content: Text('Selamat bekenalan dengan kami!'),
                        // OK button untuk menutup pop-up
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
            ),
          ],
        ),
      ],
    );
  }
}
/* PetListScreen widget menampilkan list dari pets dengan menggunakan
ListView.builder wdiget. */
class PetListScreen extends StatelessWidget {
  /* Define sebuah array untuk menampung nama, gender, umur, dan link dari
  masing-masing pets yang akan ditambilkan ke dalam variabel pets. Untuk
  menyimpan source dari gambar, menggunakan variabel imageUrl */
  final List<Pet> pets = [
    Pet(name: 'Acle', gender: 'Jantan', age: 4, imageUrl: 'assets/images/acle.jpg'),
    Pet(name: 'Joko', gender: 'Jantan', age: 1.5, imageUrl: 'assets/images/joko.jpg'),
    Pet(name: 'Gato', gender: 'Betina', age: 3, imageUrl: 'assets/images/gato.jpg'),
    Pet(name: 'Mao', gender: 'Betina', age: 3, imageUrl: 'assets/images/mao.jpg'),
    Pet(name: 'Neko', gender: 'Jantan', age: 3, imageUrl: 'assets/images/neko.jpg'),
    Pet(name: 'Pytho', gender: 'Betina', age: 4, imageUrl: 'assets/images/pytho.jpg'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pet List'),
      ),
      body: ListView.builder(
        itemCount: pets.length,
        itemBuilder: (context, index) {
          /* Card dan ListTile widgets digunakan untuk membuat kartu for each pet
          di dalam array.*/
          return Card(
            child: ListTile(
              /* CircleAvatar class untuk menampilkan image ke dalam Card
              dengan backgroundImage property dengan value AssetImage karena
              akan mengambil dari folder assets */
              leading: CircleAvatar(
                backgroundImage: AssetImage(pets[index].imageUrl),
              ),
              /* Text widget untuk menampilkan nama, gender, dan umur di dalam
              card */
              title: Text(pets[index].name),
              subtitle: Text('${pets[index].gender} - ${pets[index].age} tahun'),
              onTap: () {
                String pet_name = pets[index].name;
                // menampilkan text dengan snackbar saat klik each ListTile
                ScaffoldMessenger.of(context).showSnackBar( // method for display SnackBar
                  SnackBar(
                    content: Text('Kamu memilih $pet_name !'), // text yang ditampilkan
                    duration: Duration(milliseconds: 500), // durasi menampilkan text
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
