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

import com.example.fostracker.models.*;
import com.google.gson.Gson;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

import com.google.cloud.spanner.ResultSet;
import com.google.gson.JsonObject;
import com.example.fostracker.servlets.VerificationServlet.VerificationDatabaseHelper;

/**
 * Prints the Store status given Store phone from Stores table in JSON format.
 * <p>
 * This Servlet converts the ResultSet into JSON object and prints to the response on @WebServlet(value = "/store/phon/status").
 */
@WebServlet(value = "/store/phone/status")
public class GetStoreStatusByStorePhoneServlet extends HttpServlet {

    //Gson object that is used to convert Strings into JSON objects
    private Gson gson = new Gson();

    class StoreStatus {
        String status;

        StoreStatus( String status ){
            this.status = status;
        }
    }

    /**
     * HTTP Get method prints the query as response.
     *
     * @param storeDetailsRequest is GET request.
     * @param response            is HttpServletResponse object that is used to write the response.
     * @throws ServletException
     * @throws IOException
     */
    @Override
    protected void doPost(HttpServletRequest storeDetailsRequest, HttpServletResponse response) throws ServletException, IOException {

        // Reads the json String using POST request.
        String json = storeDetailsRequest.getReader().readLine();

        // sets the response to json format.
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        // output variable is used to write to response.
        PrintWriter output;
        output = response.getWriter();

        // If json is null ( No data was posted ) set the error to 403.
        if (json == null) {
            output.print("No data given");
            response.setStatus(403);
        } else {

            // Convert json string to json object to parse data.
            JsonObject jsonObj = new Gson().fromJson(json, JsonObject.class);

            // Get phone from the JSON object.
            String storePhone = jsonObj.get("storePhone").getAsString();

            StoreStatus storeAndStatus;
            String storeStatusString;
            String status = VerificationDatabaseHelper.queryStatusUsingStorePhone(storePhone);

            // If storeData is not empty then sets status to grey.
            if (status!=null) {
                storeAndStatus = new StoreStatus(status);
                storeStatusString = this.gson.toJson(storeAndStatus);
                output.println(storeStatusString);
            } else {
                storeAndStatus = new StoreStatus("grey");
                storeStatusString = this.gson.toJson(storeAndStatus);
                output.println(storeStatusString);
            }

            // Prints success message.
            output.print("Successful");
            output.flush();
        }
    }
}

