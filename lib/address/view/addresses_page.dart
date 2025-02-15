import 'dart:convert';

import 'package:ecommerce_app/address/view/add_new_address_page.dart';
import 'package:ecommerce_app/address/view/location_picker.dart';
import 'package:ecommerce_app/features/home/data/models/address_model.dart';
import 'package:ecommerce_app/providers/address_provider.dart';
import 'package:ecommerce_app/shared/widget/main_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:map_location_picker/map_location_picker.dart';
import 'package:skeletonizer/skeletonizer.dart';
var addressListFuture = FutureProvider.autoDispose.family<List<AddressModel>, void>((ref,endpoint)async{
 var addresses = ref.watch(addressesProvider.notifier);
return addresses.getAddresses();

});

var selectedAddressId =  StateProvider<int?>((ref) {
  return null;
});
var selectAdressModel =  StateProvider<AddressModel?>((ref) {
  return null;
});

class AddressesPage extends ConsumerStatefulWidget {
  final bool?  addressSelection;
  final Function(AddressModel?)? selectAddress;
  const AddressesPage({super.key ,this.selectAddress, this.addressSelection=false});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddressesPageState();
}

class _AddressesPageState extends ConsumerState<AddressesPage> {
  @override
  Widget build(BuildContext context) {
    var addressListFutureValue = ref.watch(addressListFuture(''));
    var selectedAddress = ref.watch(selectedAddressId);
    var selectedAddressModel = ref.watch(selectAdressModel);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Addresses"),
            TextButton.icon(onPressed: (){

            },
            icon: const Icon(Icons.lock,size: 15,              color: Colors.green , 
),
             label: const Text("All data is encrypted" , 
             style: TextStyle(
              color: Colors.green , 
              fontSize: 15
             ),
             ))
          ],
        ),
        centerTitle: true,

      ),

      body: RefreshIndicator(
        onRefresh: ()async{
ref.refresh(addressListFuture(''));
        },
        child: Column(
          
          children: [
            const SizedBox(height: 20,),
               addressListFutureValue.when(
        data: (data){
          // return  Text(data.toString());
          return Expanded(
            child: ListView(
              shrinkWrap: true, 
              
              children: data.map(
                    (address) {
            
                    return Container(

                      margin: const EdgeInsets.symmetric(
                        vertical: 8
                      ),
            padding: const EdgeInsets.all(5),
            width: MediaQuery.sizeOf(context).width,
            height:MediaQuery.sizeOf(context).height/5 ,
            decoration:  BoxDecoration(
              color: Colors.white, 
            
            boxShadow: [
              BoxShadow(
                color: Colors.grey[200]!, 
                offset: const Offset(0, 1), 
                spreadRadius: 5 
                , blurRadius: 5
              )
            ]
            ),
            child:  Column(
              spacing: 5,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
            
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              // mainAxisSize: MainAxisSize.min,
              children: [
            Text(address.fullName.toString()), 
            const SizedBox(width: 8,), 
            const Text("+966 536627478"), 
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              // mainAxisSize: MainAxisSize.min,
              children: [
            Text(address.zipCode.toString()), 
            const SizedBox(width: 8,), 
            Text(address.city.toString()), 
              ],
            ),
            
            Text("""/street /${address.city} /${address.country} """), 
            const Spacer(),
            const Divider(thickness:.5,)
            , 
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
            Radio<int>(value: 
            address.id!
            
            , groupValue: selectedAddress, onChanged: ( value){
if (value==selectedAddress) {
    ref.read(selectedAddressId.notifier).state= null;
    ref.read(selectAdressModel.notifier).state=null;
    return;
} ref.read(selectAdressModel.notifier).state=address;

             ref.read(selectedAddressId.notifier).state= value as int;
            }), 
            
             Row(
              spacing: 5,
              mainAxisSize: MainAxisSize.min,
              children: [
                TextButton(onPressed: (){
            
                }, child: const Text("Delete")) , 
                 const Divider(height: 8,
                
                ),
             TextButton(onPressed: (){
            
                }, child: const Text("Copy")) , 
             TextButton(onPressed: (){
            
                }, child: const Text("Edit")) , 
            
            
              ],
            )
            
              ],
            )
            ,
            const SizedBox(height: 3,)
            ],),
                    );
            return ListTile(
            title: Text(address.fullName.toString(), 
                    
                    style: const TextStyle(
            color: Colors.black
                    ),
                    ), 
            subtitle: Text(address.city!, 
                    
                    style: const TextStyle(
            color: Colors.black
                    ),
                    ), 
                    
                    );
                    }
              ).toList(),
            ),
          );
        }
        , 
        loading: ()=>  Skeletonizer(child: 
        ListView(
            shrinkWrap: true, 
            children: [5,345,345,345,35,3,534,534,534,5,345,].map(
        (address)=> Text(address.toString())
            ).toList(),
          )
        ), 
        error: (_ , __)=> IconButton(onPressed: (){
          ref.refresh(addressListFuture(''));
        }, icon: const Icon(Icons.refresh)) 
        
               ), 
                
                
             Padding(
              padding: const EdgeInsets.all(8.0),
              child: MainButton(text: 
              // widget.addressSelection!?
              'Select',
              
              // 'Add a new address', 
              color: Colors.amber[900]!,
              onPressed: (){

                if (   widget.addressSelection!) {

                  widget.selectAddress!(selectedAddressModel!);
                  Navigator.pop(context);

                  return;
                }


              }),
            )
          ],
        ),
      ),

      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
      
        child: FloatingActionButton(
          
          backgroundColor: Theme.of(context).primaryColor,
          onPressed: 
        
        (){
        
                   Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                      return const LocationPicker();
                      
                      
                        // return MapLocationPicker(
                        //   apiKey: "AIzaSyC0q-wYn5rsUtWx2zLLr8uRftMaTIPU2U4",
                        //   popOnNextButtonTaped: true,
                        //   // hideBackButton: true  ,
                        //   currentLatLng: const LatLng(29.146727, 76.464895),
                        //   debounceDuration: const Duration(milliseconds: 500),
                        
                        //   onNext: (GeocodingResult? result) {
                        //     if (result != null) {
                        //       setState(() {
                        //         // address = result.formattedAddress ?? "";
                        //       });
                  
                              
                        //     }
                  
                            
                        //   },
                        //   onLongPress: (ltlng){
                        //     Navigator.of(context)
                        //       .pushReplacement(MaterialPageRoute(builder: (_)=> 
                        //        AddNewAddressPage(
                        //         latLng: ltlng
                                
                        //         ,
                        //       )
                        //       ));
                        //   },
                        //   onSuggestionSelected: (PlacesDetailsResponse? result) {
                        //     if (result != null) {
                        //       setState(() {
                        //         // autocompletePlace =
                        //         //     result.result.formattedAddress ?? "";
                        //       });
                        //     }
                        //   },
                        // );
                      
                      
                      },
                    ),
                  );
              
              
        }, 
        child: const Icon(Icons.add ,color: Colors.white,),
        ),
      ),
    );
  }
}