# Red Clan Network
# About
`red_clan_network` is a Dart package designed to simplify API requests by abstracting common functionalities like GET, POST, PUT, PATCH, and DELETE methods. It provides a flexible and customizable way to handle different types of HTTP requests and parse responses into Dart models.
## Features

- **API Type**: Just provide API type(GET, POST, PATCH, PUT, DELETE).
- **Flexible Data Handling**: If you also need something in return you can provide model or function will return response.statusCode and resonponse.body automatically.
- **Simplified Code**: Get auto mapped models in simpliest form of `success` or `failure`.


### Red_Clan_Networ Example

```dart
Create Model
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
// Then add this use this function of package
Make an instance of api before use
  final ApiService apiService = ApiService();
  
//
List<TodoModel> dataList = [];
String message = 'Press button any of above';
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
  // you can call any API of get using this function
```
### Post Example

```dart
Future<void> postData() async {
  var bodyData = {
    "email": "codered@youtube.com",
    "secure_pin": "Asd@01814"
  };
  var response = await apiService.request(
    url: 'https://api.yoururl.com//login', // Adjusted URL
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
```
### Delete Example

```dart
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

```

### Put Example

```dart
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

```

### Patch Example

```dart
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
```

[![Learn More](https://github.com/RanaSharjeelShji/equal_space/blob/main/example/asset/banner.jpg?raw=true)](https://www.youtube.com/channel/UCnM_HfTRzP_XRdyYmfvTsGQ)
### Contributors


[![Learn More](https://yt3.googleusercontent.com/9A0wEzTcikgC4mV4t0wfGrEQUWuKqcPI_thgqBGkRlDpRSbMHwAnKoAl0HmEoVoikNs7CgCGpg=s176-c-k-c0x00ffffff-no-rj)](https://www.youtube.com/channel/UCnM_HfTRzP_XRdyYmfvTsGQ)
[![Learn More](https://github.com/RanaSharjeelShji/equal_space/blob/main/example/asset/image%20(4).png?raw=true)](https://github.com/RanaSharjeelShji)
- **Rana Sharjeel Ali Flutter Developer**
[![Learn More](https://avatars.githubusercontent.com/u/55307690?v=4)](https://github.com/MohammadAbuzar945)
- **Muhammad Abuzar Backend Developer**
