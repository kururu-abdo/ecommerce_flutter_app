import 'package:ecommerce_app/features/home/bloc/home_bloc.dart';
import 'package:ecommerce_app/features/home/bloc/home_event.dart';
import 'package:ecommerce_app/features/home/bloc/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home2 extends StatefulWidget {
  const Home2({super.key});

  @override
  State<Home2> createState() => _Home2State();
}

class _Home2State extends State<Home2> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
       context
        .read<HomeBloc>()
        .add(const LoadHomeCategoriesEvent(
          categories: [] ,
          isCompleted: false
        ));
  }
  @override
  Widget build(BuildContext context) {
    return     BlocBuilder<HomeBloc, HomeViewState>(
                        builder: (context, state) {
if (state.status== HomeViewStatus.loading) {
  return const CircularProgressIndicator();
}
else if (state.status== HomeViewStatus.loading) {
  return const Text("Error");
}else{
  return const SizedBox();
}


                        }
    );
  }
}