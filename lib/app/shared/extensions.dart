import 'dart:ui';

extension FuturePlus on Future{
  static Future<List<A>> forEachFuture<T, A>(List<T> dataList, Future<A> Function(T) transformObject) async {
    List<A> list = List<A>();
    dataList.forEach((o) async {
      list.add(await transformObject(o));
    });
    await Future.doWhile(() async {
      if(dataList.length != list.length){
        await Future.delayed(Duration(milliseconds: 200));
      }
      return (dataList.length != list.length);
    });
    return list;
  }
}

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}

extension StringCapitalise on String{
  String capitalise() {
    String text;  
    text = this.split(" ").map<String>((t) {
      return t[0].toUpperCase() + t.substring(1);
    }).reduce((a, b) => a + " " + b);
    return text;
  }
}