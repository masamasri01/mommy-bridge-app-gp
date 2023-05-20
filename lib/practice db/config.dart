const url = 'http://192.168.1.9:3000/';

final loginMom = url + 'loginMom';
final loginTeacher = url + 'loginTeacher';

const registeration = "${url}registeration";
const mealAdd = "${url}mealAdd";
const MyChildrenListGet = url + "MyChildrenListGet";
const napAdd = url + "napAdd";
const announceAdd = url + "announceAdd";
const accidentAdd = url + "accidentAdd";
const attendAdd = url + "attendAdd";
const MySonsGet = url + "MySonsGet";
const getTeacherData = url + "teachers/";
//          ***********Mom

const updateMomPhone = "${url}updateMomPhone";
const updateMomAddress = "${url}updateMomAddress";
const updateMomJob = "${url}updateMomJob";
const updateMomRelationship = "${url}updateMomRelationship";
const getMomData = url + "moms/";
const medicineAdd = url + "attendAdd";

//       ----child----
const getChildData = url + "child/";
const updateChildAddress = url + "updateChildAddress";
//router.patch('/child/:id/hobby',UserController.addChildHobby)
//router.patch('/child/:id/allergy',UserController.addChildAllergy)
