import '../request_client.dart';

class Add {
  final int value1;
  final int value2;

  Add({this.value1 = 10, this.value2 = 20});

  int addValue(){
    int result = value1 + value2;
    return result;
  }

  int subValue(val, val2){
    int result = val - val2;
    return result;
  }

  Future callApi() async{
    final authHeader = <String, String>{
      'Accept': "application/json",
      'Content-Type': 'application/json'
    };

    await RequestClient().get('https://reqres.in/api/users', authHeader).then((value) {
      print(value.statusCode);
      print(value.body);
    });
  }
}