import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todolist_googlemaps/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.android);
  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  
   MyApp({super.key});
   FirebaseFirestore DB =FirebaseFirestore.instance;
  Future<void> _addData(String task) async{
        
    Timestamp _date = Timestamp.fromDate(DateTime.now());
    CollectionReference tasks = DB.collection('task');
    print(task);

    return tasks.add({'task':task,'date':_date,'number':10})
    .then((value) => print('New Task added'))
    .catchError((error)=> print(error));
  }

  Future<void> _updateData(String id) async{
    CollectionReference tasks = DB.collection('task');

    return tasks.doc(id).set(
      {
       'name':'John',
       'age':30,
       'address':'street 123',
      },SetOptions(merge: true)).then((value) =>print('data has been set')).catchError((error)=> print('Failed to set data'));
      }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo List App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter To Do App'),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('task').snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError){
              return const Center(
                child: Text("Something Wrong"),
              );  
            }
          if (snapshot.connectionState == ConnectionState.active){
            
            return ListView(
              children: snapshot.data!.docs.map((document){ Map<String, dynamic>data = document.data()! as Map<String, dynamic>;
              return GestureDetector(
                onTap: (){_updateData(document.id);
                },
                child: Card(
                  elevation: 5,
                  child: ListTile(
                    title: Text(data['task']),
                    subtitle: Text(data['number'].toString()),
                  ),
                ),
              );
              
              }).toList(),
              
            );      
              }
              return Center(
                child: Text("Loading........."),
              );
          } ,
        ),
        floatingActionButton: FloatingActionButton(onPressed: (){
          _addData('create CRUD operation');
        },
        child: const Icon(Icons.add),
        
        ),
      ),
    );
  }
}


