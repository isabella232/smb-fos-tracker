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

package com.example.fostracker.servlets.VerificationServlet;

import com.google.cloud.Timestamp;
import com.google.cloud.spanner.Mutation;
import com.google.cloud.spanner.ResultSet;
import com.google.cloud.spanner.SpannerException;
import com.google.cloud.spanner.Statement;

import java.util.ArrayList;
import java.util.List;
import java.io.PrintWriter;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.util.Collections;

import com.example.fostracker.models.Verification;

/**
 * This class contains all operations that are to be done on Verifications table.
 * <p>
 * Stores all column names in constant Strings and these constants are used whenever column name needs to be referred.
 * Inserts new data into verifications table.
 * Query the complete Verification table and returns ResultSet object.
 */
public class VerificationDatabaseHelper {

    // Column names are stored in these constant Strings.
    public final static String TABLE_NAME = "Verifications";
    public final static String COLUMN_AGENT_EMAIL = "AgentEmail";
    public final static String COLUMN_STORE_PHONE = "StorePhone";
    public final static String COLUMN_VERIFICATION_LATITUDE = "VerificationLatitude";
    public final static String COLUMN_VERIFICATION_LONGITUDE = "VerificationLongitude";
    public final static String COLUMN_VERIFICATION_STATUS = "VerificationStatus";
    public final static String COLUMN_VERIFICATION_TIME = "VerificationTime";

    /**
     * Writes data into verification table using Mutations
     *
     * @param newVerification is the Verification object that we wish to insert into verifications table
     * @return a boolean variable that indicates whether the insertion is successful or not
     */
    public static boolean writeData(Verification newVerification) {
        List<Mutation> verificationMutation = new ArrayList<>();
        verificationMutation.add(Mutation.newInsertBuilder(TABLE_NAME)
                .set(COLUMN_AGENT_EMAIL)
                .to(newVerification.getAgentEmail())
                .set(COLUMN_STORE_PHONE)
                .to(newVerification.getStorePhone())
                .set(COLUMN_VERIFICATION_LATITUDE)
                .to(newVerification.getVerificationCoordinates().getLatitude())
                .set(COLUMN_VERIFICATION_LONGITUDE)
                .to(newVerification.getVerificationCoordinates().getLongitude())
                .set(COLUMN_VERIFICATION_STATUS)
                .to(newVerification.getStoreVerificationStatus())
                .set(COLUMN_VERIFICATION_TIME)
                .to(Timestamp.of(java.sql.Timestamp.valueOf(ZonedDateTime.now(ZoneId.of("Asia/Kolkata")).toLocalDateTime())))
                .build());
        try {
            SpannerClient.getDatabaseClient().write(verificationMutation);
            return true;
        } catch (SpannerException e) {

            return false;
        }
    }

    /**
     * Queries the complete verifications table.
     *
     * @return ResultSet object that refers to all rows in verifications table
     */
    //change to querying using struct
    public static ResultSet queryData() {

        ResultSet verificationData =
                SpannerClient.getDatabaseClient()
                        .singleUse()
                        .executeQuery(Statement.of("SELECT " + COLUMN_AGENT_EMAIL + ", " + COLUMN_STORE_PHONE + ", "
                                + COLUMN_VERIFICATION_LATITUDE + ", " + COLUMN_VERIFICATION_LONGITUDE + ", "
                                + COLUMN_VERIFICATION_STATUS + ", " + COLUMN_VERIFICATION_TIME + ", "
                                + "FROM " + TABLE_NAME));

        return verificationData;
    }

}
