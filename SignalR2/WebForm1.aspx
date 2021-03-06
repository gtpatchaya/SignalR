﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm1.aspx.cs" Inherits="SignalR2.WebForm1" %>
<!DOCTYPE html>
<html>
<head>
    <title>SignalR Simple Chat</title>
    <style type="text/css">
        .container {
            background-color: #99CCFF;
            border: thick solid #808080;
            padding: 20px;
            margin: 20px;
        }
    </style>
</head>
<body>
   <div class="container">
        <div id="yourname"></div>
        <input type="hidden" id="displayname" />
        Send to <input type="text" id="to" size="5" /> Message <input type="text" id="message" />
        <input type="button" id="sendmessage" value="Send" />
        <ul id="discussion"></ul>
    </div>
     <!--Script references. -->
    <!--Reference the jQuery library. -->
  <%--  <script src="/Scripts/jquery-3.4.1.m    in.js"></script>--%>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <!--Reference the SignalR library. -->
    <script src="/Scripts/jquery.signalR-2.4.1.js"></script>
    <!--Reference the autogenerated SignalR hub script. -->
    <script src="signalr/hubs"></script>
    <!--Add script to update the page and send messages.-->
    <script type="text/javascript">
        $(function () {

            // Declare a proxy to reference the hub.
            var chat = $.connection.myHub1;

            // Create a function that the hub can call to broadcast messages.
            chat.client.broadcastMessage = function (name, to, message) {
                // Html encode display name and message.
                if (to == $('#displayname').val()) {
                    var encodedName = $('<div />').text(name).html();
                    var encodedMsg = $('<div />').text(message).html();
                    // Add the message to the page.
                    $('#discussion').append('<li><strong>' + encodedName
                        + '</strong>:&nbsp;&nbsp;' + encodedMsg + '</li>');
                }
            };


            // Get the user name and store it to prepend to messages.
            $('#displayname').val(prompt('Enter your name:', ''));
            $('#yourname').html('Your name = ' + $('#displayname').val());

            // Set initial focus to message input box.
            $('#message').focus();
            // Start the connection.
            $.connection.hub.start().done(function () {
                $('#sendmessage').click(function () {
                    // Call the Send method on the hub.
                    chat.server.myChatSend($('#displayname').val(), $('#to').val(), $('#message').val());
                    // Clear text box and reset focus for next comment.
                    $('#message').val('').focus();
                });
            });



        });
    </script>
</body>
</html>