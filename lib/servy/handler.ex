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
        # conv means conversation between the browser and our server.
        # we only can assing a new value to the key resp_body beceause it already exists. If we tried to assing conv a new key, the compiler wont let us do it.        
        %{ conv | resp_body: "Bears, Lions, Tigers"}
    end

    def format_response(conv) do
        # TODO: Use values in the map to create an HTTP response string        
        """
        HTTP/1.1 200 OK
        Content-Type: text/html
        Content-Length: #{String.length(conv.resp_body)}
        
        #{conv.resp_body}
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