<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.master" AutoEventWireup="true" CodeFile="GeneralCollectionAdd.aspx.cs" Inherits="Admin_GeneralCollectionAdd" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <!-- OR for ThemeRoller styling
    <link rel="stylesheet" href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.10.3/themes/south-street/jquery-ui.css">
    <link rel="stylesheet" href="ui-southstreet.datepick.css">
    -->
    <link href="assets/Calenders/jquery.calendars.picker.css" rel="stylesheet" />
    <!-- OR for ThemeRoller styling
    <link rel="stylesheet" href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.10.3/themes/south-street/jquery-ui.css">
    <link rel="stylesheet" href="ui-southstreet.datepick.css">
    -->
    <%--    <script src="//ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js">
    </script>--%>

    <script src="assets/Calenders/jquery.plugin.js"></script>
    <!--<script src="jquery.calendars.all.js"></script><!-- Use instead of calendars, plus, and picker below -->

    <script src="assets/Calenders/jquery.calendars.js"></script>
    <script src="assets/Calenders/jquery.calendars.plus.js"></script>
    <script src="assets/Calenders/jquery.calendars.picker.js"></script>
    <!--<script src="jquery.calendars.picker.ext.js"></script><!-- Include for ThemeRoller styling -->
    <script src="assets/Calenders/jquery.calendars.ummalqura.js"></script>
    <script src="assets/Calenders/jquery.calendars.ummalqura-ar.js"></script>
    <link href="assets/Calenders/jquery.calendars.picker.css" rel="stylesheet" />
    <script>
        $(function () {
            //	$.calendars.picker.setDefaults({renderer: $.calendars.picker.themeRollerRenderer}); // Requires jquery.calendars.picker.ext.js
            var calendar = $.calendars.instance('UmmAlQura', 'ar');

            $('#ContentPlaceHolder1_popupDatepicker').calendarsPicker({ calendar: calendar });
            $('#ContentPlaceHolder1_popupDatepickerEnd').calendarsPicker({ calendar: calendar });

            $('.calendars').width = $('#ContentPlaceHolder1_popupDatepicker').width;
        });

        //function showDateStart(date) {
        //    //document.getElementById("lblStart").innerHTML = date;
        //    document.getElementById('lblStart').innerText = date;
        //}
        //function showDateEnd(date) {
        //    //document.getElementById("lblStart").innerHTML = date;
        //    document.getElementById('lblEnd').innerText = date;
        //}
        //function btnSubmetClicked() {
        //    alert(document.getElementById('ContentPlaceHolder1_popupDatepicker').value);
        //    window.location.href(window.location.href + "&SDate=" + document.getElementById('lblstart').innerText + "&EDate=" + document.getElementById('lblEnd').innerText);
        //}
    </script>
    <style type="text/css">
        option:hover {
            background-color: #0aa89e;
        }

        option:active {
            background-color: #0aa89e;
        }

        select : {
            background-color: #0aa89e;
        }

        select {
            -webkit-appearance: none;
            -moz-appearance: none;
            appearance: none;
        }

            select::-ms-expand { /* for IE 11 */
                display: none;
            }
    </style>
    <style type="text/css">
        .rblStyle label {
            float: left;
            margin-right: 5px;
            margin-left: 15px;
        }

        .textTable th {
            text-align: center;
        }

        .textTable td {
            text-align: center;
        }
    </style>

    <link href="assets\fancybox\source\jquery.fancybox.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="assets\uniform\css\uniform.default.css">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ScriptManager runat="server"></asp:ScriptManager>

    <div id="container" class="row-fluid">
        <!-- BEGIN PAGE -->
        <!-- BEGIN PAGE CONTAINER-->
        <!-- BEGIN PAGE HEADER-->
        <div class="space7"></div>
        <div class="row-fluid" style="visibility: hidden; display: none">
            <div class="span12">
                <!-- BEGIN THEME CUSTOMIZER-->
                <div id="theme-change" class="hidden-phone">
                    <i class="icon-cogs"></i>
                    <span class="settings">
                        <span class="text">Theme:</span>
                        <span class="colors">
                            <span class="color-default" data-style="default"></span>
                            <span class="color-gray" data-style="gray"></span>
                            <span class="color-purple" data-style="purple"></span>
                            <span class="color-navy-blue" data-style="navy-blue"></span>
                        </span>
                    </span>
                </div>
                <!-- END THEME CUSTOMIZER-->
                <h3 class="page-title">Form Wizard
                            <small>form wizard sample</small>
                </h3>
                <ul class="breadcrumb">
                    <li>
                        <a href="#"><i class="icon-home"></i></a><span class="divider">&nbsp;</span>
                    </li>
                    <li>
                        <a href="#">Form Stuff</a> <span class="divider">&nbsp;</span>
                    </li>
                    <li><a href="#">Form Wizard</a><span class="divider-last">&nbsp;</span></li>
                </ul>
            </div>
        </div>
        <!-- END PAGE HEADER-->
        <!-- BEGIN PAGE CONTENT-->
        <div class="row-fluid">
            <div class="span12">
                <div class="widget box blue" id="form_wizard_1">
                    <div class="widget-title">
                        <h4>
                            <i class="icon-reorder"></i>اضافة 

                        </h4>
                        <span class="tools">
                            <a href="javascript:;" class="icon-chevron-down"></a>
                            <a href="javascript:;" class="icon-remove"></a>
                        </span>
                    </div>
                    <div class="widget-body form">
                        <div id="divNotifi" runat="server" visible="false">
                            <button class="close" type="button" data-dismiss="alert">×</button>
                            <h4 class="alert-heading">
                                <asp:Label ID="lblDivNotifiTitle" runat="server"></asp:Label></h4>
                            <p id="pDivNotifiDesc" runat="server">
                            </p>
                        </div>
                        <div class="form-horizontal">
                            <div class="form-wizard">
                                <div class="navbar steps">
                                    <div class="navbar-inner">
                                        <ul class="row-fluid">
                                            <li class="span4">
                                                <a href="#tab1" data-toggle="tab" class="step active">
                                                    <span class="number">1</span>
                                                    <span class="desc"><i class="icon-ok"></i>معلومات المستفيد</span>
                                                </a>
                                            </li>
                                            <li class="span4">
                                                <a href="#tab2" data-toggle="tab" class="step">
                                                    <span class="number">2</span>
                                                    <span class="desc"><i class="icon-ok"></i>الخطوة الأخيرة</span>
                                                </a>
                                            </li>
                                            
                                        </ul>
                                    </div>
                                </div>
                                <div id="bar" class="progress progress-striped">
                                    <div class="bar"></div>
                                </div>
                                <div class="tab-content">
                                    <div class="tab-pane active" id="tab1">
                                        <h4>خطوة 1 <strong>معلومات المستفيد</strong></h4>
                                        <div class="control-group">
                                            <asp:HiddenField ID="hfVistorID" runat="server" />
                                            <asp:HiddenField ID="hfName" runat="server" />
                                            <asp:HiddenField ID="hfMobile" runat="server" />
                                            <asp:HiddenField ID="hfGender" runat="server" />
                                            <label class="control-label">رقم العضوية / رقم الهوية</label>
                                            <div class="controls">
                                                <input id="txtSearch" name="txtSearch" runat="server" type="text" class="span6">
                                                <asp:RequiredFieldValidator ID="rfvtxtSearch" runat="server" ErrorMessage="يجب ادخل رقم العضوية / رقم الهوية" ControlToValidate="txtSearch" SetFocusOnError="true" ValidationGroup="AddGroup"></asp:RequiredFieldValidator>
                                            </div>
                                        </div>
                                        <div class="control-group">
                                            <div class="control-label"></div>
                                            <div class="controls">
                                                <input id="btnsearch" type="button" class="btn-danger" value="بحث" />
                                            </div>
                                        </div>
                                        <div class="control-group">
                                            <label class="control-label">اسم المستفيد *</label>
                                            <div class="controls">
                                                <input id="txtUserName" name="txtUserName" runat="server" type="text" class="span6" disabled="disabled">
                                                <asp:RequiredFieldValidator ID="rfvtxtUserName" runat="server" ErrorMessage="يجب ادخال اسم المستفيد" ControlToValidate="txtUserName" SetFocusOnError="true" ValidationGroup="AddGroup"></asp:RequiredFieldValidator>
                                            </div>
                                        </div>
                                        <div class="control-group">
                                            <label class="control-label">رقم العضوية *</label>
                                            <div class="controls">
                                                <input id="txtUserCode" name="txtUserCode" runat="server" type="text" class="span6" disabled="disabled">
                                            </div>
                                        </div>


                                        <div class="control-group">
                                            <label class="control-label">رقم الجوال</label>
                                            <div class="controls">
                                                <input id="txtMobile" name="txtMobile" runat="server" type="text" class="span6" disabled="disabled">
                                            </div>
                                        </div>
                                        <div class="control-group">
                                            <label class="control-label">الجنس *</label>
                                            <div class="controls">
                                                <asp:Label ID="lblGender" runat="server" Text="ذكر"></asp:Label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tab-pane" id="tab2">
                                        <h4>خطوة 2 <strong>تفاصيل الخدمة</strong></h4>
                                        <div class="control-group">
                                            <label class="control-label">تاريخ الإستلام *</label>
                                            <div class="controls">
                                                <input type="text" class="span6" id="popupDatepicker" runat="server" name="txtStart" />
                                                <asp:RequiredFieldValidator ID="rfvpopupDatepicker" runat="server" ErrorMessage="يجب ادخال تاريخ الإستلام " ControlToValidate="popupDatepicker" ValidationGroup="AddGroup"></asp:RequiredFieldValidator>

                                            </div>
                                        </div>
                                        <%--<div class="control-group">
                                            <label class="control-label">تاريخ الإنتهاء</label>
                                            <div class="controls">
                                                <input type="text" class="span6" value="" id="popupDatepickerEnd" runat="server" name="txtEnd" />
                                                <span id="lblDateError" style="visibility: hidden">يجب ان يكون تاريخ الاستلام اقل من تاريخ الانتهاء</span>
                                            </div>
                                        </div>--%>
                                        <div class="control-group">
                                            <label class="control-label">رقم الكاونتر *</label>
                                            <div class="controls">
                                                <asp:DropDownList ID="ddlCounter" runat="server">
                                                    <asp:ListItem Text ="كاونتر 1" Value ="1" />
                                                    <asp:ListItem Text ="كاونتر 2" Value ="2" />
                                                    <asp:ListItem Text ="كاونتر 3" Value ="3" />
                                                    <asp:ListItem Text ="كاونتر 4" Value ="4" />
                                                    <asp:ListItem Text ="كاونتر 5" Value ="5" />
                                                    <asp:ListItem Text ="كاونتر 6" Value ="6" />
                                                    <asp:ListItem Text ="كاونتر 7" Value ="7" />
                                                   
                                                </asp:DropDownList>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="يجب ادخال عدد الكتب المستخرجة " ControlToValidate="txtNoOfBooks" ValidationGroup="AddGroup"></asp:RequiredFieldValidator>

                                            </div>
                                        </div>
                                        
                                        <div class="control-group">
                                            <label class="control-label">عدد الكتب المستخرجة *</label>
                                            <div class="controls">
                                                <input type="text" class="span6" id="txtNoOfBooks" runat="server" name="txtNoOfBooks" />
                                                <asp:RequiredFieldValidator ID="rfvtxtNoOfBooks" runat="server" ErrorMessage="يجب ادخال عدد الكتب المستخرجة " ControlToValidate="txtNoOfBooks" ValidationGroup="AddGroup"></asp:RequiredFieldValidator>

                                            </div>
                                        </div>
                                    </div>

                           
                                </div>
                                <div class="form-actions clearfix">
                                    <asp:LinkButton ID="btnSave" runat="server" OnClick="btnSave_Click" CssClass="btn btn-success button-submit" ValidationGroup="AddGroup">حفظ<i class="fa fa-check"></i></asp:LinkButton>
                                    <a href="javascript:;" class="btn btn-primary blue button-next">التالي <i class="fa fa-angle-right"></i>
                                    </a>
                                    <a href="javascript:;" class="btn button-previous">
                                        <i class="fa fa-angle-left"></i>السابق
                                    </a>

                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- END PAGE CONTENT-->
    </div>
    <!-- END PAGE CONTAINER-->

    <!-- END PAGE -->

    <script src="assets\bootstrap-wizard\jquery.bootstrap.wizard.min.js"></script>
    <script src="js\jquery.blockui.js"></script>
    <!-- ie8 fixes -->
    <!--[if lt IE 9]>
    <script src="js/excanvas.js"></script>
    <script src="js/respond.js"></script>
    <![endif]-->
    <script type="text/javascript" src="assets\chosen-bootstrap\chosen\chosen.jquery.min.js"></script>
    <script type="text/javascript" src="assets\uniform\jquery.uniform.min.js"></script>
    <script>
        jQuery(document).ready(function () {
            // initiate layout and plugins
            App.init();
        });
    </script>
    <script type="text/javascript">
        <%--        $(function () {
            $(".hellobutton").click(function () {
                PageMethods.getVistor($("#<%=txtSearchID.ClientID%>").val(),
                function (result) {
                    alert(result);
                });
        });
    });--%>


        $(function () {
            $(".divContent").hide();
            $(".bottom-wizard").hide();
            $(".h5Exist").hide()
            var vistor;
            $("#btnsearch").click(function () {
                var results = new Array();

                vistor = $("#<%=txtSearch.ClientID%>").val();
                //Without array you can use like to construct JSON object  
                // var results = { empList : [{ "ID": "1", "Name": "Manas" },   { "ID": "2", "Name": "Tester" }] };  



                $.ajax({
                    url: 'webservice.svc/getVistorByID',
                    data: '{"id":"' + vistor + '"}',
                    type: 'POST',
                    contentType: 'application/json',
                    dataType: 'json',
                    beforeSend: function () {

                    },
                    success: function (result) {
                        $("#loadMe").modal("hide");
                        $.each(result, function (index, emp) {
                            if (result.error == "true") {
                                alert("An error occurred: " & result.errorMessage);
                            } else {
                                if (emp.Name != "" && emp.Name != null) {

                                    $("#<%=txtUserName.ClientID%>").val(emp.Name);
                                    $('#<%=txtMobile.ClientID%>').val(emp.Mobile);
                                    $('#<%=hfVistorID.ClientID%>').val(emp.vistor_id);
                                    $('#<%=txtUserCode.ClientID%>').val(emp.vistor_id);
                                    $("#<%=hfName.ClientID%>").val(emp.Name);
                                    $('#<%=hfMobile.ClientID%>').val(emp.Mobile);
                                    if (!emp.Gender) {
                                        //  $('input[name="ctl00$ContentPlaceHolder1$rblGender"][value="0"]').prop('checked', true);
                                        $('#<%=lblGender.ClientID%>').text("انثى");
                                        $('#<%=hfGender.ClientID%>').val('0');
                                    }
                                    else {
                                        $('#<%=lblGender.ClientID%>').text("ذكر");
                                        $('#<%=hfGender.ClientID%>').val('1');
                                    }
                                } else {
                                    $("#myModal").modal();

                                }
                            }

                        });
                    },
                    error: function (xhr) {

                        $("#myModal").modal();

                        // alert('Request Status: ' + xhr.status + ' Status Text: ' + xhr.statusText + ' ' + xhr.responseText);
                    },
                    complete: function () {
                    },
                    failure: function (jqXHR, textStatus, errorThrown) {
                    }
                });
            });
        });








    </script>
</asp:Content>

