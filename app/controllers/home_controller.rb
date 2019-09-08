class HomeController < ApplicationController
  def index
  	require 'net/http'
  	require 'json'
  	@url = 'http://www.airnowapi.org/aq/observation/zipCode/current/?format=application/json&zipCode=10475&distance=0&API_KEY=D2B47CFE-EDB7-46AC-9843-ACEF5E8AC98B'
  	@uri = URI(@url)
  	@response = Net::HTTP.get(@uri)
  	@output = JSON.parse(@response)
  	@area = ""
  	# check for empty results
  	if @output.empty?
  		@final_output = "Error"
  		@color= "red" 
  	else
  		@final_output = @output[0]["AQI"]
  		@area = @output[0]["ReportingArea"] 
    	@message = ""

    	if (0...50) === @final_output

  		@color="green"
  		@message = ". Today the air at " + @area  + " is very good"
  		elsif (51...100) === @final_output
  		@color="yellow"  
  		@message = ".  Today the air at " + @area  + " is moderate" 
  		elsif (101...150) === @final_output
  		@color="orange"  
  		@message = ". Today the air at " + @area  + " is unhealthy for sensitive groups" 
  		
  		end

  	end

  	
  	def zipcode
      @zip_query = params[:zipcode]
      if params[:zipcode] == ""
        @zip_query = "Hey you forgot to enter a zipcode !"
      elsif params[:zipcode]

        require 'net/http'
        require 'json'
        @url = 'http://www.airnowapi.org/aq/observation/zipCode/current/?format=application/json&zipCode='+ @zip_query +'&distance=0&API_KEY=D2B47CFE-EDB7-46AC-9843-ACEF5E8AC98B'
        @uri = URI(@url)
        @response = Net::HTTP.get(@uri)
        @output = JSON.parse(@response)
        @area = ""
        # check for empty results
        if @output.empty?
          @final_output = "Error"
          @color= "red" 
        else
          @final_output = @output[0]["AQI"]
          @area = @output[0]["ReportingArea"] 
          @message = ""

            if (0...50) === @final_output

            @color="green"
            @message = ". Today the air at " + @area  + " is very good"
            elsif (51...100) === @final_output
            @color="yellow"  
            @message = ".  Today the air at " + @area  + " is moderate" 
            elsif (101...150) === @final_output
            @color="orange"  
            @message = ". Today the air at " + @area  + " is unhealthy for sensitive groups" 
      
       end
      end
          
    end


  	end

    
    
  end



end

