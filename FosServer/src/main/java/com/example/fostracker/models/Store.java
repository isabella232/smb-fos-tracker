package com.example.fostracker.models;

import java.sql.Timestamp;
import java.time.ZoneId;
import java.time.ZonedDateTime;

/** Serves as a model for store objects that will be used in to communicate information about GPay Merchants' stores
 * and businesses */
public class Store {
    Name ownerName;
    String email;
    Address storeAddress;
    Coordinates coordinates;
    String phone;
    String storeName;
    Timestamp creationDateTime;

    public Store() {};

    /**
     * @param ownerName - the name of the business owner
     * @param address - the address of the store/business
     * @param email - the gmail address associated with the account of the business owner
     * @param coordinates - the coordinates of the business taken when the owner confirms the business location
     * @param phone - the phone number associated with the store. It is the primary identifier
     * @param storeName - the name that is displayed on the store
     * creationDateTime is set by default to the current time of Asia/Kolkata and cannot be changed later
     */
    public Store(Name ownerName,
                 Address address,
                 String email,
                 Coordinates coordinates,
                 String phone,
                 String storeName
                 ) {
        this.ownerName = ownerName;
        this.storeAddress = address;
        this.email = email;
        this.coordinates = coordinates;
        this.phone = phone;
        this.storeName = storeName;
        this.creationDateTime = Timestamp.valueOf(ZonedDateTime.now(ZoneId.of("Asia/Kolkata")).toLocalDateTime());
    }

    public String getStoreName() {
        return storeName;
    }

    public void setStoreName(String storeName) {
        this.storeName = storeName;
    }

    public String getMerchantEmail() {
        return email;
    }

    public void setMerchantEmail(String email) {
        this.email = email;
    }


    public Coordinates getStoreCoordinates() {
        return coordinates;
    }

    public void setStoreCoordinates(Coordinates coordinates) {
        this.coordinates = coordinates;
    }

    public String getStorePhone() {
        return phone;
    }

    public void setStorePhone(String phone) {
        this.phone = phone;
    }

    public Address getStoreAddress() {
        return storeAddress;
    }

    public void setStoreAddress(Address storeAddress) {
        this.storeAddress = storeAddress;
    }

    public Timestamp getStoreCreationDateTime() {
        return creationDateTime;
    }

    public Name getOwnerName() {
        return ownerName;
    }

    public void setOwnerName(Name ownerName) {
        this.ownerName = ownerName;
    }

}
