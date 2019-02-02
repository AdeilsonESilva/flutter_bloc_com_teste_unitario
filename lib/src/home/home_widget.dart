import 'package:bloc_test/src/home/home_bloc.dart';
import 'package:bloc_test/src/home/model/post.dart';
import 'package:flutter/material.dart';

class HomeWidget extends StatefulWidget {
  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  HomeBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = HomeBloc();
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("JSON API"),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: bloc.listOut,
        builder: (context, AsyncSnapshot<List<Post>> snapshot) {
          if (!snapshot.hasData)
            return Center(
              child: CircularProgressIndicator(),
            );

          if (snapshot.hasError)
            return GestureDetector(
              onTap: () {
                bloc.listIn.add(true);
              },
              child: Center(
                child: Text("Houve um erro!"),
              ),
            );

          List<Post> posts = snapshot.data;

          return ListView.builder(
            itemCount: posts.length,
            itemBuilder: (BuildContext context, int index) {
              Post post = posts[index];
              print(post.id);
              return ListTile(
                leading: CircleAvatar(
                  child: Text("${post.id}"),
                ),
                title: Text(post.title),
                subtitle: Text(post.body),
              );
            },
          );
        },
      ),
    );
  }
}
