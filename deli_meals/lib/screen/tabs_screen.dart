import '../widgets/main_drawer.dart';
import 'package:flutter/material.dart';
import 'categories_screen.dart';
import 'favorites_screen.dart';

class TabScreen extends StatefulWidget {
  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  final List<Map<String, Object>> _pages = [
    {'page': CategoriesScreen(), 'title': 'Categories'},
    {'page': FavoritesScreen(), 'title': 'Favorites'},
  ];

  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        initialIndex: 0,
        child: Scaffold(
          appBar: AppBar(
            title: Text(_pages[_selectedPageIndex]['title']),
          ),
          drawer: MainDrawer(),
          body: _pages[_selectedPageIndex]['page'],
          bottomNavigationBar: BottomNavigationBar(
            onTap: _selectPage,
            backgroundColor: Theme.of(context).primaryColor,
            unselectedItemColor: Colors.white,
            selectedItemColor: Theme.of(context).accentColor,
            currentIndex: _selectedPageIndex,
            type: BottomNavigationBarType.shifting,
            items: [
              BottomNavigationBarItem(
                  backgroundColor: Theme.of(context).primaryColor,
                  icon: Icon(Icons.category),
                  label: 'Categories'),
              BottomNavigationBarItem(
                  backgroundColor: Theme.of(context).primaryColor,
                  icon: Icon(Icons.star),
                  label: 'Favorites'),
            ],
          ),
        ));
  }
}
