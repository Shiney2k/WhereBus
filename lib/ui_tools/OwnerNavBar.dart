import 'package:flutter/material.dart';
import 'package:wherebus/tools/get_user_json_model.dart';

class OwnerNavBar extends StatelessWidget {
  const OwnerNavBar({Key? key, required this.data}) : super(key: key);
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
                Text('${data.document.fname!}-${data.document.acctype!}'),
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
            decoration: const BoxDecoration(
              color: Colors.blue,
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage("assets/images/background.jpg")),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: (){},
          ),
          ListTile(
            leading: const Icon(Icons.bus_alert_outlined),
            title: const Text('Bus'),
            onTap: (){},
          ),
          ListTile(
            leading: const Icon(Icons.add_card_sharp),
            title: const Text('Bookings'),
            onTap: (){},
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Account'),
            onTap: (){},
          ),
          ListTile(
            leading: const Icon(Icons.share),
            title: const Text('Share'),
            onTap: (){},
          ),
          const Divider(),
          ListTile(
            title: const Text('Logout'),
            leading: const Icon(Icons.exit_to_app),
            //onTap: () => Navigator.pushNamed(context, '/SignIn'),
            onTap: () {
              showDialog<void>(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Sign out'),
                    content: SingleChildScrollView(
                      child: ListBody(children: const <Widget>[
                        Text('Are you sure you want to sign out?'),
                      ]),
                    ),
                    actions: <Widget>[
                      TextButton(
                        child: const Text('Ok'),
                        onPressed: () {
                          Navigator.pushNamed(context, '/SignIn');
                        },
                      ),
                      TextButton(
                        child: const Text('Cancel'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
