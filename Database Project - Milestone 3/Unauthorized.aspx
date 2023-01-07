<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Unauthorized.aspx.cs" Inherits="Database_Project___Milestone_3.Unauthorized" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Unauthorized</title>
    <link rel="stylesheet" href="./css/bootstrap.css" />
    <script src="./js/bootstrap.js"></script>
    <style>
        body{
            padding-top: 120px; 
        }
    </style>
</head>
<body>
    <!-- Navbar -->
        <nav class="navbar fixed-top navbar-expand-lg bg-dark navbar-dark text-light p-3 mb-5">
            <p class="h2 text-warning float-left">Unauthorized access</p>
        </nav>

    <!-- Main section -->
    <form id="form1" runat="server">
        <div class="float-left p-5">
            <p>You do not have the permission to access this page on your account.</p>
            <asp:LinkButton runat="server" CssClass="btn btn-secondary" ID="return_button" onclick="returnToLogin">Return to login page</asp:LinkButton>
            <br />
            <br />
                <hr />
            <br />
        </div>
    </form>
</body>
</html>
