import 'dart:developer';

import 'package:ecommerce_app/address/view/location_picker.dart';
import 'package:ecommerce_app/features/home/views/home.dart';
import 'package:ecommerce_app/providers/address_provider.dart';
import 'package:ecommerce_app/shared/widget/main_button.dart';
import 'package:ecommerce_app/shared/widget/normal_textfield.dart';
import 'package:ecommerce_app/shared/widget/phone_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:map_location_picker/map_location_picker.dart';
import 'package:mix/mix.dart';

class AddNewAddressPage extends ConsumerStatefulWidget {
  final LatLng? latLng;
  final double? lat;
  final double? lng;

  const AddNewAddressPage( {

    this.lat, this.lng,this.latLng, super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddNewAddressPageState();
}

class _AddNewAddressPageState extends ConsumerState<AddNewAddressPage> {
final style = Style(
  $box.height(10),
  // $box.width(100),
  
);
final TextEditingController _countryController = TextEditingController();
final FocusNode _countryFocus= FocusNode();

final TextEditingController _cityController = TextEditingController();
final FocusNode _cityFocus= FocusNode();


final TextEditingController _streetController = TextEditingController();
final FocusNode _streetFocus= FocusNode();
final _formKey = GlobalKey<FormState>();

final TextEditingController _zipController = TextEditingController();
final FocusNode _zipFocus= FocusNode();


final TextEditingController _fnameController = TextEditingController();
final FocusNode _fnameFocus= FocusNode();


final TextEditingController _lnameController = TextEditingController();
final FocusNode _lnameFocus= FocusNode();

final TextEditingController _phoneController = TextEditingController();
final FocusNode _phoneFocus= FocusNode();


double? resLat, resLng;

 // Password validation
  String? _requiredFieldValidation(String? value) {
    if (value == null || value.isEmpty) {
      return 'this filed is required';
    } 
    return null;
  }

Widget Gap(){
  return Box(style: style,);
}
@override
  void dispose() {
_cityController.dispose();
_cityController.dispose();
_streetController.dispose();
_zipController.dispose();
_fnameController.dispose();
_lnameController.dispose();
_phoneController.dispose();



    // TODO: implement dispose
    super.dispose();
  }

  void _addAddress(BuildContext context )async{
     final address = ref.watch(addressesProvider.notifier);
    if (_formKey.currentState!.validate()) {
       final error = await
       address.addAddress(_countryController.text,
        _cityController.text, _streetController.text,
         _zipController.text, 
         '${_fnameController.text} ${_lnameController.text}'
         , _phoneController.text
         , 
         
          widget.lat! ,widget.lng!
         
         );

                if (error.toString().toLowerCase().contains("failed")) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(error.toString())),
                  );
                } else {
                  Navigator.pop(context);
                }
    }
  }



  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Add new Address"),
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

      body:   Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          
          child: Column(
            
            children: [
        SizedBox(
          height: MediaQuery.sizeOf(context).width*.30,
        child: GestureDetector(
          onTap: (){
            Navigator.of(context).push(
        
        MaterialPageRoute(builder: (_)=>  
        
        const LocationPicker()
        )
            ).then((result){
        Map<String,dynamic> res = result;
        resLat = res['lat'];
        resLng = res['lng'];
        setState(() {
          
        });
            });
          },
          child: GoogleMap(
            onTap: (latlng){
  Navigator.of(context).push(
        
        MaterialPageRoute(builder: (_)=>  
        
         LocationPicker(
          initialLatitude: latlng.latitude,
          initialLongitude: latlng.longitude,
        )
        ));
            },
            markers: {
        Marker(markerId: const MarkerId("current"), 
        
        position: LatLng(
          
          resLat??
          widget.lat!,resLng?? widget.lng!)
        )
            },
            initialCameraPosition: CameraPosition(target: 
          LatLng(
            resLat??
            widget.lat!, 
            resLng??
            widget.lng!), 
          
          
          
          )),
        ),
        ),
        const SizedBox(height: 20,) ,
               NormalextFormField(hintText: 'Country/Region', 
              controller: _countryController,
                                      validator: _requiredFieldValidation,
        
              ), 
        
               Gap(),
                           NormalextFormField(hintText: 'City', 
        
                                      controller: _cityController,
        
                          validator: _requiredFieldValidation,
                          
                          ),
                           Gap(),
               NormalextFormField(hintText: 'Street'
              
              ,
              controller: _streetController,       
                               validator: _requiredFieldValidation,
        
              ), 
               Gap(),
                 NormalextFormField(hintText: 'Zip code', 
                 
                controller: _zipController,                        validator: _requiredFieldValidation,
        
                 ), 
               Gap(),
               NormalextFormField(hintText: 'First Name'
              , controller: _fnameController,                        validator: _requiredFieldValidation,
        
              
              ), 
         Gap(),
                           NormalextFormField(hintText: 'Last Name', 
                           controller: _lnameController,                        validator: _requiredFieldValidation,
        
                           ), 
         Gap(),
                           PhoneFormField(hintText: 
                          'phone Number', 
                          controller: _phoneController,
                          keyboardType: TextInputType.number,                        validator: _requiredFieldValidation,
        
                        
                          ),
        
                           Gap(), 
        MainButton(
            color: Colors.amber[900]!,
          text: 'Save',
          
        isLoading: ref.watch(addressesProvider),
                onPressed:()=> _addAddress(context),
        
        
        )
        
            ],
          ),
          ),
      ),
    );
  }
}