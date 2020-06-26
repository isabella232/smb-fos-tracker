/*
 * Copyright 2020 Google LLC
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
package com.example.fostracker.servlets;

import com.example.fostracker.models.Store;
import com.google.cloud.Timestamp;
import com.google.cloud.spanner.*;
import com.google.gson.Gson;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.util.ArrayList;
import java.util.List;

@WebServlet(value = "/stores")
public class GetStoresServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Gson gson = new Gson();
        DatabaseClient databaseClient = null;
        try {
            SpannerOptions spannerOptions = SpannerOptions.newBuilder().build();
            Spanner spanner = spannerOptions.getService();
            databaseClient = spanner.getDatabaseClient(DatabaseId.of("fos-tracker-278709", "fos-server-instance", "fos-database"));
        } catch (Exception e) {
            e.printStackTrace();
            resp.setStatus(405);
            resp.getWriter().println("Spanner connection error");
        }
        ResultSet resultSet;
        try {
            resultSet = databaseClient.singleUse().executeQuery(Statement.of("SELECT StorePhone, MerchantEmail, StoreLatitude, StoreLongitude FROM Stores"));
        } catch (SpannerException e) {
            e.printStackTrace();
            resp.setStatus(403);
            resp.getWriter().println("Unsuccessful");
            return;
        }
        resp.setStatus(200);
        while (resultSet.next()) {
            resp.getWriter().printf("StorePhone: %s, MerchantEmail: %s, StoreCoordinates:{%f, %f}\n", resultSet.getString(0), resultSet.getString(1), resultSet.getDouble(2), resultSet.getDouble(3));
        }

    }
}
