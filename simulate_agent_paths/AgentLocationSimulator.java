import java.io.BufferedReader;
import java.io.FileReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLConnection;
import java.nio.charset.StandardCharsets;

/**
 * Sends post requests to "https://fos-tracker-278709.an.r.appspot.com/update_agent_location"
 * for updating latitude and longitude of agent in database whose coordinates are
 * given in the CoordinatesFile.
 */
class ThreadforSendingLocationofAgent extends Thread{

    String CoordinatesFile;
    ThreadforSendingLocationofAgent(String CoordinatesFile){
        this.CoordinatesFile = CoordinatesFile;
    }

    @Override
    public void run(){
        try{
            String email, latitude, longitude;
            BufferedReader br = new BufferedReader(new FileReader(CoordinatesFile));
            email = br.readLine();
            String latitude_longitude = br.readLine();
            while (latitude_longitude!=null){

                String[] latitude_longitude_tuple = latitude_longitude.split(" ");
                latitude = latitude_longitude_tuple[0];
                longitude = latitude_longitude_tuple[1];
                String jsonRequest = "{\"email\":\""+email+"\",\"latitude\":"+latitude+",\"longitude\":"+longitude+"}";
                byte[] out = jsonRequest.getBytes(StandardCharsets.UTF_8);
                int length = out.length;

                URL url = new URL("https://fos-tracker-278709.an.r.appspot.com/update_agent_location");
                URLConnection con = url.openConnection();
                HttpURLConnection http = (HttpURLConnection)con;
                http.setRequestMethod("POST"); // PUT is another valid option
                http.setDoOutput(true);

                http.setFixedLengthStreamingMode(length);
                http.setRequestProperty("Content-Type", "application/json; charset=UTF-8");
                http.connect();
                try(OutputStream os = http.getOutputStream()) {
                    os.write(out);
                }

                latitude_longitude = br.readLine();
                // Coordinates are updated every 2 seconds
                sleep(2000);
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
            ThreadforSendingLocationofAgent agentTransistion = new ThreadforSendingLocationofAgent(args[i]);
            agentTransistion.start();
        }
    }
}