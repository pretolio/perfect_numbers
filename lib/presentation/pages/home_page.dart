import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodels/home_viewmodel.dart';
import 'check_number_page.dart';
import 'find_range_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfect Numbers'),
        centerTitle: true,
      ),
      body: Selector<HomeViewModel, int>(
        selector: (_, vm) => vm.currentIndex,
        builder: (context, currentIndex, _) {
          return IndexedStack(
            index: currentIndex,
            children: const [
              CheckNumberPage(),
              FindRangePage(),
            ],
          );
        },
      ),
      bottomNavigationBar: Selector<HomeViewModel, int>(
        selector: (_, vm) => vm.currentIndex,
        builder: (context, currentIndex, _) {
          return NavigationBar(
            selectedIndex: currentIndex,
            onDestinationSelected: (index) {
              context.read<HomeViewModel>().setIndex(index);
            },
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.check_circle_outline),
                selectedIcon: Icon(Icons.check_circle),
                label: 'Verificar',
              ),
              NavigationDestination(
                icon: Icon(Icons.format_list_numbered),
                selectedIcon: Icon(Icons.format_list_numbered),
                label: 'Range',
              ),
            ],
          );
        },
      ),
    );
  }
}
