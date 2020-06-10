package com.example.fostracker.models;

/**
 * Serves as a model for coordinates (stores latitudes and longitudes)
 * Will be used later to store location of an agent or verification
 */
public class Coordinates {
    double latitude;
    double longitude;

    public Coordinates(double latitude, double longitude) {
        this.latitude = latitude;
        this.longitude = longitude;
    }

    public double getLatitude() {
        return latitude;
    }

    public void setLatitude(double latitude) {
        this.latitude = latitude;
    }

    public double getLongitude() {
        return longitude;
    }

    public void setLongitude(double longitude) {
        this.longitude = longitude;
    }
}
