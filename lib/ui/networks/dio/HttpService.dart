import 'package:dio/dio.dart';
import '../../constants/exports.dart';
import '../../database/shared_pred.dart';
import 'error_handling.dart';


class HttpsService{
   Dio? dio;
   // var token;


   // dio = Dio(BaseOptions(
   // connectTimeout: 30000,
   // baseUrl: 'your api',
   // responseType: ResponseType.json,
   // contentType: ContentType.json.toString(),
   // ))
   // ..interceptors.addAll(
   // [
   // InterceptorsWrapper(onRequest: (RequestOptions requestOptions) {
   // dio.interceptors.requestLock.lock();
   // String token = ShareP.sharedPreferences.getString('token');
   // if (token != null) {
   // dio.options.headers[HttpHeaders.authorizationHeader] =
   // 'Bearer ' + token;
   // }
   // dio.interceptors.requestLock.unlock();
   // return requestOptions;
   // }),
   // // other interceptor
   // ],
   // );
   
   var headers = {
     'Content-Type': 'multipart/form-data',
     'Authorization': 'Bearer ${localStorage.read(LocalStorageConstants().token)}'
   };

   var headersGet = {
     'Accept': 'application/json',
     'Authorization': 'Bearer ${localStorage.read(LocalStorageConstants().token)}'
   };

 // Future<Response> getHttpsService({endPoint,queryParameter})async{
 //    Options options=
 //        Options(
 //         // queryParameters: queryParameter,
 //      headers:headers,
 //      // baseUrl: base_url+endPoint,
 //      responseType: ResponseType.json,
 //       sendTimeout: 60*1000, // 60 seconds
 //        receiveTimeout: 60*1000
 //    );
 //
 // Response response= await  dio!.get(
 //      BASE_URL+endPoint,
 //      queryParameters: queryParameter,
 //      options: options,
 //    );
 //    initializeInterceptor();
 //   return  response;
 //  }



  initializeInterceptor(){
        dio!.interceptors.add(InterceptorsWrapper(
          onRequest: (RequestOptions? options,onRequest)  {
            debugPrint("${options?.baseUrl}${options?.path} ");
          },
          onResponse: (response,onResponse) {
            debugPrint(response.statusMessage);
            },
          onError: (DioError dioError,onDioError) {
            debugPrint(dioError.message);
          }));
         }

}