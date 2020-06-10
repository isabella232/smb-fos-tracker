package com.example.fostracker.models;

import java.sql.Timestamp;
import java.time.ZoneId;
import java.time.ZonedDateTime;

/**
 * Serves as a model for store objects that will be used in to communicate information about GPay Merchants' stores
 * and businesses
 */
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
    public static final String VERIFICATION_SUCCESSFUL = "green";
    public static final String NOT_VERIFIED = "yellow";
    public static final String VERIFICATION_UNSUCCESSFUL = "red";
    public static final int VERIFICATION_SUCCESSFUL_INT = 1;
    public static final int NOT_VERIFIED_INT = 0;
    public static final int VERIFICATION_UNSUCCESSFUL_INT = -1;

    /**
     * @param agentEmail              - email id of the agent who completed the verification
     * @param storePhone              - the store phone number that was verified
     * @param verificationCoordinates - the location the agent was at at the time of verification
     * @param verificationStatus      - whether the verification was successful/unsuccessful/incomplete
     *                                verificationDateTime is set by default to the current time of Asia/Kolkata and cannot be changed later
     */
    public Verification(String agentEmail, String storePhone, Coordinates verificationCoordinates, int verificationStatus) {
        this.agentEmail = agentEmail;
        this.storePhone = storePhone;
        this.verificationCoordinates = verificationCoordinates;
        this.verificationStatus = getStoreVerificationString(verificationStatus);
        this.verificationCreationDateTime = Timestamp.valueOf(ZonedDateTime.now(ZoneId.of("Asia/Kolkata")).toLocalDateTime());
    }

    /**
     * @param agentEmail                   - email id of the agent who completed the verification
     * @param storePhone                   - the store phone number that was verified
     * @param verificationCoordinates      - the location the agent was at at the time of verification
     * @param verificationStatus           - whether the verification was successful/unsuccessful/incomplete
     * @param verificationCreationDateTime -is absolute time when verification had been done.
     */
    public Verification(String agentEmail, String storePhone, Coordinates verificationCoordinates, int verificationStatus, Timestamp verificationCreationDateTime) {
        this.agentEmail = agentEmail;
        this.storePhone = storePhone;
        this.verificationCoordinates = verificationCoordinates;
        this.verificationStatus = getStoreVerificationString(verificationStatus);
        this.verificationCreationDateTime = verificationCreationDateTime;
    }

    //Based on the status integral value it sets to required status string
    private String getStoreVerificationString(int verificationStatus) {
        switch (verificationStatus) {
            case VERIFICATION_UNSUCCESSFUL_INT:
                return VERIFICATION_UNSUCCESSFUL;
            case VERIFICATION_SUCCESSFUL_INT:
                return NOT_VERIFIED;
            case NOT_VERIFIED_INT:
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