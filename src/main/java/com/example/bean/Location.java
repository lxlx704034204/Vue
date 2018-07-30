package com.example.bean;

public class Location {
    private String placename;
    private String address;
    private String province;
    private String provincecode;
    private String city;
    private String citycode;
    private String district;
    private String districtcode;
    private String lngandlat;

    public String getPlacename() {
        return placename;
    }

    public void setPlacename(String placename) {
        this.placename = placename;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getProvince() {
        return province;
    }

    public void setProvince(String province) {
        this.province = province;
    }

    public String getProvincecode() {
        return provincecode;
    }

    public void setProvincecode(String provincecode) {
        this.provincecode = provincecode;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getCitycode() {
        return citycode;
    }

    public void setCitycode(String citycode) {
        this.citycode = citycode;
    }

    public String getDistrict() {
        return district;
    }

    public void setDistrict(String district) {
        this.district = district;
    }

    public String getDistrictcode() {
        return districtcode;
    }

    public void setDistrictcode(String districtcode) {
        this.districtcode = districtcode;
    }

    public String getLngandlat() {
        return lngandlat;
    }

    public void setLngandlat(String lngandlat) {
        this.lngandlat = lngandlat;
    }

    public Location() {
    }

    public Location(String placename, String address, String province, String provincecode, String city, String citycode, String district, String districtcode, String lngandlat) {
        this.placename = placename;
        this.address = address;
        this.province = province;
        this.provincecode = provincecode;
        this.city = city;
        this.citycode = citycode;
        this.district = district;
        this.districtcode = districtcode;
        this.lngandlat = lngandlat;
    }

    @Override
    public String toString() {
        return "Location{" +
                "placename='" + placename + '\'' +
                ", address='" + address + '\'' +
                ", province='" + province + '\'' +
                ", provincecode='" + provincecode + '\'' +
                ", city='" + city + '\'' +
                ", citycode='" + citycode + '\'' +
                ", district='" + district + '\'' +
                ", districtcode='" + districtcode + '\'' +
                ", lngandlat='" + lngandlat + '\'' +
                '}';
    }
}
