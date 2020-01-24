import 'package:flutter/material.dart';
class PlaceTileWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: <Widget>[
          CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage("https://www.ademilar.com.br/blog/wp-content/uploads/2018/02/conheca-o-jardim-botanico-de-curitiba-ademilar.jpg"),
          ),
        ],
      ),
    );
  }
}
  