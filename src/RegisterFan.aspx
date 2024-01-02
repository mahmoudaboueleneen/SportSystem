<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RegisterFan.aspx.cs" Inherits="Database_Project___Milestone_3.RegisterFan" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Register - Fan</title>
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
        <a href="RegisterFan.aspx" style="text-decoration: none" class="h2 text-white float-left">Register | Fan</a>
        <div class="container"></div>
        <asp:LinkButton runat="server" CssClass="btn btn-secondary float-right" ID="login_button" onclick="login_button_click">Login</asp:LinkButton>
    </nav>

    <!-- Main section -->
        <div class="float-center p-5">
            <h4>Registration</h4>
            <medium class="text-muted">Create your account on the system as a fan. You will be able to view matches and purchase tickets to attend them.</medium><br />
            <span class="text-danger h6">Please note that all fields below are required and cannot be empty. *</span><br /><br />
            <small class="text-muted">Name, username, password, national ID and address can be a maximum of twenty (20) characters. For phone number, only numbers allowed. For birth date, only valid dates allowed with years starting from 1754.</small><br />
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
                 <span class="input-group-text" id="basic-addon4">‎‎ <i class="fa-regular fa-address-card"></i></span>
             </div>
             <asp:TextBox type="text" ID="nationalid1" runat="server" placeholder="National ID" CssClass="form-control"></asp:TextBox>
            </div>

            <div class="input-group mb-3" style="width: 340px">
                <div class="input-group-prepend" style="width: 42px">
                 <span class="input-group-text" id="basic-addon5">‎‎ <i class="fa-solid fa-phone"></i></span>
             </div>
             <asp:TextBox type="text" ID="phonenumber1" runat="server" placeholder="Phone Number" CssClass="form-control"></asp:TextBox>
            </div>

            <small class="text-muted">(Birth date)</small>
            <div class="input-group mb-3" style="width: 340px">
                <div class="input-group-prepend" style="width: 42px">
                 <span class="input-group-text" id="basic-addon6">‎‎ <i class="fa-solid fa-cake-candles"></i></span>
             </div>
             <asp:TextBox type="date" ID="birthdate1" runat="server" placeholder="Birth Date" CssClass="form-control"></asp:TextBox>
            </div>

            <div class="input-group mb-3" style="width: 340px">
                <div class="input-group-prepend" style="width: 42px">
                 <span class="input-group-text" id="basic-addon7">‎‎ <i class="fa-solid fa-map-location-dot"></i></span>
             </div>
             <asp:TextBox type="text" ID="address1" runat="server" placeholder="Address" CssClass="form-control"></asp:TextBox>
            </div>

            <!--

            <i class="fa-solid fa-signature"></i> <label> </label> Name<br />
            <asp:TextBox ID="name" runat="server" Width="250px" CssClass="form-control"></asp:TextBox>
            <small class="text-muted">Can't be empty, maximum of twenty (20) characters.</small><br />
            <br />
            <i class="fa-solid fa-user"></i> <label> </label> Username<br />
            <asp:TextBox ID="username" runat="server" Width="250px" CssClass="form-control"></asp:TextBox>
            <small class="text-muted">Can't be empty, maximum of twenty (20) characters.</small><br />
            <br />
            <i class="fa-solid fa-key"></i> <label> </label> Password<br />
            <asp:TextBox ID="password" runat="server" type="password" Width="250px" CssClass="form-control"></asp:TextBox>
            <small class="text-muted">Can't be empty, maximum of twenty (20) characters.</small><br />
            <br />
            <i class="fa-regular fa-address-card"></i> <label> </label> National ID
            <br />
            <asp:TextBox ID="nationalid" runat="server" Width="250px" CssClass="form-control"></asp:TextBox>
            <small class="text-muted">Can't be empty.</small><br />
            <br />
            <i class="fa-solid fa-phone"></i> <label> </label> Phone number
            <br />
            <asp:TextBox ID="phonenumber" runat="server" Width="250px" CssClass="form-control"></asp:TextBox>
            <small class="text-muted">Only numbers allowed.</small><br />
            <br />
            <i class="fa-solid fa-cake-candles"></i> <label> </label> Birth date
            <br />
            <asp:TextBox ID="birthdate" runat="server" type="date" Width="250px" CssClass="form-control"></asp:TextBox>
            <small class="text-muted">Valid dates only, years starting from 1754.</small><br />
            <br />
            <i class="fa-solid fa-map-location-dot"></i> <label> </label> Address
            <br />
            <asp:TextBox ID="address" runat="server" Width="250px" CssClass="form-control"></asp:TextBox>
            <small class="text-muted">Can't be empty, maximum of twenty (20) characters.</small><br />
            <br />

            -->
            <br />
            <asp:LinkButton runat="server" CssClass="btn btn-primary btn-md float-right" Width="340px" ID="register_button" onclick="register_button_click">Register</asp:LinkButton>
        </div>
    </form>
</body>
</html>
