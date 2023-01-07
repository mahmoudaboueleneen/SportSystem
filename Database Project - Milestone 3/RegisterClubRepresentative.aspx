﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RegisterClubRepresentative.aspx.cs" Inherits="Database_Project___Milestone_3.RegisterClubRepresentative" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Register - Club Representative</title>
    <link rel="stylesheet" href="./css/bootstrap.css" />
    <link rel="stylesheet" href="./fontawesome/css/fontawesome.css" />
    <link rel="stylesheet" href="./fontawesome/css/brands.css" />
    <link rel="stylesheet" href="./fontawesome/css/solid.css" />
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
        <a href="RegisterClubRepresentative.aspx" style="text-decoration: none" class="h2 text-white float-left">Register | Club Representative</a>
        <div class="container"></div>
        <asp:LinkButton runat="server" CssClass="btn btn-secondary float-right" ID="login_button" onclick="login_button_click">Login</asp:LinkButton>
    </nav>

    <!-- Main section -->
        <div class="float-center p-5">
            <h4>Registration</h4>
            <medium class="text-muted">Register on the system as a Club Representative. You will have access to view and manage matters related to your represented club.</medium><br />
            <span class="text-danger h6">Please note that all fields below are required *.</span><br /><br />
            <small class="text-muted">Name, username, password and club name can be a maximum of twenty (20) characters. For club name, the club must already exist on the system. You must enter the club name exactly as it is on the system (case sensitive).</small><br />
            <br />

            <div class="input-group mb-3" style="width: 340px">
                <div class="input-group-prepend" style="width: 42px">
                 <span class="input-group-text" id="basic-addon1">‎‎ <i class="fa-solid fa-signature"></i></span>
             </div>
             <asp:TextBox ID="name1" runat="server" placeholder="Name" CssClass="form-control"></asp:TextBox>
            </div>

            <div class="input-group mb-3" style="width: 340px">
                <div class="input-group-prepend" style="width: 42px">
                 <span class="input-group-text" id="basic-addon2">‎‎ <i class="fa-solid fa-user"></i></span>
             </div>
             <asp:TextBox ID="username1" runat="server" placeholder="Username" CssClass="form-control"></asp:TextBox>
            </div>

            <div class="input-group mb-3" style="width: 340px">
                <div class="input-group-prepend" style="width: 42px">
                 <span class="input-group-text" id="basic-addon3">‎‎ <i class="fa-solid fa-unlock-keyhole"></i></span>
             </div>
             <asp:TextBox type="password" ID="password1" runat="server" placeholder="Password" CssClass="form-control"></asp:TextBox>
            </div>

            <div class="input-group mb-3" style="width: 340px">
                <div class="input-group-prepend" style="width: 42px">
                 <span class="input-group-text" id="basic-addon4">‎‎ <i class="fa-solid fa-users-line"></i></span>
             </div>
             <asp:TextBox ID="clubname1" runat="server" placeholder="Club Name (must already exist)" CssClass="form-control"></asp:TextBox>
            </div>

            <!--
            Name<br />
            <asp:TextBox ID="name" runat="server" Width="250px" CssClass="form-control"></asp:TextBox>
            <small class="text-muted">Can't be empty, maximum of twenty (20) characters.</small><br />
            <br />
            Username<br />
            <asp:TextBox ID="username" runat="server" Width="250px" CssClass="form-control"></asp:TextBox>
            <small class="text-muted">Can't be empty, maximum of twenty (20) characters.</small><br />
            <br />
            Password<br />
            <asp:TextBox ID="password" runat="server" type="password" Width="250px" CssClass="form-control"></asp:TextBox>
            <small class="text-muted">Can't be empty, maximum of twenty (20) characters.</small><br />
            <br />
            Club name (must already exist)<br />
            <asp:TextBox ID="clubname" runat="server" Width="250px" CssClass="form-control"></asp:TextBox>
            <small class="text-muted">Can't be empty, maximum of twenty (20) characters.</small><br />
            <br />
            -->

            <br />
            <asp:LinkButton runat="server" CssClass="btn btn-primary btn-md float-right" Width="340px" ID="register_button" onclick="register_button_click">Register</asp:LinkButton>
        </div>
    </form>
</body>
</html>
