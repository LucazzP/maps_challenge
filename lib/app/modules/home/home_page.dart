import 'package:desafio_maps/app/modules/home/home_bloc.dart';
import 'package:desafio_maps/app/modules/home/home_module.dart';
import 'package:desafio_maps/app/modules/home/subpages/favorites/favorites_page.dart';
import 'package:desafio_maps/app/modules/home/subpages/maps/maps_page.dart';
import 'package:desafio_maps/app/modules/home/subpages/profile/profile_page.dart';
import 'package:desafio_maps/app/modules/home/widgets/search/search_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final HomeBloc bloc = HomeModule.to.get<HomeBloc>();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: PageView(
        controller: bloc.pageController,
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
          FavoritesPage(),
          MapsPage(),
          ProfilePage(),
        ],
      ),
      key: bloc.scaffoldKey,
      bottomNavigationBar: _bottomNavigator,
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: StreamBuilder<int>(
            stream: bloc.activePage.stream,
            initialData: 1,
            builder: (context, snapshot) {
              return snapshot?.data == 1 ? SearchWidget() : AppBar(
                title: Text(snapshot.data == 0 ? "Favorites" : "Profile", style: TextStyle(fontWeight: FontWeight.w900),),
                centerTitle: true,
                actions: <Widget>[
                  if(snapshot.data == 2) IconButton(
                    icon: Icon(Icons.exit_to_app),
                    onPressed: () => FirebaseAuth.instance.signOut(),
                  )
                ],
              );
            }),
      ),
    );
  }

  Widget get _bottomNavigator => StreamBuilder<int>(
        stream: bloc.activePage.stream,
        initialData: 1,
        builder: (BuildContext context, snapshot) {
          return BottomNavigationBar(
            onTap: (page) => bloc.changePage(page),
            currentIndex: snapshot.data,
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
        },
      );
}
