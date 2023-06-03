import 'dart:io';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import '../../constants/exports.dart';


class UploadDocuments extends GetView<UploadDocumentController> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(child:
    GetBuilder<UploadDocumentController>(
      init: UploadDocumentController(),
      builder: (controller) {
        return
          Scaffold(
              appBar: customAppBar(
                  title: controller.schemeName
              ),
              body:WillPopScope(
                onWillPop: (){
                   return Get.delete<UploadDocumentController>();
                },
                child:   controller.isLoadingAppliedSchemes.value
                    ? loader()
                    : Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: documentsInformationContainer(),
                    ),
                    _applySchemesButton(),
                  ],
                ) ,
              )





          );
      }


    ));
  }

          documentsInformationContainer(){
             return SingleChildScrollView(
               child:
               Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       _form(),
                       sizedBox(height: margin_20),
                       divider(height: 6.0,color: dividerColor),
                       sizedBox(height: margin_10),
                       controller.selfDeclartionFilePath!=null&&controller.selfDeclartionFilePath!=""||controller.detailsProjectReportFilePath!=null&&controller.detailsProjectReportFilePath!=""? _uploadDocument():Container(),
                        controller.selfDeclartionFilePath!=null&&controller.selfDeclartionFilePath!=""||controller.detailsProjectReportFilePath!=null&&controller.detailsProjectReportFilePath!=""? divider(height: 6.0,color: dividerColor):Container(),
                        sizedBox(height: margin_10),
                       _scanAndUploadDocumentContainer(),
                     ],
                   )

             );
          }


          _form(){
           return setPaddingAll(
             margin: margin_20,
             widget: Form(
               key: controller.formkey,
               child: Column(
                 children: [
                   _landApplyFor(),
                   sizedBox(height: height_20),
                   _landAddress(),
                 ],
               ),
             )
           );

          }


    _landApplyFor(){
    return CommonTextField(
          controller: controller.landApplyEditController,
          validation: (value) {
            if (value == null || value.isEmpty) {
              return pleaseSelectItemStr.tr;
            }
            return null;
          },
          onChanged: (value) {

            },
          inputType: TextInputType.number,
          inputActions: TextInputAction.next,
          labelText: landAreaApplyStr.tr,

        );
       }




        _landAddress(){
          return CommonTextField(
            controller: controller.landAddressEditController,
            validation: (value) {
              if (value == null || value.isEmpty) {
                return pleaseSelectItemStr.tr;
              }
              return null;
            },
            onChanged: (value) {
              controller.landAddressValue(value);
              },
            inputType: TextInputType.number,
            inputActions: TextInputAction.next,
            suffix: _landAddressDropDownMenu(),
          );

        }

  _landAddressDropDownMenu(){
    return DropdownSearch<dynamic>(
        popupProps: const PopupProps.menu(
          fit: FlexFit.loose,
          showSelectedItems: false,
        ),
        items: controller.addressList,
        dropdownDecoratorProps: DropDownDecoratorProps(
            dropdownSearchDecoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: margin_20,vertical: margin_10),
              border: InputBorder.none,
            )
        ),
        onChanged: (value){
          controller.landAddressValue(value);

        },
        selectedItem:controller.landAddressEditController.text==""?landAddressStr.tr:controller.landAddressEditController.text
    );


  }




  /*===============================================download documents container=========================*/

  _uploadDocument(){
  return  setPaddingAll(
    margin: margin_20,
    widget: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         _uploadDocumentTitle(),
       sizedBox(height: margin_30),
       _downloadsubTitle(),
        sizedBox(height: margin_20),
        _downloadFileList(),
        sizedBox(height: margin_10),

      ],
    ),
  );


  }

    _uploadDocumentTitle(){
    return commonText(uploadDocumentStr.tr,color: headingColor,fontSize: font_18,);
     }
     _downloadsubTitle(){
    return commonText(downloadDocumentStr.tr,color: paragraphColor,fontSize: font_14,);
  }


  _downloadFileList(){
     return ListView.builder(
       shrinkWrap: true,
         primary: false,
         itemCount: controller.downloadFileList.length,
         itemBuilder: (context,index){
         return index==0?controller.detailsProjectReportFilePath!=null?
         _downloadContainerWithButton(index,controller.downloadFileList[index], downloadStr.tr, (){
         toast("File Downloading...");

           controller.downloadFile(index);//this is because  downloading file shown in download folder

           },icon:Icon(Icons.file_download_outlined,color: white,)
         ):Container():index==1?controller.selfDeclartionFilePath!=null?_downloadContainerWithButton(index,controller.downloadFileList[index], downloadStr.tr, (){
           toast("File Downloading...");
           controller.downloadFile(index);//this is because  downloading file shown in download folder
         },icon:Icon(Icons.file_download_outlined,color: white,)):Container():Container();
         });

  }






_downloadContainerWithButton(index,title,buttonText,onButtonClick,{icon}){
  return
    Container(
    margin: EdgeInsets.symmetric(vertical: margin_10),
    decoration: BoxDecoration(
        border:Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(radius_4)
    ),
    child:
    setPaddingAll(
      margin:margin_10,
      widget: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child:commonText(title,fontSize: font_14,fontWeight: FontWeight.w400,maxLines: 2)),
          getInkWell(
            ontap:onButtonClick,
            widget: Container(
                padding: EdgeInsets.symmetric(vertical: margin_12,horizontal: margin_30),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radius_24),
                  color: thirdColor,
                ),
                child:
                Row(
                  children: [
                    icon??Container(),
                    commonText(buttonText.toUpperCase(),fontSize: font_12,color: white),
                  ],
                )

            ),
          )
        ],
      ),
    ),
  );

}

  _commonContainerWithButton(index,title,buttonText,onButtonClick,{icon}){
    return Container(
      margin: EdgeInsets.symmetric(vertical: margin_10),
      decoration: BoxDecoration(
          border:Border.all(color: borderColor),
          borderRadius: BorderRadius.circular(radius_4)
      ),
      child:
      Column(
        children: [
          setPaddingAll(
            margin:margin_20,
            widget: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child:commonText(title,fontSize: font_14,fontWeight: FontWeight.w400,maxLines: 2)),
                getInkWell(
                  ontap:onButtonClick,
                  widget:
                  controller.showPDFFile[index]==true?Container():
                  Container(
                    padding: EdgeInsets.symmetric(vertical: margin_12,horizontal: margin_30),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(radius_24),
                      color: thirdColor,
                    ),
                    child:
                    Row(
                      children: [
                        icon??Container(),
                        commonText(buttonText.toUpperCase(),fontSize: font_12,color: white),
                      ],
                    )

                  ),
                )
              ],
            ),
          ),
          controller.showPDFFile[index]==true?_pickedPDfView(index):Container()
        ],
      ),
    );

  }
/*===============================================scan Upload documents container=========================*/


      _scanAndUploadDocumentContainer(){
        return setPaddingAll(
          margin: margin_20,
          widget:Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _scanUploadSubTitle(),
              sizedBox(height: margin_20),
              _uploadDocumentList(),

            ],
          )
        );


      }

  _scanUploadSubTitle(){
    return commonText(scanDocumentStr.tr,color: paragraphColor,fontSize: font_14,);
  }

  _uploadDocumentList(){
   return GetBuilder<UploadDocumentController>(
       id: "uploads",
       builder: (_){
      return  ListView.builder(
          shrinkWrap: true,
          primary: false,
          itemCount: controller.uploadDocumentList.length,
          itemBuilder: (context,index){
            return _commonContainerWithButton(index,controller.uploadDocumentList[index], uploadStr.tr, (){
              _pickPDFDocument(index);
              debugPrint("pdf list is${controller.pickedPDfList.toString()}");
            });



          });
   })

 ;


  }


  _pickPDFDocument(index)async{
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions:['pdf']
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
        controller.pickedPDfList.insert(index,File(result.files.single.path!));
        controller.pickedPDfList.removeAt(index+1);

        controller.enableApplySchemesButton.value=!controller.pickedPDfList.contains("null");
        debugPrint("picked pdf list${controller.pickedPDfList}");
        debugPrint("button enabled${ controller.enableApplySchemesButton.value}");
        controller.showPDFFile[index]=true;
        controller.refreshScreen();

        if(controller.enableApplySchemesButton.value==true){
          controller.refreshButton();
        }
        if(controller.isFileUpdated.isNotEmpty){
          controller.isFileUpdated[index]=true;
        }

      }

    }
    else {
      toast(noPdfFilePickedStr.tr);
    }
  }

  _pickedPDfView(index){
    return
   Container(
     padding: EdgeInsets.symmetric(horizontal: margin_10,vertical: margin_14),
        color: lightBlueColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                // assetImage(image: img_pdf,height: 20.0,width: 20.0),
                  sizedBox(width: margin_10),
                 Expanded(child:commonText( "${controller.pickedPDfList[index].path.split('/').last}",color: floatingTextColor,fontSize: font_14),
                 )
                ],
              ),
            ),
            getInkWell(
                ontap: (){
                  controller.showPDFFile[index]=false;
                 controller.pickedPDfList.insert(index, "null");
                 controller.pickedPDfList.removeAt(index+1);
                 debugPrint("show false ${controller.showPDFFile.toString()}");
                 debugPrint("show pdf ${controller.pickedPDfList.toString()}");
                 controller.refreshScreen();
                },
                widget: Icon(Icons.close,color: floatingTextColor,))
          ],
        ),

    );
  }



  _applySchemesButton(){
    return GetBuilder<UploadDocumentController>(
      id: "applyButton",
      builder: (_){
        return   Container(
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

        if(controller.enableApplySchemesButton.value==true){
        if(controller.formkey.currentState!.validate()){
        controller.appliedSchemesApiCall();
        }
        }
        else{
          toast(pickRequiredFileStr.tr);
        }
        },
        style:ElevatedButton.styleFrom(
        backgroundColor:controller.enableApplySchemesButton.value?primaryColor:disableButtonColor,
        shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(margin_25)
        ),
        padding: EdgeInsets.symmetric(vertical:margin_20,horizontal:margin_10)
        ),

        child: commonText(proceedApplyStr.tr.toUpperCase(),color: controller.enableApplySchemesButton.value?white:disableButtonTextColor,fontWeight: FontWeight.w500,fontSize: font_14,letterSpacing:1.25),
        )
        ),
        );
      },

    );

  }
    }




