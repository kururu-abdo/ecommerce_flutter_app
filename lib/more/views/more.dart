import 'package:ecommerce_app/features/orders/views/orders_screen.dart';
import 'package:ecommerce_app/login/page/login.dart';
import 'package:ecommerce_app/profile/views/profile_screen.dart';
import 'package:ecommerce_app/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MoreScreen extends ConsumerWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context ,WidgetRef ref) {
    return Scaffold(
     backgroundColor: Colors.white,
     appBar: PreferredSize(preferredSize: 
     
     const Size.fromHeight(180)
     , child: Container(
decoration: BoxDecoration(
  borderRadius: const BorderRadius.vertical(
    bottom: Radius.circular(20)
  ),
  color: Theme.of(context).primaryColor
),
child: const Column(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [ SizedBox(height: 24,), 
    CircleAvatar(
      radius: 40,
    ), 
    SizedBox(height: 8,), 
    Text('Abdo', 
    
    style: TextStyle(
      color: Colors.white
    ),
    ), 

 SizedBox(height: 16,), 
Row(
  mainAxisSize: MainAxisSize.max,
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: [
Column(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
Text("Orders"

,style: TextStyle(
      color: Colors.white
    ),
), 
Text("9",style: TextStyle(
      color: Colors.white
    ),)
  ],
),

Column(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
Text("Notifiations",style: TextStyle(
      color: Colors.white
    ),), 
Text("30",style: TextStyle(
      color: Colors.white
    ),)
  ],
),
Column(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
Text("Favourites",style: TextStyle(
      color: Colors.white
    ),), 
Text("2",style: TextStyle(
      color: Colors.white
    ),)
  ],
),


  ],
)
  ],
),
     )),
      body: ListView(
        children: [
          const SizedBox(height: 24,),
          // Profile Option
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Profile'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen()));
            },
          ),
          const Divider(),

          // Orders Option
          ListTile(
            leading: const Icon(Icons.shopping_bag),
            title: const Text('Orders'),
            onTap: () {
                           Navigator.push(context, MaterialPageRoute(builder: (context) => OrdersScreen()));

            },
          ),
          const Divider(),

          // Favorites Option
          ListTile(
            leading: const Icon(Icons.favorite),
            title: const Text('Favorites'),
            onTap: () {
              // Navigator.push(context, MaterialPageRoute(builder: (context) => FavoritesScreen()));
            },
          ),
          const Divider(),

          // Settings Option
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              // Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsScreen()));
            },
          ),
          const Divider(),

          // Help Option
          ListTile(
            leading: const Icon(Icons.help),
            title: const Text('Help & Support'),
            onTap: () {
              // Navigator.push(context, MaterialPageRoute(builder: (context) => HelpScreen()));
            },
          ),
          const Divider(),

          ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text("Logout", style: TextStyle(color: Colors.red)),
              onTap: () async {
                // Perform logout
                ref.read(userProvider.notifier).logout();

                // Optionally navigate to the login screen
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>const LoginScreen()));
              },
            ),
        ],
      ),
    );
  }
}
