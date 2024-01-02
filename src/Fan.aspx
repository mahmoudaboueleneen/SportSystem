<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Fan.aspx.cs" Inherits="Database_Project___Milestone_3.Fan" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Fan</title>
    <link rel="stylesheet" href="./css/bootstrap.css" />
    <link rel="stylesheet" href="./fontawesome/css/fontawesome.css" />
    <link rel="stylesheet" href="./fontawesome/css/brands.css" />
    <link rel="stylesheet" href="./fontawesome/css/solid.css" />
    <script src="./js/bootstrap.js"></script>
    <style>
        body {
            padding-top: 120px; 
        }
        .greeniconcolor{
            color: mediumspringgreen;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">

    <!-- Navbar -->
        <nav class="navbar fixed-top navbar-expand-lg bg-dark navbar-dark text-light p-3 mb-5">
            <a href="Fan.aspx" style="text-decoration: none" class="h2 text-warning float-left">Fan</a>
            <div class="container"></div>
            <asp:LinkButton runat="server" CssClass="btn btn-secondary float-right" ID="logout_button" onclick="logout_button_click">Logout</asp:LinkButton>
        </nav>

    <!-- Main section -->
        <div class="float-left p-5">
            <h4>Available matches from:</h4>
            <p>Select a starting date to display matches with tickets available to purchase.</p>
            <asp:TextBox ID="TextBox2" runat="server" Width="250px" CssClass="form-control" type="datetime-local" min="2018-06-07T00:00" max="3000-06-14T00:00" OnTextChanged="TextBox2_TextChanged"></asp:TextBox>
            <br />
            <asp:GridView ID="GridView1" runat="server" BackColor="White" BorderColor="#E7E7FF" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Horizontal" CssClass="table table-striped">
                <EmptyDataTemplate>No matches with tickets available.</EmptyDataTemplate>
            </asp:GridView>
            <br />
            <asp:LinkButton runat="server" CssClass="btn btn-primary btn-md" ID="ShowStadiums_button" onclick="ShowStadiums_button_click">Show Stadiums</asp:LinkButton>
            <br />
            <br />
            <br />
            <br />
            <h4>Purchase Ticket</h4><i class="fa-solid fa-ticket icon-cog greeniconcolor"></i> <label> </label>
            Select a match to buy a ticket for.
            <br />
            <br />
            <asp:DropDownList ID="ddl" Width="250px" CssClass="form-control" runat="server">
            </asp:DropDownList>
            <asp:textbox id="Message_Box" runat="server" CssClass="border border-white text-success bg-white" ReadOnly="true" IsHitTestVisible="False" />
            <br />
            <asp:LinkButton runat="server" CssClass="btn btn-success btn-md" ID="PurchaseTicket_button" onclick="PurchaseTicket_button_click">Buy Ticket</asp:LinkButton>
        </div>
    </form>
</body>
</html>
