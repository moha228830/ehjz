class Product {
  int id;
  String name;
  String description;
  double price;
  double overPrice;
  int brandId;
  String made;
  int subCategoryId;
  String categoryId;
  int qut;
  int pay;
  int view;
  int newItem;
  int popular;
  int over;
  int subSubCategoryId;
  String img;
  int activity;
  int precentage;
  List images ;
  List sizes;
  int numItem;
  String imgFullPath;
  int type;


  Product(
      {this.id,
      this.name,
      this.description,
      this.price,
      this.overPrice,
      this.brandId,
      this.made,
      this.subCategoryId,
      this.categoryId,
      this.qut,
      this.pay,
      this.view,
      this.newItem,
      this.popular,
      this.over,
      this.subSubCategoryId,
      this.img,
      this.activity,
      this.numItem,
      this.imgFullPath,
        this.precentage,
        this.images,
        this.sizes,
        this.type
      });

    Product.fromJson(Map<String, dynamic> json) {
    id =  json['id'];
    name = json['name'];
    description = json['description'];
    price =   json['price'].toDouble();
    overPrice = json['over_price'].toDouble();
    brandId = json['brand_id'];
    made = json['made'];
    subCategoryId = json['subCategory_id'];
    categoryId = json['category_id'];
    qut = json['qut'];
    pay = json['pay'];
    view = json['view'];
    newItem = json['new'];
    popular = json['popular'];
    over = json['over'];
    subSubCategoryId = json['subSubCategory_id'];
    img = json['img'];
    activity = json['activity'];
    numItem = json['num'];
    imgFullPath = json['img_full_path'];
    precentage = json['precentage'];
    images = json['images'];
    sizes = json['sizes'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['price'] = this.price;
    data['over_price'] = this.overPrice;
    data['brand_id'] = this.brandId;
    data['made'] = this.made;
    data['subCategory_id'] = this.subCategoryId;
    data['category_id'] = this.categoryId;
    data['qut'] = this.qut;
    data['pay'] = this.pay;
    data['view'] = this.view;
    data['new'] = this.newItem;
    data['popular'] = this.popular;
    data['over'] = this.over;
    data['subSubCategory_id'] = this.subSubCategoryId;
    data['img'] = this.img;
    data['activity'] = this.activity;
    data['num'] = this.numItem;
    data['img_full_path'] = this.imgFullPath;
    data['precentage'] = this.precentage;
    data['images'] = this.images;
    data['sizes'] = this.sizes;
    data['type'] = this.type;

    return data;
  }
}