<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Database_Project___Milestone_3.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>SportSystem - log in or register</title>
    <link rel="stylesheet" href="./css/bootstrap.css" />
    <link rel="stylesheet" href="./fontawesome/css/fontawesome.css" />
    <link rel="stylesheet" href="./fontawesome/css/brands.css" />
    <link rel="stylesheet" href="./fontawesome/css/solid.css" />
    <script src="./js/bootstrap.js"></script>
    <style>
        .footer {
            position: fixed;
            left: 0;
            bottom: 0;
            height: 5px;
            width: 100%;
            color: white;
            text-align: center;
        }
        .iconcolor{
            color: #0d6efd;
        }
    </style>
</head>
<body>
    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg bg-dark navbar-dark text-light p-3 mb-5">
        <div class="container">
            <span class="h2 text-white">Welcome</span>
            <button class="btn btn-secondary" type="button" data-bs-toggle="collapse" data-bs-target="#reg">
                <span>Register</span>
            </button>

            <div class="collapse" id="reg">
                <ul class="navbar-nav">
                    <li class="nav-item">
                        <a href="RegisterFan.aspx" class="nav-link">Register as Fan</a>
                    </li>
                    <li class="nav-item">
                        <a href="RegisterSportsAssociationManager.aspx" class="nav-link">Register as Sports Association Manager</a>
                    </li>
                    <li class="nav-item">
                        <a href="RegisterClubRepresentative.aspx" class="nav-link">Register as Club Representative</a>
                    </li>
                    <li class="nav-item">
                        <a href="RegisterStadiumManager.aspx" class="nav-link">Register as Stadium Manager</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Main section -->
    <div class="d-flex flex-row bg-white px-5">
        <div class="container">
            <form id="form1" runat="server">
                <h2>System login</h2>
                <medium class="text-muted">Sign in to your account on SportSystem.</medium><br /><br />
                <div class="container">
                    <i class="fa-solid fa-ranking-star icon-cog iconcolor"></i>
                </div>
                <br />
                <p class="text-muted">Username<br />
                <asp:TextBox ID="username" runat="server" OnTextChanged="TextBox1_TextChanged" Width="250px" CssClass="form-control float-center"></asp:TextBox>
                </p>
                <p class="text-muted">
                Password<br /><asp:TextBox ID="password" runat="server" type="password" Width="250px" CssClass="form-control float-center"></asp:TextBox>
                </p>
                <br />
                <asp:LinkButton runat="server" CssClass="btn btn-primary btn-md" ID="login_button" Width="170px" onclick="login_button_click">Login</asp:LinkButton>
                <br />
                <br />
                <br />
                <br />
                <asp:textbox id="Message_Box" runat="server" CssClass="border border-white text-success bg-white" IsHitTestVisible="False" Focusable="False" />
                <br />
                <hr />
                <small class="text-muted">Courtesy of Team 70 · German University in Cairo · (CSEN501) Database I Project · Winter Semester 2022.</small>
                <br />
            </form>
        </div>
     </div>
</body>
</html>
