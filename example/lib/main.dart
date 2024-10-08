import 'dart:io';
import 'package:flutter/material.dart';
import 'package:red_clan_network/red_clan_network.dart';
import 'package:http/http.dart' as http;

// Define your model to represent Todo data
class TodoModel {
  int? userId;
  int? id;
  String? title;
  bool? completed;

  // Constructor
  TodoModel({this.userId, this.id, this.title, this.completed});

  // Method to create a TodoModel from JSON data
  TodoModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    id = json['id'];
    title = json['title'];
    completed = json['completed'];
  }

  // Method to convert TodoModel to JSON format
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
  runApp(MyApp()); // Run the MyApp widget
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'API Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(), // Set MyHomePage as the home screen
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ApiService apiService = ApiService(); // Create an instance of ApiService
  List<TodoModel> dataList = []; // List to hold fetched data
  String message = 'Press button any of above'; // Initial message

  @override
  void initState() {
    super.initState();
    fetchData(); // Fetch data when the widget is initialized
  }

  // Fetch data from the API
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
        dataList = response.response as List<TodoModel>; // Update the dataList with fetched data
      } else {
        message = 'Something went wrong with ${response.code}'; // Update message if there was an error
      }
    });
  }

  // Post data to the API
  Future<void> postData() async {
    var bodyData = {
      "email": "codered@youtube.com",
      "secure_pin": "this is my pin"
    };
    var response = await apiService.request(
      url: 'https://api.yoursurl.com/login',
      method: 'POST',
      successStatusCodes: [200, 201], 
      headers: {
        'Content-Type': 'application/json',
      },
      body: bodyData,
    );

    setState(() {
      if (response.isSuccess) {
        message = 'Data Post Success'; // Update message on success
      } else {
        message = 'Something went wrong with ${response.code}'; // Update message on error
      }
    });
  }

  // Put data to the API
  Future<void> putData() async {
    var bodyData = {
      "name": "CompanyX",
      "metric_limit": 50,
      "allow_negative_credits": false
    };
    var response = await apiService.request(
      url: 'https://dummy.restapiexample.com/api/v1/update/21',
      method: 'PUT',
      successStatusCodes: [200, 201], 
      headers: {
        'Authorization': ' ',
        'Content-Type': 'application/json'
      },
      body: bodyData,
    );

    setState(() {
      dataList = []; // Clear dataList on update
      if (response.isSuccess) {
        message = 'Data Put Success'; // Update message on success
      } else {
        message = 'Something went wrong with ${response.code}'; // Update message on error
      }
    });
  }

  // Delete data from the API
  Future<void> delete() async {
    var bodyData = {
      "email": "coderedclan@youtube.com",
      "secure_pin": "this is my pin"
    };
    var response = await apiService.request(
      url: 'https://dummy.restapiexample.com/api/v1/delete/3',
      method: 'DELETE',
      successStatusCodes: [200, 201], 
      headers: {
        'Content-Type': 'application/json',
        'Authorization': ""
      },
      body: bodyData,
    );

    setState(() {
      dataList = []; // Clear dataList on delete
      if (response.isSuccess) {
        message = 'Delete Success'; // Update message on success
      } else {
        message = 'Something went wrong with ${response.code}'; // Update message on error
      }
    });
  }

  // Patch data to the API
  Future<void> patchData() async {
    var bodyData = {
      "name": "CompanyX",
      "metric_limit": 50,
      "allow_negative_credits": false
    };
    var response = await apiService.request(
      url: 'https://your_patch_api_link',
      method: 'PATCH',
      successStatusCodes: [200, 201], 
      headers: {
        'Authorization': ' ',
        'Content-Type': 'application/json'
      },
      body: bodyData,
    );

    setState(() {
      dataList = []; // Clear dataList on patch
      if (response.isSuccess) {
        message = 'Patch Success'; // Update message on success
      } else {
        message = 'Something went wrong with ${response.code}'; // Update message on error
      }
    });
  }

  // Post data with a file to the API
  Future<void> postDataWithFile() async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('https://your_file_upload_api_link'),
    );

    request.headers.addAll({
      'Content-Type': 'multipart/form-data',
      'Authorization': 'Bearer your_token_here',
    });

    request.fields['description'] = 'File upload example';

    // Replace 'path_to_your_file' with the actual path to your file
    var file = await http.MultipartFile.fromPath('file', 'path_to_your_file');
    request.files.add(file);

    var response = await request.send();

    final responseBody = await response.stream.bytesToString();

    setState(() {
      if (response.statusCode == 200 || response.statusCode == 201) {
        message = 'File Upload Success'; // Update message on success
      } else {
        message = 'Something went wrong with ${response.statusCode}'; // Update message on error
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('API Example'), // App bar title
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () async {
                await postData(); // Call postData when button is pressed
              },
              child: Text("Post Data"),
            ),
            ElevatedButton(
              onPressed: () async {
                await delete(); // Call delete when button is pressed
              },
              child: Text("Delete"),
            ),
            ElevatedButton(
              onPressed: () async {
                await putData(); // Call putData when button is pressed
              },
              child: Text("Put Data"),
            ),
            ElevatedButton(
              onPressed: () async {
                await patchData(); // Call patchData when button is pressed
              },
              child: Text("Patch Data"),
            ),
            ElevatedButton(
              onPressed: () async {
                await fetchData(); // Call fetchData when button is pressed
              },
              child: Text("Fetch Data"),
            ),
            ElevatedButton(
              onPressed: () async {
                await postDataWithFile(); // Call postDataWithFile when button is pressed
              },
              child: Text("Post Data with File"),
            ),
            Divider(),
            Text(message), // Display message based on API response
            Divider(),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: dataList.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(dataList[index].title.toString()), // Display title of each Todo item
                        subtitle: dataList[index].completed != true
                            ? Container(
                                width: 10,
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text("Completed"),
                                ),
                              )
                            : Container(
                                width: 10,
                                decoration: BoxDecoration(
                                  color: Colors.amber,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text("Pending"),
                                ),
                              ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
