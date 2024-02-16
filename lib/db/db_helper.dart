import 'package:cloud_firestore/cloud_firestore.dart';
 
class Dbhelper{


  
  FirebaseFirestore DB=FirebaseFirestore.instance;
  

 Future<void> _addData(Map<String, dynamic> data) async{
  
        
    Timestamp _date = Timestamp.fromDate(DateTime.now());
    CollectionReference tasks = DB.collection('task');
  

    return tasks.add({
      'task':data['task'],
    'date':data['date'],
    'desc':data['desc']})
    .then((value) => print('New Task added'))
    .catchError((error)=> print(error));
  }

  Future<void> _updateData(Map<String, dynamic> data,String id) async{
    CollectionReference tasks = DB.collection('task');

    return tasks.doc(id).update(
      {
       'task':data['task'],
    'date':data['date'],
    'desc':data['desc'],
      }).then((value) => print("Update Done"));
      }

  Future<void> _DeleteData(String Id) async
  {
    CollectionReference task =DB.collection('task');

    return task.doc(Id).delete();
  }    

}