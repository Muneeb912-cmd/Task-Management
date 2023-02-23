import 'package:fire_base_crud/Models/Task_Model.dart';
import 'package:fire_base_crud/screens/Details.dart';
import 'package:fire_base_crud/screens/Edit.dart';
import 'package:fire_base_crud/screens/Insertion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../services/remort_services.dart';
import '../utils/widgets_function.dart';

class Posts extends StatefulWidget {
  const Posts({super.key});

  @override
  State<Posts> createState() => _PostsState();
}

class _PostsState extends State<Posts> {
  List<TaskModel>? Task;
  var isLoaded = false;
  String id = '';

  //bool isDeleted = false;

  @override
  void initState() {
    super.initState();
    //fetching data
    getdata();
  }

  getdata() async {
    Task = await remort_services().getPosts();
    //print(posts?.length);
    if (Task != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  deleteData(String id) {
    remort_services().Delete(id);
  }

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    initState();
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    ScrollController scollBarController = ScrollController();
    return Scaffold(
      backgroundColor: Color.fromRGBO(99, 89, 133, 1.0),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Insertion()),
            );
          },
        ),
        centerTitle: true,
        title: const Text(
          "Today's Task",
          style: TextStyle(color: Color.fromRGBO(255, 254, 251, 0.992)),
        ),
        backgroundColor: Color.fromRGBO(68, 60, 104, 1.0),
      ),
      body: Scrollbar(
        controller: scollBarController,
        child: Visibility(
          visible: isLoaded,
          replacement: const Center(
            child: CircularProgressIndicator(),
          ),
          child: ListView.builder(
              controller: scollBarController,
              itemCount: Task?.length,
              itemBuilder: (context, index) {
                // print(index);
                // print(posts![1]);
                const Text('Swipe right to Access Delete method');

                return Slidable(
                  // Specify a key if the Slidable is dismissible.
                  key: Key(Task![index].id),

                  // The start action pane is the one at the left or the top side.
                  startActionPane: ActionPane(
                    // A motion is a widget used to control how the pane animates.
                    motion: const ScrollMotion(),

                    // A pane can dismiss the Slidable.
                    dismissible: DismissiblePane(
                      key: Key(Task![index].id),
                      onDismissed: () {
                        deleteData(Task![index].id);
                        setState(() {
                          Task!.removeAt(index);
                        });

                        // Then show a snackbar.
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text('dismissed')));
                      },
                    ),

                    // All actions are defined in the children parameter.
                    children: const [
                      // A SlidableAction can have an icon and/or a label.
                      SlidableAction(
                        onPressed: null,
                        backgroundColor: Color.fromRGBO(99, 89, 133, 1.0),
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                        label: 'Swipe Right to Delete',
                      ),
                    ],
                  ),

                  // The end action pane is the one at the right or the bottom side.
                  endActionPane: ActionPane(
                    motion: ScrollMotion(),
                    children: [
                      SlidableAction(
                        // An action can be bigger than the others.
                        flex: 2,
                        onPressed: (context) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Edit(
                                      id: Task![index].id,
                                      date: Task![index].date,
                                      deadline: Task![index].deadline,
                                      description: Task![index].description,
                                      status: Task![index].status,
                                      title: Task![index].title,
                                    )),
                          );
                        },
                        backgroundColor: Color.fromRGBO(99, 89, 133, 1.0),
                        foregroundColor: Colors.white,
                        icon: Icons.edit,
                        label: 'Edit',
                      ),
                    ],
                  ),

                  // The child of the Slidable is what the user sees when the
                  // component is not dragged.

                  child: Container(
                    width: 10000,
                    height: 100,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Details(
                                    id: Task![index].id,
                                    date: Task![index].date,
                                    deadline: Task![index].deadline,
                                    description: Task![index].description,
                                    status: Task![index].status,
                                    title: Task![index].title,
                                  )),
                        );
                      },
                      child: Card(
                        margin: EdgeInsets.all(10),
                        color: Color.fromRGBO(57, 48, 83, 1.0),
                        shadowColor: Colors.blueGrey,
                        elevation: 10,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              //crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // Padding(
                                //   padding: EdgeInsets.only(left: 25),
                                //   child: RichText(
                                //       text: TextSpan(
                                //           style: const TextStyle(
                                //             fontSize: 14.0,
                                //             color: Color.fromRGBO(
                                //                 255, 251, 235, 3.0),
                                //           ),
                                //           children: <TextSpan>[
                                //         const TextSpan(
                                //             text: 'ID : ',
                                //             style: TextStyle(
                                //                 fontWeight: FontWeight.bold,
                                //                 color: Color.fromRGBO(
                                //                     248, 203, 166, 1.0))),
                                //         TextSpan(
                                //           text: posts?[index].id,
                                //         ),
                                //       ])),
                                // ),
                              ],
                            ),
                            addHorizontalSpace(20),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      width: 220,
                                      child: RichText(
                                        text: TextSpan(
                                            style: const TextStyle(
                                              fontSize: 14.0,
                                              color: Color.fromRGBO(
                                                  255, 251, 235, 3.0),
                                            ),
                                            children: <TextSpan>[
                                              const TextSpan(
                                                  text: 'Date : ',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Color.fromRGBO(
                                                          248, 203, 166, 1.0))),
                                              TextSpan(text: Task?[index].date),
                                              const TextSpan(
                                                  text: '\nDeadline : ',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Color.fromRGBO(
                                                          248, 203, 166, 1.0))),
                                              TextSpan(
                                                  text: Task?[index].deadline),
                                              const TextSpan(
                                                  text: '\nTask : ',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Color.fromRGBO(
                                                          248, 203, 166, 1.0))),
                                              TextSpan(
                                                  text: Task?[index].title),
                                            ]),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            addHorizontalSpace(20),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    SizedBox(
                                      width: 70,
                                      child: RichText(
                                          text: TextSpan(
                                              style: const TextStyle(
                                                fontSize: 14.0,
                                                color: Color.fromRGBO(
                                                    255, 251, 235, 3.0),
                                              ),
                                              children: <TextSpan>[
                                            const TextSpan(
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Color.fromRGBO(
                                                        248, 203, 166, 1.0))),
                                            TextSpan(
                                                text: Task?[index].status,
                                                style: TextStyle(
                                                    color: Color.fromRGBO(
                                                        248, 203, 166, 1.0))),
                                          ])),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }
}
