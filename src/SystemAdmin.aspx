<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SystemAdmin.aspx.cs" Inherits="Database_Project___Milestone_3.SystemAdmin" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>System Admin</title>
    <link rel="stylesheet" href="./css/bootstrap.css" />
    <link rel="stylesheet" href="./fontawesome/css/fontawesome.css" />
    <link rel="stylesheet" href="./fontawesome/css/brands.css" />
    <link rel="stylesheet" href="./fontawesome/css/solid.css" />
    <script src="./js/bootstrap.js"></script>
    <style type="text/css">
        body{
            padding-top: 120px; 
        }
        .blueiconcolor{
            color: dodgerblue;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">

    <!-- Navbar -->
    <nav class="navbar fixed-top navbar-expand-lg bg-dark navbar-dark text-light p-3 mb-2">
        <a href="SystemAdmin.aspx" style="text-decoration: none" class="h2 text-warning float-left">System Admin</a>
        <div class="container"></div>
        <asp:LinkButton runat="server" CssClass="btn btn-secondary float-right" ID="logout_button" onclick="logout_button_click">Logout</asp:LinkButton>
    </nav>

    <!-- Main section -->
        <div class="float-left p-5">
            <span class="h2"> Club Management </span> <i class="fa-solid fa-people-group icon-cog fa-2x"></i><br /><br /><br />
            <h4>Add Club</h4>
            <label>Create a new club with the following data and add it to the system. Club name and location can be a maximum of twenty (20) characters.</label><br /><br />
            Club name<br />
            <asp:TextBox ID="addClub_name" runat="server" Width="250px" CssClass="form-control"></asp:TextBox>
            <br />
            Club location<br />
            <asp:TextBox ID="addClub_location" runat="server" Width="250px" CssClass="form-control"></asp:TextBox>
            <br />
            <asp:LinkButton runat="server" ID="addClub_button" CssClass="btn btn-success float-right" onclick="addClub_button_click">Add Club</asp:LinkButton>
            <br />
            <br />
            <br />
            <h4>Delete Club</h4>
            <label>Delete a club that has the following name from the system. Club name can be a maximum of twenty (20) characters.</label><br /><br />
            Club name<asp:TextBox ID="deleteClub_name" runat="server" Width="250px" CssClass="form-control"></asp:TextBox>
            <br />
            <asp:LinkButton runat="server" ID="deleteClub_button" CssClass="btn btn-danger float-right" onclick="deleteClub_button_click">Delete Club</asp:LinkButton>
            <br />
            <br />
            <br />
            <hr />
            <br />
            <span class="h2"> Stadium Management </span><br /><br /><br />
            <h4>Add Stadium</h4>
            <label>Add a stadium to the system with the following data.</label><br /><br />
            Stadium name<asp:TextBox ID="addStadium_name" runat="server" Width="250px" CssClass="form-control"></asp:TextBox>
            <br />
            Stadium location<br />
            <asp:TextBox ID="addStadium_location" runat="server" Width="250px" CssClass="form-control"></asp:TextBox>
            <br />
            Stadium capacity<br />
            <asp:TextBox ID="addStadium_capacity" runat="server" Width="250px" CssClass="form-control"></asp:TextBox>
            <br />
            <asp:LinkButton runat="server" ID="addStadium_button" CssClass="btn btn-success float-right" onclick="addStadium_button_click">Add Stadium</asp:LinkButton>
            <br />
            <br />
            <br />
            <h4>Delete Stadium</h4>
            <label>Delete a stadium with the following name from the system.</label><br /><br />
            Stadium name<br />
            <asp:TextBox ID="deleteStadium_name" runat="server" Width="250px" CssClass="form-control"></asp:TextBox>
            <br />
            <asp:LinkButton runat="server" ID="deleteStadium_button" CssClass="btn btn-danger float-right" onclick="deleteStadium_button_click">Delete Stadium</asp:LinkButton>
            <br />
            <br />
            <br />
            <hr />
            <br />
            <span class="h2"> Fan Management </span> <i class="fa-solid fa-users icon-cog fa-2x"></i><br /><br /><br />
            <h4>Block Fan</h4>
            <label>Block a fan with the following National ID from using the system.</label><br /><br />
            Fan National ID<br />
            <asp:TextBox ID="blockFan_nationalID" runat="server" Width="250px" CssClass="form-control"></asp:TextBox>
            <br />
            <asp:LinkButton runat="server" ID="blockFan_button" CssClass="btn btn-danger float-right" onclick="blockFan_button_click">Block Fan</asp:LinkButton>
        </div>
    </form>
</body>
</html>
