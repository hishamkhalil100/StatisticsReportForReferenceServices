<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.master" AutoEventWireup="true" CodeFile="ItemsSearch.aspx.cs" Inherits="ItemsSearch" %>

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
    <script src="//ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js">
    </script>

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
        .ss option:hover {
            background-color: #0aa89e;
        }

        .ss option:active {
            background-color: #0aa89e;
        }

        /*.ss select : {
            background-color: #0aa89e;
        }*/

        .ss first-child select {
            -webkit-appearance: none;
            -moz-appearance: none;
            appearance: none;
        }

        .ss select::-ms-expand { /* for IE 11 */
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

        .calendars-month-year {
            width: 49% !important;
        }

        .buttonCSS {
            color: black;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div class="space20"></div>
    <div class="row-fluid">
        <div class="span12">
            <!-- BEGIN SAMPLE TABLE widget-->
            <div class="widget">
                <div class="widget-title">
                    <h4><i class="icon-cogs"></i>العناصر</h4>
                    <span class="tools">
                        <a class="icon-chevron-down" href="javascript:;"></a>
                        <a class="icon-remove" href="javascript:;"></a>
                    </span>
                </div>
                <div class="widget-body">
                    <div id="divNotifi" runat="server" visible="false">
                        <button class="close" type="button" data-dismiss="alert">×</button>
                        <h4 class="alert-heading">
                            <asp:Label ID="lblDivNotifiTitle" runat="server"></asp:Label></h4>
                        <p id="pDivNotifiDesc" runat="server">
                        </p>
                    </div>
                    <div class="row-fluid">
                        <div id="divUserName" runat="server" class="span3">
                            <asp:TextBox type="text" ID="txtUserName" runat="server" CssClass="span10 " placeholder="اسم الموظف "></asp:TextBox>
                        </div>
                        <div id="divCustomerName" runat="server" class="span3">
                            <asp:TextBox ID="txtCustomerName" runat="server" CssClass="span10 " placeholder="اسم المستفيد "></asp:TextBox>
                        </div>
                        <div id="divpopupDatepicker" runat="server" class="span2">
                            <input type="text" class="span10 ss" id="popupDatepicker" runat="server" name="txtStart" placeholder="تاريخ الإستلام" />
                        </div>
                        <div id="divpopupDatepickerEnd" runat="server" class="span2">
                            <input type="text" class="span10 ss" value="" id="popupDatepickerEnd" runat="server" placeholder="تاريخ الانتهاء" />
                        </div>
                        <div class="span2 ">
                            <asp:DropDownList ID="ddlDepartment" runat="server" size="1" name="sample_1_length" aria-controls="sample_1" class="input">
                            </asp:DropDownList>
                        </div>
                        <div class="row-fluid">
                            <div class="span4 ">
                                عدد العناصر في الصفحة 
                                <asp:DropDownList ID="ddlpgSize" runat="server" size="1" name="sample_1_length" aria-controls="sample_1" class="input-mini">
                                    <asp:ListItem Value="10" Selected="selected">10</asp:ListItem>
                                    <asp:ListItem Value="25">25</asp:ListItem>
                                    <asp:ListItem Value="50">50</asp:ListItem>
                                    <asp:ListItem Value="100">100</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <div class="span4 ">
                                <asp:Button CssClass="span10 btn btn-primary " ID="btnSearch" runat="server" Text="بحث" OnClick="btnSearch_Click" />
                            </div>
                        </div>

                    </div>
                    <br />
                    <table class="table table-striped table-bordered table-advance table-hover textTable">
                        <thead>
                            <tr>
                                <th><i class="icon-briefcase"></i>&nbsp; الرقم</th>
                                <th><i class="icon-user"></i>&nbsp; اسم المستفيد</th>
                                <th><i class="icon-user"></i>&nbsp; الجوال</th>
                                <th><i class="icon-group"></i>&nbsp; الجنس</th>
                                <th><i class="icon-user-md"></i>&nbsp; الموظف</th>
                                <th><i class="icon-calendar"></i>&nbsp; تاريخ الإستلام</th>
                                <th><i class="icon-calendar"></i>&nbsp; تاريخ الإنتهاء</th>
                                <th><i class="icon-book"></i>&nbsp; التخصص العلمي</th>
                                <th><i class="icon-book"></i>&nbsp; طريقة الأرسال</th>
                                <th><i class=" icon-bookmark-empty"></i>&nbsp; الفترة</th>
                                <th><i class="icon-flag"></i>&nbsp;اللغة</th>
                                <th><i class="icon-search"></i>&nbsp;نوع البحث</th>
                                <th><i class="fa fa-cogs"></i>&nbsp;الخيارات</th>
                            </tr>
                        </thead>
                        <asp:ListView ID="dlItems" runat="server" OnItemCommand="dlUsers_ItemCommand" OnItemDataBound="dlUsers_ItemDataBound" RepeatLayout="Flow" RepeatDirection="Horizontal">
                            <ItemTemplate>
                                <tbody>
                                    <tr>
                                        <td class="highlight">
                                            <div class="success"></div>
                                            &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp;
                                            <asp:Label ID="lblNumber" runat="server" Text='<%# Eval("Number")%>' />
                                        </td>
                                        <td>
                                            <asp:Label ID="lblCustomerName" runat="server" Text='<%# Eval("Customer_Name")%>' />
                                        </td>
                                        <td>
                                            <asp:Label ID="lblMobile" runat="server" Text='<%# Eval("Mobile")%>' />
                                        </td>
                                        <td>
                                            <asp:Label ID="lblCustomerGender" runat="server" /><!-- get from code itemDataBound-->
                                        </td>
                                        <td>
                                            <asp:Label ID="lblUserName" runat="server" Text='<%# Eval("User_Name")%>' />
                                        </td>
                                        <td>
                                            <asp:Label ID="lblReceiveDate" runat="server" /><!-- get from code itemDataBound-->
                                        </td>
                                        <td>
                                            <asp:Label ID="lblFinshDate" runat="server" /><!-- get from code itemDataBound-->
                                        </td>
                                        <td>
                                            <asp:Label ID="lblDegree" runat="server" /><!-- get from code itemDataBound-->
                                        </td>
                                        <td>
                                            <asp:Label ID="lblSendMethod" runat="server" /><!-- get from code itemDataBound-->
                                        </td>
                                        <td>
                                            <asp:Label ID="lblPeriod" runat="server" /><!-- get from code itemDataBound-->
                                        </td>
                                        <td>
                                            <asp:Label ID="lblLanguage" runat="server" /><!-- get from code itemDataBound-->
                                        </td>
                                        <td>
                                            <asp:Label ID="lblSearchType" runat="server" /><!-- get from code itemDataBound-->
                                        </td>
                                        <td>
                                            <asp:LinkButton ID="lnkbtnEdit" runat="server" CssClass="btn mini purple" CommandArgument='<%# DataBinder.Eval(Container.DataItem,"Number") %>' CommandName="edititem"><i class="fa fa-pencil icon-white"></i> &nbsp; تعديل</asp:LinkButton>
                                        </td>
                                    </tr>
                                </tbody>
                            </ItemTemplate>
                        </asp:ListView>
                    </table>
                    <br />
                    <asp:DataPager ID="DataPagerdlItems" runat="server" PagedControlID="dlItems"
                        PageSize="10" OnPreRender="DataPagerdlItems_PreRender">
                        <Fields>
                            <asp:NextPreviousPagerField ShowFirstPageButton="True" ShowNextPageButton="False" ButtonCssClass="btn " FirstPageText="البداية" PreviousPageText="السابق" />
                            <asp:NumericPagerField NumericButtonCssClass="btn btn-mini" CurrentPageLabelCssClass="btn btn-success" NextPreviousButtonCssClass="btn btn-mini" />
                            <asp:NextPreviousPagerField ShowLastPageButton="True" ShowPreviousPageButton="False" ButtonCssClass="btn " NextPageText="التالي" LastPageText="النهاية" />
                        </Fields>
                    </asp:DataPager>
                </div>
            </div>
            <!-- END SAMPLE TABLE widget-->
        </div>
    </div>
</asp:Content>

