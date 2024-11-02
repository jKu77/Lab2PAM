import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Barbershop App',
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Lista cu caile imaginilor
  final List<String> imagePaths = [
    'assets/timer_photos/att1.jpg',
    'assets/timer_photos/att2.jpg',
    'assets/timer_photos/att3.jpg',
    'assets/timer_photos/att4.jpg',
    'assets/timer_photos/att5.jpg',
  ];

  int _currentImageIndex = 0; // Indexul curent al imaginii
  Timer? _timer; // Timer-ul pentru schimbarea automată a imaginii

  @override
  void initState() {
    super.initState();
    // Initializarea timer-ul la imaginea la fiecare 5 secunde
    _timer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      setState(() {
        // Schimba la urmatoarea imagine din lista
        _currentImageIndex = (_currentImageIndex + 1) % imagePaths.length;
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // Anuleaza timerul cand e distrus widget u
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.black),
          onPressed: () {},
        ),
        actions: const [
          CircleAvatar(
            backgroundImage: AssetImage('assets/pics/picture.png'),
          ),
          SizedBox(width: 16),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Bine te am gasit,',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const Text(
                'Ghemu Gheorghe',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              const SizedBox(height: 16),

              // Container-ul cu imaginea care se schimbă automat
              Container(
                width: double.infinity,
                height: 160,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: AssetImage(imagePaths[
                        _currentImageIndex]), // Afișează imaginea curentă
                    fit: BoxFit.cover,
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      left: 16,
                      bottom: 16,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 255, 255, 255),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text('Booking Now'),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Restul elementelor rămân la fel...
              TextField(
                decoration: InputDecoration(
                  hintText: 'Cauta un barber sau o locatie..',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Cel mai apropiat',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              const SizedBox(height: 16),
              _buildBarbershopList(context),
              const SizedBox(height: 16),
              Center(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('See All'),
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Cel mai recomandat',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              const SizedBox(height: 16),
              _buildRecommendedList(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBarbershopList(BuildContext context) {
    return Column(
      children: List.generate(3, (index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                'assets/pics/${index + 1}.jpg',
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
            ),
            title: Text(
              'Barbershop ${index + 1} - Haircut & Massage',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Row(
              children: [
                const Icon(Icons.star, size: 16, color: Colors.yellow),
                const SizedBox(width: 4),
                Text('4.${5 - index}'),
                const SizedBox(width: 8),
                Text(
                  '${index + 1} km away',
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          ),
        );
      }),
    );
  }

  Widget _buildRecommendedList(BuildContext context) {
    return Column(
      children: List.generate(3, (index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                  child: Image.asset(
                    'assets/pics/${index + 4}.jpg',
                    width: double.infinity,
                    height: 160,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Recommended Barbershop ${index + 4}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const Row(
                        children: [
                          Icon(Icons.location_on, size: 16, color: Colors.grey),
                          SizedBox(width: 4),
                          Text('5 km away',
                              style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(Icons.star,
                              size: 16, color: Colors.yellow),
                          const SizedBox(width: 4),
                          Text('4.${9 - index - 1}'),
                        ],
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 255, 255, 255),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text('Booking'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
