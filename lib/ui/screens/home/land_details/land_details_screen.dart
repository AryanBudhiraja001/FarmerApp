

import 'dart:io';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import '../../../constants/exports.dart';
import '../../../shimmer_effect/shimmerWidget.dart';

class LandDetailsScreen extends GetView<LandDetailsController> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(child:
    GetBuilder<LandDetailsController>(
      init: LandDetailsController(),
        builder: (controller){
          return Scaffold(
           appBar: _landDetailsAppBar(),
              body:
                  controller.isLoadingLandDetailsData.value?loader():
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child:
                  FutureBuilder(
                  future:    controller.landDetailsFutureData,
                  builder: (context,data){
                     if(data.connectionState==ConnectionState.done){
                       if(data.hasData){
                         return    controller.addLandDetailsList.isEmpty?noDataAvailable(title:addLandDetailsStr.tr):_landDetailsList();
                       }
                       if(data.hasError){
                         return noDataAvailable(title:addLandDetailsStr.tr);
                       }
                     }
                     if(data.connectionState==ConnectionState.waiting){
                       return
                        _landAddressShimmerWidget();
                     }
                     else{
                       return noDataAvailable(title:addLandDetailsStr.tr);
                     }
                     },
              )

              ),
           // _addLandButton(),

                ],)

          );
        }
        )
    );
  }



      _landDetailsList(){
       return setPadding(
         topPadding: margin_20,
         bottomPadding: margin_20,
         widget: ListView.separated(
           separatorBuilder: (context,index){
             return Container();
               // setPadding(
               //   leftPadding: margin_20,
               //   rightPadding: margin_20,
               //   widget:divider(color: dividerColor2)
               // );
           },
           shrinkWrap: true,
             itemCount:  controller.addLandDetailsList.length,
             itemBuilder: (_,index){
           return  _landDetails(index);
             }),
       );
      }

  _landDetails(index){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: margin_20,vertical: margin_8),
      decoration: BoxDecoration(
        color:lightBlueColor2,
        borderRadius: BorderRadius.circular(radius_4),
        border: Border.all(color: borderColor)
      ),
      child: Column(
        children: [
          getInkWell(
            ontap: (){
              if(controller.extendLandDetailsForm[index]!=true){
                controller.resetExtendLandDetailsForm(index);
              }
              controller.extendLandFormFun(index);
            },
            widget: setPadding(
              leftPadding: margin_20,
              rightPadding: margin_20,
              topPadding: margin_20,
              bottomPadding: margin_20,
              widget: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: commonText(controller.landDetailsDataList[index].landAddress!,fontSize: font_18,color: paragraphColor,maxLines: 1),
                  ),
                  sizedBox(width: margin_30),
                   Row(
                     children: [
                       getInkWell(
                           widget: Icon(Icons.delete_rounded,color: paragraphColor,),
                         ontap: (){
                           _deleteLandDialog(controller.landDetailsDataList[index].landAddress!,index,controller.landDetailsDataList[index].id);
                         }
                       ),
                       sizedBox(width: margin_30),
                       controller.extendLandDetailsForm[index]?Icon(Icons.expand_less,size: 30,color: paragraphColor,): Icon(Icons.expand_more,size: 30,color: paragraphColor,),
                     ],
                   )
                ],
              ),
            ),
          ),
          controller.extendLandDetailsForm[index]?_form(index):Container()
        ],
      ),
    );
  }



    _deleteLandDialog(address,index,landId){
   return    commonDialogs(
       body:
       Column(
         children: [
           Container(
             padding: EdgeInsets.all(margin_16),
             decoration: const BoxDecoration(
                 shape: BoxShape.circle,
                 color: deletebackColor
             ),
             child:const Icon(Icons.delete_outline,color: redColor,),
           ),
           sizedBox(height: margin_20),
           commonText("${confirmDeleteStr.tr}\n${"$address"}?",fontWeight: FontWeight.w400,color:subtitleColor,textHeight: 1.4,align: TextAlign.center),
           sizedBox(height: margin_20),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              getInkWell(
                ontap: (){
                  Get.back();
                },
                widget:  commonText(cancelStr.toUpperCase().tr,color:subtitleColor),
              ),

              sizedBox(width: margin_16),
              CustomButton(
                onClick: (){controller.deleteLandApiCall(landId, index);
                  Get.back();
                },
                buttonColor: deleteColor,
                cornerRadius: radius_24,
                verticalPadding: margin_12,
                horizontalPadding: margin_32,
                buttonText: deleteStr.toUpperCase().tr,
              )
            ],
          )

         ],
       )

   );
  }




  _form(index){
    return
      SingleChildScrollView(
        child: setPaddingAll(
          margin: margin_20,
          widget:
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
              sizedBox(height: margin_16),
            _updateButton(index),
              sizedBox(height: margin_24),
             divider(),
            ],
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
      labelText: stateStr.tr,
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
        selectedItem:controller.stateEditController.text==""?selectStateStr.tr:controller.stateEditController.text
    );

  }

  _districtEditText(){
    return getInkWell(
      ontap: (){
        toast(districtNotEditable.tr);
      },
      widget: CommonTextField(
        controller: controller.districtEditController,
        enable: false,
        readOnly: true,
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
      ),
    );

  }

  _districtDropDown(){
    return DropdownSearch<dynamic>(
        popupProps: const PopupProps.menu(
          fit: FlexFit.loose,
          showSelectedItems: false,
        ),
        items: controller.districtList,
        dropdownDecoratorProps: DropDownDecoratorProps(
            baseStyle:  GoogleFonts.roboto(
              textStyle:TextStyle(color: paragraphColor,fontSize: font_16,fontWeight: FontWeight.w400),),
            dropdownSearchDecoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: margin_20,vertical: margin_10),
              border: InputBorder.none,
            )
        ),
        onChanged: (value){
        //  controller.tehsilType("");
         // controller.villageType("");
          // _controller.tehsilEditController.text="";
          // _controller.villageEditController.text="";

         // controller.districtType(value);
         // var index=controller.districtList.indexOf(value);
        //  controller.selectDistrictIndexIdFun(index);
        //  controller.tehsilList.clear();
         // controller.tehsilIdList.clear();


          /*==================    get tehsil list  of district selected=================*/
         // controller.getTehsilData(controller.selectedDistrictIndex.value);controller.selectDistrictTypeIdFun(controller.districtIdList[index]);
         // controller.selectDistrictIdFun(controller.selectDistrictTypeId.value);

        },
        selectedItem:controller.districtEditController.text==""?selectDistrictTypeStr:controller.districtEditController.text
    );

  }


  _tehsilEditText(){
    return getInkWell(
      ontap: (){
        toast(tehsilNotEditable.tr);
      },
      widget: CommonTextField(
        controller: controller.tehsilEditController,
        enable: false,
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
      ),
    );

  }
  _tehsilDropDown(){
    return DropdownSearch<dynamic>(
        popupProps: const PopupProps.menu(
          fit: FlexFit.loose,
          showSelectedItems: false,
        ),
        items:controller.tehsilList,
        dropdownDecoratorProps: DropDownDecoratorProps(
            baseStyle:  GoogleFonts.roboto(
              textStyle:TextStyle(color: paragraphColor,fontSize: font_16,fontWeight: FontWeight.w400),),
            dropdownSearchDecoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: margin_20,vertical: margin_10),
              border: InputBorder.none,
            )
        ),
        onChanged: (value){
          // controller.villageType("");
          // var index=controller.tehsilList.indexOf(value);
          // controller.tehsilEditController.text=value;
          // controller.selectVillageTypeId.value=index;
          // controller.villageList.clear();
          // controller.villageIdList.clear();
          // controller.selecttehsilIndexIdFun(index);
          // controller.getVillageData(controller.selectedTehsilIndex.value,
          //     controller.selectedDistrictIndex.value);
          //
          // controller.selectTehsilTypeIdFun(controller.tehsilIdList[index]);
          //
          // controller.selectTehsilIdFun(controller.selectTehsilTypeId.value);



        },
        selectedItem:controller.tehsilEditController.text==""?selectTehsilStr.tr:controller.tehsilEditController.text
    );

  }

  _villageCityEditText(){
    return getInkWell(
      ontap: (){
        toast(villageNotEditable.tr);
      },
      widget: CommonTextField(
        controller:controller.villageEditController,
        enable: false,
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
      ),
    );

  }

  _villageDropDown(){
    return DropdownSearch<dynamic>(
        popupProps: const PopupProps.menu(
          fit: FlexFit.loose,
          showSelectedItems: false,
        ),
        items: controller.villageList,
        dropdownDecoratorProps: DropDownDecoratorProps(
            baseStyle:  GoogleFonts.roboto(
              textStyle:TextStyle(color: paragraphColor,fontSize: font_16,fontWeight: FontWeight.w400),),
            dropdownSearchDecoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: margin_20,vertical: margin_10),
              border: InputBorder.none,
            )
        ),
        onChanged: (value){
          // controller.villageEditController.text=value;
          // var index=controller.villageList.indexOf(value);
          // controller.selectVillageTypeIdFun(controller.villageIdList[index]);
          // controller.selectVillageIdFun(controller.selectVillageTypeId.value);
          // debugPrint("select value${controller.villageIdList[index]}");
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
      labelText: fullAddressStr.tr,
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
                Expanded(child:commonText(uploadFardStr.tr,fontSize: font_14,fontWeight: FontWeight.w400))
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
          controller.isPickedFardFile.value=true;
          controller.pickFardFile=File(result.files.single.path!);
          controller.isPickedFardFile.value=true;
          controller.refreshScreen();
        }

    }
    else {
      toast(noPdfFilePickedStr.tr);
    }
  }

  _pickedFardView(){
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
                Expanded(child:commonText(uploadPatwariReportStr.tr,fontSize: font_14,fontWeight: FontWeight.w400),
                ),
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
        controller.isPickedPatedarDocumentFile.value=true;
        controller.pickPatedarDocumentFile=File(result.files.single.path!);
       controller.isPickedPatedarDocumentFile.value=true;
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







  _landDetailsAppBar(){
    return AppBar(
      centerTitle: false,
      leading: null,
      automaticallyImplyLeading: false,
      actions: [
        getInkWell(
          ontap: (){
      Get.toNamed(Routes().landDetailsFields)!.then((value) {
        controller.landDetailsFilled.value=value;
        if(controller.landDetailsFilled.value==true){
          controller.addLandDetailsList.clear();
          controller.extendLandDetailsForm.clear();
          controller.landDetailsDataList.clear();
          controller.fetchLandDetails();
          controller.refreshScreen();
          }
      });
      },
          widget: Align(
            alignment: Alignment.center,
            child:     setPadding(
              rightPadding: margin_20,
              widget: Row(
                children: [
                  Icon(Icons.add),
                  commonText(addLandStr.tr.toUpperCase(), color: white, fontSize: font_14),
                ],
              )

            ),
          ),
        )


      ],
      title: Row(
        children: [
          getInkWell(
              widget:Icon(Icons.arrow_back,color: white,),
              ontap: (){
                Get.back(result:controller.landDetailsFilled.value);
              }
          ),
          sizedBox(width: margin_20) ,
          commonText(landDetailsStr.tr, color: white, fontSize: font_20),



        ],
      ),
      backgroundColor: secondaryColor,
    );


  }





























/*======================================update button ========================*/
  _updateButton(index){
    return
        setPadding(
          leftPadding: margin_20,
          rightPadding: margin_20,
          widget: Container(
            width: 100,
            child: ElevatedButton(onPressed: (){
             controller.updateLandDetailsPostApiCall(index);


              // Get.toNamed(Routes().landDetailsFields)!.then((value) {
              //   _controller.landDetailsFilled.value=value;
              //   if(_controller.landDetailsFilled.value==true){
              //     _controller.refreshScreen();
              //   }
              // });
            },
                style:ElevatedButton.styleFrom(

                    backgroundColor: updateButtonColor,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: primaryColor),
                      borderRadius: BorderRadius.circular(margin_25),
                    ),
                    padding: EdgeInsets.symmetric(vertical:margin_16,horizontal:margin_10)
                ),
                child:    commonText(updateStr.tr.toUpperCase(),color: white,fontSize: font_14,letterSpacing:1.25),


            ),
          ) );
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
