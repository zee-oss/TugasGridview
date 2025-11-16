import 'package:flutter/material.dart';
import 'detail_page.dart';
import 'model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Katalog Wisata",
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Katalog Wisata"),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.list), text: "List View"),
              Tab(icon: Icon(Icons.grid_on), text: "Grid View"),
            ],
          ),
        ),
        body: TabBarView(children: [buildListView(), buildGridView()]),
      ),
    );
  }
}

Widget buildListView() {
  Wisata wisata = Wisata();

  return ListView.builder(
    itemCount: wisata.Data.length,
    itemBuilder: (context, index) {
      final item = wisata.Data[index];
      return Card(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: ListTile(
          leading: Image.network(item["image"]!, width: 100, fit: BoxFit.cover),
          title: Text(item["title"]!),
          subtitle: Text(item["description"]!),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => DetailPage(
                  title: item["title"]!,
                  description: item["description"]!,
                  image: item["image"]!,
                ),
              ),
            );
          },
        ),
      );
    },
  );
}

Widget buildGridView() {
  Wisata w = Wisata();

  return GridView.builder(
    padding: EdgeInsets.all(10),
    itemCount: w.Data.length,
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
    ),
    itemBuilder: (context, index) {
      final item = w.Data[index];
      return InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => DetailPage(
                title: item["title"]!,
                description: item["description"]!,
                image: item["image"]!,
              ),
            ),
          );
        },
        child: Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(child: Image.network(item["image"]!, fit: BoxFit.cover)),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  item["title"]!,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
