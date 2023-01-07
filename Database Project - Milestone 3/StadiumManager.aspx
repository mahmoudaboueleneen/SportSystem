<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="StadiumManager.aspx.cs" Inherits="Database_Project___Milestone_3.StadiumManager" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Stadium Manager</title>
    <link rel="stylesheet" href="./css/bootstrap.css" />
    <script src="./js/bootstrap.js"></script>
    <style>
        body{
            padding-top: 120px; 
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">

    <!-- Navbar -->
        <nav class="navbar fixed-top navbar-expand-lg bg-dark navbar-dark text-light p-3">
            <a href="StadiumManager.aspx" style="text-decoration: none" class="h2 text-warning float-left">Stadium Manager</a>
            <div class="container"></div>
            <asp:LinkButton runat="server" CssClass="btn btn-secondary float-right" ID="logout_button" onclick="logout_button_click">Logout</asp:LinkButton>
        </nav>

    <!-- Main section -->
        <div class="float-left p-5">
            <h4>My Stadium</h4>
            <label>Information about the club you are representing.</label><br /><br />
            <asp:GridView ID="GridView1" runat="server" BackColor="White" BorderColor="#E7E7FF" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Horizontal" CssClass="table table-striped">
                <EmptyDataTemplate>Not currently managing a stadium</EmptyDataTemplate>
            </asp:GridView>
            <br />
            <br />
        <h4>All host requests</h4>
        <label>All match host requests received from club representatives.</label><br /><br />
        <asp:GridView ID="GridView2" runat="server" BackColor="White" BorderColor="#E7E7FF" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Horizontal" CssClass="table table-striped">
            <EmptyDataTemplate>No host requests found</EmptyDataTemplate>
        </asp:GridView>
        <br />
        <hr />
        <br />
        <h4>Accept host request for a match</h4>
        <label>Accept host request of a club for a certain match on your stadium.</label><br /><br />
        Host club name<br />
        <asp:TextBox ID="TextBox1" runat="server" Width="250px" CssClass="form-control"></asp:TextBox><br />
        Guest club name<br />
        <asp:TextBox ID="TextBox2" runat="server" Width="250px" CssClass="form-control"></asp:TextBox>
        <br />
        Match start date<br />
        <asp:TextBox ID="TextBox3" runat="server" type="datetime-local" Width="250px" CssClass="form-control"></asp:TextBox>
        <small class="text-muted">Valid dates only, years starting from 1754.</small><br />
        <br />
        <asp:LinkButton runat="server" CssClass="btn btn-success float-right" ID="Button1" onclick="acceptRequest">Accept Request</asp:LinkButton>
        <br />
        <br />
        <hr />
        <br />
        <h4>Reject host request for a match</h4>
        <label>Reject host request of a club for a certain match on your stadium.</label><br /><br />
        Host club name<br />
        <asp:TextBox ID="TextBox4" runat="server" Width="250px" CssClass="form-control"></asp:TextBox>
        <br />
        Guest club name<br />
        <asp:TextBox ID="TextBox5" runat="server" Width="250px" CssClass="form-control"></asp:TextBox>
        <br />
        Match start date<br />
        <asp:TextBox ID="TextBox6" runat="server" type="datetime-local" Width="250px" CssClass="form-control"></asp:TextBox>
        <small class="text-muted">Valid dates only, years starting from 1754.</small><br />
        <br />
        <asp:LinkButton runat="server" CssClass="btn btn-danger float-right" ID="Button2" onclick="rejectRequest">Reject Request</asp:LinkButton>
        <br />
        <br />
        <br />
        <br />
        </div>
    </form>
</body>
</html>
