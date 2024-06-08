// ignore_for_file: avoid_print
import 'package:app/services/data.dart';
import 'package:gsheets/gsheets.dart';

class DataSheetsApi {
  static const _credentials = r'''
{
  "type": "service_account",
  "project_id": "upbusiness-425717",
  "private_key_id": "23f8e7c8263859b2acb7b5ef521073fb2c071b2a",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDVJETSzbSqmDNi\nQ22WBi1yx/x1uVdHx+ETgJtXdAYwux7j5IqcDLNwwJA9mZbIumY0FiDAiRKtZMuX\niOof4/Q5aaio55kTllCnLYOnSHJotZlmxByCF+AwKp8951BuCqDjm4uDGgX2SN8L\nSIxaYooEPdYwTENb4/rv856Jmnn7Rr5vl+IEgxgc9+EqDUVPUWyjI4K89etfQPi4\nd9Vq38RqiSqNqTGaGVOHJbhA2lE5F/i6MmuTuiedxr2NY3ndC5JYYGi+XBsyUhPn\nSA8wtK+fhdIWbBZ0qTlac+rNk2D6rSRKxruBdo4wNtRLPNCXRdWN8d6SyrydWHo3\ngLzyqXRVAgMBAAECggEADuuQCcsD56E/Oj9gGiK/5wtgJ9mGkOwesbUiAALg4A5p\nQNNhxJS7BvHj5vwBFcy+lMzWaW6ZqRuniNRjwexneea55hZNnT+7e53FsTMdbH5c\niQNsv3VDvftt1EaErH9VTeQ4kD/ab6ggPPOiJ5LtoxMKaFfJAKi6izYxleOuFaHN\nq9sRKXWYH6o6hlq9GI+QrU7wl7eBToCKB8ptqY1d379qfWIfKFfwhGOrS+dh/G3d\nfWARBnguxxunGM1TS769BLHDR+4jtpcAbB0pZba2wNBT2vHOUdG4VqaNUybiqHp/\nm+PPrxGxdJ+l5nrQmGr1Ay3Qk9WouHUDL+HUfIiZTQKBgQD8U0t3lZ5Toox2ipHH\na5pm49yhtba6B2BMwniOLrflm9D86bH/D8UeDx2Chbf6+A/vW6UqYBY6qsLZaBzA\nqTBF+qlz2WQkIswAa2S/SlpjGD7+eslcAi0XhEnbAU7DMt4FEZHSFWoI/DNW/GZw\nke8cE3J/5S1gWd3pTRYNes7cNwKBgQDYPuRAXdAzLKsFGwgMx/tURHD6Sdmh1tqY\nyK3bVYG5gcVtYJjrA4GjqLfRKa1AmEbH60V9Zone9skjmqQckCHdErqyW82OmKBD\n244vlDTPsGEldDinKSP5o3vZkzoUlK+WzbpDwNP2vfywi6PaBxy48zmc0uCIi41o\n5KGJX1ol0wKBgQCGyfQZeIpwQPfp5xICxn9fkT9t/wUSkRgnSQdfZKOF+1uDj08v\nYnw5F3f7HnVuko7onTs4zMVzJ38Y5h3d6UNJTqKwqSNujkwNuVDDQvPP1cbo6Cyi\nguMVmexeGm+5pHWnnYAZCqlvDVJbmE8cuUhS5iyXF5TK0JbTpwMtxjm0twKBgA+1\nme1XI13kW9Q2H4KWMJrxkeeM3+OS8TRyN7ccYh0w4T/N6a4BBjT2d8wZI/3yUgoJ\n/HVcsp1g/kG45T0x91PRHYEBjFBUpCfp1k18jc2cuaH37HmwUm27Q68NtAV0u8DP\n1z0+z+c37BiDPHcFVz/UY5YR97/Tq4U4Psf1Bl6DAoGAcTUZdrBCib59KmRajEzg\n57JeH7HtN49o+Wi2N+A63UnC/e6ICTn0g124H2KUF1bMzSWYRT+6XpV+cTaQbvJQ\nWkQDOP63vBy++3N94sjm3QHHndEqe/v9YGdSVswPa6XWle/SYyAwiuh87RcLEbE+\nm3MBsCD8OWGnF5fqMu+Qmyo=\n-----END PRIVATE KEY-----\n",
  "client_email": "upbusiness@upbusiness-425717.iam.gserviceaccount.com",
  "client_id": "111905074481569731196",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/upbusiness%40upbusiness-425717.iam.gserviceaccount.com",
  "universe_domain": "googleapis.com"
}

''';

  static const _spreadsheetId = '1thi11zOH-htZ1C1yxdUzkeXMN5lKmutTYTfwvo7ynjI';

  static final _gsheets = GSheets(_credentials);
  static Worksheet? _dataSheet;

  static Future init() async {
    try {
      final spreadsheet = await _gsheets.spreadsheet(_spreadsheetId);
      _dataSheet = await _getWorkSheet(spreadsheet, title: 'Database');

      final firstRow = DataFields.getFields();
      _dataSheet!.values.insertRow(1, firstRow);
    } catch (e) {
      print('Init Error: $e');
    }
  }

  static Future<Worksheet> _getWorkSheet(
    Spreadsheet spreadsheet, {
    required String title,
  }) async {
    try {
      return await spreadsheet.addWorksheet(title);
    } catch (e) {
      return spreadsheet.worksheetByTitle(title)!;
    }
  }

  static Future<List<Data>> getAll() async {
    if (_dataSheet == null) return <Data>[];

    final data = await _dataSheet!.values.map.allRows();
    return data == null ? <Data>[] : data.map(Data.fromJson).toList();
  }

  static Future<Data?> getByItemCode(String itemCode) async {
    if (_dataSheet == null) return null;

    final json = await _dataSheet!.values.map.rowByKey(itemCode, fromColumn: 1);
    return json == null ? null : Data.fromJson(json);
  }

  static Future insert(List<Map<String, dynamic>> rowList) async {
    if (_dataSheet == null) return;

    _dataSheet!.values.map.appendRows(rowList);
  }
}
