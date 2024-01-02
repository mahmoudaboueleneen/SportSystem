<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SportsAssociationManager.aspx.cs" Inherits="Database_Project___Milestone_3.SportsAssociationManager" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Sports Association Manager</title>
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
        <nav class="navbar fixed-top navbar-expand-lg bg-dark navbar-dark text-light p-3 mb-2">
            <a href="SportsAssociationManager.aspx" style="text-decoration: none" class="h2 text-warning float-left">Sports Association Manager</a>
            <div class="container"></div>
            <asp:LinkButton runat="server" CssClass="btn btn-secondary float-right" ID="logout_button" onclick="logout_button_click">Logout</asp:LinkButton>
        </nav>

        <!-- Main section -->
        <div class="float-left p-5">
            <h4>Add match</h4>
            <label>Add a match in the system with the following data. Club names can be a maximum of twenty (20) characters. Clubs MUST already exist on the system and their names must be entered exactly as they are on the system (case sensitive).</label><br /><br />
            Host club name<br />
            <asp:TextBox ID="TextBox2" runat="server" Width="250px" CssClass="form-control"></asp:TextBox>
            <br />
            Guest club name<br />
            <asp:TextBox ID="TextBox3" runat="server" Width="250px" CssClass="form-control"></asp:TextBox>
            <br />
            Start time<br />
            <asp:TextBox ID="TextBox4" runat="server" type="datetime-local" Width="250px" CssClass="form-control"></asp:TextBox>
            <small class="text-muted">Valid dates only, years starting from 1754.</small><br />
            <br />
            End time<br />
            <asp:TextBox ID="TextBox5" runat="server" type="datetime-local" Width="250px" CssClass="form-control"></asp:TextBox>
            <small class="text-muted">Valid dates only, years starting from 1754.</small><br />
            <br />
            <asp:LinkButton runat="server" CssClass="btn btn-success float-right" ID="AddMatch_Button" onclick="AddMatch_Button_Click">Add Match</asp:LinkButton>
            <br />
            <br />
            <br />
            <br />
            <h4>Delete match</h4>
            <label>Delete a match from the system that matches the following data. Club names can be a maximum of twenty (20) characters. Club MUST already exist on the system and its name must be entered exactly as they are on the system (case sensitive).</label><br /><br />
            Host club name<br />
            <asp:TextBox ID="TextBox6" runat="server" Width="250px" CssClass="form-control"></asp:TextBox>
            <br />
            Guest club name<br />
            <asp:TextBox ID="TextBox7" runat="server" Width="250px" CssClass="form-control"></asp:TextBox>
            <br />
            Start time<br />
            <asp:TextBox ID="TextBox8" runat="server" type="datetime-local" Width="250px" CssClass="form-control"></asp:TextBox>
            <small class="text-muted">Valid dates only, years starting from 1754.</small><br />
            <br />
            End time<br />
            <asp:TextBox ID="TextBox9" runat="server" type="datetime-local" Width="250px" CssClass="form-control"></asp:TextBox>
            <small class="text-muted">Valid dates only, years starting from 1754.</small><br />
            <br />
            <asp:LinkButton runat="server" CssClass="btn btn-danger float-right" ID="Button2" onclick="DeleteMatch_Button_Click">Delete Match</asp:LinkButton>
            <br />
            <br />
            <br />
            <br />
            <h4>Upcoming matches</h4>
            <label>All upcoming matches stored in the system.</label><br /><br />
            <asp:GridView ID="GridView1" runat="server" BackColor="White" BorderColor="#E7E7FF" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Horizontal" CssClass="table table-striped">
                <EmptyDataTemplate>No matches found</EmptyDataTemplate>
            </asp:GridView>
            <br />


            <br />
            <h4>Played matches</h4>
            <label>All played matches stored in the system.</label><br /><br />
            <asp:GridView ID="GridView2" runat="server" BackColor="White" BorderColor="#E7E7FF" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Horizontal" CssClass="table table-striped">
                <EmptyDataTemplate>No matches found</EmptyDataTemplate>
            </asp:GridView>
            <br />
            <br />
            <h4>Clubs never matched</h4>
            <label>These clubs have never faced each other in a match.</label><br /><br />
            <asp:GridView ID="GridView3" runat="server" BackColor="White" BorderColor="#E7E7FF" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Horizontal" CssClass="table table-striped">
                <EmptyDataTemplate>No records available</EmptyDataTemplate>
            </asp:GridView>
            <br />
            <br />
            <br />
        </div>
    </form>
</body>
</html>
