defmodule Servy.Handler do

    def handle(request) do
        request 
        |> parse 
        |> route        
        |> format_response
    end

    def parse(request) do        
        # the underscore means we dont need the value or dont care about its value. So we put a _ as a wildcard variable.
        [ method, path, _ ] = request
                                |> String.split("\n")
                                |> List.first
                                |> String.split(" ")

        
        %{ method: method, path: path, resp_body: "" }
    end

    def route(conv) do 
        # TODO: Create a new map that also has the response body
        # conv means conversation between the browser and our server
        conv = %{ method: "GET", path: "/wildthings", resp_body: "Bears, Lions, Tigers" }
    end

    def format_response(conv) do
        # TODO: Use values in the map to create an HTTP response string
        """
        HTTP/1.1 200 OK
        Content-Type: text/html
        Content-Length: 20
        
        Bears, Lions, Tigers
        """
    end

end

request = """
GET /wildthings HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*

"""

response = Servy.Handler.handle(request)

IO.puts(response)