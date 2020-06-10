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

import com.fasterxml.jackson.core.io.UTF8Writer;
import com.google.gson.Gson;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.example.fostracker.models.Verification;

@WebServlet(value = "/verifications/new")
public class AddStoreVerificationStatusServlet extends HttpServlet {

    private Gson gson = new Gson();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String json = request.getReader().readLine();

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter pw = response.getWriter();
        pw.write("Success");

        Verification newVerification = gson.fromJson(json, Verification.class);

       boolean insertSuccessful = VerificationDatabaseHelper.writeData(newVerification, pw);
       if(insertSuccessful){
            response.setStatus(200);
            response.getWriter().println("Successful");
       } else {
            response.setStatus(403);
            response.getWriter().println("Unsuccessful");
       }
    }
}
