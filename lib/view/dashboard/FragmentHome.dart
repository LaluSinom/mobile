import 'package:flutter/material.dart';

class FragmentHome extends StatelessWidget {
  const FragmentHome({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Apartemen"),
        centerTitle: true,
      ),
      body: Container(
        height: 100,
        width: 100,
        decoration: const BoxDecoration(
          color: Colors.blue,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {},
      ),
    );
  }
}
