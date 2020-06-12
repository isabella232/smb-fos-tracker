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
 * This class contains operations that are to be done on Agents table.
 *
 * Stores required column names in constant Strings and these constants are used whenever column name needs to be referred.
 * Query the Agents table email and coordinate columns and returns ResultSet object.
 */
public class AgentDatabaseHelper {

    // Column names are stored in these constant Strings.
    public final static String TABLE_NAME = "Agents";
    public final static String COLUMN_AGENT_EMAIL = "AgentEmail";
    public final static String COLUMN_AGENT_LATITUDE = "AgentLatitude";
    public final static String COLUMN_AGENT_LONGITUDE = "AgentLongitude";

    /**
     * Query the Agents table email and coordinate columns
     *
     * @return ResultSet object that refers to all rows in agents table and corresponding columns
     */
    public static ResultSet queryAgentsEmailAndCoordinatesData() {

        ResultSet agentsData =
                SpannerClient.getDatabaseClient()
                        .singleUse()
                        .executeQuery(Statement.of("SELECT " + COLUMN_AGENT_EMAIL + ", "
                                + COLUMN_AGENT_LATITUDE + ", " + COLUMN_AGENT_LONGITUDE
                                + " FROM " + TABLE_NAME));

        return agentsData;
    }
}
