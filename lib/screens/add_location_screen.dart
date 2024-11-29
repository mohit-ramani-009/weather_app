import 'package:flutter/material.dart';

class AddLocationScreen extends StatefulWidget {
  const AddLocationScreen({super.key});

  @override
  State<AddLocationScreen> createState() => _AddLocationScreenState();
}

class _AddLocationScreenState extends State<AddLocationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text('Add Location'),
        backgroundColor: const Color(0xFF05307B),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(
                filled: true,
                hintText: 'Search for a location',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 20),

            const Text(
              "Recently Searched",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: List.generate(5, (index) {
                  return ListTile(
                    leading: const Icon(Icons.location_on, color: Colors.blue),
                    title: Text("City $index"),
                    subtitle: Text("Country $index"),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      // Add navigation or logic here later
                    },
                  );
                }),
              ),
            ),

            // Add Location Button
            ElevatedButton.icon(
              onPressed: () {
                // Add navigation or logic here later
              },
              icon: const Icon(Icons.add),
              label: const Text("Add Current Location"),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF05307B),
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                minimumSize: const Size(double.infinity, 48),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
