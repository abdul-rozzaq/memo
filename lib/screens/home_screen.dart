import 'package:flutter/material.dart';
import 'package:memo/providers/app_provider.dart';
import 'package:memo/screens/exemine_dart.dart';
import 'package:provider/provider.dart';
import '../models/theme.dart' as models;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    AppProvider provider = Provider.of(context, listen: false);

    provider.loadWords();
  }

  @override
  Widget build(BuildContext context) {
    AppProvider provider = Provider.of(context, listen: true);

    return Scaffold(
      drawer: const Drawer(),
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: const Text(
          'Home',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: provider.isLoaded
          ? RefreshIndicator(
              onRefresh: () => provider.loadWords(),
              child: ListView.builder(
                itemCount: provider.themes.length,
                itemBuilder: (context, index) {
                  models.Theme theme = provider.themes[index];

                  return ListTile(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ExaminePage(
                          theme: theme,
                        ),
                      ),
                    ),
                    title: Text('${theme.id}. ${theme.name}'),
                  );
                },
              ),
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
