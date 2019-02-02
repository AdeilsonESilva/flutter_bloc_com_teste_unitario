import 'package:bloc_test/src/home/home_service.dart';
import 'package:bloc_test/src/home/model/post.dart';
import 'package:rxdart/rxdart.dart';

class HomeBloc {
  final _listController = BehaviorSubject<bool>(seedValue: false);
  Sink<bool> get listIn => _listController.sink;
  Observable<List<Post>> listOut;

  HomeService service = HomeService();

  HomeBloc() {
    listOut = _listController.stream.asyncMap((d) => service.getPosts());
  }

  dispose() {
    _listController.close();
  }
}
