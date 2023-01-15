import 'package:phil_app/src/models/employee_model.dart';
import 'package:phil_app/src/providers/db_provider.dart';
import 'package:dio/dio.dart';

class EmployeeApiProvider {
  Future<List<Employee?>> getAllEmployees() async {
    var url = "https://63974b5777359127a0332fac.mockapi.io/Entidad";
    Response response = await Dio().get(url);

    return (response.data as List).map((employee) {
      // ignore: avoid_print
      print('Inserting $employee');
      DBProvider.db.createEmployee(Employee.fromJson(employee));
    }).toList();
  }
}
