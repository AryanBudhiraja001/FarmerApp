

import 'dart:convert';


import 'package:dio/dio.dart';



class AuthParams{


  profileUpdateData(
  {var userId,
  var applicantTypeId,
  var applicantName,
  var fatherName,
  var gender,
  var residence,
  var aadhaarNumber,
  var panNumber,
  var casteCategoryIdValue,
  var state,
  var district,
  var tehsil,
  var city,
  var fullAddress,
  var postalCode,
   var image
  }){

      return  FormData.fromMap({
        "user_id":userId,
      "applicant_type_id":applicantTypeId,
      "applicant_name":applicantName,
      "father_husband_name":fatherName,
      "gender":gender,
      "resident":residence,
      "aadhar_no":aadhaarNumber,
      "pan_no":panNumber,
      "caste_category_id":casteCategoryIdValue,
      "state":state,
      "district_id":district,
      "tehsil_id":tehsil,
      "city_id":city,
      "full_address":fullAddress,
      "postal_code":postalCode,
      "avatar":image,
      });
     }

     updateProfileUpdateData(
         {var userId,
           var applicantTypeId,
           var applicantName,
           var fatherName,
           var gender,
           var residence,
           var aadhaarNumber,
           var panNumber,
           var casteCategoryIdValue,
           MultipartFile? image
         }){

       return  FormData.fromMap({
         "user_id":userId,
         "applicant_type_id":applicantTypeId,
         "applicant_name":applicantName,
         "father_husband_name":fatherName,
         "gender":gender,
         "resident":residence,
         "aadhar_no":aadhaarNumber,
         "pan_no":panNumber,
         "caste_category_id":casteCategoryIdValue,

         "avatar":image,
       });
     }


    addressUpdateData(
         {
           var userId,
           var state,
           var district,
           var tehsil,
           var city,
           var fullAddress,
           var postalCode,

         }){

       return  FormData.fromMap({
         "user_id":userId,
         "state":state,
         "district_id":district,
         "tehsil_id":tehsil,
         "city_id":city,
         "full_address":fullAddress,
         "postal_code":postalCode,

            });
     }

  languageUpdate({var userId,var locale}){
    return FormData.fromMap({
        'data': json.encode(
            {
    }
    )
        });}


     registerAuth({
       var mobileNumber,
       var languageLocale,
       var deviceToken,
     }){
       return FormData.fromMap({
         "mobile_number":mobileNumber,
         "language":languageLocale,
         "device_token":deviceToken,
       });}


     loginAuth({
       var mobileNumber,
       var deviceToken,
     }){
       return FormData.fromMap({
         "mobile_number":mobileNumber,
         "device_token":deviceToken,
       });}

  sendOtpAuth({
    var mobileNumber,
  }){
    return FormData.fromMap({
      "mobile_number":mobileNumber,
    });}

  verifyOtpAuth({
    var otp,
    var userId,
  }){
    return FormData.fromMap({
      "otp":otp,
      "user_id":userId
    });}

  resendOtpAuth({
    var userId,
  }){
    return FormData.fromMap({
      "user_id":userId
    });}



     logoutAuth({
       var token,
     }){
       return FormData.fromMap({
         "token":token,
       });}


  mandiPriceParam({
         var market,
         var district,
    var commodity,
  }){
    return FormData.fromMap({
      "market":market,
      "district":district,
      "commodity":commodity,

    });
   }

    bankDetailsParam({
       var farmerid,
       var bankName,
       var ifscCode,
       var branchName,
       var accountNumber,
       var holderName,
       var bankBranchAddress,
      var uploadCancelCheck,
      var uploadPassbook
     }){
       return FormData.fromMap({
         "farmer_id":farmerid,
         "bank_name":bankName,
         "ifsc_code":ifscCode,
         "branch_name":branchName,
         "account_no":accountNumber,
         "account_name":holderName,
         "bank_branch_address":bankBranchAddress,
         "upload_cancel_check":uploadCancelCheck,
         "upload_passbook":uploadPassbook,

       });
     }

     landDetailsParam({
       var landId,
       var farmerid,
       var totalLandArea,
       var state,
       var district,
       var tehsil,
       var city,
       var pinCode,
       var landAddress,
       var areaInformations,
       var pateDarNo,
       var khewatNumber,
       var khatauniNo,
       var khasraNo,


     var uploadFard,
       var uploadPatedarDocument
     }){
       return FormData.fromMap({
         "land_id[]":landId,
         "farmer_id":farmerid,
         "total_land_area[]":totalLandArea,
         "state[]":state,
         "district_id[]":district,
         "tehsil_id[]":tehsil,
         "city_id[]":city,
         "pin_code[]":pinCode,
         "land_address[]":landAddress,
         "area_information[]":areaInformations,
         "pattedar_no[]":pateDarNo,
         "khewat_no[]":khewatNumber,
         "khatauni_no[]":khatauniNo,
         "khasra_no[]":khasraNo,
         "upload_fard[]":uploadFard,
         "upload_pattedar[]":uploadPatedarDocument,
       });
     }


    appliedSchemesParam({
      var farmerId,
      var landId,
      var landApplied,
      var schemeId,
      var publicPrivate,
     var selfDeclarationFile,
     var projectDetailsFile,
     var reject,
      var index,
    var othersDocuments,
    })
    {
      return FormData.fromMap({
        "farmer_id":farmerId,
        "scheme_id":schemeId,
        "land_address_id":landId,
        "land_applied":landApplied,
        "public_private":publicPrivate,
        "project_note":projectDetailsFile,
        "self_declaration":selfDeclarationFile,
        "reject":reject,
        "index[]":index,
       "other_documents[]":othersDocuments,
      }
      );
    }


    saveNotificationParam({
    var userId,
    var save,
    }){
   return FormData.fromMap({
     "user_id":userId,
     "save":save,
   }) ;
  }
}

