package com.example.fostracker.models;

/**
 * Serves as a model for store objects that will be used to plot on Google Maps
 */
public class StoreAndStatus{
    String storePhone;
    Coordinates storeCoordinates;
    String verificationStatus;

    /**
     * If store verification is successful then database table stores "green" String.
     * else if merchant is not registered then database table stores "grey" String
     * else if store verification is  unsuccessful then database table stores "red" String
     * else if merchant needs to be revisited then database table stores "grey" String
     */
    public static final String VERIFICATION_SUCCESSFUL = "green";
    public static final String NOT_VERIFIED = "grey";
    public static final String VERIFICATION_UNSUCCESSFUL = "red";
    public static final String NEEDS_REVISIT = "yellow";
    public static final int VERIFICATION_SUCCESSFUL_INT = 2;
    public static final int NOT_VERIFIED_INT = 0;
    public static final int VERIFICATION_UNSUCCESSFUL_INT = -1;
    public static final int NEEDS_REVISIT_INT = 1;

    /**
     * @param storePhone              - the store phone number that was verified
     * @param storeCoordinates        - the location the store
     * @param verificationStatus      - whether the verification was successful/unsuccessful/incomplete
     */
    public StoreAndStatus(String storePhone, Coordinates storeCoordinates, int verificationStatus) {
        this.storePhone = storePhone;
        this.storeCoordinates = storeCoordinates;
        this.verificationStatus = getStoreVerificationString(verificationStatus);
    }

    //Based on the status integral value it sets to required status string
    private String getStoreVerificationString(int verificationStatus) {
        switch (verificationStatus) {
            case VERIFICATION_UNSUCCESSFUL_INT:
                return VERIFICATION_UNSUCCESSFUL;
            case VERIFICATION_SUCCESSFUL_INT:
                return VERIFICATION_SUCCESSFUL;
            case NOT_VERIFIED_INT:
                return NOT_VERIFIED;
            case NEEDS_REVISIT_INT:
                return NEEDS_REVISIT;
            default:
                return null;
        }
    }

    public String getStorePhone() {
        return storePhone;
    }

    public void setStorePhone(String storeID) {
        this.storePhone = storeID;
    }

    public Coordinates getStoreCoordinates() {
        return storeCoordinates;
    }

    public void setStoreCoordinates(Coordinates coordinates) {
        this.storeCoordinates = coordinates;
    }

    public String getStoreVerificationStatus() {
        return verificationStatus;
    }

    public void setStoreVerificationStatus(String status) {
        this.verificationStatus = status;
    }
}