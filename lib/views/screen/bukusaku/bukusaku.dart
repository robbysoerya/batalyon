import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';

class BukuSaku extends StatefulWidget {
  static const id = 'bukusaku';
  @override
  _BukuSakuState createState() => _BukuSakuState();
}

class _BukuSakuState extends State<BukuSaku> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
            child: Html(style: {
          "td": Style(
              alignment: Alignment.center,
              textAlign: TextAlign.center,
              border: Border.all()),
          "th": Style(
              alignment: Alignment.center,
              textAlign: TextAlign.center,
              border: Border.all())
        }, data: '''
<h4 style="text-align: center">DATA TES KESEGARAN JASMANI</h4>
<h4 style="text-align: center">SEMESTER 1</h4>
<table style="width: 100%">
  <tr>
    <th rowspan="2">NO</th>
    <th rowspan="2">HARI / TGL</th>
    <th colspan="2">LARI 12 M</th>
    <th colspan="2">PULL UP</th>
    <th colspan="2">SIT UP</th>
    <th colspan="2">PUSH UP</th>
  </tr>
  <tr>
    <th>WKT</th>
    <th>NILAI</th>
    <th>JML</th>
    <th>NILAI</th>
    <th>JML</th>
    <th>NILAI</th>
    <th>JML</th>
    <th>NILAI</th>
  </tr>
  <tr>
    <td>1</td>
    <td>SENIN / 15 Januari 2020</td>
    <td>20 m</td>
    <td>80.0</td>
    <td>20</td>
    <td>80.0</td>
    <td>20</td>
    <td>80.0</td>
    <td>20</td>
    <td>80.0</td>
  </tr>
  <tr>
    <td>2</td>
    <td>SENIN / 15 Januari 2020</td>
    <td>20 m</td>
    <td>80.0</td>
    <td>20</td>
    <td>80.0</td>
    <td>20</td>
    <td>80.0</td>
    <td>20</td>
    <td>80.0</td>
  </tr>
</table>
<br />
<table style="width: 100%">
  <tr>
    <th colspan="2">SHUTTLE RUN</th>
    <th colspan="2">LUNGES</th>
    <th colspan="2">NILAI</th>
    <th colspan="2" rowspan="2">TOTAL</th>
  </tr>
  <tr>
    <th>WKT</th>
    <th>NILAI</th>
    <th>JML</th>
    <th>NILAI</th>
    <th>A</th>
    <th>B</th>
  </tr>
  <tr>
    <td>20 m</td>
    <td>80.0</td>
    <td>20</td>
    <td>80.0</td>
    <td>20</td>
    <td>80.0</td>
    <td>20</td>
    <td>80.0</td>
  </tr>
  <tr>
    <td>20 m</td>
    <td>80.0</td>
    <td>20</td>
    <td>80.0</td>
    <td>20</td>
    <td>80.0</td>
    <td>20</td>
    <td>80.0</td>
  </tr>
</table>
''')),
      ),
    );
  }
}
