import 'dart:convert';
import 'dart:developer';

import 'package:ecommerce_app/address/view/addresses_page.dart';
import 'package:ecommerce_app/checkout/views/widgets/order_summary.dart';
import 'package:ecommerce_app/dashboard/views/dashboard.dart';
import 'package:ecommerce_app/features/home/data/models/address_model.dart';
import 'package:ecommerce_app/providers/http_client_provider.dart';
import 'package:ecommerce_app/providers/order_provider.dart';
import 'package:ecommerce_app/shared/result.dart';
import 'package:ecommerce_app/shared/widget/main_button.dart';
import 'package:ecommerce_app/utils/Strings.dart';
import 'package:ecommerce_app/utils/colors.dart';
import 'package:ecommerce_app/utils/images.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeletonizer/skeletonizer.dart';
final paymentMethodProvider = FutureProvider.autoDispose.family<List<Map<String, dynamic>>, String>((ref, endpoint) async {
  final apiService = ref.read(httpClientProvider);
 var response =await apiService.get(endpoint);
 
 Iterable data = jsonDecode(((response as Success).value as http.Response).body) ;
 log(data.toString());
  return data.map((row)=>{
    'id':row['id'], 
    'ar_name':row['ar_name'], 
    'en_name':row['en_name'], 
    'available':row['available'],
    'logo_url':row['logo_url'], 
    'description':row['description']
  }).toList();
});
var selectedPaymentMethod = StateProvider<int?>((ref) {
  return  null;
});
final selectedAddress = StateProvider<int?>((ref) {
  return  null;
});
final selectedAddressModel = StateProvider<AddressModel?>((ref) {
  return  null;
});
final addressProvider = FutureProvider.family<List<AddressModel>, String>((ref, endpoint) async {
  final apiService = ref.read(httpClientProvider);
 var response =await apiService.get(endpoint);

 Iterable data = jsonDecode(((response as Success).value as http.Response).body) ;
  return data.map((row)=>AddressModel.fromJson(row)).toList();
});

class CheckoutScreen extends ConsumerStatefulWidget {


  final double totalCost;
List<Map<String,dynamic>>? items;
   CheckoutScreen({super.key, required this.totalCost, 
  
  this.items});

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends ConsumerState<CheckoutScreen> {
  final _formKey = GlobalKey<FormState>();
  final _addressController = TextEditingController();
  final _cardNumberController = TextEditingController();
  late double productTotal;
  late double discount;
  late double shipping;
    late double tax;
    late double grandTotal;


 // List of payment methods
  
  @override
  void dispose() {
    _addressController.dispose();
    _cardNumberController.dispose();
    super.dispose();
  



  }

  void _processPayment() {
    if (_formKey.currentState!.validate()) {
      // Implement payment processing here
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Payment processed successfully!')));
    }
  }

  void _makeOrder(BuildContext context)async {
             final auth = ref.watch(orderProvider.notifier);
 var addressModel = ref.watch(selectAdressModel);
      try {
   log(widget.items.runtimeType.toString());
     var result=await   auth.makeOrder(addressModel!.id.toString(), 
        widget.items!, 
        0.0
        , "");

        if (result== null || result.toString().contains("failure")) {
           ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(result.toString())),
                  );
  return ;
}

 ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("order sent")),
                  );

                   Navigator.pushAndRemoveUntil(context
                  ,
                  MaterialPageRoute(builder: (_)=> const DashboardPage()), 
                  (route)=> true
                  );
      } catch (e) {
         ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(e.toString())),
                  );

                 
      }

  }

  @override
  Widget build(BuildContext context) {

    var addressModel = ref.watch(selectAdressModel);
  productTotal =  widget.items!.fold(0.0, (price,item)=> 
    
    price + (item['quantity']*item['price'] )
    );
    discount = .0;
    shipping = 5.0;
    tax = .15;

    grandTotal =  (
      productTotal-
      (productTotal*discount )  + shipping + 
      (productTotal*tax)
    
    
    );
        var paymentMethodsAsyncValue = ref.watch(paymentMethodProvider('/payment')); // Example endpoint
    final addressAsyncValue = ref.watch(addressProvider('/address'));

   var selectedMethodValue =  ref.read(selectedPaymentMethod.notifier).state;
   var selectedAddressValue =  ref.read(selectedAddress.notifier).state;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Checkout'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
               
                const SizedBox(height: 20),
//                 Text('Payment Information', style: Theme.of(context).textTheme.displaySmall!.copyWith(
//             fontSize: 18
//                 )),
//                              const SizedBox(height: 8),  

//             paymentMethodsAsyncValue.when(data: (data){
// return

//             ListView.builder(
//               physics: const NeverScrollableScrollPhysics(),
//               shrinkWrap: true, 
//               itemCount: data.length,
//               itemBuilder: (context,index){
//               var paymentMethod = data[index];
            
//                return Card(
//               margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
//               elevation: .0,
//               color: Colors.transparent,
//               child: ListTile(
//                 leading: Image.network(
//               Strings.BASE_URL+ 
//                  paymentMethod['logo_url'],
//                   width: 50,
//                   height: 50,
//                   fit: BoxFit.contain,
//                 ),
//                 title: Text(paymentMethod['ar_name']),
//                 trailing: Checkbox(
//                   value:
//                   paymentMethod['available']==1
//                   //  paymentMethod['isSelected']
                   
//                    ,
//                   onChanged: (isSelected) {
//                     if (isSelected!) {

//                     selectedMethodValue
//                              = int.parse( paymentMethod['available'].toString());

//                     }
//                     // _onCheckboxChanged(method['id'], isSelected);
//                   },
//                 ),
//                 onTap: () {
//                   // _onCheckboxChanged(method['id'], !method['isSelected']);
//                 },
//               ),
//             );
//               },
//             );
            



//             },
            
//              error: (_,__){
//               return const SizedBox();
//              }, loading: (){
// return


//             Skeletonizer(
//               enabled: true,
//               child: ListView.builder(
//                 physics: const NeverScrollableScrollPhysics(),
//                 shrinkWrap: true, 
//                 itemCount: paymentMethods.length,
//                 itemBuilder: (context,index){
//                 var paymentMethod = paymentMethods[index];
              
//                  return Card(
//                 margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
//                 elevation: .0,
//                 color: Colors.transparent,
//                 child: ListTile(
//                   leading: Image.asset(
//                     paymentMethod['image'],
//                     width: 50,
//                     height: 50,
//                     fit: BoxFit.contain,
//                   ),
//                   title: Text(paymentMethod['name']),
//                   trailing: Checkbox(
//                     value: paymentMethod['isSelected'],
//                     onChanged: (isSelected) {
//                       // _onCheckboxChanged(method['id'], isSelected);
//                     },
//                   ),
//                   onTap: () {
//                     // _onCheckboxChanged(method['id'], !method['isSelected']);
//                   },
//                 ),
//               );
//                 },
//               ),
//             );
            




//              })

//              ,
            
            
//                 const SizedBox(height: 8),
             Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [

                
                 Text('Delivery Address',
                 style: Theme.of(context).textTheme.displaySmall!.copyWith(
                             fontSize: 18
                    )
                 
                 ),
             
             
             TextButton(onPressed: (){
Navigator.of(context).push(

  MaterialPageRoute(builder: (_)=>   AddressesPage(
    addressSelection: true,
    selectAddress: (data){
ref.read(selectAdressModel.notifier).state = data;
    },
  ))
);
             }, child: const Text("Edit"))
               ],
             ),

 
 (addressModel==null)?
  
               Column(
                                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                  const Text("Add location") , const SizedBox(width: 8,) , 
                  IconButton(onPressed: (){
                  Navigator.of(context).push(

                    MaterialPageRoute(builder: (_)=> const AddressesPage())
                  );
                  }, icon: const Icon(Icons.add))
                    ],
                  ),
                ],
              )
          


: 

                Column(

              
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
const Text("Work Address" , style: TextStyle(
  color: Colors.grey ,fontSize: 14, 

),), 
Row(
  children: [
const Text("Street: 89 ," , style: TextStyle(
  color: Colors.grey ,fontSize: 14, 

),), 
Text("${addressModel.city} , " , style: const TextStyle(
  color: Colors.grey ,fontSize: 14, 

),), 
 Text("${addressModel.country}  " , style: const TextStyle(
  color: Colors.grey ,fontSize: 14, 

),), 
Text("${addressModel.zipCode}" , style: const TextStyle(
  color: Colors.grey ,fontSize: 14, 

),), 
  ],
), 

 const Text("097428739988" , style: TextStyle(
  color: Colors.grey ,fontSize: 14, 

),), 

                ],
              )
            
    

             , 
             
             
              const SizedBox(height: 8),  
            OrderSummaryWidget(productTotal: productTotal,
            discount: discount,
            tax: tax,
            grandTotal: grandTotal,
            shipping:shipping,
            
            
              
            ),
                const SizedBox(height: 8),



                 Text('Note',
                 style: Theme.of(context).textTheme.displaySmall!.copyWith(
                             fontSize: 18
                    )
                 
                 ),
             const SizedBox(height: 8,),
               Container(
                height: MediaQuery.of(context).size.height/5,
                width: MediaQuery.of(context).size.width ,
            decoration: BoxDecoration(
              border: Border.all(
                width: 1, color: Colors.grey
              ),
              borderRadius: BorderRadius.circular(8)
            ),
            padding: const EdgeInsets.all(4),
                 child: TextFormField(
                    controller: _addressController,
                    maxLines: 10
                     ,
                    decoration:  const InputDecoration(
                      border: InputBorder.none,
                      enabledBorder:  InputBorder.none,
                      disabledBorder:  InputBorder.none,
                      
                      hintText: 
                    ''),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter an address';
                      }
                      return null;
                    },
                 
                  ),
               ),
                const SizedBox(height: 20),
            
            
                  MainButton(
                    color: 
                    
                    Theme.of(context).brightness==Brightness.light?
                    Colors.black:Colors.white
                    ,
                    
                    text:  "Confirm Order",
                  
                   onPressed: (){
            if (addressModel ==null ) {
              //make order
      

              return;
            }

            _makeOrder(context);
                    
                   })
               
              ],
            ),
          ),
        ),
      ),
    );
  }
}
