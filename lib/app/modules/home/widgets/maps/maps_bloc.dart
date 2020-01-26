import 'package:desafio_maps/app/modules/home/home_bloc.dart';
import 'package:desafio_maps/app/modules/home/home_module.dart';
import 'package:desafio_maps/app/modules/home/home_repository.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rxdart/rxdart.dart';

class MapsBloc extends Disposable {
  HomeRepository _repo = HomeModule.to.get<HomeRepository>();
  HomeBloc bloc = HomeModule.to.get<HomeBloc>();
  BehaviorSubject<Set<Marker>> markers =
      BehaviorSubject<Set<Marker>>.seeded(Set<Marker>());

  Future<void> getNearbyPlaces(double lat, double lng) async {
    // NOTE Verify if the last request have more than 1000 meters from the future request 
    if (markers.value.isEmpty || (await Geolocator()
            .distanceBetween(bloc.lastLat, bloc.lastLng, lat, lng)) >
        1000) {
      bloc.updateLastLocation(lat, lng);
      addMarkersOffline();
      // var res = await _repo.getPlacesNearby(
      //     bloc.lastLat.toString(), bloc.lastLng.toString());
      // addAllMarkers(
      //   List.castFrom<dynamic, Map<String, dynamic>>(res.data['results'])
      //       .map(
      //         (json) => markerFromJson(json),
      //       )
      //       .toSet(),
      // );
      // while (res.data.containsKey("next_page_token")) {
      //   res = await _repo.getPlacesNearby(
      //       bloc.lastLat.toString(), bloc.lastLng.toString(),
      //       pageToken: res.data['next_page_token']);
      //   addAllMarkers(
      //     List.castFrom<dynamic, Map<String, dynamic>>(res.data['results'])
      //         .map(
      //           (json) => markerFromJson(json),
      //         )
      //         .toSet(),
      //   );
      // }
    }
  }

  Marker markerFromJson(Map<String, dynamic> json) {
    return Marker(
        position: LatLng(json['geometry']['location']['lat'],
            json['geometry']['location']['lng']),
        markerId: MarkerId(json['place_id']),
        onTap: () {
          bloc.openDetailsPlace(json['place_id']);
        },
        infoWindow: InfoWindow(
          title: json['name'],
        ));
  }

  void addAllMarkers(Set<Marker> _markers) {
    Set<Marker> list = markers.value;
    list.addAll(_markers);
    markers.sink.add(list);
  }

  void addMarkersOffline(){
    addAllMarkers([
      {
         "geometry": {
            "location": {
               "lat": -25.4101027,
               "lng": -49.2671932
            },
            "viewport": {
               "northeast": {
                  "lat": -25.4087096,
                  "lng": -49.2653134
               },
               "southwest": {
                  "lat": -25.4116904,
                  "lng": -49.2683786
               }
            }
         },
         "icon": "https://maps.gstatic.com/mapfiles/place_api/icons/museum-71.png",
         "id": "5ca3f67fdc03a8afce6fa3d13a92a7bec60f29fa",
         "name": "Museu Oscar Niemeyer",
         "opening_hours": {
            "open_now": true
         },
         "photos": [
            {
               "height": 2365,
               "html_attributions": [
                  "<a href=\"https://maps.google.com/maps/contrib/107578356434471648197\">Museu Oscar Niemeyer</a>"
               ],
               "photo_reference": "CmRaAAAAAPeedrZU__B1VSrp1jpIIH80FYIgBi9us4XYQh8rumT2NeP_FzO4Z5MyriOhioaic6CQ6Dx6sVTxuMlpZ8uza30D7g8jj5ke39YukXP-sZ_NV6KNxMTVJai2IPA4cxq_EhDCya6tOU_C2babFN7gua4rGhTMoCH21X_0HuaGK3DlfkxP4hfgiQ",
               "width": 3543
            }
         ],
         "place_id": "ChIJFWlvqB_k3JQR7jsyAF9M8vU",
         "plus_code": {
            "compound_code": "HPQM+X4 Centro Cívico - Matriz, Curitiba - State of Paraná, Brazil",
            "global_code": "586GHPQM+X4"
         },
         "rating": 4.7,
         "reference": "ChIJFWlvqB_k3JQR7jsyAF9M8vU",
         "scope": "GOOGLE",
         "types": [
            "museum",
            "tourist_attraction",
            "point_of_interest",
            "establishment"
         ],
         "user_ratings_total": 35206,
         "vicinity": "Rua Marechal Hermes, 999 - Centro Cívico, Curitiba"
      },
      {
         "geometry": {
            "location": {
               "lat": -25.4253585,
               "lng": -49.2674291
            },
            "viewport": {
               "northeast": {
                  "lat": -25.4219318,
                  "lng": -49.2634584
               },
               "southwest": {
                  "lat": -25.4286006,
                  "lng": -49.2707768
               }
            }
         },
         "icon": "https://maps.gstatic.com/mapfiles/place_api/icons/generic_recreational-71.png",
         "id": "6a35a76f1e6fa773d72ee62a94b54ec9024607bb",
         "name": "Passeio Público",
         "opening_hours": {
            "open_now": true
         },
         "photos": [
            {
               "height": 3841,
               "html_attributions": [
                  "<a href=\"https://maps.google.com/maps/contrib/116639319979407829961\">Bruno Caetano</a>"
               ],
               "photo_reference": "CmRaAAAAznAvN5NHLbvl0Q_YaM6HINjMLGy-w5RT3R1Gv7mDamsruksN3mRXdT4Ijj-WDVTKn92aL9enmucrIs8BJ3sakM2aIvRy6_zVHVEZuD7T8JCrGfYJBtEOviT_FEPz3d-FEhADCqO_reJ6eBHCo1khqEZoGhSXgI-OQudwxRjFSNVZjT7l5jLliA",
               "width": 4165
            }
         ],
         "place_id": "ChIJVbyydhTk3JQR3rEscng0WJ4",
         "plus_code": {
            "compound_code": "HPFM+V2 Curitiba, State of Paraná, Brazil",
            "global_code": "586GHPFM+V2"
         },
         "rating": 4.3,
         "reference": "ChIJVbyydhTk3JQR3rEscng0WJ4",
         "scope": "GOOGLE",
         "types": [
            "tourist_attraction",
            "park",
            "point_of_interest",
            "establishment"
         ],
         "user_ratings_total": 19313,
         "vicinity": "Rua Presidente Carlos Cavalcanti, s/n - Centro, Curitiba"
      },
      {
         "geometry": {
            "location": {
               "lat": -25.4323855,
               "lng": -49.2643665
            },
            "viewport": {
               "northeast": {
                  "lat": -25.43105066970849,
                  "lng": -49.2629827197085
               },
               "southwest": {
                  "lat": -25.4337486302915,
                  "lng": -49.2656806802915
               }
            }
         },
         "icon": "https://maps.gstatic.com/mapfiles/place_api/icons/worship_general-71.png",
         "id": "2d6f73b9eb70e2822ed00e768046dd8f1e7e2b05",
         "name": "Sanctuary of Our Lady of Guadalupe",
         "photos": [
            {
               "height": 3096,
               "html_attributions": [
                  "<a href=\"https://maps.google.com/maps/contrib/114286897009645293655\">Andre Luiz Cardoso de Morais</a>"
               ],
               "photo_reference": "CmRaAAAARKryb_hcviQnGfS-PuBQDizYIIcLo4ELj4i-aMQEct8uLXDoG7TeiMnqGWbRu8239JY3PNDzgbh6VP4pWMqR8YIZynZmLneXvmEKFZykT0S59jsCQ16lCdYKk7jI0-fqEhAc51K8EwksiJScAK1KA0LpGhSP0SkJgXTVEBwS2JAhJMTBpbNlSA",
               "width": 4128
            }
         ],
         "place_id": "ChIJJbHyHGrk3JQRpX_Ng-vYD2g",
         "plus_code": {
            "compound_code": "HP9P+27 Curitiba, State of Paraná, Brazil",
            "global_code": "586GHP9P+27"
         },
         "rating": 4.8,
         "reference": "ChIJJbHyHGrk3JQRpX_Ng-vYD2g",
         "scope": "GOOGLE",
         "types": [
            "tourist_attraction",
            "church",
            "place_of_worship",
            "point_of_interest",
            "establishment"
         ],
         "user_ratings_total": 1045,
         "vicinity": "Praça Senador Correia, 128 - Centro, Curitiba"
      },
      {
         "geometry": {
            "location": {
               "lat": -25.4296238,
               "lng": -49.2698936
            },
            "viewport": {
               "northeast": {
                  "lat": -25.4282659197085,
                  "lng": -49.26852346970851
               },
               "southwest": {
                  "lat": -25.4309638802915,
                  "lng": -49.2712214302915
               }
            }
         },
         "icon": "https://maps.gstatic.com/mapfiles/place_api/icons/generic_business-71.png",
         "id": "95d95b4722ec5318e88d379a05fa2ea29b5302cb",
         "name": "SESC Palace of Liberty",
         "opening_hours": {
            "open_now": true
         },
         "photos": [
            {
               "height": 1000,
               "html_attributions": [
                  "<a href=\"https://maps.google.com/maps/contrib/103130150082539251645\">Sesc Paço da Liberdade</a>"
               ],
               "photo_reference": "CmRaAAAA5lcodbp9oE4JQVmc5U3botBXC4SNnoUwWVo-pf-QytHln2yEtumZyUEeknyHiBPKhs5nDJvwb5Xe3wRTCzRn0UZExlhLO4wSgD-nw1tUsXvup8skcemDKUb660uoDcD6EhDdvY_WneB8NJi8I6gnC3XtGhSEL-pohde6lfNA8e4U13gOdjiBeA",
               "width": 1920
            }
         ],
         "place_id": "ChIJ8--USBPk3JQRlTz-mPPpGHI",
         "plus_code": {
            "compound_code": "HPCJ+52 Centro - Matriz, Curitiba - State of Paraná, Brazil",
            "global_code": "586GHPCJ+52"
         },
         "rating": 4.6,
         "reference": "ChIJ8--USBPk3JQRlTz-mPPpGHI",
         "scope": "GOOGLE",
         "types": [
            "tourist_attraction",
            "point_of_interest",
            "establishment"
         ],
         "user_ratings_total": 4181,
         "vicinity": "Praça Generoso Marques, 189 - Centro, Curitiba"
      },
      {
         "geometry": {
            "location": {
               "lat": -25.4253667,
               "lng": -49.27847610000001
            },
            "viewport": {
               "northeast": {
                  "lat": -25.4239773197085,
                  "lng": -49.27707991970851
               },
               "southwest": {
                  "lat": -25.4266752802915,
                  "lng": -49.2797778802915
               }
            }
         },
         "icon": "https://maps.gstatic.com/mapfiles/place_api/icons/worship_general-71.png",
         "id": "c6ea0eac32244c0220d2e9ce33e833f145b24e3f",
         "name": "Igreja São Vicente de Paulo",
         "opening_hours": {
            "open_now": false
         },
         "photos": [
            {
               "height": 4032,
               "html_attributions": [
                  "<a href=\"https://maps.google.com/maps/contrib/109195532086432011388\">Jahfar Sadek</a>"
               ],
               "photo_reference": "CmRaAAAASTlQXTVqubASrMGs0UrF9Jl4FucwBn0d4yI4CJAdRGcUonRMIcK3fyzRn---3cwDolEo4sLfzVbzaRp9HesoysvkNvh3I-D4RKN2UoVBtlgsw4yApy1exmsG1rxdsWnxEhDsPnlTDCZv0eu-gfZtVUD-GhRpBT7lwj1XP08n1Z9RbW-D_3tfjQ",
               "width": 3024
            }
         ],
         "place_id": "ChIJU4hR3g7k3JQRrNQbZ2dwTPg",
         "plus_code": {
            "compound_code": "HPFC+VJ Curitiba, State of Paraná, Brazil",
            "global_code": "586GHPFC+VJ"
         },
         "rating": 4.7,
         "reference": "ChIJU4hR3g7k3JQRrNQbZ2dwTPg",
         "scope": "GOOGLE",
         "types": [
            "tourist_attraction",
            "church",
            "place_of_worship",
            "point_of_interest",
            "establishment"
         ],
         "user_ratings_total": 425,
         "vicinity": "Avenida Jaime Reis, 531 - São Francisco, Curitiba"
      },
      {
         "geometry": {
            "location": {
               "lat": -25.4029059,
               "lng": -49.26547459999999
            },
            "viewport": {
               "northeast": {
                  "lat": -25.4016014197085,
                  "lng": -49.2638917197085
               },
               "southwest": {
                  "lat": -25.4042993802915,
                  "lng": -49.2665896802915
               }
            }
         },
         "icon": "https://maps.gstatic.com/mapfiles/place_api/icons/worship_general-71.png",
         "id": "ed11ef65776a2847ffaab037394322ab8d179cab",
         "name": "Paróquia de Santo Agostinho e Santa Mônica",
         "photos": [
            {
               "height": 3982,
               "html_attributions": [
                  "<a href=\"https://maps.google.com/maps/contrib/112118378641896203988\">Fabio Moro</a>"
               ],
               "photo_reference": "CmRaAAAAtMyooTpeyn2Edqp1p9DfCgL2urtSAE_hvEURUb2rnCQcpedMQhiA8f2TD8I0nv4j7IhHPVaIwl13era0ZUFL66R8UIvU3caJsaZyheFxkJSIZM3HZ4-SDPIUNZRbH-T0EhAKo8A7tczveigmW-LJPwxVGhRPgOSqrmfjqfBIOAHkpR5YR4sxnQ",
               "width": 6276
            }
         ],
         "place_id": "ChIJk3IHi6Hm3JQR4VYwJwD_bdM",
         "plus_code": {
            "compound_code": "HPWM+RR Curitiba, State of Paraná, Brazil",
            "global_code": "586GHPWM+RR"
         },
         "rating": 4.8,
         "reference": "ChIJk3IHi6Hm3JQR4VYwJwD_bdM",
         "scope": "GOOGLE",
         "types": [
            "tourist_attraction",
            "church",
            "place_of_worship",
            "point_of_interest",
            "establishment"
         ],
         "user_ratings_total": 397,
         "vicinity": "Rua Eurípedes Garcez do Nascimento, 1035 - Ahú, Curitiba"
      },
      {
         "geometry": {
            "location": {
               "lat": -25.439924,
               "lng": -49.238117
            },
            "viewport": {
               "northeast": {
                  "lat": -25.43857501970849,
                  "lng": -49.23676801970849
               },
               "southwest": {
                  "lat": -25.4412729802915,
                  "lng": -49.23946598029149
               }
            }
         },
         "icon": "https://maps.gstatic.com/mapfiles/place_api/icons/museum-71.png",
         "id": "0a4bf550035616e6596196bb854c0b36efec333f",
         "name": "Gerdt Hatschbach Botanical Museum",
         "opening_hours": {
            "open_now": true
         },
         "photos": [
            {
               "height": 1824,
               "html_attributions": [
                  "<a href=\"https://maps.google.com/maps/contrib/113227876520706761191\">Herlon Heros</a>"
               ],
               "photo_reference": "CmRZAAAAAXBJCaxiwitXpfgqo67Hmuh9R-A9kgGyI-S-swDwrU0H8ehTgMSo9Vu1ri4gIvY1LS75T5RLLhwDy4FJicmAMr8PIbCbsSR3NbH6gAlW-bqOwMBvOamwpH3DZ9Gtp5CTEhCxIwW-m3O2qLQr3xNReKpQGhRKSDHtzMcbDYFW8atUzAMexsPk6g",
               "width": 3648
            }
         ],
         "place_id": "ChIJDWkxXwDl3JQRvOxJu4z21rI",
         "plus_code": {
            "compound_code": "HQ66+2Q Jardim Botânico - Matriz, Curitiba - State of Paraná, Brazil",
            "global_code": "586GHQ66+2Q"
         },
         "rating": 4.7,
         "reference": "ChIJDWkxXwDl3JQRvOxJu4z21rI",
         "scope": "GOOGLE",
         "types": [
            "museum",
            "tourist_attraction",
            "point_of_interest",
            "establishment"
         ],
         "user_ratings_total": 2061,
         "vicinity": "Rua Engenheiro Ostoja Roguski, 690 - Jardim Botânico, Curitiba"
      },
      {
         "geometry": {
            "location": {
               "lat": -25.4273967,
               "lng": -49.2762396
            },
            "viewport": {
               "northeast": {
                  "lat": -25.42633625,
                  "lng": -49.27442639999999
               },
               "southwest": {
                  "lat": -25.42994325,
                  "lng": -49.27754240000001
               }
            }
         },
         "icon": "https://maps.gstatic.com/mapfiles/place_api/icons/museum-71.png",
         "id": "94a697905df0712acb31fdc782f47b072885a66c",
         "name": "Museu Paranaense",
         "opening_hours": {
            "open_now": true
         },
         "photos": [
            {
               "height": 2448,
               "html_attributions": [
                  "<a href=\"https://maps.google.com/maps/contrib/103309633577944259267\">Luciana Reis</a>"
               ],
               "photo_reference": "CmRaAAAAjjSC6Mt8AHDhS_dKCV2aEXHcedxzKa6OBSfiGf4M9HAy5-wHibJE_o2ayG3ClQR0PlqutMTs6czj6-viCpwx4pO84D15dHQOsiCOrsCtIg22FV2N75nOMT0LsKQjrrDaEhC2TZg9kbaXMOjPnt7y4ObwGhTvnuFwYArzTF4IxaEQnqetbqkTuw",
               "width": 3264
            }
         ],
         "place_id": "ChIJV5nIeA7k3JQRgFtWpJe_Ay4",
         "plus_code": {
            "compound_code": "HPFF+2G São Francisco - Matriz, Curitiba - State of Paraná, Brazil",
            "global_code": "586GHPFF+2G"
         },
         "rating": 4.7,
         "reference": "ChIJV5nIeA7k3JQRgFtWpJe_Ay4",
         "scope": "GOOGLE",
         "types": [
            "museum",
            "tourist_attraction",
            "point_of_interest",
            "establishment"
         ],
         "user_ratings_total": 2323,
         "vicinity": "Rua Kellers, 289 - São Francisco, Curitiba"
      },
      {
         "geometry": {
            "location": {
               "lat": -25.4343079,
               "lng": -49.2572541
            },
            "viewport": {
               "northeast": {
                  "lat": -25.4328574197085,
                  "lng": -49.2559533197085
               },
               "southwest": {
                  "lat": -25.4355553802915,
                  "lng": -49.2586512802915
               }
            }
         },
         "icon": "https://maps.gstatic.com/mapfiles/place_api/icons/shopping-71.png",
         "id": "ed1fbdef0c424057b14ef90af8e4a0f3a6d22af6",
         "name": "Curitiba City Market",
         "opening_hours": {
            "open_now": true
         },
         "photos": [
            {
               "height": 315,
               "html_attributions": [
                  "<a href=\"https://maps.google.com/maps/contrib/104856008522941453581\">Mercado Municipal de Curitiba</a>"
               ],
               "photo_reference": "CmRaAAAAFWklHeEzA1uDQ9iWx6g7c7dMOoMroyMBDORf3ckkFPG9RuIJZs_hoECQPG9KR2mE2ePjsM9W5NpIwbuAwyXTdaYd3oMl_JuB1pCR3fUasM99MZOXjT77TDNLMokm1yHWEhDJxPLDG6Ts61dnN2dGkbxPGhQUJPoBtrWtfIR0ItKQ-MFSwUEAdw",
               "width": 828
            }
         ],
         "place_id": "ChIJnYfZ7ETk3JQRKsDrOXtHVTU",
         "plus_code": {
            "compound_code": "HP8V+73 Centro - Matriz, Curitiba - State of Paraná, Brazil",
            "global_code": "586GHP8V+73"
         },
         "rating": 4.6,
         "reference": "ChIJnYfZ7ETk3JQRKsDrOXtHVTU",
         "scope": "GOOGLE",
         "types": [
            "tourist_attraction",
            "grocery_or_supermarket",
            "food",
            "point_of_interest",
            "store",
            "establishment"
         ],
         "user_ratings_total": 38819,
         "vicinity": "Avenida Sete de Setembro, 1865 - Centro, Curitiba"
      },
      {
         "geometry": {
            "location": {
               "lat": -25.437499,
               "lng": -49.26579599999999
            },
            "viewport": {
               "northeast": {
                  "lat": -25.4361236697085,
                  "lng": -49.2640089697085
               },
               "southwest": {
                  "lat": -25.4388216302915,
                  "lng": -49.2667069302915
               }
            }
         },
         "icon": "https://maps.gstatic.com/mapfiles/place_api/icons/museum-71.png",
         "id": "daa1cb529b2685f1ba33a3334b5bfb7432dabd93",
         "name": "Railway Museum",
         "opening_hours": {
            "open_now": true
         },
         "photos": [
            {
               "height": 1152,
               "html_attributions": [
                  "<a href=\"https://maps.google.com/maps/contrib/103660929809522544542\">Museu Ferroviário</a>"
               ],
               "photo_reference": "CmRaAAAAuAVXfwIJ8P_dNdvVwSPLfVriWvqrAF1kIQfNh8h1E4jXvY2FN8ys26ZtPb6vhAdB3-OHzdbMr9o3gYrCeBAthgPmZxvd6ozQJzGibIKWz5pTv_dWEcBluj3tYH8EMxZ8EhAlqk5z_2_-gruO0LEY3TMMGhRCYFk64MKEORXSlN0x2PWOo8djGg",
               "width": 2048
            }
         ],
         "place_id": "ChIJiw3yZ2jk3JQRg9MJOP8f60U",
         "plus_code": {
            "compound_code": "HP7M+2M Rebouças - Matriz, Curitiba - State of Paraná, Brazil",
            "global_code": "586GHP7M+2M"
         },
         "rating": 4.6,
         "reference": "ChIJiw3yZ2jk3JQRg9MJOP8f60U",
         "scope": "GOOGLE",
         "types": [
            "tourist_attraction",
            "museum",
            "point_of_interest",
            "establishment"
         ],
         "user_ratings_total": 2787,
         "vicinity": "Avenida Sete de Setembro, 2775 - Rebouças, Curitiba"
      },
      {
         "geometry": {
            "location": {
               "lat": -25.4293568,
               "lng": -49.2674203
            },
            "viewport": {
               "northeast": {
                  "lat": -25.4280861697085,
                  "lng": -49.2660319197085
               },
               "southwest": {
                  "lat": -25.4307841302915,
                  "lng": -49.2687298802915
               }
            }
         },
         "icon": "https://maps.gstatic.com/mapfiles/place_api/icons/museum-71.png",
         "id": "accf0709222aa89f1113f8229435d0cb27e40370",
         "name": "Museu de Arte da UFPR",
         "opening_hours": {
            "open_now": false
         },
         "photos": [
            {
               "height": 3024,
               "html_attributions": [
                  "<a href=\"https://maps.google.com/maps/contrib/109074814272694916491\">Joao Tsuruda</a>"
               ],
               "photo_reference": "CmRaAAAAyCoVKaCXUXB7gml6pO8gjyzuORBh79bKV29ErwdFP296yaXW5fdlxh1QrL4jN23pQf3MMekDElyg2NEDXPl6n8l8HMoCv5xJM59fxpU-gmIKW5EVGrRe_NcTYcvivfENEhAU1yRzM_Pg17LpMxTPxhetGhRXAozBJDgGfM-KWXpECHseJvsQvw",
               "width": 4032
            }
         ],
         "place_id": "ChIJTXHYNGvk3JQRnboG_s-rtT8",
         "plus_code": {
            "compound_code": "HPCM+72 Centro - Matriz, Curitiba - State of Paraná, Brazil",
            "global_code": "586GHPCM+72"
         },
         "rating": 4.6,
         "reference": "ChIJTXHYNGvk3JQRnboG_s-rtT8",
         "scope": "GOOGLE",
         "types": [
            "museum",
            "tourist_attraction",
            "point_of_interest",
            "establishment"
         ],
         "user_ratings_total": 785,
         "vicinity": "Rua XV de Novembro, 695 - Centro, Curitiba"
      },
      {
         "geometry": {
            "location": {
               "lat": -25.427762,
               "lng": -49.271933
            },
            "viewport": {
               "northeast": {
                  "lat": -25.4266231197085,
                  "lng": -49.27071711970849
               },
               "southwest": {
                  "lat": -25.4293210802915,
                  "lng": -49.27341508029149
               }
            }
         },
         "icon": "https://maps.gstatic.com/mapfiles/place_api/icons/generic_business-71.png",
         "id": "529eac8a1cf0af8f61c707710886af50df1ad1c5",
         "name": "Casa Romário Martins",
         "opening_hours": {
            "open_now": true
         },
         "photos": [
            {
               "height": 2736,
               "html_attributions": [
                  "<a href=\"https://maps.google.com/maps/contrib/108534556472192613393\">Jackson Cabral</a>"
               ],
               "photo_reference": "CmRaAAAARLidZpyTnE6UzSO4qxHE8nWIJ6TEwym_Hn7idjTxcognOO83txx9WCthYnlYi2r7wWwBVg3u7l_2tlE-bEYl5VSzRvFuWb4NpAhiA04EGuBugXGQQZKWEBmvpnJy39MMEhC2cLjLkXdK4YpEJOgiSItfGhSz-HT6k_48zIskuRAQOOq-o_z4zw",
               "width": 3648
            }
         ],
         "place_id": "ChIJ_-IyThLk3JQRuvlYBqx05UI",
         "plus_code": {
            "compound_code": "HPCH+V6 São Francisco - Matriz, Curitiba - State of Paraná, Brazil",
            "global_code": "586GHPCH+V6"
         },
         "rating": 4.5,
         "reference": "ChIJ_-IyThLk3JQRuvlYBqx05UI",
         "scope": "GOOGLE",
         "types": [
            "tourist_attraction",
            "point_of_interest",
            "establishment"
         ],
         "user_ratings_total": 17,
         "vicinity": "L, Rua Coronel Enéas, 40 - São Francisco, Curitiba"
      },
      {
         "geometry": {
            "location": {
               "lat": -25.42770179999999,
               "lng": -49.27206119999999
            },
            "viewport": {
               "northeast": {
                  "lat": -25.4262937197085,
                  "lng": -49.2709845697085
               },
               "southwest": {
                  "lat": -25.4289916802915,
                  "lng": -49.2736825302915
               }
            }
         },
         "icon": "https://maps.gstatic.com/mapfiles/place_api/icons/worship_general-71.png",
         "id": "54e4c38bed6559abd6a58e20a8c1a9c0a9b64096",
         "name": "Church Order",
         "opening_hours": {
            "open_now": true
         },
         "photos": [
            {
               "height": 2667,
               "html_attributions": [
                  "<a href=\"https://maps.google.com/maps/contrib/106162868673610996939\">Igreja da Ordem Terceira das São Francisco de Chagas</a>"
               ],
               "photo_reference": "CmRaAAAAXXHClPYIaNZabD1ZDVR6J5kXtdXR5gY6SwZE9j1fkANMyCeNl62-M-5UWSdFs0-GnTaa8nwmDyyF2akvHe2AtfY4li59IuWMIqu2Lwa_e_qR4cRfxxs2dhi34DGZtKb3EhDkJtyFdb1MHspIJuvGdbMtGhSWOkr8KCpq1rjldfohWpnWqH-YZQ",
               "width": 4000
            }
         ],
         "place_id": "ChIJ_Zx3TxLk3JQRzwagvRZdMsQ",
         "plus_code": {
            "compound_code": "HPCH+W5 São Francisco - Matriz, Curitiba - State of Paraná, Brazil",
            "global_code": "586GHPCH+W5"
         },
         "rating": 4.7,
         "reference": "ChIJ_Zx3TxLk3JQRzwagvRZdMsQ",
         "scope": "GOOGLE",
         "types": [
            "tourist_attraction",
            "church",
            "place_of_worship",
            "point_of_interest",
            "establishment"
         ],
         "user_ratings_total": 220,
         "vicinity": "Rua Mateus Leme, 01 - São Francisco, Curitiba"
      },
      {
         "geometry": {
            "location": {
               "lat": -25.4406645,
               "lng": -49.27664009999999
            },
            "viewport": {
               "northeast": {
                  "lat": -25.4393405197085,
                  "lng": -49.2753566697085
               },
               "southwest": {
                  "lat": -25.4420384802915,
                  "lng": -49.2780546302915
               }
            }
         },
         "icon": "https://maps.gstatic.com/mapfiles/place_api/icons/generic_recreational-71.png",
         "id": "91237dac9c708be7c913cf194e21cd15b27506a9",
         "name": "Praça Oswaldo Cruz",
         "opening_hours": {
            "open_now": true
         },
         "photos": [
            {
               "height": 2448,
               "html_attributions": [
                  "<a href=\"https://maps.google.com/maps/contrib/112389231038954459408\">Odair Antunes da Silva</a>"
               ],
               "photo_reference": "CmRaAAAA75DFEklFLQ5eN6w1l6nlcpiqRRU45vBpThNw1SCtl7xymtYj2HVmFH7HYeBqqHcNAm0O3tozsywirxtsF9OgWd_6Lf4TtD5REW3WdPel8cKxov3AcXF6K0o6fVD-jHy1EhAvWb1PuOR88zjcDfhJeZxsGhTnHk-SDYTMzwOxqjILyp8mdZ2d4A",
               "width": 3264
            }
         ],
         "place_id": "ChIJPw1u9nDk3JQRnEy1gx5e0u4",
         "plus_code": {
            "compound_code": "HP5F+P8 Centro - Matriz, Curitiba - State of Paraná, Brazil",
            "global_code": "586GHP5F+P8"
         },
         "rating": 4.5,
         "reference": "ChIJPw1u9nDk3JQRnEy1gx5e0u4",
         "scope": "GOOGLE",
         "types": [
            "park",
            "tourist_attraction",
            "point_of_interest",
            "establishment"
         ],
         "user_ratings_total": 1683,
         "vicinity": "Praça Oswaldo Cruz, S/n - Centro, Curitiba"
      },
      {
         "geometry": {
            "location": {
               "lat": -25.4233842,
               "lng": -49.26841950000001
            },
            "viewport": {
               "northeast": {
                  "lat": -25.4221725197085,
                  "lng": -49.26701951970851
               },
               "southwest": {
                  "lat": -25.4248704802915,
                  "lng": -49.2697174802915
               }
            }
         },
         "icon": "https://maps.gstatic.com/mapfiles/place_api/icons/museum-71.png",
         "id": "fdad645684a5323fa3608f1fbc9d00c23a58a95d",
         "name": "Arabic Memorial",
         "opening_hours": {
            "open_now": false
         },
         "photos": [
            {
               "height": 3024,
               "html_attributions": [
                  "<a href=\"https://maps.google.com/maps/contrib/114254928592988639201\">Kaila Cristina</a>"
               ],
               "photo_reference": "CmRaAAAAuN9O-B2m_5KAznmWaCM6QnTkpw02VGagTb3vv29zU8J5qRgryeOWjSwhnCPY2K5seree8cjS3XNEXCU7zROM2J6KjYAnmJDQS0nTxgKRqst3jNz2tjgnZ6WETfgyxZ8hEhD41PMdo_k-kuC29hM6kUoTGhTWHcP4A3UpsZdtbwincMvqp_GfUA",
               "width": 5376
            }
         ],
         "place_id": "ChIJQY_8thXk3JQRGL-IJ6SE9qg",
         "plus_code": {
            "compound_code": "HPGJ+JJ Centro Cívico - Matriz, Curitiba - State of Paraná, Brazil",
            "global_code": "586GHPGJ+JJ"
         },
         "rating": 4.2,
         "reference": "ChIJQY_8thXk3JQRGL-IJ6SE9qg",
         "scope": "GOOGLE",
         "types": [
            "tourist_attraction",
            "point_of_interest",
            "establishment"
         ],
         "user_ratings_total": 277,
         "vicinity": "Avenida João Gualberto, 141 - Centro Cívico, Curitiba"
      },
      {
         "geometry": {
            "location": {
               "lat": -25.4278063,
               "lng": -49.2722547
            },
            "viewport": {
               "northeast": {
                  "lat": -25.4264573197085,
                  "lng": -49.2709057197085
               },
               "southwest": {
                  "lat": -25.42915528029151,
                  "lng": -49.2736036802915
               }
            }
         },
         "icon": "https://maps.gstatic.com/mapfiles/place_api/icons/generic_business-71.png",
         "id": "863bcb3ccbe25c4a5edd44a9189880f708efb133",
         "name": "Feira do Largo da Ordem",
         "opening_hours": {
            "open_now": true
         },
         "photos": [
            {
               "height": 3024,
               "html_attributions": [
                  "<a href=\"https://maps.google.com/maps/contrib/105856953343856269616\">Henrique Martins</a>"
               ],
               "photo_reference": "CmRaAAAACNS603OvHfBz9EjRsLr7ybVylXDjYRVmurRJygrhyA3tBbXqcY-IDbfS7zW5fb-xaBnwCks6Mk2V2A65qqq1kXs5NkD7xuBISuTs6voEEdMpahOt7UsRSFBOqyLGWlMhEhAQoa_mZZ69VbSuyREGZNU1GhTO99KEok7yBjZBmnsW0338zkBaHg",
               "width": 4032
            }
         ],
         "place_id": "ChIJ1xk5fw7k3JQRS4MOx9pS0yQ",
         "plus_code": {
            "compound_code": "HPCH+V3 Curitiba, State of Paraná, Brazil",
            "global_code": "586GHPCH+V3"
         },
         "rating": 4.7,
         "reference": "ChIJ1xk5fw7k3JQRS4MOx9pS0yQ",
         "scope": "GOOGLE",
         "types": [
            "tourist_attraction",
            "point_of_interest",
            "establishment"
         ],
         "user_ratings_total": 14483,
         "vicinity": "Cavalo Babão - Rua Kellers, s/n - São Francisco, Curitiba"
      },
      {
         "geometry": {
            "location": {
               "lat": -25.4276708,
               "lng": -49.2735195
            },
            "viewport": {
               "northeast": {
                  "lat": -25.42631656970849,
                  "lng": -49.2721556197085
               },
               "southwest": {
                  "lat": -25.4290145302915,
                  "lng": -49.27485358029149
               }
            }
         },
         "icon": "https://maps.gstatic.com/mapfiles/place_api/icons/worship_general-71.png",
         "id": "27ad5874024d88eec42af498b65535d45e3bf7c5",
         "name": "First Presbyterian Church Curitiba Independent",
         "photos": [
            {
               "height": 2151,
               "html_attributions": [
                  "<a href=\"https://maps.google.com/maps/contrib/101257347784084827662\">ESPAÇO SILVA</a>"
               ],
               "photo_reference": "CmRaAAAAKgm5tGqbDzW2wEhRLBpby7jKxhWPNpURYMOGBQmXdoQeSgdcPreuU8OYYHn2gz1IxHc-EuojtYffJFLiAGrQdAnYTsLbZGnNm_cAvTNqQzntMRg7EEfoJQgNlTFUNDMSEhAiOQx4iF6vpARC1hXufDw9GhRCEQvyO68Yi3iP2mNG1u8m_5Bimw",
               "width": 3823
            }
         ],
         "place_id": "ChIJq1QgDRLk3JQRad74IoPy-bk",
         "plus_code": {
            "compound_code": "HPCG+WH Curitiba, State of Paraná, Brazil",
            "global_code": "586GHPCG+WH"
         },
         "rating": 4.7,
         "reference": "ChIJq1QgDRLk3JQRad74IoPy-bk",
         "scope": "GOOGLE",
         "types": [
            "tourist_attraction",
            "church",
            "place_of_worship",
            "point_of_interest",
            "establishment"
         ],
         "user_ratings_total": 21,
         "vicinity": "Rua do Rosário, 218 - Centro, Curitiba"
      },
      {
         "geometry": {
            "location": {
               "lat": -25.410987,
               "lng": -49.2330599
            },
            "viewport": {
               "northeast": {
                  "lat": -25.4096078197085,
                  "lng": -49.2316571197085
               },
               "southwest": {
                  "lat": -25.4123057802915,
                  "lng": -49.2343550802915
               }
            }
         },
         "icon": "https://maps.gstatic.com/mapfiles/place_api/icons/generic_business-71.png",
         "id": "a52829eab6aeda9d73fbb91a963fef45dd8d35e5",
         "name": "Santuário Nossa Senhora da Salette",
         "opening_hours": {
            "open_now": true
         },
         "photos": [
            {
               "height": 3047,
               "html_attributions": [
                  "<a href=\"https://maps.google.com/maps/contrib/110119159006456532950\">Santuário Nossa Senhora da Salette</a>"
               ],
               "photo_reference": "CmRaAAAAuMvPa8BGjkia-B2VA_NSBnGeXC9CcPT6vMvKPjykIxUFpvan_w82mZcBk4JPL48Ah96gwMN_JY8tIr3CRCzLB7pmgKVhWwOXbwINR84WO3nncauHD0xpxwejLOn7mBeEEhD7LxOkjMyd9KGsFO7i4olgGhQd_xXE8qlTd8B1GuqqIgaLQ1NRjw",
               "width": 2538
            }
         ],
         "place_id": "ChIJy1V-hMXl3JQRONTydOzMVWA",
         "plus_code": {
            "compound_code": "HQQ8+JQ Jardim Social - Matriz, Curitiba - State of Paraná, Brazil",
            "global_code": "586GHQQ8+JQ"
         },
         "rating": 4.9,
         "reference": "ChIJy1V-hMXl3JQRONTydOzMVWA",
         "scope": "GOOGLE",
         "types": [
            "tourist_attraction",
            "place_of_worship",
            "point_of_interest",
            "establishment"
         ],
         "user_ratings_total": 53,
         "vicinity": "Rua Lange de Morretes, 691 - Jardim Social, Curitiba"
      },
      {
         "geometry": {
            "location": {
               "lat": -25.4149928,
               "lng": -49.2685798
            },
            "viewport": {
               "northeast": {
                  "lat": -25.4136997697085,
                  "lng": -49.26691906970849
               },
               "southwest": {
                  "lat": -25.4163977302915,
                  "lng": -49.26961703029149
               }
            }
         },
         "icon": "https://maps.gstatic.com/mapfiles/place_api/icons/generic_business-71.png",
         "id": "f01b5e11abd06659dd1b46bbf09bf5c0c6bb033b",
         "name": "Praça Nossa Senhora de Salette",
         "opening_hours": {
            "open_now": true
         },
         "photos": [
            {
               "height": 3456,
               "html_attributions": [
                  "<a href=\"https://maps.google.com/maps/contrib/101789797249008211374\">Leonardo Oliveira</a>"
               ],
               "photo_reference": "CmRaAAAAtchL-NNp-paUWTX-dbXA01lJbvv8bvDz6Og32I2glkOMeoysN2QLxITvScMAxU0w72xDWhFdncM11hkqflTxuMpJSI0IeA6C5klW7-T3dWiSuEV6oITteurP2m96Ou0AEhCJCfMX_oXCCPd6sWODubkbGhQCdblMBDxahH_tcE6VeqBCFuP6ww",
               "width": 4608
            }
         ],
         "place_id": "ChIJVX89sx7k3JQRKNcWy_-cgok",
         "plus_code": {
            "compound_code": "HPPJ+2H Curitiba, State of Paraná, Brazil",
            "global_code": "586GHPPJ+2H"
         },
         "rating": 4.4,
         "reference": "ChIJVX89sx7k3JQRKNcWy_-cgok",
         "scope": "GOOGLE",
         "types": [
            "tourist_attraction",
            "park",
            "point_of_interest",
            "establishment"
         ],
         "user_ratings_total": 3771,
         "vicinity": "Avenida Cândido de Abreu, 1039 - Centro Cívico, Curitiba"
      },
      {
         "geometry": {
            "location": {
               "lat": -25.4334279,
               "lng": -49.2836418
            },
            "viewport": {
               "northeast": {
                  "lat": -25.4321390197085,
                  "lng": -49.2824674197085
               },
               "southwest": {
                  "lat": -25.4348369802915,
                  "lng": -49.2851653802915
               }
            }
         },
         "icon": "https://maps.gstatic.com/mapfiles/place_api/icons/worship_general-71.png",
         "id": "5ddf9aa204f7bbc61fa1efd3152250f8fcdc1d5b",
         "name": "Parish San Francisco de Paula",
         "opening_hours": {
            "open_now": true
         },
         "photos": [
            {
               "height": 3096,
               "html_attributions": [
                  "<a href=\"https://maps.google.com/maps/contrib/108225791246753467662\">Luiz Carlos Betenheuser Júnior</a>"
               ],
               "photo_reference": "CmRaAAAAM4xHmEQ3lDkqm6eg9yyrwZV3FeeW2igJsIhUxaWAJaOc12Q8P6wIRANCXesQElt0h-8Gib2M8iLytVkToqoY93Wrf2Ord8v8FJsUvGyT46WypBZ8J6-HQZ4jFX6gQ1SwEhDI2Z9ZoNMKWSdbwIQXqthVGhQMnZM1kkfQNLAfue7fGmPg_7hE4Q",
               "width": 4128
            }
         ],
         "place_id": "ChIJRXDkcPfj3JQRebzxF0IB7-o",
         "plus_code": {
            "compound_code": "HP88+JG Curitiba, State of Paraná, Brazil",
            "global_code": "586GHP88+JG"
         },
         "rating": 4.8,
         "reference": "ChIJRXDkcPfj3JQRebzxF0IB7-o",
         "scope": "GOOGLE",
         "types": [
            "tourist_attraction",
            "church",
            "place_of_worship",
            "point_of_interest",
            "establishment"
         ],
         "user_ratings_total": 188,
         "vicinity": "Rua Desembargador Motta, 2500 - Centro, Curitiba"
      }
   ].map((json) => markerFromJson(json)).toSet());
  }

  //dispose will be called automatically by closing its streams
  @override
  void dispose() {
    markers.close();
  }
}
