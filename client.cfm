<cfscript>
private string function callSocket2( required string host, required numeric port, required string message ) {
    var result = "";
    var socket = createObject("java", "java.net.Socket");
    var outputStream = "";
    var inputStream = "";
    var output = "";
    var input = "";
    var inputStreamReader = "";

    try {
        socket.init(arguments.host, arguments.port);
    } catch(java.net.ConnectException error) {
        throw message="#error.Message#: Could not connected to host #arguments.host# on port #arguments.port#";
    }

    if ( socket.isConnected() ) {
        outputStream = socket.getOutputStream();
        output = createObject("java", "java.io.PrintWriter").init( outputStream );
        inputStream = socket.getInputStream();
        inputStreamReader = createObject("java", "java.io.InputStreamReader").init(inputStream);
        input = createObject("java", "java.io.BufferedReader").init(inputStreamReader);
        output.println(arguments.message);
        output.println();
        output.flush();
        result = input.readLine();
        socket.close();
    } else {
        throw message="Not connected to host #arguments.host# via port #arguments.port#";
    }
    return result;
}
</cfscript>

<cfoutput>#callSocket2('localhost','2000',"Hello there, it's CF")#</cfoutput>