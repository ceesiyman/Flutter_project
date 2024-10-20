import 'package:flutter/material.dart';
import 'components/home_component.dart';
import 'components/profile_component.dart';
import 'components/settings_component.dart';
import 'components/help_component.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sliding Drawer & Bottom Navigation Demo',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  String _currentPage = 'Home';
  final List<String> _pages = ['Home', 'Profile', 'Settings', 'Help'];
  final List<Widget> _bottomNavPages = [
    HomeComponent(),
    SettingsComponent(), // Dashboard page here (can be customized)
    ProfileComponent(),
  ];

  void _onBottomNavTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _getPage(String pageName) {
    switch (pageName) {
      case 'Home':
        return HomeComponent();
      case 'Profile':
        return ProfileComponent();
      case 'Settings':
        return SettingsComponent();
      case 'Help':
        return HelpComponent();
      default:
        return HomeComponent();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu, color: Colors.white),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: Text('Sliding Drawer Navigation', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.orange,
        centerTitle: true,
      ),
      drawer: Drawer(
        child: Container(
          color: Colors.orange,
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              SizedBox(
                height: 125, // Reduced height for the DrawerHeader
                child: DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.orangeAccent,
                  ),
                  child: Text(
                    'Navigation',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ),
              ),
              ..._pages.map((String page) => ListTile(
                title: Text(page, style: TextStyle(color: Colors.white)),
                onTap: () {
                  setState(() {
                    _currentPage = page;
                  });
                  Navigator.pop(context);
                },
              )).toList(),
            ],
          ),
        ),
      ),
      body: _bottomNavPages[_selectedIndex], // Display the selected page
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.orange,
        onTap: _onBottomNavTap,
      ),
    );
  }
}
