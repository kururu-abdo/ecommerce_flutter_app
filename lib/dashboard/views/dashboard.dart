import 'package:ecommerce_app/cart/view/cart_screen.dart';
import 'package:ecommerce_app/categories/view/category_list.dart';
import 'package:ecommerce_app/features/home/views/home.dart';
import 'package:ecommerce_app/more/views/more.dart';
import 'package:ecommerce_app/providers/http_client_provider.dart';
import 'package:ecommerce_app/utils/fcm_helper.dart';
import 'package:ecommerce_app/utils/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
final bottomSheetCurrentIndex = StateProvider<int>(
  (ref){ 

    return 0;
    }
);
class DashboardPage extends ConsumerStatefulWidget {
  const DashboardPage({super.key});

  @override
  ConsumerState<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends ConsumerState<DashboardPage> {
final int _selectedIndex = 0;
@override
void initState() {
super.initState();
 try {
   // Initialize FCM
  final FCMHelper fcmHelper = FCMHelper();
   fcmHelper.initialize();
   fcmHelper.getToken().then((token){
ref.read(httpClientProvider).post('/auth/account/update_token'
, {
  'user_id':4,
  'fcm_token':token
});
   });
 } catch (e) {
   
 }
}
changeIndex(int index){
                  ref.read(bottomSheetCurrentIndex.notifier).update((state) 
                  {
                    return index;
                  });
}
  @override
  Widget build(BuildContext context) {

    var currentBottomsheetIndex=ref.watch(bottomSheetCurrentIndex);
    List screens= 
    [
       HomeScreen() ,const CategoryList() ,

      const CartScreen() , Container() , const MoreScreen()
    ];
    return Scaffold(
backgroundColor: Colors.white,
      
body: screens[currentBottomsheetIndex],
// Bottom Navigation Bar
      bottomNavigationBar: Theme(
    data: Theme.of(context).copyWith(
        // sets the background color of the `BottomNavigationBar`
        canvasColor: Colors.black,
        // sets the active color of the `BottomNavigationBar` if `Brightness` is light
        // primaryColor: Colors.red,
        // textTheme: Theme
        //     .of(context)
        //     .textTheme
        //     .copyWith(caption: new TextStyle(color: Colors.yellow))
            ), // sets the inactive color of the `BottomNavigationBar`
    
        child: BottomNavigationBar(
          // fixedColor: Colors.white,
          currentIndex: currentBottomsheetIndex,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey,
          onTap: (index) {
            // setState(() {
            //   _selectedIndex = index;
            // });
            changeIndex(index);
          },
          items: const [
            BottomNavigationBarItem(
            
              icon: ImageIcon(
                
              AssetImage(Images.home)),
              label: '',
            ),
            BottomNavigationBarItem(
        icon: ImageIcon(
                
              AssetImage(Images.menu)),
              label: '',
            ),
           
             BottomNavigationBarItem(
              icon: ImageIcon(
                
              AssetImage(Images.cart)),
              label: '',
            ),
             BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border_outlined),
              label: '',
            ),
            BottomNavigationBarItem(
           icon: ImageIcon(
                
              AssetImage(Images.user)),
              label: '',
            ),
          ],
        ),
      ),
    );
  }
}