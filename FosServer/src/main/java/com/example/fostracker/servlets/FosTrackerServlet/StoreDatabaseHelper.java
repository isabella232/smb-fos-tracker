/*
 * Copyright 2019 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package com.example.fostracker.servlets.FosTrackerServlet;

import com.google.cloud.Timestamp;
import com.google.cloud.spanner.Mutation;
import com.google.cloud.spanner.ResultSet;
import com.google.cloud.spanner.SpannerException;
import com.google.cloud.spanner.Statement;

import com.example.fostracker.models.Coordinates;
import com.example.fostracker.servlets.VerificationServlet.SpannerClient;

/**
 * This class contains operations on Stores table.
 *
 * Stores required column names in constant Strings and these constants are used whenever column name needs to be referred.
 * Query the store coordinates based on store phone number in stores table
 */
public class StoreDatabaseHelper {

    // Column names are stored in these constant Strings.
    public final static String TABLE_NAME = "Stores";
    public final static String COLUMN_STORE_PHONE = "StorePhone";
    public final static String COLUMN_STORE_LATITUDE = "VerificationLatitude";
    public final static String COLUMN_STORE_LONGITUDE = "VerificationLongitude";

    // This constant stores the query store phone name
    private final static String QUERY_STORE_PHONE = "storePhone";


    /**
     * Queries the store table for store coordinates based on store phone number
     *
     * @return ResultSet object that refers to corresponding row
     */
    public static Coordinates queryStoreCoordinatesUsingStorePhone(String storePhone) {

        // store coordinates store the
        Coordinates storeCoordinates;

        // SQL statement to query store coordinates using store phone number.
        Statement statement =
                Statement.newBuilder(
                        "SELECT " + COLUMN_STORE_LATITUDE +", "
                                  + COLUMN_STORE_LONGITUDE
                        + " FROM " + TABLE_NAME
                        + " WHERE " + COLUMN_STORE_PHONE
                                   + " = @" + QUERY_STORE_PHONE)
                        .bind(QUERY_STORE_PHONE)
                        .to(storePhone)
                        .build();

        // Tries to query if it fails returns null.
        try (ResultSet storeCoordinateData = SpannerClient.getDatabaseClient().singleUse().executeQuery(statement)) {
            if (storeCoordinateData.next()) {
                int columnStoreLatitudeIndex =
                        storeCoordinateData.getColumnIndex(COLUMN_STORE_LATITUDE);
                int columnStoreLongitudeIndex =
                        storeCoordinateData.getColumnIndex(COLUMN_STORE_LONGITUDE);
                storeCoordinates = new Coordinates(storeCoordinateData.getDouble(columnStoreLatitudeIndex),
                                                    storeCoordinateData.getDouble(columnStoreLongitudeIndex));
                return storeCoordinates;
            } else{
                return  null;
            }
        } catch (SpannerException e) {
             return null;
        }
    }
}
