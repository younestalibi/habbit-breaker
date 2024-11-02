import 'package:flutter/material.dart';
import 'package:habbit_breaker/constants/image_constants.dart';
import 'package:habbit_breaker/generated/l10n.dart';
import 'package:habbit_breaker/providers/auth_provider.dart';
import 'package:habbit_breaker/screens/home_screen.dart';
import 'package:habbit_breaker/screens/setting_screen.dart';
import 'package:habbit_breaker/screens/tracker_screen.dart';
import 'package:habbit_breaker/utils/dimensions.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:provider/provider.dart';

class LayoutScreen extends StatefulWidget {
  @override
  _LayoutScreenState createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {
  PersistentTabController? _controller;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      var authProvider = Provider.of<AuthProvider>(context, listen: false);
      if (!authProvider.isAuthenticated()) {
        Navigator.pushReplacementNamed(context, "/signin");
      }
    });
    _controller = PersistentTabController(initialIndex: 0);
  }

  List<Widget> _buildScreens() {
    return [
      Center(child: HomeScreen()),
      Center(child: TrackerScreen()),
      Center(child: SettingsScreen()),
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
        icon: Icon(Icons.timer),
        title: "Progress",
        activeColorPrimary: Colors.blue,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.settings),
        title: "Settings",
        activeColorPrimary: Colors.blue,
        inactiveColorPrimary: Colors.grey,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    String userName = authProvider.getUserName();
    String userEmail = authProvider.getUserEmail();
    String userImage = authProvider.getUserPhoto();

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(backgroundImage: NetworkImage(userImage)),
            Dimensions.xsWidth,
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  S.of(context).pageHomeWelcomeFullName(userName),
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Text(
                  userEmail,
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              Provider.of<AuthProvider>(context, listen: false).logout();
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
        ],
        automaticallyImplyLeading: false,
      ),
      body: PersistentTabView(
        context,
        controller: _controller!,
        screens: _buildScreens(),
        items: _navBarsItems(),
        navBarStyle: NavBarStyle.style9,
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }
}
