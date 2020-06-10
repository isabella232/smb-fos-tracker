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

import com.example.fostracker.models.Coordinates;
import com.example.fostracker.models.Verification;
import com.google.gson.Gson;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

import com.google.cloud.spanner.ResultSet;

@WebServlet(value = "/verification")
public class GetStoreVerificationsServlet extends HttpServlet {

    private Gson gson = new Gson();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        PrintWriter output;
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        output = response.getWriter();

        Verification verificationDataIterator;
        String verificationDataIteratorString;

        ResultSet verificationData = VerificationDatabaseHelper.queryData(output);

        if (verificationData.next()) {
            int columnAgentEmailIndex = verificationData.getColumnIndex(VerificationDatabaseHelper.COLUMN_AGENT_EMAIL);
            int columnStorePhoneIndex = verificationData.getColumnIndex(VerificationDatabaseHelper.COLUMN_STORE_PHONE);
            int columnVerificationLatitudeIndex = verificationData.getColumnIndex(VerificationDatabaseHelper.COLUMN_VERIFICATION_LATITUDE);
            int columnVerificationLongitudeIndex = verificationData.getColumnIndex(VerificationDatabaseHelper.COLUMN_VERIFICATION_LONGITUDE);
            int columnVerificationStatusIndex = verificationData.getColumnIndex(VerificationDatabaseHelper.COLUMN_VERIFICATION_STATUS);
            int columnVerificationTimeIndex = verificationData.getColumnIndex(VerificationDatabaseHelper.COLUMN_VERIFICATION_TIME);

            do {
                verificationDataIterator = new Verification(verificationData.getString(columnAgentEmailIndex),
                        verificationData.getString(columnStorePhoneIndex),
                        new Coordinates(verificationData.getDouble(columnVerificationLatitudeIndex),
                                verificationData.getDouble(columnVerificationLongitudeIndex)),
                        getStatusInt(verificationData.getString(columnVerificationStatusIndex)));
                verificationDataIteratorString = this.gson.toJson(verificationDataIterator);
                output.printf(verificationDataIteratorString);
            } while (verificationData.next());

        } else {
            output.print("Please enter data. No data exists");
            output.flush();
        }
        output.print("Successful");
        output.flush();
    }

    private static int getStatusInt(String status) {
        switch (status) {
            case Verification.VERIFICATION_SUCCESSFUL:
                return Verification.VERIFICATION_SUCCESSFUL_INT;
            case Verification.VERIFICATION_UNSUCCESSFUL:
                return Verification.VERIFICATION_UNSUCCESSFUL_INT;
            case Verification.NOT_VERIFIED:
                return Verification.NOT_VERIFIED_INT;
            default:
                return 1;
        }
    }
}

