// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'package:printing/printing.dart';
// import 'package:flutter_pdfview/flutter_pdfview.dart';

// void main() {
//   runApp(ReportGeneratorApp());
// }

// class Report {
//   final String title;
//   final List<String> content;
//   String? pdfPath;

//   Report({
//     required this.title,
//     required this.content,
//     this.pdfPath,
//   });
// }

// class ReportGeneratorApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Report Generator',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       home: ReportListScreen(),
//     );
//   }
// }

// class ReportListScreen extends StatefulWidget {
//   @override
//   _ReportListScreenState createState() => _ReportListScreenState();
// }

// class _ReportListScreenState extends State<ReportListScreen> {
//   List<Report> reports = [
//     Report(
//       title: 'Sales Report',
//       content: [
//         'Total Sales: 50,000',
//         'Top Product: Widgets',
//         'Sales Growth: 15%',
//       ],
//     ),
//     Report(
//       title: 'Customer Feedback',
//       content: [
//         'Total Responses: 250',
//         'Satisfaction Rate: 92%',
//         'Key Insights: Positive feedback on customer service',
//       ],
//     ),
//   ];

//   // Generate PDF for a report
//   Future<void> generatePDF(Report report) async {
//     final pdf = pw.Document();

//     pdf.addPage(
//       pw.Page(
//         build: (pw.Context context) => pw.Column(
//           crossAxisAlignment: pw.CrossAxisAlignment.start,
//           children: [
//             pw.Text(
//               report.title,
//               style: pw.TextStyle(
//                 fontSize: 24,
//                 fontWeight: pw.FontWeight.bold
//               )
//             ),
//             pw.SizedBox(height: 20),
//             pw.Column(
//               crossAxisAlignment: pw.CrossAxisAlignment.start,
//               children: report.content.map((item) =>
//                 pw.Text(item, style: pw.TextStyle(fontSize: 16))
//               ).toList(),
//             ),
//           ],
//         ),
//       ),
//     );

//     // Save PDF
//     final output = await getTemporaryDirectory();
//     final file = File('${output.path}/${report.title.replaceAll(' ', '_')}.pdf');
//     await file.writeAsBytes(await pdf.save());

//     // Update report with PDF path
//     setState(() {
//       report.pdfPath = file.path;
//     });

//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text('PDF Generated: ${report.title}')),
//     );
//   }

//   // View PDF
//   void viewPDF(Report report) {
//     if (report.pdfPath == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Generate PDF first')),
//       );
//       return;
//     }

//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => PDFViewerPage(pdfPath: report.pdfPath!),
//       ),
//     );
//   }

//   // Download PDF
//   Future<void> downloadPDF(Report report) async {
//     if (report.pdfPath == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Generate PDF first')),
//       );
//       return;
//     }

//     try {
//       final result = await FilePicker.platform.getDirectoryPath();
//       if (result != null) {
//         final originalFile = File(report.pdfPath!);
//         final newFile = await originalFile.copy('$result/${report.title.replaceAll(' ', '_')}.pdf');

//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('PDF Downloaded: ${newFile.path}')),
//         );
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Download failed: $e')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Report Generator'),
//         centerTitle: true,
//         actions: [
//           IconButton(
//             icon: Icon(Icons.add),
//             onPressed: () {
//               // TODO: Add functionality to create new reports
//             },
//           ),
//         ],
//       ),
//       body: ListView.builder(
//         itemCount: reports.length,
//         itemBuilder: (context, index) {
//           final report = reports[index];
//           return Card(
//             margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//             child: ListTile(
//               title: Text(
//                 report.title,
//                 style: TextStyle(fontWeight: FontWeight.bold),
//               ),
//               subtitle: Text('${report.content.length} items'),
//               trailing: Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   IconButton(
//                     icon: Icon(Icons.print, color: Colors.blue),
//                     onPressed: () => generatePDF(report),
//                     tooltip: 'Generate PDF',
//                   ),
//                   IconButton(
//                     icon: Icon(Icons.preview, color: Colors.green),
//                     onPressed: () => viewPDF(report),
//                     tooltip: 'View PDF',
//                   ),
//                   IconButton(
//                     icon: Icon(Icons.download, color: Colors.red),
//                     onPressed: () => downloadPDF(report),
//                     tooltip: 'Download PDF',
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

// class PDFViewerPage extends StatelessWidget {
//   final String pdfPath;

//   const PDFViewerPage({Key? key, required this.pdfPath}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('PDF Viewer'),
//       ),
//       body: PDFView(
//         filePath: pdfPath, // Pass the file path here
//       ),
//     );
//   }
// }

import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:for_test/test.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

void main() {
  runApp(ReportGeneratorApp());
}

class ReportItem {
  final String id;
  final String status;
  final String name;

  ReportItem({
    required this.id,
    required this.status,
    required this.name,
  });
}

class ReportGeneratorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Report Generator',
      theme: ThemeData(primarySwatch: Colors.orange),
      home: LoginScreen(),
    );
  }
}

class PDFReportScreen extends StatelessWidget {
  final String reportTitle = "تقرير حالة البيانات";

  List<ReportItem> _generateDummyData() {
    return List.generate(50, (index) {
      String status;
      switch (index % 4) {
        case 0:
          status = "مكتمل";
          break;
        case 1:
          status = "قيد التنفيذ";
          break;
        case 2:
          status = "معلق";
          break;
        default:
          status = "ملغي";
      }
      return ReportItem(
        id: index.toString().padLeft(3, '0'),
        status: status,
        name: "اسم ${index + 1}",
      );
    });
  }

  Future<Uint8List> _generatePDF() async {
    final pdf = pw.Document();
    final data = _generateDummyData();
    final font = await PdfGoogleFonts.cairoRegular();
    final boldFont = await PdfGoogleFonts.cairoBold();
    final date = DateTime.now();
    final formattedDate = '${date.year}/${date.month}/${date.day}';
    const itemsPerPage = 15;
    final totalPages = (data.length / itemsPerPage).ceil();

    for (int pageNum = 0; pageNum < totalPages; pageNum++) {
      final start = pageNum * itemsPerPage;
      final end = (start + itemsPerPage) > data.length
          ? data.length
          : start + itemsPerPage;
      final pageData = data.sublist(start, end);

      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          theme: pw.ThemeData.withFont(base: font, bold: boldFont),
          build: (context) {
            return pw.Directionality(
              textDirection: pw.TextDirection.rtl,
              child: pw.Padding(
                padding: pw.EdgeInsets.all(20),
                child: pw.Column(
                  children: [
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.end,
                          children: [
                            pw.Text(
                              reportTitle,
                              style: pw.TextStyle(
                                  fontSize: 24, fontWeight: pw.FontWeight.bold),
                            ),
                            pw.Text('تاريخ التقرير: $formattedDate'),
                          ],
                        ),
                      ],
                    ),
                    pw.SizedBox(height: 20),
                    pw.Table.fromTextArray(
                      headers: ['#', 'رقم المعرف', 'الحالة', 'الاسم'],
                      data: pageData.map((item) {
                        return [
                          (data.indexOf(item) + 1).toString(),
                          item.id,
                          item.status,
                          item.name,
                        ];
                      }).toList(),
                      border: pw.TableBorder.all(),
                      cellAlignment: pw.Alignment.center,
                      headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                      cellStyle: pw.TextStyle(fontSize: 12),
                    ),
                    pw.Spacer(),
                    pw.Text(
                      'صفحة ${context.pageNumber} من $totalPages',
                      style: pw.TextStyle(fontSize: 10),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );
    }

    return pdf.save();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(reportTitle),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              onPressed: () async {
                try {
                  final pdfBytes = await _generatePDF();
                  await Printing.sharePdf(
                      bytes: pdfBytes, filename: 'report.pdf');
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('تم إنشاء التقرير بنجاح')),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('حدث خطأ أثناء إنشاء التقرير: $e')),
                  );
                }
              },
              icon: Icon(Icons.save_alt),
              label: Text('حفظ التقرير'),
            ),
            SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () async {
                try {
                  final pdfBytes = await _generatePDF();
                  await Printing.layoutPdf(onLayout: (_) => pdfBytes);
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('حدث خطأ أثناء الطباعة: $e')),
                  );
                }
              },
              icon: Icon(Icons.print),
              label: Text('طباعة التقرير'),
            ),
          ],
        ),
      ),
    );
  }
}
