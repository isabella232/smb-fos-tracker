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

package com.example.fostracker.servlets.AgentServlet;

import com.example.fostracker.models.Agent;
import com.example.fostracker.models.Coordinates;
import com.example.fostracker.models.Name;
import com.google.cloud.spanner.ResultSet;
import com.google.gson.Gson;
import com.google.gson.JsonObject;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Receives email of agent as json string request and passes email and
 * HttpServletResponse resp to spanner task [task.agentAgent()] to get
 * data of agent corresponding to requested email from spanner database.
 */
@WebServlet(name = "get_agent", value = "/get_agent")
public class GetAgentServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        Gson gson = new Gson();
        String jsonString = request.getReader().readLine();
        JsonObject jsonObject = gson.fromJson(jsonString, JsonObject.class);
        String agentEmail = jsonObject.get("email").getAsString();

        Agent agent = null;
        try {
            ResultSet resultSet = SpannerQueryFunctions.getAgent(agentEmail);

            while (resultSet.next()) {
                String firstName = resultSet.getString("AgentFirstName");
                String midName = resultSet.getString("AgentMidName");
                if (midName.isEmpty()) {
                    midName = "";
                }
                String lastName = resultSet.getString("AgentLastName");
                agentEmail = resultSet.getString("AgentEmail");
                String phone = resultSet.getString("AgentPhone");
                Double latitude = resultSet.getDouble("AgentLatitude");
                Double longitude = resultSet.getDouble("AgentLongitude");
                Name agentName = new Name(firstName, midName, lastName);
                Coordinates agentPositionCoordinates = new Coordinates(latitude, longitude);
                agent = new Agent(agentName, agentEmail, phone, agentPositionCoordinates);
            }


            String jsonResponse = gson.toJson(agent);
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(jsonResponse);

        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }

    }
}
