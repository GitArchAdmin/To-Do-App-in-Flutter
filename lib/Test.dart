import 'dart:convert';
import 'dart:io';

Map base = {
  "a":[0,1,0,0,0],
  "b":[1,1,1,1,1],
};
Map sql = {
  "a":[0,1,0,0,0],
  "b":[1,1,1,1,1],
};

void main(){

  saveToFile();
  readFromFile();
  print(sql);

}


void saveToFile() async{
  File file = File("data.txt");
  String data = jsonEncode(sql);
  await file.writeAsString(data);
}

void readFromFile() async{
  File file = File("data.txt");
  var data = await file.readAsString();
  sql = jsonDecode(data);
  print(data);
}