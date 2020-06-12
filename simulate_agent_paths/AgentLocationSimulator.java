import java.io.BufferedReader;
import java.io.FileReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLConnection;
import java.nio.charset.StandardCharsets;

/**
 * Class for holding details of agent that are required to change his/her location in
 * spanner.
 * @param AgentEmail is the email address with which agent is registered in database
 * @param AgentLatitude is current latitude of agent's location
 * @param AgentLongitude is current longitude of agent's location
 */
class AgentLocationInfo{
    String AgentEmail;
    double AgentLatitude;
    double AgentLongitude;
    String toJson(){
        return "{"
                + "\"email\":\"" + AgentEmail + "\","
                + "\"latitude\":" + Double.toString(AgentLatitude) + ","
                + "\"longitude\":" + Double.toString(AgentLongitude)
                + "}";
    }
    AgentLocationInfo(String email, double latitude, double longitude){
        this.AgentEmail = email;
        this.AgentLatitude = latitude;
        this.AgentLongitude = longitude;
    }
}

/**
 * Sends post requests to "https://fos-tracker-278709.an.r.appspot.com/update_agent_location"
 * for updating latitude and longitude of agent in database whose coordinates are
 * given in the CoordinatesFile.
 */
class ThreadForSendingLocationOfAgent extends Thread{
    private static final int UPDATE_TIME_IN_MILLISECONDS = 2000;
    String CoordinatesFile;
    ThreadForSendingLocationOfAgent(String CoordinatesFile){
        this.CoordinatesFile = CoordinatesFile;
    }

    @Override
    public void run(){
        try{
            String email;
            double latitude, longitude;
            BufferedReader br = new BufferedReader(new FileReader(CoordinatesFile));
            email = br.readLine();
            String latitude_longitude = br.readLine();
            while (latitude_longitude!=null){

                String[] latitude_longitude_tuple = latitude_longitude.split(" ");
                latitude = Double.parseDouble(latitude_longitude_tuple[0]);
                longitude = Double.parseDouble(latitude_longitude_tuple[1]);
                AgentLocationInfo agent = new AgentLocationInfo(email, latitude, longitude);
                String jsonRequest = agent.toJson();
                byte[] out = jsonRequest.getBytes(StandardCharsets.UTF_8);
                int length = out.length;

                URL url = new URL("https://fos-tracker-278709.an.r.appspot.com/update_agent_location");
                URLConnection con = url.openConnection();
                HttpURLConnection http = (HttpURLConnection)con;
                http.setRequestMethod("POST");
                http.setDoOutput(true);

                http.setFixedLengthStreamingMode(length);
                http.setRequestProperty("Content-Type", "application/json; charset=UTF-8");
                http.connect();
                try(OutputStream os = http.getOutputStream()) {
                    os.write(out);
                }

                latitude_longitude = br.readLine();
                // Coordinates are updated every 2 seconds
                sleep(UPDATE_TIME_IN_MILLISECONDS);
            }
        }
        catch(Exception e){
            e.printStackTrace();
        }finally {
        }
    }
}


public class AgentLocationSimulator{
    /**
     * Takes simulation files of different agents as arguments from command line.
     * Runs a separate thread for updating latitudes and longitudes for every agent.
     * @param args List of command line arguments. Element of this list represents
     *             name of a simulation file. Each simulation file contains email of
     *             agent in first row followed by coordinates of his/her path.
     */
    public static void main(String[] args) {
        for (int i = 0; i < args.length; i++){
            ThreadForSendingLocationOfAgent agentTransistion = new ThreadForSendingLocationOfAgent(args[i]);
            agentTransistion.start();
        }
    }
}