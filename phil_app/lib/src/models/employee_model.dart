import 'dart:convert';
import 'dart:ffi';

List<Employee> employeeFromJson(String str) =>
    List<Employee>.from(json.decode(str).map((x) => Employee.fromJson(x)));

String employeeToJson(List<Employee> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Employee {
  int? id;
  String? namePS;
  String? name;
  String? life;
  String? img;

  Employee({
    this.namePS,
    this.id,
    this.name,
    this.life,
    this.img,
  });

  factory Employee.fromJson(Map<String, dynamic> json) => Employee(
        name: json["name"],
        id: json["id"],
        life: json["life"],
        //books: json["books"],
        img: json["img"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "life": life,
        "img": img,
      };
}
