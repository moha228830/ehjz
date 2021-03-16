class PlaceModel {
  var id;
  var name;
  var userId;
  var isAd;
  var lastName;
  var price;
  var categoryId;
  var jobTitle;
  var specialization;
  var address;
  var fees;
  var waitingTime;
  var phone;
  var image;
  var description;
  var photos;
  var services;
  var createdAt;
  var updatedAt;
  var slug;
  var cityId;
  var regionId;
  var imgFullPath;
  var ad;
  var region;
  var stars;
  var sum;
  var time;
  var end;

  PlaceModel(
      {this.id,
        this.name,
        this.userId,
        this.isAd,
        this.lastName,
        this.price,
        this.categoryId,
        this.jobTitle,
        this.specialization,
        this.address,
        this.fees,
        this.waitingTime,
        this.phone,
        this.image,
        this.description,
        this.photos,
        this.services,
        this.createdAt,
        this.updatedAt,
        this.slug,
        this.cityId,
        this.regionId,
        this.imgFullPath,
        this.ad,
        this.region,
        this.stars,
        this.sum,
        this.time,
        this.end});

  PlaceModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    end = json['end'];
    name = json['name'];
    userId = json['user_id'];
    isAd = json['is_ad'];
    lastName = json['last_name'];
    price = json['price'];
    categoryId = json['category_id'];
    jobTitle = json['job_title'];
    specialization = json['specialization'];
    address = json['address'];
    fees = json['fees'];
    waitingTime = json['waiting_time'];
    phone = json['phone'];
    image = json['image'];
    description = json['description'];
    photos = json['photos'];
    services = json['services'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    slug = json['slug'];
    cityId = json['city_id'];
    regionId = json['region_id'];
    imgFullPath = json['img_full_path'];
    ad = json['ad'];
    region = json['region'];
    stars = json['stars'];
    sum = json['sum'];
    time =   new Time.fromJson(json['time']) ;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['end'] = this.end;
    data['name'] = this.name;
    data['user_id'] = this.userId;
    data['is_ad'] = this.isAd;
    data['last_name'] = this.lastName;
    data['price'] = this.price;
    data['category_id'] = this.categoryId;
    data['job_title'] = this.jobTitle;
    data['specialization'] = this.specialization;
    data['address'] = this.address;
    data['fees'] = this.fees;
    data['waiting_time'] = this.waitingTime;
    data['phone'] = this.phone;
    data['image'] = this.image;
    data['description'] = this.description;
    data['photos'] = this.photos;
    data['services'] = this.services;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['slug'] = this.slug;
    data['city_id'] = this.cityId;
    data['region_id'] = this.regionId;
    data['img_full_path'] = this.imgFullPath;
    data['ad'] = this.ad;
    data['region'] = this.region;
    data['stars'] = this.stars;
    data['sum'] = this.sum;
    data['time'] = this.time.toJson();

    return data;
  }
}

class Time {
  var id;
  var placeId;
  var day;
  var date;
  var duration;
  var stratIn;
  var endIn;
  var createdAt;
  var updatedAt;
  var first;
  var start;
  var end;

  Time(
      {this.id,
        this.placeId,
        this.day,
        this.date,
        this.duration,
        this.stratIn,
        this.endIn,
        this.createdAt,
        this.updatedAt,
        this.first,
        this.start,
        this.end});

  Time.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    placeId = json['place_id'];
    day = json['day'];
    date = json['date'];
    duration = json['duration'];
    stratIn = json['strat_in'];
    endIn = json['end_in'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    first = json['first'];
    start = json['start'];

    end = json['end'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['place_id'] = this.placeId;
    data['day'] = this.day;
    data['date'] = this.date;
    data['duration'] = this.duration;
    data['strat_in'] = this.stratIn;
    data['end_in'] = this.endIn;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['first'] = this.first;
    data['start'] = this.start;
    data['end'] = this.end;

    return data;
  }
}