<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<!-- BEGIN HEAD -->
<head>
    <meta charset="utf-8" />
    <title>Login page</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport" />
    <link href="admin\assets\bootstrap\css\bootstrap.min.css" rel="stylesheet" />
    <link href="admin\assets\font-awesome\css\font-awesome.css" rel="stylesheet" />
    <link href="admin\css\style.css" rel="stylesheet" />
    <link href="admin\css\style_responsive.css" rel="stylesheet" />
    <link href="admin\css\style_default.css" rel="stylesheet" id="style_color" />
    <style type="text/css">
        .cklabel label {
            font-size: 14px;
        }

        .cklabel input {
            float: right;
            margin: 0px 0 0 5px !important;
        }
    </style>
</head>
<!-- END HEAD -->
<!-- BEGIN BODY -->
<body id="login-body">
    <div class="login-header">
        <!-- BEGIN LOGO -->
        <div id="logo" class="center">
            <img src="admin\img\KFNL.png" alt="logo" class="center">
        </div>
        <!-- END LOGO -->
    </div>

    <!-- BEGIN LOGIN -->
    <div id="login">
        <!-- BEGIN LOGIN FORM -->
        <form id="loginform" runat="server" class="form-vertical no-padding no-margin">
            <div id ="DivMsg" runat="server" visible="false" class="alert alert-error">
                <button class="close" data-dismiss="alert">×</button>
                <strong>خطأ!</strong> اسم المستخدم او كلمة المرور غير صحيحة 
            </div>
            <div class="lock">
                <i class="icon-lock"></i>
            </div>
            <div class="control-wrap">
                <h4>تسجيل الدخول</h4>
                <div class="control-group">
                    <div class="controls">
                        <div class="input-prepend">
                            <span class="add-on"><i class="icon-user"></i></span>
                            <asp:TextBox ID="txtUserName" runat="server" placeholder="اسم المستخدم"></asp:TextBox>
                        </div>
                    </div>
                </div>
                <div class="control-group">
                    <div class="controls">
                        <div class="input-prepend">
                            <span class="add-on"><i class="icon-key"></i></span>
                            <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" placeholder="كلمة المرور"></asp:TextBox>
                        </div>
                        <div class="mtop10">
                            <div class="block-hint pull-right small">
                                <asp:CheckBox ID="chkRemberMe" runat="server" Text="تذكرني" CssClass="cklabel" />
                            </div>
                        </div>

                        <div class="clearfix space5"></div>
                    </div>

                </div>
            </div>

            <asp:Button ID="btnLogin" runat="server" CssClass="btn btn-block login-btn" Text="تسجيل الدخول" OnClick="btnLogin_Click" />
        </form>
        <!-- END LOGIN FORM -->
    </div>
    <!-- END LOGIN -->
    <!-- BEGIN COPYRIGHT -->
    <div id="login-copyright">
        مكتبة الملك فهد &copy; <span id="syear"></span>
    </div>
    <!-- END COPYRIGHT -->
    <!-- BEGIN JAVASCRIPTS -->
    <script src="admin\js\jquery-1.8.3.min.js"></script>
    <script src="admin\assets\bootstrap\js\bootstrap.min.js"></script>
    <script src="admin\js\jquery.blockui.js"></script>
    <script src="admin\js\scripts.js"></script>
    <script>
        jQuery(document).ready(function () {
            App.initLogin();
        });

    </script>
    <script>
        var d = new Date();
        var n = d.getFullYear();
        document.getElementById("syear").innerHTML = n;
    </script>
    <!-- END JAVASCRIPTS -->
</body>
<!-- END BODY -->
</html>
