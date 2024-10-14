import 'package:flutter/material.dart';
import 'package:habbit_breaker/providers/auth_provider.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PersistentTabController? _controller;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      var authProvider = Provider.of<AuthProvider>(context, listen: false);
      if (authProvider.isAuthenticated()) {
        Navigator.pushReplacementNamed(context, "/home");
      }
    });
    _controller = PersistentTabController(initialIndex: 0);
  }

  List<Widget> _buildScreens() {
    return [
      Center(child: Text("Home Page")),
      Center(child: Text("Search Page")),
      Center(child: Text("Profile Page")),
      Center(child: Text("Community Page")),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.home),
        title: "Home",
        activeColorPrimary: Colors.blue,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.search),
        title: "Search",
        activeColorPrimary: Colors.blue,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.person),
        title: "Profile",
        activeColorPrimary: Colors.blue,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.people),
        title: "Community",
        activeColorPrimary: Colors.blue,
        inactiveColorPrimary: Colors.grey,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    String userName = authProvider.getUserName(); // Get user's name
    String userEmail = authProvider.getUserEmail(); // Get user's email
    String userImage = authProvider.getUserImage(); // Get user's image

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('My App'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              Provider.of<AuthProvider>(context, listen: false).logout();
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
        ],
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
      ),
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Material(
                color: Colors.blueAccent,
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: EdgeInsets.all(50),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 52,
                          backgroundImage: NetworkImage(userImage),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Text(
                          userName,
                          style: TextStyle(fontSize: 28, color: Colors.white),
                        ),
                        Text(
                          userEmail,
                          style: TextStyle(fontSize: 14, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.home_outlined),
                    title: Text('Home'),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/home');
                    },
                  ),
                  const Divider(
                    color: Colors.black45,
                  ),
                  ListTile(
                    leading: Icon(Icons.notifications_outlined),
                    title: Text('Notifications'),
                    onTap: () {},
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      body: PersistentTabView(
        context,
        controller: _controller!,
        screens: _buildScreens(),
        items: _navBarsItems(),
        navBarStyle: NavBarStyle.style9,
      ),
    );
  }
}
