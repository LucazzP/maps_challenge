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