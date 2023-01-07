<%@ Page Language="C#" AutoEventWireup="true" EnableSessionState="ReadOnly" CodeBehind="ClubRepresentative.aspx.cs" Inherits="Database_Project___Milestone_3.ClubRepresentative" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Club Representative</title>
    <link rel="stylesheet" href="./css/bootstrap.css" />
    <link rel="stylesheet" href="./fontawesome/css/fontawesome.css" />
    <link rel="stylesheet" href="./fontawesome/css/brands.css" />
    <link rel="stylesheet" href="./fontawesome/css/solid.css" />
    <script src="./js/bootstrap.js"></script>
    <style>
        body{
            padding-top: 120px; 
        }
        .icongraycolor{
            color: darkgray;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">

    <!-- Navbar -->
    <nav class="navbar fixed-top navbar-expand-lg bg-dark navbar-dark text-light p-3 mb-2">
        <a href="ClubRepresentative.aspx" style="text-decoration: none" class="h2 text-warning float-left">Club Representative</a>
        <div class="container"></div>
        <asp:LinkButton runat="server" CssClass="btn btn-secondary float-right" ID="logout_button" onclick="logout_button_click">Logout</asp:LinkButton>
    </nav>


    <!-- Main section -->
    <div class="float-left p-5">
        <h4>My Club</h4>
        <label>Information about the club you are representing.</label><br /><br />
        <asp:GridView ID="GridView1" runat="server" BackColor="White" BorderColor="#E7E7FF" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Horizontal" CssClass="table table-striped">
            <EmptyDataTemplate>Not currently representing a club</EmptyDataTemplate>
        </asp:GridView>
        <br />
        <br />
        <h4>Club Upcoming Matches</h4>
        <label>Upcoming matches of your club.</label><br /><br />
        <asp:GridView ID="GridView2" runat="server" BackColor="White" BorderColor="#E7E7FF" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Horizontal" CssClass="table table-striped">
            <EmptyDataTemplate>No upcoming matches found</EmptyDataTemplate>
        </asp:GridView>
        <br />
        <br />
        <hr />
        <br />
        <br />
        <h4>Available Stadiums from</h4>
        <i class="fa-solid fa-circle-check icon-cog icongraycolor"></i> <label> Select a starting date to display available stadiums starting from this date.</label><br /><br />
        <label></label> <small class="text-muted">Valid dates only, starting from year 1754</small>
        <asp:TextBox ID="AvDate" runat="server" Width="250px" CssClass="form-control" type="datetime-local"></asp:TextBox>
        <br />
        <asp:GridView ID="GridView3" runat="server" BackColor="White" BorderColor="#E7E7FF" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Horizontal" CssClass="table table-striped">
            <EmptyDataTemplate>No stadiums available</EmptyDataTemplate>
        </asp:GridView>
        <br />
        <asp:LinkButton runat="server" CssClass="btn btn-primary float-right" Width="200px" ID="ShowStadiums_button" onclick="ShowStadiums_button_click">Show Stadiums</asp:LinkButton>
        <br />
        <br />
        <br />
        <hr />
        <br />
        <h4>Send Host Request</h4>
        <i class="fa-solid fa-share-from-square"></i> <label>Send a request to the stadium manager of a specified stadium to host a match on it.</label><br /><br />
        <label class="text-muted">Stadium name</label>
        <asp:TextBox ID="TextBox1" runat="server" Width="250px" CssClass="form-control"></asp:TextBox>
        <br />
        <label class="text-muted">Match start date </label> <small class="text-muted">(Valid dates only, starting from year 1754)</small><br />
        <asp:TextBox ID="TextBox2" runat="server" Width="250px" CssClass="form-control" type="datetime-local"></asp:TextBox>
        <br />
        <asp:LinkButton runat="server" CssClass="btn btn-success float-right" Width="200px" ID="SendRequest_button" onclick="SendRequest_button_click">Send Request</asp:LinkButton>
        <br />
    </div>

    </form>
</body>
</html>
