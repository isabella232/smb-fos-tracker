package com.example.fostracker.models;

import java.sql.Timestamp;
import java.time.ZoneId;
import java.time.ZonedDateTime;

/** Serves as a model for store objects that will be used in to communicate information about GPay Merchants' stores
 * and businesses */
public class Verification {
    String agentID;
    String storeID;
    Coordinates verificationCoordinates;
    String verificationStatus;
    Timestamp verificationDateTime;

    /**
     * @param agentID
     * @param storeID
     * @param verificationCoordinates
     * @param verificationStatus
     * verificationDateTime is set by default to the current time of Asia/Kolkata and cannot be changed later
     */
    public Verification(String agentID, String storeID, Coordinates verificationCoordinates, String verificationStatus) {
        this.agentID = agentID;
        this.storeID = storeID;
        this.verificationCoordinates = verificationCoordinates;
        this.verificationStatus = verificationStatus;
        this.verificationCreationDateTime = Timestamp.valueOf(ZonedDateTime.now(ZoneId.of("Asia/Kolkata")).toLocalDateTime());
    }

    public String getAgentID() {
        return agentID;
    }

    public void setAgentID(String agentID) {
        this.agentID = agentID;
    }

    public String getStoreID() {
        return storeID;
    }

    public void setStoreID(String storeID) {
        this.storeID = storeID;
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