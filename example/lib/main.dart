import 'package:flutter/material.dart';
import 'package:red_clan_network/red_clan_network.dart';

// Define your model
class TodoModel {
  int? userId;
  int? id;
  String? title;
  bool? completed;

  TodoModel({this.userId, this.id, this.title, this.completed});

  TodoModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    id = json['id'];
    title = json['title'];
    completed = json['completed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['id'] = this.id;
    data['title'] = this.title;
    data['completed'] = this.completed;
    return data;
  }
}


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'API Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ApiService apiService = ApiService();
  List<TodoModel> dataList = [];
  String message = 'Press button any of above';

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    var response = await apiService.request<TodoModel>(
      url: 'https://jsonplaceholder.typicode.com/todos', 
      method: 'GET',
      modelFromJson: (json) => TodoModel.fromJson(json),
      successStatusCodes: [200, 201], 
    );

    setState(() {
      if (response.isSuccess) {
        message = 'Data Fetched Success';
      } else {
        message = 'Some thing went wrong with ${response.code}';
      }
    });
  }
// call for post API

Future<void> postData() async {
  var bodyData = {
    "email": "codered@youtube.com",
    "secure_pin": "Asd@01814"
  };
  var response = await apiService.request(
    url: 'https://api.yoursurl.com//login', // Adjusted URL
    method: 'POST',
    successStatusCodes: [200, 201], 
    headers: {
      'Content-Type': 'application/json',
    },
    body: bodyData,
  );

  setState(() {
    if (response.isSuccess) {
     
      message = 'Data post Success';
    } else {
      message = 'Something went wrong with ${response.code}';
    }
  });
}

//  put api
Future<void> putData()async{
var bodyData = {
  "name": "CompanyX",
  "metric_limit": 50,
  "allow_negative_credits": false
};
  var response = await apiService.request(
    url: 'https://dummy.restapiexample.com/api/v1/update/21', // Adjusted URL
    method: 'PUT',
    successStatusCodes: [200, 201], 
    headers:{
  'Authorization': ' ',
  'Content-Type': 'application/json'
},
    body: bodyData,
  );

  setState(() {
    dataList = [];
    if (response.isSuccess) {
      message = 'Data Put Success';
    } else {
      message = 'Something went wrong with ${response.code}';
    }
  });
  
}

// delete api calling
Future<void> delete() async {
  var bodyData = {
    "email": "coderedclan@youtube.com",
    "secure_pin": "Asd@01814"
  };
  var response = await apiService.request(
    url: 'https://dummy.restapiexample.com/api/v1/delete/3', // Adjusted URL
    method: 'DELETE',
    successStatusCodes: [200, 201], 
    headers: {
      'Content-Type': 'application/json',
      'Authorization':""
    },
    body: bodyData,
  );

  setState(() {
    dataList = [];
    if (response.isSuccess) {
      message = 'Delete Success';
    } else {
      message = 'Something went wrong with ${response.code}';
    }
  });
}

//patch
Future<void> patchData()async{
var bodyData = {
  "name": "CompanyX",
  "metric_limit": 50,
  "allow_negative_credits": false
};
  var response = await apiService.request(
    url: 'https://your_patch_api_link', // Adjusted URL
    method: 'PATCH',
    successStatusCodes: [200, 201], 
    headers:{
  'Authorization': ' ',
  'Content-Type': 'application/json'
},
    body: bodyData,
  );

  setState(() {
    dataList = [];
    if (response.isSuccess) {
      message = 'Patch Success';
    } else {
      message = 'Something went wrong with ${response.code}';
    }
  });
  
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('API Example'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ElevatedButton(onPressed: ()async{
              await postData();
            }, child:Text("Post Data")),
            ElevatedButton(onPressed: ()async{
              await delete();
            }, child:Text(" delete")),
            ElevatedButton(onPressed: ()async{
              await putData();
            }, child: Text("Put Data")),
            ElevatedButton(onPressed: ()async{
              await patchData();
            }, child: Text("Patch Data")),
             ElevatedButton(onPressed: ()async{
              await fetchData();
            }, child: Text("Fetch Data")),
            Divider(),
            Text(message, ),
            Divider(),
            Center(
              child:Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: dataList.length,
                          itemBuilder: (context, index){
                            return ListTile(
                              title: Text(dataList[index].title.toString()),
                              subtitle: dataList[index].completed !=true?
                              Container(
                                width: 10,
                                decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(12)
                              ),
                              child: const Padding(padding: EdgeInsets.all(8.0),
                                child: Text("Completed"),
                              ),)
                              :Container(
                                width: 10,
                                decoration: BoxDecoration(
                                color: Colors.amber,
                                borderRadius: BorderRadius.circular(12)
                              ),
                              child: const Padding(padding: EdgeInsets.all(8.0),
                                child: Text("Pending"),
                              ),) ,
                            );
                          })
                      ],
                    )
            ),
          ],
        ),
      ),
    );
  }
}
