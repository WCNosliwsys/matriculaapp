import 'package:flutter/material.dart';
import 'package:matriculasapp/models/Person_model.dart';
import 'package:matriculasapp/models/carrera_model.dart';
import 'package:matriculasapp/models/institucion_model.dart';
import 'package:matriculasapp/models/matricula_model.dart';

class MatriculasHome extends StatefulWidget {
  @override
  State<MatriculasHome> createState() => _MatriculasHomeState();
}

class _MatriculasHomeState extends State<MatriculasHome> {
  List<Person> peopleList = [
    Person(name: "Ana", address: "av 1245", phone: "12345679"),
    Person(name: "Lia", address: "av lima", phone: "9751665"),
    Person(name: "Maria", address: "av mlsis", phone: "88888888"),
  ];

  List<Carrera> carrerasList = [
    Carrera(nombre: "Contabilidad", duracion: "5 años"),
    Carrera(nombre: "Diseño", duracion: "5 años"),
  ];

  List<Matricula> matriculasList = [];

  List<Institucion> institucioneslist = [];

  TextEditingController _instituteController = TextEditingController();
  TextEditingController _nombreController = TextEditingController();
  TextEditingController _direccionController = TextEditingController();
  TextEditingController _celularController = TextEditingController();
  showDialogInstitute() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Ingrese el Instituto"),
          backgroundColor: Colors.white,
          content: miTextField(
              _instituteController, "Nombre del Instituto", Icons.add),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                "Cancelar",
              ),
            ),
            TextButton(
              onPressed: () {
                print("presiono aceptar");
                institucioneslist.add(
                  Institucion(
                    nombre: _instituteController.text,
                    direccion: "AV LIMA 123123",
                    ruc: "12345678",
                    telefono: "98765431",
                    matriculas: [],
                  ),
                );
                _instituteController.text = "";
                setState(() {});
                Navigator.pop(context);
              },
              child: Text(
                "Aceptar",
              ),
            ),
          ],
        );
      },
    );
  }

  showDialogMatricula(institucionElement) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Ingrese Datos de la Persona"),
          backgroundColor: Colors.white,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              miTextField(_nombreController, "Nombre", Icons.person),
              miTextField(_direccionController, "Direccion", Icons.house),
              miTextField(_celularController, "Celular", Icons.phone,
                  inputType: TextInputType.number),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                // Navigator.pop(context);
                // Navigator.pop(context);
              },
              child: Text(
                "Cancelar",
              ),
            ),
            TextButton(
              onPressed: () {
                print("presiono aceptar");
                institucionElement.matriculas.add(
                  Matricula(
                    fecha: "14/01/2024",
                    hora: "11:05",
                    alumno: Person(
                        name: _nombreController.text,
                        address: _direccionController.text,
                        phone: _celularController.text),
                    carrera: carrerasList[1],
                  ),
                );
                _nombreController.text = "";
                _direccionController.text = "";
                _celularController.text = "";
                setState(() {});
                Navigator.pop(context);
              },
              child: Text(
                "Aceptar",
              ),
            ),
          ],
        );
      },
    );
  }

  TextField miTextField(controller, hint, icon, {TextInputType? inputType}) {
    return TextField(
      controller: controller,
      keyboardType: inputType ?? TextInputType.text,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(fontSize: 12),
        prefixIcon: Icon(
          icon,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(
            color: Colors.deepPurpleAccent,
            width: 3.0,
          ),
        ),
        enabledBorder: UnderlineInputBorder(
          // borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(
            color: Colors.redAccent,
            width: 3.0,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Matriculas App"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              //AGREGAR INSTITUCIONES
              showDialogInstitute();
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          // ElevatedButton(
          //   onPressed: () {
          //     //AGREGANDO PERSONAS
          //     // peopleList.add(
          //     //   Person(
          //     //       name: "Pedro",
          //     //       address: "av Larc0 789",
          //     //       phone: "1938771",
          //     //       dni: "12345678"),
          //     // );

          //     //AGREGANDO MATRÍCULAS
          //     // matriculasList.add(
          //     //   Matricula(
          //     //     fecha: "14/01/2024",
          //     //     hora: "11:05",
          //     //     alumno: Person(
          //     //         name: "ANAIA",
          //     //         address: "Avv cusco 123456",
          //     //         phone: "987654321"),
          //     //     carrera: carrerasList[1],
          //     //   ),
          //     // );
          //     setState(() {});
          //   },
          //   child: Text("Agregar"),
          // ),

          ...institucioneslist.map(
            (institucionElement) => Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "${institucionElement.nombre}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        print("agregando-............");
                        showDialogMatricula(institucionElement);
                        /* institucionElement.matriculas.add(
                          Matricula(
                            fecha: "14/01/2024",
                            hora: "11:05",
                            alumno: Person(
                                name: "ANIA",
                                address: "Avv cusco 123456",
                                phone: "987654321"),
                            carrera: carrerasList[1],
                          ),
                        );
                        setState(() {}); */
                      },
                      icon: Icon(Icons.add),
                    ),
                    IconButton(
                      onPressed: () {
                        print("eliminandooo INSTITUCIÓN............");
                        institucioneslist.remove(institucionElement);
                        setState(() {});
                      },
                      icon: Icon(Icons.delete),
                    ),
                    IconButton(
                      onPressed: () {
                        print("eliminandooo MATRICULAS............");
                        institucionElement.matriculas.removeRange(
                            0, institucionElement.matriculas.length);
                        setState(() {});
                      },
                      icon: Icon(Icons.clear),
                    ),
                  ],
                ),
                ...institucionElement.matriculas.map(
                  (e) => ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.cyan,
                      // radius: 25,
                      child: Text(
                        e.alumno.name[0],
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                    title: Text("${e.alumno.name} - ${e.carrera.nombre}"),
                    subtitle: Text("${e.alumno.address} - ${e.alumno.phone}"),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {
                            print("Editando....");
                            e.alumno = Person(
                                name: "ANITA",
                                address: "CCALLE 456",
                                phone: "9876543");
                            setState(() {});
                          },
                          icon: Icon(
                            Icons.edit,
                            color: Colors.blue,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            print("Eliminando....");
                            // matriculasList.removeLast();
                            // matriculasList.removeRange(0, 2);
                            // matriculasList.removeAt(1);
                            institucionElement.matriculas.remove(e);
                            setState(() {});
                          },
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
