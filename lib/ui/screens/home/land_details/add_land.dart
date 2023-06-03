import 'dart:io';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../../../constants/exports.dart';
import '../../../shimmer_effect/shimmerWidget.dart';


class AddLand extends GetView<addLandController> {


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child:
      Scaffold(
     appBar:  appBarWithDataOnBack(
          title: addLandStr,
           data:true,
        ),
        body:
            GetBuilder<addLandController>(
              init:addLandController() ,
                builder: (controller){
                return   controller.loadingData.value?loader():Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                    FutureBuilder(
                        future: controller.districtFutureData,
                        builder: (context,data){
                          if(data.connectionState==ConnectionState.done){
                            if(data.hasData){
                              return   Expanded(child:_form());
                            }
                            if(data.hasError){
                              return  noDataAvailable(title: controller.errorMessage.value);
                            }
                            if(data.connectionState==ConnectionState.waiting){
                              return  Expanded(
                                child:_landAddressShimmerWidget() ,
                              );
                            }
                          }
                          return Expanded(
                            child:_landAddressShimmerWidget() ,
                          );
                        }),
                  _applyLandDetailsButton(),
                  ],
                  );

                }
            ),
         )
      );
  }
  _form(){
    return
      SingleChildScrollView(
        child: setPaddingAll(
          margin: margin_20,
          widget:
          Form(
            key: controller.formKey,
            child: Column(
              children: [
                sizedBox(height: margin_20),
                _totalArea(),
                sizedBox(height: height_20),
                _stateEditText(),
                sizedBox(height: height_20),
                _districtEditText(),
                sizedBox(height: height_20),
                _tehsilEditText(),
                sizedBox(height: height_20),
                _villageCityEditText(),
                sizedBox(height: height_20),
                _pincodeEditText(),
                sizedBox(height: height_20),
                _landAddressEditText(),
                sizedBox(height: height_20),
                _areaInfomationEditText(),
                sizedBox(height: height_20),
               _uploadFardPDf(),
                sizedBox(height: height_20),
                _uploadPatedarDocument(),
                sizedBox(height: height_20),
                _khewatNoEditText(),
                sizedBox(height: height_20),
                _khatuniNumberEditText(),
                sizedBox(height: height_20),
                _khasraNUmberEditText(),
              ],
            ),
          ),
        ) ,
      )
    ;
  }

  _totalArea(){
    return CommonTextField(
      controller: controller.totalLandAreaEditController,
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
      labelText: areaHeatareStr.tr,
    );

  }




  _stateEditText(){
    return CommonTextField(
      controller: controller.stateEditController,
      validation: (value) {
        if (value == null || value.isEmpty) {
          return pleaseSelectItemStr.tr;
        }
        return null;
      },
      onChanged: (value) {
      },
      inputActions: TextInputAction.next,
      suffix: _stateDropDown(),
    );

  }


  _stateDropDown(){
    return DropdownSearch<dynamic>(
        popupProps: const PopupProps.menu(
          fit: FlexFit.loose,
          showSelectedItems: false,
        ),
        items: controller.stateList,
        dropdownDecoratorProps: DropDownDecoratorProps(
            baseStyle:  GoogleFonts.roboto(
              textStyle:TextStyle(color: paragraphColor,fontSize: font_16,fontWeight: FontWeight.w400),),
            dropdownSearchDecoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: margin_20,vertical: margin_10),
              border: InputBorder.none,
            )
        ),
        onChanged: (value){
          controller.stateType(value);
        },
        selectedItem:selectStateStr.tr
    );

  }

  _districtEditText(){
    return CommonTextField(
      controller: controller.districtEditController,
      validation: (value) {
        if (value == null || value.isEmpty) {
          return pleaseSelectItemStr.tr;
        }
        return null;
      },
      onChanged: (value) {

      },
      inputActions: TextInputAction.next,
      labelText: districtStr.tr,
      suffix: _districtDropDown(),
    );

  }

  _districtDropDown(){
    return DropdownSearch<dynamic>(
        popupProps: const PopupProps.menu(
          fit: FlexFit.loose,
          showSelectedItems: false,
        ),
        items: controller.landController!.districtList,
        dropdownDecoratorProps: DropDownDecoratorProps(
            baseStyle:  GoogleFonts.roboto(
              textStyle:TextStyle(color: paragraphColor,fontSize: font_16,fontWeight: FontWeight.w400),),
            dropdownSearchDecoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: margin_20,vertical: margin_10),
              border: InputBorder.none,
            )
        ),
        onChanged: (value){
          controller.tehsilType("");
          controller.villageType("");
          // _controller.tehsilEditController.text="";
          // _controller.villageEditController.text="";

          controller.districtType(value);
          var index=controller.landController!.districtList.indexOf(value);
          controller.selectDistrictIndexIdFun(index);
          controller.landController!.tehsilList.clear();
          controller.landController!.tehsilIdList.clear();


          /*==================    get tehsil list  of district selected=================*/
          controller.landController!.getTehsilData(controller.selectedDistrictIndex.value);
          controller.selectDistrictTypeIdFun(controller.landController!.districtIdList[index]);
          controller.selectDistrictIdFun(controller.selectDistrictTypeId.value);

        },
        selectedItem:controller.districtEditController.text==""?selectDistrictTypeStr.tr:controller.districtEditController.text
    );

  }


  _tehsilEditText(){
    return CommonTextField(
      controller: controller.tehsilEditController,
      validation: (value) {
        if (value == null || value.isEmpty) {
          return pleaseSelectItemStr.tr;
        }
        return null;
      },
      onChanged: (value) {

      },

      inputActions: TextInputAction.next,
      labelText: tehsilStr.tr,
      suffix: _tehsilDropDown(),
    );

  }
  _tehsilDropDown(){
    return DropdownSearch<dynamic>(
        popupProps: const PopupProps.menu(
          fit: FlexFit.loose,
          showSelectedItems: false,
        ),
        items:controller.landController!.tehsilList,
        dropdownDecoratorProps: DropDownDecoratorProps(
            baseStyle:  GoogleFonts.roboto(
              textStyle:TextStyle(color: paragraphColor,fontSize: font_16,fontWeight: FontWeight.w400),),
            dropdownSearchDecoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: margin_20,vertical: margin_10),
              border: InputBorder.none,
            )
        ),
        onChanged: (value){
          controller.villageType("");
          var index=controller.landController!.tehsilList.indexOf(value);
          controller.tehsilEditController.text=value;
          controller.selectVillageTypeId.value=index;
          controller.landController!.villageList.clear();
          controller.landController!.villageIdList.clear();
          controller.selecttehsilIndexIdFun(index);
          controller.landController!.getVillageData(controller.selectedTehsilIndex.value,
              controller.selectedDistrictIndex.value);

          controller.selectTehsilTypeIdFun(controller.landController!.tehsilIdList[index]);

          controller.selectTehsilIdFun(controller.selectTehsilTypeId.value);



        },
        selectedItem:controller.tehsilEditController.text==""?selectTehsilStr.tr:controller.tehsilEditController.text
    );

  }

  _villageCityEditText(){
    return CommonTextField(
      controller: controller.villageEditController,
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
      labelText: villageStr.tr,
      suffix: _villageDropDown(),
    );

  }

  _villageDropDown(){
    return DropdownSearch<dynamic>(
        popupProps: const PopupProps.menu(
          fit: FlexFit.loose,
          showSelectedItems: false,
        ),
        items: controller.landController!.villageList,
        dropdownDecoratorProps: DropDownDecoratorProps(
            baseStyle:  GoogleFonts.roboto(
              textStyle:TextStyle(color: paragraphColor,fontSize: font_16,fontWeight: FontWeight.w400),),
            dropdownSearchDecoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: margin_20,vertical: margin_10),
              border: InputBorder.none,
            )
        ),
        onChanged: (value){
          controller.villageEditController.text=value;
          var index=controller.landController!.villageList.indexOf(value);
          controller.selectVillageTypeIdFun(controller.landController!.villageIdList[index]);
          controller.selectVillageIdFun(controller.selectVillageTypeId.value);
          debugPrint("select value${controller.landController!.villageIdList[index]}");
        },
        selectedItem:controller.villageEditController.text==""?selectCityVillageStr.tr:controller.villageEditController.text
    );

  }

  _pincodeEditText(){
    return CommonTextField(
      controller: controller.pincodeEditController,
      inputFormators: [pinCodeFormatter],
      validation: (value) {
        if (value == null || value.isEmpty) {
          return pleaseSelectItemStr.tr;
        }
        else if (value.length<6) {
          return validPin.tr;
        }
        return null;
      },
      onChanged: (value) {
      },
      inputType: TextInputType.number,
      inputActions: TextInputAction.next,
      labelText: pinCodeStr.tr,
    );
  }


  _landAddressEditText(){
    return CommonTextField(
      controller: controller.landAddressEditController,
      validation: (value) {
        if (value == null || value.isEmpty) {
          return pleaseSelectItemStr.tr;
        }
        return null;
      },
      onChanged: (value) {
      },
      inputActions: TextInputAction.next,
      labelText: landAddressStr.tr,
    );
  }
  _areaInfomationEditText(){
    return CommonTextField(
      controller: controller.areaInformationEditController,
      validation: (value) {
        if (value == null || value.isEmpty) {
          return pleaseSelectItemStr.tr;
        }
        return null;
      },
      onChanged: (value) {
      },
      inputActions: TextInputAction.next,
      labelText: areaInformationStr.tr,
    );
  }


  _uploadFardPDf(){
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
                Expanded(
                    child:commonText(uploadFardStr.tr,fontSize: font_14,fontWeight: FontWeight.w400))
                ,
                getInkWell(
                  ontap: ()  {
                    _pickFardDocument();
                    controller.refreshScreen();
                  },
                  widget:
                  controller.pickFardFile!=null?Container():

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
          controller.pickFardFile!=null?_pickedFardView():Container(),
        ],
      ),
    );

  }

  _pickFardDocument()async{
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
        controller.pickFardFile=File(result.files.single.path!);
        controller.refreshScreen();
      }
    } else {
      toast(noPdfFilePickedStr.tr);
    }
  }

  _pickedFardView()
  {
    return Container(
      color: lightBlueColor,
      padding: EdgeInsets.symmetric(vertical: margin_14,horizontal: margin_10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                // assetImage(image: img_pdf,height: 20.0,width: 20.0),
                sizedBox(width: margin_10),
                Expanded(child:commonText( "${controller.pickFardFile.path.split('/').last}",color: floatingTextColor,fontSize: font_14),
                )
              ],
            ),
          ),
          getInkWell(
              ontap: (){
                controller.pickFardFile=null;
                controller.refreshScreen();
              },
              widget: Icon(Icons.close,color: floatingTextColor,))
        ],
      ),

    );
  }


  _uploadPatedarDocument(){
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
                Expanded(child: commonText(uploadPatwariReportStr.tr,fontSize: font_14,fontWeight: FontWeight.w400))
                ,
                getInkWell(
                  ontap: ()  {
                    _pickPatedarPDf();

                  },
                  widget:
                  controller.pickPatedarDocumentFile!=null?Container():

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
          controller.pickPatedarDocumentFile!=null?_pickedPatedarView():Container(),
        ],
      ),
    );

  }




  _pickPatedarPDf()async{
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
        controller.pickPatedarDocumentFile=File(result.files.single.path!);
        controller.refreshScreen();
      }

    } else {
      toast(noPdfFilePickedStr.tr);
    }
  }
  _pickedPatedarView(){
    return
      Container(
        color: lightBlueColor,
        padding: EdgeInsets.symmetric(horizontal: margin_10,vertical: margin_14),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  // assetImage(image: img_pdf,height: 20.0,width: 20.0),
                  sizedBox(width: margin_10),
                  Expanded(child:commonText( "${controller.pickPatedarDocumentFile.path.split('/').last}",color: floatingTextColor,fontSize: font_14),
                  )
                ],
              ),
            ),
            getInkWell(
                ontap: (){
                  controller.pickPatedarDocumentFile=null;
                  controller.refreshScreen();
                },
                widget: Icon(Icons.close,color: floatingTextColor,))
          ],
        ),
      );
  }

  _khewatNoEditText(){
    return CommonTextField(
      controller: controller.khewatNoEditController,
      validation: (value) {
        if (value == null || value.isEmpty) {
          return pleaseSelectItemStr.tr;
        }
        return null;
      },
      onChanged: (value) {
      },

      inputActions: TextInputAction.next,
      labelText: khewatNoStr.tr,
    );
  }


  _khatuniNumberEditText(){
    return CommonTextField(
      controller: controller.khataniNoEditController,
      validation: (value) {
        if (value == null || value.isEmpty) {
          return pleaseSelectItemStr.tr;
        }
        return null;
      },
      onChanged: (value) {
      },

      inputActions: TextInputAction.next,
      labelText: khatauniNo.tr,
    );
  }
  _khasraNUmberEditText(){
    return CommonTextField(
      controller: controller.khasraNoEditController,
      validation: (value) {
        if (value == null || value.isEmpty) {
          return pleaseSelectItemStr.tr;
        }
        return null;
      },
      onChanged: (value) {
      },

      inputActions: TextInputAction.next,
      labelText: kasraNoStr.tr,
    );
  }


  _landAddressShimmerWidget(){
    return SingleChildScrollView(
      child: Center(
        child: setPaddingAll(
          margin: margin_20,
          widget: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              sizedBox(height: height_30),
              ListView.builder(
                  itemCount: 15,
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

  /*======================================apply button========================*/
  _applyLandDetailsButton(){
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
            if(controller.formKey.currentState!.validate()) {
              if (controller.pickFardFile != null &&
                  controller.pickPatedarDocumentFile != null) {
                controller.landDetailsPostApiCall();
              }
              else {
                toast(pickRequiredFileStr.tr);
              }
            }
            else{
              toast(pleaseFillRequiredFieldStr.tr);
            }
          },
            style:ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(margin_25)
                ),
                padding: EdgeInsets.symmetric(vertical:margin_20,horizontal:margin_10)
            ),

            child: commonText(saveStr.tr,color: white,fontWeight: FontWeight.w500,fontSize: font_14,letterSpacing:1.25),
          )
      ),
    );
  }
}
