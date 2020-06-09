package com.example.fostracker.models;

import java.sql.Timestamp;
import java.time.ZoneId;
import java.time.ZonedDateTime;

/** Serves as a model for store objects that will be used in to communicate information about GPay Merchants' stores
 * and businesses */
public class Verification {
    String agentEmail;
    String storePhone;
    Coordinates verificationCoordinates;
    String verificationStatus;
    Timestamp verificationCreationDateTime;

    /**
     * If store verification is successful then database table stores "green" String.
     * else if merchant is not registered then database table stores "yellow" String
     * else if store verification is  unsuccessful then database table stores "red" String
     */
    private final String VERIFICATION_SUCCESSFUL = "green";
    private final String NOT_REGISTERED = "yellow";
    private final String VERIFICATION_UNSUCCESSFUL = "red";

    /**
     * @param agentEmail - email id of the agent who completed the verification
     * @param storePhone - the store phone number that was verified
     * @param verificationCoordinates - the location the agent was at at the time of verification
     * @param verificationStatus - whether the verification was successful/unsuccessful/incomplete
     * verificationDateTime is set by default to the current time of Asia/Kolkata and cannot be changed later
     */
    public Verification(String agentEmail, String storePhone, Coordinates verificationCoordinates, int verificationStatus) {
        this.agentEmail = agentEmail;
        this.storePhone = storePhone;
        this.verificationCoordinates = verificationCoordinates;
        this.verificationStatus = getStoreVerificationString(verificationStatus);
        this.verificationCreationDateTime = Timestamp.valueOf(ZonedDateTime.now(ZoneId.of("Asia/Kolkata")).toLocalDateTime());
    }

    //Based on the status integral value it sets to required status string
    private String getStoreVerificationString(int verificationStatus){
        switch(verificationStatus){
            case 0:
                return VERIFICATION_UNSUCCESSFUL;
            case -1:
                return NOT_REGISTERED;
            case 1:
                return VERIFICATION_SUCCESSFUL;
            default:
                return null;
        }
    }

    public String getAgentEmail() {
        return agentEmail;
    }

    public void setAgentEmail(String agentID) {
        this.agentEmail = agentID;
    }

    public String getStorePhone() {
        return storePhone;
    }

    public void setStorePhone(String storeID) {
        this.storePhone = storeID;
    }

    public Coordinates getVerificationCoordinates() {
        return verificationCoordinates;
    }

    public void setVerificationCoordinates(Coordinates coordinates) {
        this.verificationCoordinates = coordinates;
    }

    public String getStoreVerificationStatus() {
        return verificationStatus;
    }

    public void setStoreVerificationStatus(String status) {
        this.verificationStatus = status;
    }

    public Timestamp getStoreVerificationDateTime() {
        return verificationCreationDateTime;
    }
}