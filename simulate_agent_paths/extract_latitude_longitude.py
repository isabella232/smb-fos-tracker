"""
	Generate direction path on Google maps and paste the URL to https://mapstogpx.com/
	Click on "Let's go" to generate gpx file. 
	In extract_latitude_longitude.py change the following things
	    a. gpx file in Input_GPX_File.
	    b. name of output file in Output_Text_file.
	    c. email of agent in Agent_Email
	This will generate text file with agent email followed by gps coordinates
"""

Input_GPX_File = "path_coordinate_files/mapstogpx20200610_055123.gpx"
Agent_Email = "example@gmail.com"

# Default output file name is Agent_Email_path_coordinates 
Output_Text_File = Agent_Email+"_path_coordinates"

file_in = open(Input_GPX_File)
file_out = open(Output_Text_File, "w+")

file_out.write(Agent_Email+"\n")

for row in file_in:
	if row.find("<trkpt ") != -1:
		row = row.strip("\n")
		row = row[:-1]
		row = row.strip()
		latitude_longitude = row.split()
		latitude = latitude_longitude[1]
		longitude = latitude_longitude[2]
		latitude_label_value = latitude.split("=")
		longitude_label_value = longitude.split("=")
		latitude_value = float(latitude_label_value[1][1:-1])
		longitude_value = float(longitude_label_value[1][1:-1]) 
		file_out.write(str(latitude_value)+" "+str(longitude_value)+"\n")