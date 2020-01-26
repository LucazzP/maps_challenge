import 'package:desafio_maps/app/modules/home/widgets/maps/maps_widget.dart';
import 'package:desafio_maps/app/modules/home/widgets/search/search_widget.dart';
import 'package:flutter/material.dart';

import 'home_bloc.dart';
import 'home_module.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: MapsWidget(),
      key: HomeModule.to.get<HomeBloc>().scaffoldKey,
      bottomNavigationBar: _bottomNavigator,
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(double.maxFinite),
        child: SearchWidget(),
      ),
    );
  }

  final Widget _bottomNavigator = BottomNavigationBar(
    items: [
      const BottomNavigationBarItem(
        icon: const Icon(Icons.star),
        title: const SizedBox(),
      ),
      const BottomNavigationBarItem(
        icon: const Icon(Icons.location_on),
        title: const SizedBox(),
      ),
      const BottomNavigationBarItem(
        icon: const Icon(Icons.person),
        title: const SizedBox(),
      ),
    ],
  );
}
