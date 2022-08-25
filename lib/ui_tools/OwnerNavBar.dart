import 'package:flutter/material.dart';
import 'package:wherebus/tools/get_user_json_model.dart';

class OwnerNavBar extends StatelessWidget {
  const OwnerNavBar(this.data);
  final GetUserJsonModel data;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Remove padding
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName:
                Text(data.document.fname! + '-' + data.document.acctype!),
            accountEmail: Text(data.document.email!),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.asset(
                  'assets/images/user-avatar.png',
                  fit: BoxFit.cover,
                  width: 90,
                  height: 90,
                ),
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.blue,
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage("assets/images/background.jpg")),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () => null,
          ),
          ListTile(
            leading: Icon(Icons.bus_alert_outlined),
            title: Text('Bus'),
            onTap: () => null,
          ),
          ListTile(
            leading: Icon(Icons.add_card_sharp),
            title: Text('Bookings'),
            onTap: () => null,
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Account'),
            onTap: () => null,
          ),
          ListTile(
            leading: Icon(Icons.share),
            title: Text('Share'),
            onTap: () => null,
          ),
          Divider(),
          ListTile(
            title: Text('Logout'),
            leading: Icon(Icons.exit_to_app),
            onTap: () => Navigator.pushNamed(context, '/SignIn'),
          ),
        ],
      ),
    );
  }
}
