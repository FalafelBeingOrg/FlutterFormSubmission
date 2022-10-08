import 'package:gsheets/gsheets.dart';
import 'package:flutter_form_submission/user.dart';
class UserSheetsApi {
  static const _credentials = r'''
  {
  "type": "service_account",
  "project_id": "gsheets-364900",
  "private_key_id": "c886c4363848a0abbb46365756584120f10cc773",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQC7QR7Wo/FPbtWL\nl/0TttHRvOxZ2sBNIRACH4UkSWC3KSmr+uTZZf9NAybHT31mu5SvalCD7eT1TcT6\nbUUyetma5ROyvhV0lNKFbe2R7cAOvyRTr1spnCcO4aHiscprToNIZp3Ydee6Eb/N\ncGH+N/fF55zNJIWKMFqSYKkSMhI6jBuMhZyzrNg/3Vt/aSYEZ9yyNUdgksQJLgMF\nBPP70EmITmXTBYzHMkEp/Yx/xCGT7sQGiHfn8HWzb8gTJ61FAy6DsYLW4lxsxrC7\nyRJSSzH8cbx8zxFj5M4Rh6P7SwkdKvJRBFJzbTxqlEFsX33NqNptAfTrzQahqBUm\nXndeELQBAgMBAAECggEAAmmWsx847FQPjj/ZXoKmy16gEOb06Ul5bP2TooxgzEX3\nJ88Qrw2rBLFQs5VTlpo+EnslKb32itkt+31Nkevr7RycbLDEPVSZgxHlKKcj0qIl\nyVTjW3LhPJuC5r/G+CudHLatu+yGSBW9ydtzzRRS2IrhBfI9gjKYnXV/WCEAWR66\nqj5Yrh9cRekfQI2LqURiuoI+r/vZD+YXigmoAUjJNAXDO5oX6SJ7NsM+lRQg/Ub/\nWC47O0dusCnIkZ10r7bTdw6/fJIshIWbLmeDfxCGbnSdCionJ9+scVH63MMnoS8G\niL0YdpEQi2Og4SJ31g3CX/g2UQcka5kwADMmFqRVUQKBgQDlpzMx3ueDNWRkos85\njLG+BQxaBNDx5XYXoJd8Rax2TGvUy17boX2zCOC/RMUmuBjMnURFr3EF9v5x9joa\ngO1Ao/5vHpUcrUpSsnIAzlE61qUOyVB6NgcK8o0nqoUWs+lGXOo1t99ZUdXO3Ks7\n8T/0ZxhBMHZm4KnjUNOb8QCkDQKBgQDQvLCiRnUrBDAL4YOF8UeOFUQN7vLsy/JN\nyovGQfo9gyWYzXB3XpZu03S5ulNZbzGlmEoimlSYLxxR8xRKjahropdSLtqdBeQm\npi+U7ZV04SmCT2F8yvl1mvWUPsc+NYOm+MMiZMfdgGKZI6kMPSbFw6NGAKGuYtE9\npHrnAtDOxQKBgHF+Q+qtgjRxun+Rhl+mjGCgFg6WurwQ7l+W2cZsmGKOOewb5XEd\nSgWkqY1c6yHLcVYNkqPtpCmSewTO7sASXy3G3gMEViSp70UXMwf67mHpmgDItKDw\n+mIKpH+p4cPqfapsWMLbb+Gwc72biHRDMZwTJwVwcdM9zDeuxiUW4X4xAoGBALGo\nV2HWO/UfvFDwYIPIxtEcMm71d9apApLJGEvmbbia/Y3fFKDUZY7v9IH7HuOYqxW4\n1yg6WFOqjR0GmbeWd8kcelRdQn2wvO1UNl04FSOEXFLngx62lrlM6UWCZQwCegnL\n4jFMu3s/wSt72W5sQarChx2WfgWxX0tqyZwCnnvNAoGAbfSJD3fLHXv+in53vlbs\n9SO9KN6HMR8rvgMpDKDbdEKiOElmHpHR/+8Z/BmLAxJ9ZBfm2+OjNL2DhVs+4O4W\nGRf6Is1HkIxX2yNEfCIfoVIwKcyUuZP3jN5bAcHfRnRhGcTljXvyGFaNehk60l2F\nt3Q7u6dGZfocdJqiXMrsuUU=\n-----END PRIVATE KEY-----\n",
  "client_email": "gsheets@gsheets-364900.iam.gserviceaccount.com",
  "client_id": "100909557817753944140",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/gsheets%40gsheets-364900.iam.gserviceaccount.com"
}
''';
    static final _spreadsheetId = '1bnI3BqS3aRftfCY01Ps1oSnH4IrPrl5PAPr81buvdPE';
    static final _gsheets = GSheets(_credentials);
    static Worksheet? _userSheet;

    static Future init() async {
      try{
        final spreadsheet = await _gsheets.spreadsheet(_spreadsheetId);
        _userSheet = await _getWorkSheet(spreadsheet, title: "Data");

        final firstRow = UserFields.getFields();
        _userSheet!.values.insertRow(1, firstRow);
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
        } catch(e){
          return spreadsheet.worksheetByTitle(title)!;
        }
      }

      static Future insert(List<Map<String, dynamic>> rowList) async {
        if (_userSheet == null) return;
        _userSheet!.values.map.appendRows(rowList);
      }
}