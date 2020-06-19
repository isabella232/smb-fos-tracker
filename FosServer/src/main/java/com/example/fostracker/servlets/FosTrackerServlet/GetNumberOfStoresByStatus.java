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

import com.example.fostracker.models.Coordinates;
import com.example.fostracker.models.Agent;
import com.google.gson.Gson;
import com.example.fostracker.servlets.AgentServlet.SpannerQueryFunctions;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;

import com.google.cloud.spanner.ResultSet;

/**
 * Prints the total number of stores by verification status in JSON format.
 * <p>
 * This Servlet converts the ResultSet into JSON object and prints to the response on @WebServlet(value = "/number_of_stores_by_status").
 */

@WebServlet(value = "/number_of_stores_by_status")
public class GetNumberOfStoresByStatus extends HttpServlet {

    // Gson object that is used to convert Strings into JSON objects
    private Gson gson = new Gson();

    /**
     * HTTP Get method prints the query as response.
     *
     * @param request  is GET request.
     * @param response is HttpServletResponse object that is used to write the response.
     * @throws ServletException
     * @throws IOException
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        // sets the response to json format.
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        // output variable is used to write to response.
        PrintWriter output;
        output = response.getWriter();

        // Calling function to query the database and saving the result in numberOfMerchantsByStatus
        ResultSet numberOfStoresByStatus = SpannerQueryFunctions.getNumberOfStoresByStatus();

        // HashMap for storing the number of merchants in each status category.
        HashMap<String, Long> statusToNumberOfStoresMap = new HashMap<>();

        // If data is not empty then prints all the rows else prints "No data exists".
        if (numberOfStoresByStatus.next()) {

            // Loop through all rows and key as verification status and value as number of stores in hashmap.
            do {
                Long value = numberOfStoresByStatus.getLong("NumberOfStores");
                String key = "UNVISITED";
                if (numberOfStoresByStatus.isNull("VerificationStatus") == false) {
                    key = numberOfStoresByStatus.getString("VerificationStatus");
                }
                statusToNumberOfStoresMap.put(key, value);

            } while (numberOfStoresByStatus.next());
            
            String responseJson = gson.toJson(statusToNumberOfStoresMap);
            output.write(responseJson);
            numberOfStoresByStatus.close();
        } else {
            response.setStatus(403);
            output.print("No data exists");
            output.flush();
        }
        output.flush();
    }

}

