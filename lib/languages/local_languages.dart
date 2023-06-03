import '../ui/constants/exports.dart';

class Languages extends Translations {
  @override
  Map<String, Map<String,String>> get keys =>
      {
        'en_US': {
          'homeStr1': 'Hello World',
   APP_NAME:"Kisan-e-Bagbani",

/*::::::::::::::::::::::::::::login texts:::::::::::::::::::::::::::::::*/
  loginStr:"Login",
  welcomeStr:"Welcome!",
  welcome:"Welcome!",
  enterProductNameStr:"Enter Product Name",
  enterProductPriceStr:"Enter Product Price",
  productDetailsStr:"Enter Product Details",
  addItemStr:"Add Item",
  productStr:"Product",
   emailStr:"Email",
   passwordStr:"Password",
   registerStr:"REGISTER",
   forgetPassStrQ:"Forget Password?",
   forgetPassStr:"Forget Password",
   alreadyAppliedStr:"Applied",


/*::::::::::::::::::::::::::::forgetPassword texts:::::::::::::::::::::::::::::::*/
   sendStr:"Send",


/*::::::::::::::::::::::::::::register texts:::::::::::::::::::::::::::::::*/
   phoneStr:"Phone",
   registerSuccessfullyStr:"Register successfully",


/*::::::::::::::::::::::::::::validations texts:::::::::::::::::::::::::::::::*/
   loginSuccessfullyStr:"login successfully",
   validEmailStr:'Enter a valid email address',
   validPasswordStr:'Password Length should not be less than 8',
   validMobileStr:'PLease enter valid mobile number',
   appicantTypeValidationStr:'Please Select Applicant Type',
   appicantTypeNameStr:'Please add Applicant Name',
   pleaseFillFieldStr:'Please Fill This Field',
   pleaseFillRequiredFieldStr:'Please Fill Required Field Correctly',
   pleaseSelectItemStr:'Please Select Item',
   pleaseEnterValidAccountStr:'Please Enter Valid Account No.',
   aadharLengthStr:'Please Enter valid Aadhaar Card',
   validPin:'Please Enter valid pin',
   ifscCode:'Please Enter valid IFSC Code',
   validPan:'Please Enter valid Pan Number',
   pleasePickImage:"please Pick profile Image",
   accountNumberNotMatchedStr:"Account Number Not Matched",


/*::::::::::::::::::::::::::::select language texts:::::::::::::::::::::::::::::::*/
   englishStr:"English",
   punjabiStr:"ਪੰਜਾਬੀ",
   hindiStr:"हिन्दी",
   selectLanguageStr:"Select language",
   farmerRegisterStr:"Farmer Registration",


/*::::::::::::::::::::::::::::register texts:::::::::::::::::::::::::::::::*/
   mobileNumberStr:"Mobile number",
   getOtpStr:"GET OTP",
   alreadyStr:"Already have an account?",
   preTextPhoneStr:"(+91) ",


/*::::::::::::::::::::::::::::enter otp texts:::::::::::::::::::::::::::::::*/
   notReceiveStr:"Don't receive OTP?",
   resendStr:"Resend",
   enterTheOtpStr:"Enter the OTP",
   receiveInStr:"received in your number",
   userVerifiedStr:"user verified",
   enterValidOtpStr:"enter valid otp",


/*::::::::::::::::::::::::::::farmer login texts:::::::::::::::::::::::::::::::*/
   farmerLoginStr:"Farmer Login",
   notHaveAccountStr:"Don't have account?",
   registerNowStr:"Register now",
   verifyStr:"VERIFY",

/*::::::::::::::::::::::::::::home Screen texts:::::::::::::::::::::::::::::::*/
   mainTitleStr:"Explore schemes",
   homeStr:"Home",
   schemesStr:"Schemes",
   mandiRateStr:"Mandi Rate",
   videoFeedStr:"Video Feed",
   cartStr:"Cart",
   profileStr:"Profile",

/*::::::::::::::::::::::::::::explore  Screen texts:::::::::::::::::::::::::::::::*/
   exploreSchemesTitleStr:"Explore schemes",

/*::::::::::::::::::::::::::::profile  Screen texts:::::::::::::::::::::::::::::::*/
   galleryStr:"Gallery",
   cameraStr:"Camera",
   pickImageStr:"Choose Options",
   applicantStr:"Applicant type",
   applicantNameStr:"Applicant name",
   applicantFatherNameStr:"Father's/Husband Name",
   residentStr:"Resident",
   indianStr:"Indian",
   punjabStr:"Punjab",
   applicantGrandFatherNameStr:"Grand Father's Name",
   genderStr:"Gender",
   maleStr:"Male",
   femaleStr:"Female",
   othersStr:"Others",
   aadhaarNoStr:"Aadhaar No",
   panNoStr:"PAN No",
   casteStr:"Caste Category",
   scStr:"SC",
   generalStr:"General",
   bcStr:"BC",
   stateStr:"State",
   districtStr:"District",
   tehsilStr:"Block",
   villageStr:"Village/City",
   fullAddressStr:"Full Address",
   pinCodeStr:"Pin Code",
   saveStr:"Save",
   proceedStr:"Proceed",
   continueStr:"Continue",
   completeStr:"Complete",
   profileInfoStr:"Profile Info",
   updatePersonalInfoStr:"Update Profile",
   updateAddressStr:"Update Address",
   addressStr:"Address",
   selectApplicantTypeStr:"Select Applicant Type",
   selectCategoryTypeStr:"Select caste category",
   selectDistrictTypeStr:"Select District",
   selectStateStr:"Select State",
   selectGenderStr:"Select Gender",
   selectResidentStr:"Select Resident",
   selectTehsilStr:"Select Tehsil",
   selectCityVillageStr:"Select City/Village",


/*::::::::::::::::::::::::::::schemes details   Screen texts:::::::::::::::::::::::::::::::*/
   schemesDetailsStr:"Schemes Details",
   titleSchemes:"Schemes Details",
   knowMoreStr:"KNOW MORE",
   applyStr:"APPLY",
   proceedstr:"Proceed",
   requiredDocumentStr:"Required Documents",
   noVideoAvailStr:"No Videos Available",
   videosStr:"Videos",



/*::::::::::::::::::::::::::::drawer details   Screen texts:::::::::::::::::::::::::::::::*/

   notificationsStr:"Notifications",
   personalInfoStr:"Personal Info",
   languagePreferenceStr:"Language preference",
   logoutStr:"Log Out",


/*::::::::::::::::::::::::::::home Screen texts:::::::::::::::::::::::::::::::*/
   seeAllStr:"SEE ALL",
   featuresSchemesStr:"Feature Schemes",
   mandiPriceStr:"Mandi Price",
   viewAllStr:"VIEW ALL",
   todayInformation:"Today's Jankari",
   languagesPreferenceStr:"Language preference",
   callToActionStr:"CALL TO ACTION",
   publicStr:"Public",
   privateStr:"Private",


/*::::::::::::::::::::::::::::mandi Rate Screen:::::::::::::::::::::::::::::::*/
   selectCommodityStr:"Select\nCommodity :",
   quantalStr:"/quintal",
   miniPriceStr:"Minimum\nPrice",
   averagePriceStr:"Average\nPrice",
   maxPriceStr:"Maximum\nPrice",

/*::::::::::::::::::::::::::::today weather  Screen:::::::::::::::::::::::::::::::*/
   todayWeatherStr:"Today's Weather",
   weeklyForeCastStr:"Weekly Forecast",



   updateProfileStr:"Update Profile",
   pleaseSelectCategoryStr:"Please select category",

/*::::::::::::::::::::::::::::complete details screen:::::::::::::::::::::::::::::::*/
   completeDetailsStr:"Complete Details",
   incompleteDetailsStr:"Incomplete Details",
   bankDetailsStr:"Bank Details",
   landDetailsStr:"Land Details",
   subDetailsStr:"You need to fill out the following forms and upload the documents before applying to any scheme",

/*::::::::::::::::::::::::::::schemes tracking  screen:::::::::::::::::::::::::::::::*/
   applicationStatusStr:"Application Status",
   committeeStr:"Committee",
   approvedStr:"Approved",
   applicationsInformationStr:"Application Information",
   landAddressStr:"Land Address",
   dateAppliedStr:"Date Applied",
   applicationNoStr:"Application No.",
   typeOFSchemesStr:"Type Of Scheme",
   subsidyTypeStr:" Subsidy Type",
   currentlyReviewingByStr:"Currently Reviewing By",


  /*:::::::::::::::bank details screen:::::::::::::::::::::::::::::::*/
   bankNameStr:"Bank Name",
   ifscCodeStr:"IFSC Code",
   branchNameStr:"Branch Name",
   accountNumberStr:"Account Number",
   confirmAccountNumberStr:" Confirm Account Number",
   nameOfFarmerStr:"Name of the farmer in the Bank A/C",
   bankBranchAddressStr:"Bank Branch Address",
   uploadStr:"Upload",
   uploadCancelCheckStr:"Upload Cancel Cheque",
   uploadBankPassbookStr:"Upload Bank Passbook",
   noPdfFilePickedStr:"No PDF File Picked",

/*:::::::::::::::land Details details screen:::::::::::::::::::::::::::::::*/

   areaHeatareStr:"Total Land Area(hectare)",
   landSurveyStr:"Land Survey Number",
   areaInformationStr:"Area Information",
   patedarStr:"Pattedar No",
   uploadFardStr:"Upload Fard/R.O.R Document",
          uploadPatwariReportStr:"Upload Patwari/Namberdar Report",
   khewatNoStr:"Khewat No./Khata No.",
   khatauniNo:"Khatauni No",
   kasraNoStr:"Khasra No/Plot No.",
   addLandStr:"Add Land",
   landAddress1Str:"Land Address 1",


/*:::::::::::::::upload Documents  details screen:::::::::::::::::::::::::::::::*/
   proceedApplyStr:"Proceed to Apply",
   landAreaApplyStr:"How much land area you apply for? (Hectare)",
   uploadDocumentStr:"Upload Documents",
   downloadDocumentStr:"Download,Print,Fill,Upload",
   scanDocumentStr:"Scan Document and Upload",


/*:::::::::::::::my schemes screen:::::::::::::::::::::::::::::::*/
   mySchemesStr:"My Schemes",



/*:::::::::::::::add land fields data screen:::::::::::::::::::::::::::::::*/
   addLandDetailsStr:"Add Land Details",
   noRecordAvailStr:"No Record Found",
   selectComponentStr:"Select Component",
   selectSubComponentStr:"Select SubComponent",
   updateStr:"Update",
   editStr:"Edit",
   deleteStr:"Delete",
   confirmDeleteStr:"Do You Want to delete",
   cancelStr:"Cancel",

/*:::::::::::::::my schemes:::::::::::::::::::::::::::::::*/
   applicationStr:"Application no",
   statusOfSchemesStr:"Status of Schemes",
   locationStr:"Location",
   stageStr:"Stage",


/*:::::::::::::::explore schemes:::::::::::::::::::::::::::::::*/
   showFilterStr:"Show Filter",
   showLessStr:"Show Less",
   searchStr:"Search",
   allStr:"All",
   noDataAvailStr:"No Data Available",
   noSchemesAppliedStr:"No applied Schemes",
   noFeaturesSchemesStr:"No Features Schemes Available",
   noSchemesStr:"No Schemes Available",
   noRequiredDocumentStr:"No Required Document Available",
   privateSubStr:"Private:",
   publicSubStr:"Public:",
   nextPageStr:"Next Page",
   prevPageStr:"Prev Page",
   reApplyStr:"ReSubmit",

   tehsilOfficerStr:"Tehsil Officer",
   districtOfficerStr:"District Officer",
   checkIssuesStr:"Check Issues",
   checkReasonButtonStr: "Reason of rejection",
   downloadingStr: "Downloading...",
   downloadStr: "Download",
   retryStr: "Retry",
   farmerNameDummyStr: "null",
   issuesDesStr: "Your application have some issues, Fix them and upload then under 7 days",
   requiredStr:"Required *",
          mobileNumberAlreadyExistStr:"Mobile Number not registered",
   costNormsStr:"Cost Norms: ",
   subsidyStr:"Subsidy",
   detailedDesciptionStr:"Detailed Description",
   noDesAvailStr:"No Description Available",
   completeDocStr:"complete documents",
   fileWarningStr:"File size should not be greater than 5mb",
   pickRequiredFileStr:"Please pick required pdf file",
   successfullyAddedStr:"Successfully Added",
   villageNotEditable:"Village Not Editable",
   districtNotEditable:"District Not Editable",
   tehsilNotEditable:"Tehsil Not Editable",
   fileNotDownloadedStr:"file not downloaded",

   varietyStr:"Variety:",
   dateStr:"Date:",
   mandiStr:"Mandi",

   tooManyOtpWarningStr:"too many requests for otp on this number,sent otp on another number",

   otpSendStr:"OTP sent",
   somethingWrongStr:"Something went wrong",
   otpResendStr:"OTP resent",
   invalidPhoneStr:'The provided phone number is not valid.',
   cloudsStr:"Clouds",
   viewsStr:"Views",
   tokenExpiredStr:"Token expired",
   pleaseEnableLocationsStr:"Please enable location",
   noTimeAvailStr:"No Time Available",

   landDetailsAddedStr:"Land Detail added Successfully",
   noComAvailStr: "No Component Available",
   noCategoryAvailStr:"No category available",
   subSchemesStr:"SubSchemes",
   selectStr:"Select",
   applicationsStr:"Application ",
   daysStr:"Days",
   ihrmStr:'IHRM:',
   landUpdatedStr:"Land Details Updated Successfully",
   todayStr:"Today",
   detailsOfExpenditureStr:"Details of Expenditure(With Bills)",
   applicationsFormStr:"Applications Form/DPR",
   selfDeclarationStr:"Self Declaration",
          resentOtpInStr:"Resend OTP in"


},
        'pa_IN': {
          'homeStr1': 'ਸਤ ਸ੍ਰੀ ਅਕਾਲ',
         APP_NAME:'ਕਿਸਾਨ-ਏ-ਬਾਗਬਾਣੀ',
        loginStr:"ਲਾਗਿਨ",
       welcomeStr:"ਜੀ ਆਇਆਂ ਨੂੰ!",
     welcome:"ਜੀ ਆਇਆਂ ਨੂੰ!",
   enterProductNameStr:"ਉਤਪਾਦ ਦਾ ਨਾਮ ਦਰਜ ਕਰੋ",
   enterProductPriceStr:"ਉਤਪਾਦ ਦੀ ਕੀਮਤ ਦਰਜ ਕਰੋ",
   productDetailsStr:"ਉਤਪਾਦ ਵੇਰਵੇ ਦਰਜ ਕਰੋ",
  addItemStr:"ਆਈਟਮ ਸ਼ਾਮਲ ਕਰੋ",
  productStr:"ਉਤਪਾਦ",
  emailStr:"ਈ - ਮੇਲ",
  passwordStr:"ਪਾਸਵਰਡ",
  registerStr:"ਰਜਿਸਟਰ",
  forgetPassStrQ:"ਪਾਸਵਰਡ ਭੁੱਲ ਗਏ ਹੋ?",
  forgetPassStr:"ਪਾਸਵਰਡ ਭੁੱਲ ਗਏ ਹੋ",
  alreadyAppliedStr:"ਲਾਗੂ ਕੀਤਾ",


/*::::::::::::::::::::::::::::forgetPassword texts:::::::::::::::::::::::::::::::*/
  sendStr:"ਭੇਜੋ",


/*::::::::::::::::::::::::::::register texts:::::::::::::::::::::::::::::::*/
  phoneStr:"ਫ਼ੋਨ",
  registerSuccessfullyStr:"ਸਫਲਤਾਪੂਰਵਕ ਰਜਿਸਟਰ ਕਰੋ",


/*::::::::::::::::::::::::::::validations texts:::::::::::::::::::::::::::::::*/
  loginSuccessfullyStr:"ਸਫਲਤਾਪੂਰਵਕ ਲੌਗਇਨ ਕਰੋ",
  validEmailStr:'ਇੱਕ ਵੈਧ ਈਮੇਲ ਪਤਾ ਦਰਜ ਕਰੋ',
  validPasswordStr:'ਪਾਸਵਰਡ ਦੀ ਲੰਬਾਈ 8 ਤੋਂ ਘੱਟ ਨਹੀਂ ਹੋਣੀ ਚਾਹੀਦੀ',
  validMobileStr:'ਕਿਰਪਾ ਕਰਕੇ ਵੈਧ ਮੋਬਾਈਲ ਨੰਬਰ ਦਾਖਲ ਕਰੋ',
  appicantTypeValidationStr:'ਕਿਰਪਾ ਕਰਕੇ ਬਿਨੈਕਾਰ ਦੀ ਕਿਸਮ ਚੁਣੋ',
  appicantTypeNameStr:'ਕਿਰਪਾ ਕਰਕੇ ਬਿਨੈਕਾਰ ਦਾ ਨਾਮ ਸ਼ਾਮਲ ਕਰੋ',
  pleaseFillFieldStr:'ਕਿਰਪਾ ਕਰਕੇ ਇਸ ਖੇਤਰ ਨੂੰ ਭਰੋ',
  pleaseFillRequiredFieldStr:'ਕਿਰਪਾ ਕਰਕੇ ਲੋੜੀਂਦੇ ਖੇਤਰਾਂ ਨੂੰ ਸਹੀ ਢੰਗ ਨਾਲ ਭਰੋ',
  pleaseSelectItemStr:'ਕਿਰਪਾ ਕਰਕੇ ਆਈਟਮ ਦੀ ਚੋਣ ਕਰੋ',
  pleaseEnterValidAccountStr:'ਕਿਰਪਾ ਕਰਕੇ ਵੈਧ ਖਾਤਾ ਨੰਬਰ ਦਰਜ ਕਰੋ।',
  aadharLengthStr:'ਕਿਰਪਾ ਕਰਕੇ ਵੈਧ ਆਧਾਰ ਕਾਰਡ ਦਰਜ ਕਰੋ',
  validPin:'ਕਿਰਪਾ ਕਰਕੇ ਵੈਧ ਪਿੰਨ ਦਾਖਲ ਕਰੋ',
  ifscCode:'ਕਿਰਪਾ ਕਰਕੇ ਵੈਧ IFSC ਕੋਡ ਦਾਖਲ ਕਰੋ',
  validPan:'ਕਿਰਪਾ ਕਰਕੇ ਵੈਧ ਪੈਨ ਨੰਬਰ ਦਰਜ ਕਰੋ',
  pleasePickImage:"ਕਿਰਪਾ ਕਰਕੇ ਪ੍ਰੋਫਾਈਲ ਚਿੱਤਰ ਚੁਣੋ",
  accountNumberNotMatchedStr:"ਖਾਤਾ ਨੰਬਰ ਮੇਲ ਨਹੀਂ ਖਾਂਦਾ",


/*::::::::::::::::::::::::::::select language texts:::::::::::::::::::::::::::::::*/
  englishStr:"English",
  punjabiStr:"ਪੰਜਾਬੀ",
  hindiStr:"हिन्दी",
  selectLanguageStr:"ਭਾਸ਼ਾ ਚੁਣੋ",
  farmerRegisterStr:"ਕਿਸਾਨ ਰਜਿਸਟ੍ਰੇਸ਼ਨ",


/*::::::::::::::::::::::::::::register texts:::::::::::::::::::::::::::::::*/
  mobileNumberStr:"ਮੋਬਾਇਲ ਨੰਬਰ",
  getOtpStr:"OTP ਪ੍ਰਾਪਤ ਕਰੋ",
  alreadyStr:"ਕੀ ਪਹਿਲਾਂ ਤੋਂ ਹੀ ਖਾਤਾ ਹੈ?",
  preTextPhoneStr:"(+91) ",


/*::::::::::::::::::::::::::::enter otp texts:::::::::::::::::::::::::::::::*/
  notReceiveStr:"ਕੀ OTP ਪ੍ਰਾਪਤ ਨਹੀਂ ਹੋਇਆ?",
  resendStr:"ਦੁਬਾਰਾ ਭੇਜੋ",
  enterTheOtpStr:"OTP ਦਾਖਲ ਕਰੋ",
  receiveInStr:"ਤੁਹਾਡੇ ਨੰਬਰ ਵਿੱਚ ਪ੍ਰਾਪਤ ਹੋਇਆ",
  userVerifiedStr:"ਉਪਭੋਗਤਾ ਪ੍ਰਮਾਣਿਤ",
  enterValidOtpStr:"ਵੈਧ otp ਦਰਜ ਕਰੋ",


/*::::::::::::::::::::::::::::farmer login texts:::::::::::::::::::::::::::::::*/
  farmerLoginStr:"ਕਿਸਾਨ ਲੌਗਇਨ",
  notHaveAccountStr:"ਕੀ ਤੁਹਾਡੇ ਕੋਲ ਖਾਤਾ ਨਹੀਂ ਹੈ?",
  registerNowStr:"ਹੁਣੇ ਦਰਜ ਕਰਵਾਓ",
  verifyStr:"ਤਸਦੀਕ ਕਰੋ",

/*::::::::::::::::::::::::::::home Screen texts:::::::::::::::::::::::::::::::*/
  mainTitleStr:"ਸਕੀਮਾਂ ਦੀ ਪੜਚੋਲ ਕਰੋ",
  homeStr:"ਹੋਮ",
  schemesStr:"ਸਕੀਮਾਂ",
  mandiRateStr:"ਮੰਡੀ ਰੇਟ",
  videoFeedStr:"ਵੀਡੀਓ ਫੀਡ",
  cartStr:"ਕਾਰਟ",
  profileStr:"ਪ੍ਰੋਫਾਈਲ",

/*::::::::::::::::::::::::::::explore  Screen texts:::::::::::::::::::::::::::::::*/
  exploreSchemesTitleStr:"ਸਕੀਮਾਂ ਦੀ ਪੜਚੋਲ ਕਰੋ",

/*::::::::::::::::::::::::::::profile  Screen texts:::::::::::::::::::::::::::::::*/
  galleryStr:"ਗੈਲਰੀ",
  cameraStr:"ਕੈਮਰਾ",
  pickImageStr:"ਵਿਕਲਪ ਚੁਣੋ",
  applicantStr:"ਬਿਨੈਕਾਰ ਦੀ ਕਿਸਮ",
  applicantNameStr:"ਬਿਨੈਕਾਰ ਦਾ ਨਾਮ",
  applicantFatherNameStr:"ਪਿਤਾ/ਪਤੀ ਦਾ ਨਾਮ",
  residentStr:"ਨਿਵਾਸੀ",
  indianStr:"ਭਾਰਤੀ",
  punjabStr:"ਪੰਜਾਬ",
  applicantGrandFatherNameStr:"ਦਾਦਾ ਪਿਤਾ ਦਾ ਨਾਮ",
  genderStr:"ਲਿੰਗ",
  maleStr:"ਨਰ",
  femaleStr:"ਔਰਤ",
  othersStr:"ਹੋਰ",
  aadhaarNoStr:"ਆਧਾਰ ਨੰ",
  panNoStr:"ਪੈਨ ਨੰਬਰ",
  casteStr:"ਜਾਤੀ ਸ਼੍ਰੇਣੀ",
  scStr:"SC",
  generalStr:"General",
  bcStr:"BC",
  stateStr:"ਰਾਜ",
  districtStr:"ਜ਼ਿਲ੍ਹਾ",
  tehsilStr:"ਬਲਾਕ",
  villageStr:"ਪਿੰਡ/ਸ਼ਹਿਰ",
  fullAddressStr:"ਪੂਰਾ ਪਤਾ",
  pinCodeStr:"ਪਿੰਨ ਕੋਡ",
  saveStr:"ਸੇਵ ਕਰੋ",
  proceedStr:"ਅੱਗੇ ਵਧੋ",
  continueStr:"ਜਾਰੀ ਰੱਖੋ",
  completeStr:"ਸੰਪੂਰਨ",
  profileInfoStr:"ਪ੍ਰੋਫਾਈਲ ਜਾਣਕਾਰੀ",
  updatePersonalInfoStr:"ਪ੍ਰੋਫਾਈਲ ਅੱਪਡੇਟ ਕਰੋ",
  updateAddressStr:"ਪਤਾ ਅੱਪਡੇਟ ਕਰੋ",
  addressStr:"ਪਤਾ",
  selectApplicantTypeStr:"ਬਿਨੈਕਾਰ ਦੀ ਕਿਸਮ ਚੁਣੋ",
  selectCategoryTypeStr:"ਜਾਤੀ ਸ਼੍ਰੇਣੀ ਚੁਣੋ",
  selectDistrictTypeStr:"ਜ਼ਿਲ੍ਹਾ ਚੁਣੋ",
  selectStateStr:"ਰਾਜ ਚੁਣੋ",
  selectGenderStr:"ਲਿੰਗ ਚੁਣੋ",
  selectResidentStr:"ਨਿਵਾਸੀ ਚੁਣੋ",
  selectTehsilStr:"ਤਹਿਸੀਲ ਚੁਣੋ",
  selectCityVillageStr:"ਸ਼ਹਿਰ/ਪਿੰਡ ਚੁਣੋ",


/*::::::::::::::::::::::::::::schemes details   Screen texts:::::::::::::::::::::::::::::::*/
  schemesDetailsStr:"ਸਕੀਮਾਂ ਦੇ ਵੇਰਵੇ",
  titleSchemes:"ਸਕੀਮਾਂ ਦੇ ਵੇਰਵੇ",
  knowMoreStr:"ਹੋਰ ਜਾਣੋ",
  applyStr:"ਅਪਲਾਈ ਕਰੋ",
  proceedstr:"ਅੱਗੇ ਵਧੋ",
  requiredDocumentStr:"ਲੋੜੀਂਦੇ ਦਸਤਾਵੇਜ਼",
  noVideoAvailStr:"ਕੋਈ ਵੀਡੀਓ ਉਪਲਬਧ ਨਹੀਂ ਹੈ",
  videosStr:"ਵੀਡੀਓ",



/*::::::::::::::::::::::::::::drawer details   Screen texts:::::::::::::::::::::::::::::::*/

  notificationsStr:"ਸੂਚਨਾਵਾਂ",
  personalInfoStr:"ਨਿੱਜੀ ਜਾਣਕਾਰੀ",
  languagePreferenceStr:"ਭਾਸ਼ਾ ਦੀ ਤਰਜੀਹ",
  logoutStr:"ਲਾੱਗ ਆਊਟ, ਬਾਹਰ ਆਉਣਾ",


/*::::::::::::::::::::::::::::home Screen texts:::::::::::::::::::::::::::::::*/
  seeAllStr:"ਸਭ ਦੇਖੋ",
  featuresSchemesStr:"ਫੀਚਰ ਸਕੀਮਾਂ",
  mandiPriceStr:"ਮੰਡੀ  ਕੀਮਤ",
  viewAllStr:"ਸਭ ਦੇਖੋ",
  todayInformation:"ਅੱਜ ਦੀ ਜਾਣਕਾਰੀ",
  languagesPreferenceStr:"ਭਾਸ਼ਾ ਦੀ ਤਰਜੀਹ",
  callToActionStr:"ਕਾਰਵਾਈ ਕਰਨ ਲਈ ਕਾਲ ਕਰੋ",
  publicStr:"ਜਨਤਕ",
  privateStr:"ਨਿਜੀ",

/*::::::::::::::::::::::::::::mandi Rate Screen:::::::::::::::::::::::::::::::*/
  selectCommodityStr:"ਵਸਤੂ ਚੁਣੋ:",
  quantalStr:"/ ਕੁਇੰਟਲ",
  miniPriceStr:"ਘੱਟੋ-ਘੱਟ ਕੀਮਤ",
  averagePriceStr:"ਔਸਤ ਕੀਮਤ",
  maxPriceStr:"ਅਧਿਕਤਮ ਕੀਮਤ",

/*::::::::::::::::::::::::::::today weather  Screen:::::::::::::::::::::::::::::::*/
  todayWeatherStr:"ਅੱਜ ਦਾ ਮੌਸਮ",
  weeklyForeCastStr:"ਹਫਤਾਵਾਰੀ ਪੂਰਵ ਅਨੁਮਾਨ",



  updateProfileStr:"ਪ੍ਰੋਫਾਈਲ ਅੱਪਡੇਟ ਕਰੋ",
  pleaseSelectCategoryStr:"ਕਿਰਪਾ ਕਰਕੇ ਸ਼੍ਰੇਣੀ ਚੁਣੋ",

/*::::::::::::::::::::::::::::complete details screen:::::::::::::::::::::::::::::::*/
  completeDetailsStr:"ਪੂਰਾ ਵੇਰਵਾ",
  incompleteDetailsStr:"ਅਧੂਰੇ ਵੇਰਵੇ",
  bankDetailsStr:"ਬੈਂਕ ਵੇਰਵੇ",
  landDetailsStr:"ਜ਼ਮੀਨ ਦੇ ਵੇਰਵੇ",
  subDetailsStr:"ਕਿਸੇ ਵੀ ਸਕੀਮ ਵਿੱਚ ਅਪਲਾਈ ਕਰਨ ਤੋਂ ਪਹਿਲਾਂ ਤੁਹਾਨੂੰ ਹੇਠਾਂ ਦਿੱਤੇ ਫਾਰਮ ਨੂੰ ਭਰਨਾ ਪਵੇਗਾ ਅਤੇ ਦਸਤਾਵੇਜ਼ ਅਪਲੋਡ ਕਰਨੇ ਪੈਣਗੇ",

/*::::::::::::::::::::::::::::schemes tracking  screen:::::::::::::::::::::::::::::::*/
  applicationStatusStr:"ਐਪਲੀਕੇਸ਼ਨ ਸਥਿਤੀ",
  committeeStr:"ਕਮੇਟੀ",
  approvedStr:"ਨੂੰ ਮਨਜ਼ੂਰੀ ਦਿੱਤੀ",
  applicationsInformationStr:"ਐਪਲੀਕੇਸ਼ਨ ਜਾਣਕਾਰੀ",
  landAddressStr:"ਜ਼ਮੀਨ ਦਾ ਪਤਾ",
  dateAppliedStr:"ਲਾਗੂ ਹੋਣ ਦੀ ਮਿਤੀ",
  applicationNoStr:"ਐਪਲੀਕੇਸ਼ਨ ਨੰ.",
  typeOFSchemesStr:"ਸਕੀਮ ਦੀ ਕਿਸਮ",
  subsidyTypeStr:" ਸਬਸਿਡੀ ਦੀ ਕਿਸਮ",
  currentlyReviewingByStr:"ਇਸ ਸਮੇਂ ਦੁਆਰਾ ਸਮੀਖਿਆ ਕੀਤੀ ਜਾ ਰਹੀ ਹੈ",


  /*:::::::::::::::bank details screen:::::::::::::::::::::::::::::::*/
  bankNameStr:"ਬੈਂਕ ਦਾ ਨਾਮ",
  ifscCodeStr:"IFSC ਕੋਡ",
  branchNameStr:"ਸ਼ਾਖਾ ਦਾ ਨਾਮ",
  accountNumberStr:"ਅਕਾਊਂਟ ਨੰਬਰ",
  confirmAccountNumberStr:" ਖਾਤਾ ਨੰਬਰ ਦੀ ਪੁਸ਼ਟੀ ਕਰੋ",
  nameOfFarmerStr:"ਬੈਂਕ A/C ਵਿੱਚ ਕਿਸਾਨ ਦਾ ਨਾਮ",
  bankBranchAddressStr:"ਬੈਂਕ ਸ਼ਾਖਾ ਦਾ ਪਤਾ",
  uploadStr:" ਅੱਪਲੋਡ ਕਰੋ",
  uploadCancelCheckStr:"ਅਪਲੋਡ ਰੱਦ ਕਰੋ ਚੈੱਕ",
  uploadBankPassbookStr:"ਬੈਂਕ ਪਾਸਬੁੱਕ ਅੱਪਲੋਡ ਕਰੋ",
  noPdfFilePickedStr:"ਕੋਈ PDF ਫਾਈਲ ਨਹੀਂ ਚੁਣੀ ਗਈ",

/*:::::::::::::::land Details details screen:::::::::::::::::::::::::::::::*/

  areaHeatareStr:"ਕੁੱਲ ਜ਼ਮੀਨੀ ਖੇਤਰ (ਹੈਕਟੇਅਰ)",
  landSurveyStr:"ਜ਼ਮੀਨੀ ਸਰਵੇਖਣ ਨੰਬਰ",
  areaInformationStr:"ਖੇਤਰ ਜਾਣਕਾਰੀ",
  patedarStr:"ਪਟੇਦਾਰ ਨੰ",
  uploadFardStr:"ਫਰਦ/ਆਰ.ਓ.ਆਰ ਦਸਤਾਵੇਜ਼ ਅੱਪਲੋਡ ਕਰੋ",
  uploadPatwariReportStr:"ਪਟਵਾਰੀ/ਨੰਬਰਦਾਰ ਰਿਪੋਰਟ ਅੱਪਲੋਡ ਕਰੋ",
  khewatNoStr:"ਖੇਵਟ ਨੰ./ਖਟਾ ਨੰ.",
  khatauniNo:"ਖਤੌਨੀ ਨੰ.",
  kasraNoStr:"ਖਸਰਾ ਨੰ/ਪਲਾਟ ਨੰ.",
  addLandStr:"ਜ਼ਮੀਨ ਸ਼ਾਮਲ ਕਰੋ",
  landAddress1Str:"ਜ਼ਮੀਨ ਦਾ ਪਤਾ 1",


/*:::::::::::::::upload Documents  details screen:::::::::::::::::::::::::::::::*/
  proceedApplyStr:"ਅਪਲਾਈ ਕਰਨ ਲਈ ਅੱਗੇ ਵਧੋ",
  landAreaApplyStr:"ਤੁਸੀਂ ਜ਼ਮੀਨ ਦੇ ਕਿੰਨੇ ਖੇਤਰ ਲਈ ਅਰਜ਼ੀ ਦਿੰਦੇ ਹੋ? (ਹੈਕਟੇਅਰ)",
  uploadDocumentStr:"ਦਸਤਾਵੇਜ਼ ਅੱਪਲੋਡ ਕਰੋ",
  downloadDocumentStr:"ਡਾਊਨਲੋਡ ਕਰੋ, ਪ੍ਰਿੰਟ ਕਰੋ, ਭਰੋ, ਅੱਪਲੋਡ ਕਰੋ",
  scanDocumentStr:"ਦਸਤਾਵੇਜ਼ ਨੂੰ ਸਕੈਨ ਕਰੋ ਅਤੇ ਅੱਪਲੋਡ ਕਰੋ",


/*:::::::::::::::my schemes screen:::::::::::::::::::::::::::::::*/
  mySchemesStr:"ਮੇਰੀਆਂ ਸਕੀਮਾਂ",



/*:::::::::::::::add land fields data screen:::::::::::::::::::::::::::::::*/
  addLandDetailsStr:"ਜ਼ਮੀਨ ਦੇ ਵੇਰਵੇ ਸ਼ਾਮਲ ਕਰੋ",
  noRecordAvailStr:"ਕੋਈ ਰਿਕਾਰਡ ਨਹੀਂ ਮਿਲਿਆ",
  selectComponentStr:"ਕੰਪੋਨੈਂਟ ਚੁਣੋ",
  selectSubComponentStr:"ਸਬ-ਕੰਪੋਨੈਂਟ ਚੁਣੋ",
  updateStr:"ਅੱਪਡੇਟ ਕਰੋ",
  editStr:"ਸੰਪਾਦਿਤ ਕਰੋ",
  deleteStr:"ਮਿਟਾਓ",
  confirmDeleteStr:"ਕੀ ਤੁਸੀਂ ਮਿਟਾਉਣਾ ਚਾਹੁੰਦੇ ਹੋ",
  cancelStr:"ਰੱਦ ਕਰੋ",

/*:::::::::::::::my schemes:::::::::::::::::::::::::::::::*/
  applicationStr:"ਐਪਲੀਕੇਸ਼ਨ ਨੰ",
  statusOfSchemesStr:"ਸਕੀਮਾਂ ਦੀ ਸਥਿਤੀ",
  locationStr:"ਟਿਕਾਣਾ",
  stageStr:"ਸਟੇਜ",


/*:::::::::::::::explore schemes:::::::::::::::::::::::::::::::*/
   showFilterStr:"ਫਿਲਟਰ ਦਿਖਾਓ",
  showLessStr:"ਘੱਟ ਦਿਖਾਓ",
  searchStr:"ਖੋਜ",
  allStr:"ਸਾਰੇ",
  noDataAvailStr:"ਕੋਈ ਡਾਟਾ ਉਪਲਬਧ ਨਹੀਂ ਹੈ",
  noSchemesAppliedStr:"ਕੋਈ ਲਾਗੂ ਸਕੀਮਾਂ ਨਹੀਂ",
  noFeaturesSchemesStr:"ਕੋਈ ਵਿਸ਼ੇਸ਼ਤਾਵਾਂ ਸਕੀਮਾਂ ਉਪਲਬਧ ਨਹੀਂ ਹਨ",
  noSchemesStr:"ਕੋਈ ਸਕੀਮਾਂ ਉਪਲਬਧ ਨਹੀਂ ਹਨ",
  noRequiredDocumentStr:"ਕੋਈ ਲੋੜੀਂਦਾ ਦਸਤਾਵੇਜ਼ ਉਪਲਬਧ ਨਹੀਂ ਹੈ",
  privateSubStr:"ਨਿਜੀ:",
  publicSubStr:"ਜਨਤਕ:",
  nextPageStr:"ਅਗਲਾ ਪੰਨਾ",
  prevPageStr:"ਪਿਛਲਾ ਪੰਨਾ",
  reApplyStr:"ਮੁੜ-ਸਪੁਰਦ ਕਰੋ",

  tehsilOfficerStr:"ਤਹਿਸੀਲ ਅਫਸਰ",
  districtOfficerStr:"ਜ਼ਿਲ੍ਹਾ ਅਧਿਕਾਰੀ",
  checkIssuesStr:"ਮੁੱਦਿਆਂ ਦੀ ਜਾਂਚ ਕਰੋ",
  checkReasonButtonStr: "ਅਸਵੀਕਾਰ ਕਰਨ ਦਾ ਕਾਰਨ",
  downloadingStr: "ਡਾਊਨਲੋਡ ਕੀਤਾ ਜਾ ਰਿਹਾ ਹੈ...",
  downloadStr: "ਡਾਊਨਲੋਡ ਕਰੋ",
  retryStr: "ਦੁਬਾਰਾ ਕੋਸ਼ਿਸ਼ ਕਰੋ",
  farmerNameDummyStr: "null",
  issuesDesStr: "ਤੁਹਾਡੀ ਅਰਜ਼ੀ ਵਿੱਚ ਕੁਝ ਸਮੱਸਿਆਵਾਂ ਹਨ, ਉਹਨਾਂ ਨੂੰ ਠੀਕ ਕਰੋ ਅਤੇ ਫਿਰ 7 ਦਿਨਾਂ ਦੇ ਅੰਦਰ ਅੱਪਲੋਡ ਕਰੋ",
          requiredStr:"ਲੋੜੀਂਦਾ ਹੈ *",
          mobileNumberAlreadyExistStr:"ਮੋਬਾਈਲ ਨੰਬਰ ਰਜਿਸਟਰਡ ਨਹੀਂ ਹੈ",

  costNormsStr:"ਲਾਗਤ ਮਾਪਦੰਡ:",
  subsidyStr:"ਸਬਸਿਡੀ",
  detailedDesciptionStr:"ਵਿਸਤ੍ਰਿਤ ਵਰਣਨ",
  noDesAvailStr:"ਕੋਈ ਵੇਰਵਾ ਉਪਲਬਧ ਨਹੀਂ ਹੈ",
  completeDocStr:"ਪੂਰੇ ਦਸਤਾਵੇਜ਼",
  fileWarningStr:"ਫ਼ਾਈਲ ਦਾ ਆਕਾਰ 5mb ਤੋਂ ਵੱਧ ਨਹੀਂ ਹੋਣਾ ਚਾਹੀਦਾ",
  pickRequiredFileStr:"ਕਿਰਪਾ ਕਰਕੇ ਲੋੜੀਂਦੀ ਪੀਡੀਐਫ ਫਾਈਲ ਚੁਣੋ",
  successfullyAddedStr:"ਸਫਲਤਾਪੂਰਵਕ ਸ਼ਾਮਲ ਕੀਤਾ ਗਿਆ",
  villageNotEditable:"ਪਿੰਡ ਸੰਪਾਦਨਯੋਗ ਨਹੀਂ ਹੈ",
  districtNotEditable:"ਜ਼ਿਲ੍ਹਾ ਸੰਪਾਦਨਯੋਗ ਨਹੀਂ ਹੈ",
  tehsilNotEditable:"ਤਹਿਸੀਲ ਸੋਧਯੋਗ ਨਹੀਂ ਹੈ",
  fileNotDownloadedStr:"ਫਾਈਲ ਡਾਊਨਲੋਡ ਨਹੀਂ ਹੋਈ",

  varietyStr:"ਵਿਭਿੰਨਤਾ:",
  dateStr:"ਤਾਰੀਖ਼:",
  mandiStr:"ਮੰਡੀ",
   tooManyOtpWarningStr:"ਇਸ ਨੰਬਰ 'ਤੇ otp ਲਈ ਬਹੁਤ ਸਾਰੀਆਂ ਬੇਨਤੀਆਂ, ਕਿਸੇ ਹੋਰ ਨੰਬਰ 'ਤੇ otp ਭੇਜਿਆ ਗਿਆ",

   otpSendStr:"OTP ਭੇਜਿਆ ਗਿਆ",
   somethingWrongStr:"ਕੁਝ ਗਲਤ ਹੋ ਗਿਆ",
   otpResendStr:"OTP ਦੁਬਾਰਾ ਭੇਜਿਆ ਗਿਆ",
   invalidPhoneStr:'ਪ੍ਰਦਾਨ ਕੀਤਾ ਫ਼ੋਨ ਨੰਬਰ ਵੈਧ ਨਹੀਂ ਹੈ।',
   cloudsStr:"ਬੱਦਲ",
   viewsStr:"ਦੇਖੋ",
   tokenExpiredStr:"ਟੋਕਨ ਦੀ ਮਿਆਦ ਪੁੱਗ ਗਈ",
   pleaseEnableLocationsStr:"ਕਿਰਪਾ ਕਰਕੇ ਟਿਕਾਣਾ ਚਾਲੂ ਕਰੋ",
   noTimeAvailStr:"ਕੋਈ ਸਮਾਂ ਉਪਲਬਧ ਨਹੀਂ ਹੈ",

   landDetailsAddedStr:"ਜ਼ਮੀਨ ਦਾ ਵੇਰਵਾ ਸਫਲਤਾਪੂਰਵਕ ਸ਼ਾਮਲ ਕੀਤਾ ਗਿਆ",
   noComAvailStr: "ਕੋਈ ਕੰਪੋਨੈਂਟ ਉਪਲਬਧ ਨਹੀਂ ਹੈ",
   noCategoryAvailStr:"ਕੋਈ ਸ਼੍ਰੇਣੀ ਉਪਲਬਧ ਨਹੀਂ ਹੈ",
   subSchemesStr:"ਸਬ ਸਕੀਮਾਂ",
   selectStr:"ਚੁਣੋ",
   applicationsStr:"ਐਪਲੀਕੇਸ਼ਨ  ",
   daysStr:"ਦਿਨ",
   ihrmStr:'IHRM:',
   landUpdatedStr:"ਜ਼ਮੀਨ ਦੇ ਵੇਰਵੇ ਸਫਲਤਾਪੂਰਵਕ ਅੱਪਡੇਟ ਕੀਤੇ ਗਏ",
   todayStr:"ਅੱਜ",
   detailsOfExpenditureStr:"ਖਰਚੇ ਦੇ ਵੇਰਵੇ (ਬਿਲਾਂ ਦੇ ਨਾਲ)",
   applicationsFormStr:"ਐਪਲੀਕੇਸ਼ਨ ਫਾਰਮ/ਡੀ.ਪੀ.ਆਰ",
   selfDeclarationStr:"ਸਵੈ ਘੋਸ਼ਣਾ",
   resentOtpInStr:"otp ਮੁੜ ਭੇਜੋ ਵਿੱਚ"

},

        'hi_IN': {
          'homeStr1': 'नमस्ते दुनिया',
  APP_NAME:"किसान-ए-बागबानी",

/*::::::::::::::::::::::::::::login texts:::::::::::::::::::::::::::::::*/
  loginStr:"लॉग इन करें",
   welcomeStr:"स्वागत!",
   welcome:"स्वागत!",
   enterProductNameStr:" उत्पाद का नाम दर्ज करें",
   enterProductPriceStr:"उत्पाद मूल्य दर्ज करें",
   productDetailsStr:"उत्पाद विवरण दर्ज करें",
  addItemStr:"मद जोड़ें",
  productStr:"उत्पाद",
  emailStr:"ईमेल",
  passwordStr:"पासवर्ड",
  registerStr:"पंजीकरण करवाना",
  forgetPassStrQ:"पासवर्ड भूल गए?",
  forgetPassStr:"पासवर्ड भूल गए",
  alreadyAppliedStr:"लागू",


/*::::::::::::::::::::::::::::forgetPassword texts:::::::::::::::::::::::::::::::*/
  sendStr:"भेजना",


/*::::::::::::::::::::::::::::register texts:::::::::::::::::::::::::::::::*/
  phoneStr:"फ़ोन",
  registerSuccessfullyStr:"सफलतापूर्वक पंजीकरण करें",


/*::::::::::::::::::::::::::::validations texts:::::::::::::::::::::::::::::::*/
  loginSuccessfullyStr:"सफलतापूर्वक लॉगिन",
  validEmailStr:'एक मान्य ईमेल पता दर्ज करें',
  validPasswordStr:'पासवर्ड की लंबाई 8 से कम नहीं होनी चाहिए',
  validMobileStr:'कृपया मान्य मोबाइल नंबर दर्ज करें',
  appicantTypeValidationStr:'कृपया आवेदक प्रकार का चयन करें',
  appicantTypeNameStr:'कृपया आवेदक का नाम जोड़ें',
  pleaseFillFieldStr:'कृपया इस फील्ड को भरें',
  pleaseFillRequiredFieldStr:'कृपया आवश्यक फ़ील्ड को सही ढंग से भरें',
  pleaseSelectItemStr:'कृपया आइटम का चयन करें',

  pleaseEnterValidAccountStr:'कृपया मान्य खाता संख्या दर्ज करें।',
  aadharLengthStr:'कृपया वैध आधार कार्ड दर्ज करें',
  validPin:'कृपया वैध पिन दर्ज करें',
  ifscCode:'कृपया मान्य IFSC कोड दर्ज करें',
  validPan:'कृपया मान्य पैन नंबर दर्ज करें',
  pleasePickImage:"कृपया प्रोफ़ाइल छवि चुनें",
  accountNumberNotMatchedStr:"खाता संख्या मेल नहीं खाती",


/*::::::::::::::::::::::::::::select language texts:::::::::::::::::::::::::::::::*/
  englishStr:"English",
  punjabiStr:"ਪੰਜਾਬੀ",
  hindiStr:"हिन्दी",
  selectLanguageStr:"भाषा चुने",
  farmerRegisterStr:"किसान पंजीकरण",


/*::::::::::::::::::::::::::::register texts:::::::::::::::::::::::::::::::*/
  mobileNumberStr:"मोबाइल नंबर",
  getOtpStr:"ओटीपी प्राप्त करें",
  alreadyStr:"क्या आपके पास पहले से एक खाता मौजूद है?",
  preTextPhoneStr:"(+91) ",


/*::::::::::::::::::::::::::::enter otp texts:::::::::::::::::::::::::::::::*/
  notReceiveStr:"ओटीपी प्राप्त नहीं होता?",
  resendStr:"पुन: भेजें",
  enterTheOtpStr:"ओटीपी दर्ज करें",
  receiveInStr:"आपके नंबर पर प्राप्त हुआ",
  userVerifiedStr:"उपयोगकर्ता सत्यापित",
  enterValidOtpStr:"मान्य ओटीपी दर्ज करें",


/*::::::::::::::::::::::::::::farmer login texts:::::::::::::::::::::::::::::::*/
  farmerLoginStr:"किसान लॉगिन",
  notHaveAccountStr:"खाता नहीं है?",
  registerNowStr:"अभी पंजीकरण करें",
  verifyStr:"सत्यापित करना",

/*::::::::::::::::::::::::::::home Screen texts:::::::::::::::::::::::::::::::*/
  mainTitleStr:"योजनाओं का अन्वेषण करें",
  homeStr:"होम",
  schemesStr:"योजनाओं",
  mandiRateStr:"मंडी रेट",
  videoFeedStr:"वीडियो फ़ीड",
  cartStr:"कार्ट",
  profileStr:"प्रोफ़ाइल",

/*::::::::::::::::::::::::::::explore  Screen texts:::::::::::::::::::::::::::::::*/
  exploreSchemesTitleStr:"योजनाओं का अन्वेषण करें",

/*::::::::::::::::::::::::::::profile  Screen texts:::::::::::::::::::::::::::::::*/
  galleryStr:"गेलरी",
  cameraStr:"कैमरा",
  pickImageStr:"विकल्प चुनें",
  applicantStr:"आवेदक प्रकार",
  applicantNameStr:"आवेदक का नाम",
  applicantFatherNameStr:"पिता/पति का नाम",
  residentStr:"निवासी",
  indianStr:"भारतीय",
  punjabStr:"पंजाब",
  applicantGrandFatherNameStr:"दादा का नाम",
  genderStr:"लिंग",
  maleStr:"नर",
  femaleStr:"महिला",
  othersStr:"अन्य",
  aadhaarNoStr:"आधार संख्या",
  panNoStr:"पैन नंबर",
  casteStr:"जाति श्रेणी",
  scStr:"SC",
  generalStr:"General",
  bcStr:"BC",
  stateStr:"राज्य",
  districtStr:"ज़िला",
  tehsilStr:"ब्लॉक",
  villageStr:"गांव/शहर",
  fullAddressStr:"पूरा पता",
  pinCodeStr:"पिन कोड",
  saveStr:"सेव करें",
  proceedStr:"आगे बढ़ना",
  continueStr:"जारी रखना",
  completeStr:"पूरा",
  profileInfoStr:"प्रोफ़ाइल जानकारी",
  updatePersonalInfoStr:"प्रोफ़ाइल अपडेट करें",
  updateAddressStr:"अद्यतन पता",
  addressStr:"पता",
  selectApplicantTypeStr:"आवेदक प्रकार का चयन करें",
  selectCategoryTypeStr:"जाति श्रेणी का चयन करें",
  selectDistrictTypeStr:"जिला चुनें",
  selectStateStr:"राज्य चुनें",
  selectGenderStr:"लिंग चुनें",
  selectResidentStr:"निवासी का चयन करें",
  selectTehsilStr:"तहसील का चयन करें",
  selectCityVillageStr:"शहर/गांव चुनें",


/*::::::::::::::::::::::::::::schemes details   Screen texts:::::::::::::::::::::::::::::::*/
  schemesDetailsStr:"योजनाओं का विवरण",
  titleSchemes:"योजनाओं का विवरण",
  knowMoreStr:"अधिक जानते हैं",
  applyStr:"आवेदन करना",
  proceedstr:"आगे बढ़ना",
  requiredDocumentStr:"आवश्यक दस्तावेज",
  noVideoAvailStr:"कोई वीडियो उपलब्ध नहीं है",
  videosStr:"वीडियो",



/*::::::::::::::::::::::::::::drawer details   Screen texts:::::::::::::::::::::::::::::::*/

  notificationsStr:"सूचनाएं",
  personalInfoStr:"व्यक्तिगत जानकारी",
  languagePreferenceStr:"भाषा वरीयता",
  logoutStr:"लॉग आउट",


/*::::::::::::::::::::::::::::home Screen texts:::::::::::::::::::::::::::::::*/
  seeAllStr:"सभी देखें",
  featuresSchemesStr:"फ़ीचर योजनाएं",
  mandiPriceStr:"मंडी  कीमत",
  viewAllStr:"सभी को देखें",
  todayInformation:"टुडे'स जानकारी",
  languagesPreferenceStr:"भाषा वरीयता",
  callToActionStr:"कार्यवाई के लिए बुलावा",
  publicStr:"जनता",
  privateStr:"निजी",

/*::::::::::::::::::::::::::::mandi Rate Screen:::::::::::::::::::::::::::::::*/
  selectCommodityStr:"कमोडिटी\nचुनें :",
  quantalStr:"/क्विंटल",
  miniPriceStr:"न्यूनतम\nमूल्य",
  averagePriceStr:"औसत\n मूल्य",
  maxPriceStr:"अधिकतम मूल्य",

/*::::::::::::::::::::::::::::today weather  Screen:::::::::::::::::::::::::::::::*/
  todayWeatherStr:"आज का मौसम",
  weeklyForeCastStr:"साप्ताहिक पूर्वानुमान",



  updateProfileStr:"प्रोफ़ाइल अपडेट करें",
  pleaseSelectCategoryStr:"कृपया श्रेणी चुनें",

/*::::::::::::::::::::::::::::complete details screen:::::::::::::::::::::::::::::::*/
  completeDetailsStr:"पूरा विवरण",
  incompleteDetailsStr:"अधूरा विवरण",
  bankDetailsStr:"बैंक विवरण",
  landDetailsStr:"भूमि विवरण",
  subDetailsStr:"किसी भी योजना में आवेदन करने से पहले आपको निम्नलिखित फॉर्म भरने होंगे और दस्तावेज अपलोड करने होंगे",

/*::::::::::::::::::::::::::::schemes tracking  screen:::::::::::::::::::::::::::::::*/
  applicationStatusStr:"आवेदन की स्थिति",
  committeeStr:"समिति",
  approvedStr:"अनुमत",
  applicationsInformationStr:"आवेदन की सूचना",
  landAddressStr:"भूमि का पता",
  dateAppliedStr:"लागू होने की तिथि",
  applicationNoStr:"आवेदन अंक.",
  typeOFSchemesStr:"योजना का प्रकार",
  subsidyTypeStr:"सब्सिडी का प्रकार",
  currentlyReviewingByStr:"वर्तमान में समीक्षा कर रहा है",


  /*:::::::::::::::bank details screen:::::::::::::::::::::::::::::::*/
  bankNameStr:"बैंक का नाम",
  ifscCodeStr:"आईएफएससी कोड",
  branchNameStr:"शाखा का नाम",
  accountNumberStr:"खाता संख्या",
  confirmAccountNumberStr:" खाता संख्या की पुष्टि करें",
  nameOfFarmerStr:"बैंक खाते में किसान का नाम",
  bankBranchAddressStr:"बैंक शाखा का पता",
  uploadStr:"अपलोड",
  uploadCancelCheckStr:"अपलोड रद्द करें चेक",
  uploadBankPassbookStr:"बैंक पासबुक अपलोड करें",
  noPdfFilePickedStr:"कोई पीडीएफ फाइल नहीं चुनी गई",

/*:::::::::::::::land Details details screen:::::::::::::::::::::::::::::::*/

  areaHeatareStr:"कुल भूमि क्षेत्र (हेक्टेयर)",
  landSurveyStr:"भूमि सर्वेक्षण संख्या",
  areaInformationStr:"क्षेत्र की जानकारी",
  patedarStr:"पट्टेदार नं",
  uploadFardStr:"फर्द/आर.ओ.आर दस्तावेज अपलोड करें",
  uploadPatwariReportStr:"पटवारी/नंबरदार रिपोर्ट अपलोड करें",
  khewatNoStr:"खेवट नं./खता नं.",
  khatauniNo:"खतौनी नं",
  kasraNoStr:"खसरा नं / प्लॉट नं।",
  addLandStr:"भूमि जोड़ें",
  landAddress1Str:"भूमि का पता 1",


/*:::::::::::::::upload Documents  details screen:::::::::::::::::::::::::::::::*/
  proceedApplyStr:"आवेदन करने के लिए आगे बढ़ें",
  landAreaApplyStr:"आप कितने भूमि क्षेत्र के लिए आवेदन करते हैं? (हेक्टेयर)",
  uploadDocumentStr:"दस्तावेज़ अपलोड करें",
  downloadDocumentStr:"डाउनलोड करें, प्रिंट करें, भरें, अपलोड करें",
  scanDocumentStr:"दस्तावेज़ स्कैन करें और अपलोड करें",


/*:::::::::::::::my schemes screen:::::::::::::::::::::::::::::::*/
  mySchemesStr:"मेरी योजनाएं",



/*:::::::::::::::add land fields data screen:::::::::::::::::::::::::::::::*/
  addLandDetailsStr:"भूमि विवरण जोड़ें",
  noRecordAvailStr:"कोई रिकॉर्ड नहीं मिला",
  selectComponentStr:"घटक का चयन करें",
  selectSubComponentStr:"उपघटक का चयन करें",
  updateStr:"अद्यतन",
  editStr:"संपादन करना",
  deleteStr:"मिटाना",
  confirmDeleteStr:"क्या आप हटाना चाहते हैं",
  cancelStr:"रद्द करना",

/*:::::::::::::::my schemes:::::::::::::::::::::::::::::::*/
  applicationStr:"आवेदन नं",
  statusOfSchemesStr:"योजनाओं की स्थिति",
  locationStr:"जगह",
  stageStr:"अवस्था",


/*:::::::::::::::explore schemes:::::::::::::::::::::::::::::::*/
  showFilterStr:"फ़िल्टर दिखाएं",
  showLessStr:"कम दिखाएं",
  searchStr:"खोज",
  allStr:"सभी",
  noDataAvailStr:"कोई डेटा मौजूद नहीं",
  noSchemesAppliedStr:"कोई लागू योजनाएँ नहीं",
  noFeaturesSchemesStr:"कोई सुविधाएँ योजनाएँ उपलब्ध नहीं हैं",
  noSchemesStr:"कोई योजना उपलब्ध नहीं है",
  noRequiredDocumentStr:"कोई आवश्यक दस्तावेज़ उपलब्ध नहीं है",
  privateSubStr:"निजी:",
  publicSubStr:"जनता:",
  nextPageStr:"अगला पृष्ठ",
  prevPageStr:"पिछला पृष्ठ",
  reApplyStr:"पुनः सबमिट करें",

  tehsilOfficerStr:"तहसील अधिकारी",
  districtOfficerStr:"जिला पदाधिकारी",
  checkIssuesStr:"मुद्दों की जाँच करें",
  checkReasonButtonStr: "अस्वीकृति का कारण",
  downloadingStr: "डाउनलोड हो रहा है...",
  downloadStr: "डाउनलोड करना",
  retryStr: "पुन: प्रयास करें",
  farmerNameDummyStr: "व्यर्थ",
  issuesDesStr: "आपके एप्लिकेशन में कुछ समस्याएँ हैं, उन्हें ठीक करें और फिर 7 दिनों के अंदर अपलोड करें",

          requiredStr:"आवश्यक *",

          mobileNumberAlreadyExistStr:"मोबाइल नंबर पंजीकृत नहीं है",
  costNormsStr:"लागत मानदंड: ",
  subsidyStr:"सब्सिडी",
  detailedDesciptionStr:"विस्तृत विवरण",
  noDesAvailStr:"कोई विवरण उपलब्ध नहीं",
  completeDocStr:"पूर्ण दस्तावेज",
  pickRequiredFileStr:"कृपया आवश्यक पीडीएफ फाइल चुनें",
  successfullyAddedStr:"सफलतापूर्वक शामिल",
  villageNotEditable:"गांव संपादन योग्य नहीं है",
  districtNotEditable:"जिला संपादन योग्य नहीं",
  tehsilNotEditable:"तहसील संपादन योग्य नहीं",
  fileNotDownloadedStr:"फ़ाइल डाउनलोड नहीं हुई",
          varietyStr:"विविधता:",
  dateStr:"तारीख:",
  mandiStr:"मंडी",

   tooManyOtpWarningStr:"इस नंबर पर ओटीपी के लिए बहुत अधिक अनुरोध, दूसरे नंबर पर ओटीपी भेजा गया",

 otpSendStr:"ओटीपी भेजा गया",
 somethingWrongStr:"Sकुछ गलत हो गया",
 otpResendStr:"ओटीपी रिसेंट",
 invalidPhoneStr:'दिया गया फ़ोन नंबर मान्य नहीं है.',
 cloudsStr:"बादलों",
 viewsStr:"दृश्य",
 tokenExpiredStr:"Tटोकन समाप्त हो गया",
 pleaseEnableLocationsStr:"कृपया स्थान सक्षम करें",
 noTimeAvailStr:"कोई समय उपलब्ध नहीं है",

 landDetailsAddedStr:"भूमि विवरण सफलतापूर्वक जोड़ा गया",
 noComAvailStr: "कोई घटक उपलब्ध नहीं है",
 noCategoryAvailStr:"कोई श्रेणी उपलब्ध नहीं है",
 subSchemesStr:"उपयोजनाएं",
 selectStr:"चुनना",
 applicationsStr:"आवेदन  ",
 daysStr:"दिन",
 ihrmStr:'IHRM:',
 landUpdatedStr:"भूमि विवरण सफलतापूर्वक अपडेट किया गया",
 todayStr:"आज",
 detailsOfExpenditureStr:"व्यय का विवरण (बिल सहित)",
 applicationsFormStr:"आवेदन प्रपत्र/डीपीआर",
 selfDeclarationStr:"स्व घोषणा",
   resentOtpInStr:"ओटीपी फिर से भेजें में"

        }
      };
}