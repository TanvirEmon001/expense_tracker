import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Items"),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.add))],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Expanded(
          child: ListView.builder(
            itemCount: 10,
            itemBuilder: (_, index) {
              return Card(
                elevation: 5,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: .start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Get my Salary",
                              style: Theme.of(context).textTheme.titleLarge!
                                  .copyWith(fontWeight: .bold),
                            ),
                          ),
                          IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
                        ],
                      ),

                      Row(
                        children: [
                          Expanded(child: Text("Balance: 1000")),
                          Expanded(child: Text("04-02-2026, 11:45AM")),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
