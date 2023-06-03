

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import '../../../constants/exports.dart';
import '../../../shimmer_effect/shimmerWidget.dart';

class BankDetailsScreen extends GetView<BankDetailsController> {


  @override
  Widget build(BuildContext context) {
    return SafeArea(child: GetBuilder<BankDetailsController>(
      init: BankDetailsController(),
        builder: (controller){
          return Scaffold(
            appBar: _bankDetailsAppBar(),
              body:
                   controller.isLoadingBankData.value?loader():
                   FutureBuilder(
                        future: controller.futureBankDetailsData,
                        builder: (_,data){
                         if(data.connectionState==ConnectionState.done){
                           if(data.hasData){
                             return      Column(
                               mainAxisSize: MainAxisSize.max,
                                 children: [
                                   Expanded(child:
                                   setPaddingAll(
                                     margin: margin_20,
                                     widget:
                                     _form(),
                                   )
                                   ),
                                   _applyBankDetailsButton(buttonText: updateStr.tr),
                                 ],);
                             };

                         }
                         if(data.connectionState==ConnectionState.waiting){
                           return _bankDetailsShimmerWidget();
                         }
                         else {
                         return noDataAvailable(title: controller.fetchBankDetailsErrorMessage.value);
                         }
                        })
             

          );
        }

    )

    );
  }
  _bankDetailsAppBar(){
    return AppBar(
      centerTitle: false,
      leading: null,
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          getInkWell(
              widget:Icon(Icons.arrow_back,color: white,),
              ontap: (){
                Get.back(result:controller.isBankDetailsFilled.value
                );
              }
          ),
          sizedBox(width: margin_20) ,
          commonText( bankDetailsStr.tr, color: white, fontSize: font_20),
        ],
      ),
      backgroundColor: secondaryColor,
    );


  }

  _form(){
    return
      SingleChildScrollView(
        child: Form(
          key: controller.formKey,
              child: Column(
                children: [
                  sizedBox(height: margin_20),
                  _bankNameEditText(),
                  sizedBox(height: height_20),
                  _ifscCodeEditText(),
                  sizedBox(height: height_20),
                  _branchNameEditText(),
                  sizedBox(height: height_20),
                  _accountNoEditText(),
                  sizedBox(height: height_20),
                  _confirmAccountNoEditText(),
                  sizedBox(height: height_20),
                  _nameOnAccountEditText(),
                  sizedBox(height: height_20),
                  _branchAddressEditText(),
                  sizedBox(height: height_20),
                  _uploadBankCancelCheckPDf(),
                   sizedBox(height: height_20),
                  _uploadBankPassbookPDf(),
                ],
              ),
            ),
      );
  }

   _bankNameEditText(){
       return CommonTextField(
      controller: controller.bankNameEditController,
         validation: (value) {
        if (value == null || value.isEmpty) {
          return pleaseSelectItemStr.tr;
        }
        return null;
      },
      onChanged: (value) {

      },
      inputActions: TextInputAction.next,
      labelText: bankNameStr.tr,
       );

   }

  _ifscCodeEditText(){
    return CommonTextField(
      controller: controller.ifscCodeEditController,
      validation: (value) {
        if (value == null || value.isEmpty) {
          return pleaseSelectItemStr.tr;
        }
        else if (value.length<11) {
          return ifscCode.tr;
        }
        return null;
      },
      onChanged: (value) {
        },
      inputFormators: [ifscCodeFormatter],
      inputActions: TextInputAction.next,
      labelText: ifscCodeStr.tr,
    );

  }
  _branchNameEditText(){
    return CommonTextField(
      controller: controller.branchNameEditController,
      validation: (value) {
        if (value == null || value.isEmpty) {
          return pleaseSelectItemStr.tr;
        }
        return null;
      },
      onChanged: (value) {

      },
      inputActions: TextInputAction.next,
      labelText: branchNameStr.tr,
    );

  }
  _accountNoEditText(){
    return CommonTextField(
      controller: controller.accountNoEditController,
      validation: (value) {
        if (value == null || value.isEmpty) {
          return pleaseSelectItemStr.tr;
        }
        else if (value.length<9) {
          return pleaseEnterValidAccountStr.tr;
        }
        return null;
      },
      onChanged: (value) {

      },
      inputFormators: [accountNumberFormatter],
      inputType: TextInputType.number,
      inputActions: TextInputAction.next,
      labelText: accountNumberStr.tr,
    );

  }

  _confirmAccountNoEditText(){
    return CommonTextField(
      controller: controller.confirmAccountNoEditController,
      validation: (value) {
        if (value == null || value.isEmpty) {
          return pleaseSelectItemStr.tr;
        }
       else if(value!=controller.accountNoEditController.text){
          return accountNumberNotMatchedStr.tr;
        }
        else if (value.length<9) {
          return pleaseEnterValidAccountStr.tr;
        }
        return null;
      },
      onChanged: (value) {

      },
      inputType: TextInputType.number,
      inputActions: TextInputAction.next,
      labelText: confirmAccountNumberStr.tr,
    );

  }
  _nameOnAccountEditText(){
    return CommonTextField(
      controller: controller.farmerNameEditController,
      validation: (value) {
        if (value == null || value.isEmpty) {
          return pleaseSelectItemStr.tr;
        }
        return null;
      },
      onChanged: (value) {
        },
      inputActions: TextInputAction.next,
      labelText: nameOfFarmerStr.tr,
    );
  }
  _branchAddressEditText(){
    return CommonTextField(
      controller: controller.bankBranchAddressEditController,
      validation: (value) {
        if (value == null || value.isEmpty) {
          return pleaseSelectItemStr.tr;
        }
        return null;
      },
      onChanged: (value) {
      },
      inputActions: TextInputAction.next,
      labelText: bankBranchAddressStr.tr,
    );
  }



  _uploadBankCancelCheckPDf(){
   return Container(
     decoration: BoxDecoration(
       border:Border.all(color: borderColor),
       borderRadius: BorderRadius.circular(radius_4)
     ),
     child:
     Column(
       children: [
         setPadding(
           leftPadding: margin_20,
           rightPadding: margin_20,
           topPadding: margin_20,
           bottomPadding: margin_20,
           widget: Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [
               commonText(uploadCancelCheckStr.tr,fontSize: font_14,fontWeight: FontWeight.w400),
               getInkWell(
                 ontap: ()  {
                   _pickCancelCheckPDf();
                   },
                 widget:
                 controller.pickedCancelCheckPDfFile!=null?Container():

                 Container(
                   padding: EdgeInsets.symmetric(vertical: margin_12,horizontal: margin_30),
                   decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(radius_24),
                     color: thirdColor,
                   ),
                   child: commonText(uploadStr.tr.toUpperCase(),fontSize: font_12,color: white),
                 ),
               )
             ],
           ),
         ),
         controller.pickedCancelCheckPDfFile!=null?_pickedCancelCheckFileView():Container(),
       ],
     ),
   );

  }

  _pickCancelCheckPDf()async{
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
        allowedExtensions:["pdf","jpg","jpeg","png"]
    );
    if (result != null) {
      var sizeInBytes = result.files.single.size;
      debugPrint("size of file in bytes$sizeInBytes");
      double sizeInMb = sizeInBytes/(1024)/1024;
      debugPrint("size of file in mb$sizeInMb");
      if (sizeInMb.round() > 5){
        toast(fileWarningStr.tr);
      }else{
        controller.pickedCancelCheckPDfFile=File(result.files.single.path!);
        controller.ispickedCancelCheckPDfFile.value=false;
        controller.refreshScreen();
      }

    } else {
      toast(noPdfFilePickedStr.tr);
    }
  }

  _pickedCancelCheckFileView(){
      return Container(
          color: lightBlueColor,
          padding: EdgeInsets.symmetric(vertical: margin_14,horizontal: margin_10),
          child: Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: commonText( "${controller.pickedCancelCheckPDfFile.path.split('/').last}",color: floatingTextColor,fontSize: font_14),
              ),
              getInkWell(
                  ontap: (){
                    controller.pickedCancelCheckPDfFile=null;
                    controller.refreshScreen();
                    },
                  widget: Icon(Icons.close,color: floatingTextColor,))
            ],
          ),

      );
  }

  _uploadBankPassbookPDf(){
    return   Container(
      decoration: BoxDecoration(
          border:Border.all(color: borderColor),
          borderRadius: BorderRadius.circular(radius_4)
      ),
      child:
      Column(
        children: [
          setPadding(
            leftPadding: margin_20,
            rightPadding: margin_20,
            topPadding: margin_20,
            bottomPadding: margin_20,
            widget: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                commonText(uploadBankPassbookStr.tr,fontSize: font_14,fontWeight: FontWeight.w400),
                getInkWell(
                  ontap: ()  {
                    _pickBankPassBookPDf();
                    controller.refreshScreen();
                  },
                  widget:
                  controller.pickedPassbookPDFFile!=null?Container():

                  Container(
                    padding: EdgeInsets.symmetric(vertical: margin_12,horizontal: margin_30),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(radius_24),
                      color: thirdColor,
                    ),
                    child: commonText(uploadStr.tr.toUpperCase(),fontSize: font_12,color: white),
                  ),
                )
              ],
            ),
          ),
          controller.pickedPassbookPDFFile!=null?_pickedPassbookView():Container(),
        ],
      ),
    );

  }




  _pickBankPassBookPDf()async{
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions:["pdf","jpg","jpeg","png"]
    );
    if (result != null) {
      var sizeInBytes = result.files.single.size;
      debugPrint("size of file in bytes$sizeInBytes");
      double sizeInMb = sizeInBytes/(1024)/1024;
      debugPrint("size of file in mb$sizeInMb");
      if (sizeInMb.round() > 5){
        toast(fileWarningStr.tr);
      }
      else{
        controller.pickedPassbookPDFFile=File(result.files.single.path!);
      controller.ispickedPassbookPDFFile.value=false;
        controller.refreshScreen();
      }

    } else {
      toast(noPdfFilePickedStr.tr);
    }
  }
  _pickedPassbookView(){
    return
      Container(
        color: lightBlueColor,
        padding: EdgeInsets.symmetric(vertical: margin_14,horizontal: margin_10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  sizedBox(width: margin_10),
                  Expanded(child:commonText( "${controller.pickedPassbookPDFFile.path.split('/').last}",color: floatingTextColor,fontSize: font_14),
                  )
                ],
              ),
            ),
            getInkWell(
                ontap: (){
                  controller.pickedPassbookPDFFile=null;
                  controller.refreshScreen();
                },
                widget: Icon(Icons.close,color: floatingTextColor,))
          ],
        ),

    );
  }


/*======================================apply button========================*/
  _applyBankDetailsButton({buttonText}){
    return Container(
      width: double.infinity,
      padding:EdgeInsets.symmetric(vertical: margin_20) ,
      decoration: BoxDecoration(
          color: white,
          border: Border(
              top: BorderSide(color: borderColor)
          )
      ),
      child:setPadding(
          leftPadding: margin_20,
          rightPadding: margin_20,
          widget:
          ElevatedButton(onPressed: (){
            if(controller.formKey.currentState!.validate()){
              if(controller.pickedCancelCheckPDfFile!=null&&controller.pickedPassbookPDFFile!=null){
                // toast("bank details saved ");
                // _controller.bankDetailsFilled.value=true;
                controller.bankDetailsPostApiCall();
              }
              else{
                toast(pickRequiredFileStr.tr);
              }

            }
            else{
              toast(pleaseFillRequiredFieldStr);
            }
          },
            style:ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(margin_25)
                ),
                padding: EdgeInsets.symmetric(vertical:margin_20,horizontal:margin_10)
            ),

            child: commonText(buttonText,color: white,fontWeight: FontWeight.w500,fontSize: font_14,letterSpacing:1.25),
          )
      ),
    );
  }



  _bankDetailsShimmerWidget(){
    return SingleChildScrollView(
      child: Center(
        child: setPaddingAll(
          margin: margin_20,
          widget: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              sizedBox(height: height_30),
              ListView.builder(
                  itemCount: 8,
                  shrinkWrap: true,
                  primary: false,
                  itemBuilder: (context,index){
                    return  setPadding(
                        bottomPadding: height_20,
                        widget: ShimmerWidget.rectangular(height: 56.0));
                  }),
            ],
          ),
        ),
      ),
    );

  }
}
