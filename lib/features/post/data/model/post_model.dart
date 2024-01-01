class PostModel{
  String ?name;
  String ?dateTime;
  String?image;
  String?text;
  String ?uId;
  String?postImage;
  PostModel({
  this.name,
  this.postImage,
  this.dateTime,
  this.image,
  this.text,
  this.uId,

  });
  PostModel.fromJson(Map<String,dynamic>json){
  postImage=json['postImage'];
  name=json['name'];
  dateTime=json['dateTime'];
  image=json['image'];
  text=json["text"];
  uId=json['uId'];
  }
  Map<String,dynamic>toMap(){
  return{
  'name':name,
  'postImage':postImage,
  'dateTime':dateTime,
  'image': image,
  'text':text,
  'uId':uId,
  };

  }

}