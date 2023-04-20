import 'dart:io';
import 'dart:typed_data';

import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shoesclientapp/models/product_model.dart';
import 'package:shoesclientapp/services/remote/firestore_service.dart';
import 'package:shoesclientapp/ui/general/brand_color.dart';
import 'package:shoesclientapp/ui/widgets/common_button_widget.dart';
import 'package:shoesclientapp/ui/widgets/common_text.dart';
import 'package:shoesclientapp/ui/widgets/common_widget.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:shoesclientapp/utils/assets_data.dart';

class ReportAdminPage extends StatefulWidget {
  @override
  State<ReportAdminPage> createState() => _ReportAdminPageState();
}

class _ReportAdminPageState extends State<ReportAdminPage> {
  FirestoreService firestoreService = FirestoreService();
  List<ProductModel> products = [];
  @override
  void initState() {
    firestoreService.getProducts().then((value) {
      products = value;
    });
    super.initState();
  }

  exportExcel() async {
    //nos creamos un exel
    Excel myExcel = Excel.createExcel();
    //ahora nos creamos una hoja
    Sheet? sheet = myExcel.sheets[myExcel.getDefaultSheet() as String];
    //realimos la ubicaición de mis celdas
    sheet!.cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: 0)).value =
        "Producto";
    sheet.cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: 0)).value =
        "Marca";
    sheet.cell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: 0)).value =
        "Precio";
    for (var i = 0; i < products.length; i++) {
      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: i + 1))
          .value = products[i].name;
    }
    //ahora construiremos el excel con nuestro metodo "save()"
    List<int>? bytes = myExcel.save();
    //con esto mostramos nuestra ruta o ubicación dde donde se guarda
    Directory directory = await getApplicationDocumentsDirectory();
    print(directory.path);
    //ahora construiremos el excel con nuestro metodo "save()"
    // print(myExcel.save(fileName: "FlutterExcel.xlsx"));
    //genero mi archivo vacio con su extensión
    // File fileExcel = File("${directory.path}/prueba_excel.xlsx");
    //genero mi ruta
    // fileExcel.createSync(recursive: true);
    //Guardamos los datos que tenemos en nuestro byte
    // fileExcel.writeAsBytesSync(bytes!);

    //UNA FORMA DE REALIZAR MÁS CORTO
    File fileExcel = File("${directory.path}/prueba_excel.xlsx")
      ..createSync(recursive: true)
      ..writeAsBytesSync(bytes!);
    //abrumos nuestro archivo
    await OpenFilex.open(fileExcel.path);
  }

  //AQUI ESPORTAREMOS EN NUESTRO PDF
  exportPDf() async {
    ByteData byteData = await rootBundle.load(AssetsData.imageLogo);
    Uint8List bytesImage = byteData.buffer.asUint8List();
    final pdf = pw.Document();
    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        header: (context) {
          return pw.Container(
            height: 20,
            width: double.infinity,
            color: PdfColors.yellow,
          );
        },
        footer: (context) {
          return pw.Container(
            height: 20,
            width: double.infinity,
            color: PdfColors.blue,
          );
        },
        build: (pw.Context context) {
          return [
            pw.Image(
              pw.MemoryImage(bytesImage),
            ),
            pw.Text("holasdasdasdasd"),
            pw.Text("aaaaaaaaaa"),
            pw.Row(
              children: [
                pw.Text("aaaaaaaaaa"),
                pw.Text("aaaaaaaaaa"),
              ],
            ),
            pw.SizedBox(
              height: 20.0,
            ),
            pw.ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                return pw.Container(
                  margin: const pw.EdgeInsets.symmetric(vertical: 8),
                  padding: const pw.EdgeInsets.all(12.0),
                  decoration: pw.BoxDecoration(
                    border: pw.Border.all(
                      color: PdfColors.black,
                      width: 1.1,
                    ),
                  ),
                  child: pw.Row(
                    children: [
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text("Nombre del producto: "),
                          pw.Text("Precio: "),
                          pw.Text("Descuento: "),
                        ],
                      ),
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text(products[index].name),
                          pw.Text(products[index].price.toStringAsFixed(2)),
                          pw.Text(products[index].discount.toStringAsFixed(2)),
                        ],
                      ),
                    ],
                  ),
                );
              },
            )
          ];
        },
      ),
    );
    Uint8List bytes = await pdf.save();
    Directory directory = await getApplicationDocumentsDirectory();
    File pdfFile = File("${directory.path}/prueba_pdf.pdf")
      ..createSync(recursive: true)
      ..writeAsBytesSync(bytes);
    await OpenFilex.open(pdfFile.path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: BrandColor.secondaryColor,
          title: const H4(
            text: "Reportes",
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        body: Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CommonButtonWidget(
                text: "Generar Exel",
                color: BrandColor.secondaryColor,
                onPressed: () {
                  exportExcel();
                },
              ),
              spacing20,
              CommonButtonWidget(
                text: "Generar PDF",
                color: BrandColor.primaryFontColor,
                onPressed: () {
                  exportPDf();
                },
              ),
            ],
          ),
        ));
  }
}
