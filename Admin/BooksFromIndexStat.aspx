<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.master" AutoEventWireup="true" CodeFile="BooksFromIndexStat.aspx.cs" Inherits="Admin_BooksFromIndexStat" %>

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
        function printdiv(printpage) {
            var headstr = "<html><head><title></title></head><body><div style=\"margin:0 auto;\"><h1 style=\"text-align:center;\"><img src=\"img/KFNLLOGO.png\"/></h1><br /><br /><br /><h1 style=\"text-align:center;\">الكتب المستلمة من إدارة الفهرسة</h1>";
            var fromToDate = "";
            var datestart = document.getElementById("ContentPlaceHolder1_popupDatepicker").getAttribute("value");
            var dateEnd = document.getElementById("ContentPlaceHolder1_popupDatepickerEnd").getAttribute("value");
            if (datestart != null && dateEnd != null) {
                fromToDate = "<h4 id=\"h4date\" style=\"text-align:center;\"> احصائية من تاريخ " + datestart + " الى تاريخ " + dateEnd + "</h4></div>";
            } else if (datestart != null && dateEnd == null) {
                fromToDate = "<h4 id=\"h4date\" style=\"text-align:center;\"> احصائية من تاريخ " + datestart + "</h4></div>";

            } else if (datestart == null && dateEnd != null) {
                fromToDate = "<h4 id=\"h4date\" style=\"text-align:center;\"> الى تاريخ " + dateEnd + "</h4></div>";
            }
            else {
                fromToDate = "</div>";
            }
            var footstr = "</body>";
            var newstr = document.all.item(printpage).innerHTML;
            var oldstr = document.body.innerHTML;
            document.body.innerHTML = headstr + fromToDate + newstr + footstr;
            window.print();
            document.body.innerHTML = oldstr;
            return false;
        }
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

        .borderLeft {
            border-left: 1px solid #ddd !important;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <!-- BEGIN PAGE -->
    <div class="space7"></div>
    <div class="row-fluid">
        <div class="span12">
            <!-- BEGIN SAMPLE TABLE widget-->
            <div class="widget">
                <div class="widget-title">
                    <h4><i class="icon-cogs"></i>التقارير</h4>
                    <span class="tools">
                        <a class="icon-chevron-down" href="javascript:;"></a>
                        <a class="icon-remove" href="javascript:;"></a>
                    </span>
                </div>
                <div class="widget-body">
                    <div class="row-fluid">
                        <div class="span3">
                            <input type="text" class="span10 ss" id="popupDatepicker" runat="server" name="txtStart" placeholder="تاريخ الإدخال" />
                        </div>
                        <div class="span3">
                            <input type="text" class="span10 ss" value="" id="popupDatepickerEnd" runat="server" placeholder="تاريخ الانتهاء" />
                        </div>
                        <div class="row-fluid">
                            <div class="span6 offset3">
                                <div class="span6">
                                    <asp:Button CssClass="span10 btn btn-primary " ID="btnSearch" runat="server" Text="بحث" OnClick="btnSearch_Click" />
                                </div>
                                <div class="span6">
                                    <asp:Button ID="printButton" runat="server" CssClass="span10 btn btn-primary" Text="طباعة" OnClientClick="printdiv('div_print');" />
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="space7"></div>
                    <div class="space7"></div>
                    <div class="space7"></div>
                    <div id="div_print">
                        <table class="table table-striped table-bordered table-advance table-hover textTable">
                            <thead>
                            <tr>
                                  
                                    <th class="borderLeft"><i class="fa fa-file"></i>&nbsp;عدد العناوين </th>
                                    <th class="borderLeft"><i class="fa fa-file"></i>&nbsp;عدد النسخ </th>
                                 
                                  
                                </tr>

                            </thead>
                            <tbody>
                                <tr>
                                    <td class="borderLeft">
                                        <div class="success"></div>
                                        <asp:Label ID="lblNoTitles" runat="server" />
                                    </td>
                                    <td class=" borderLeft">
                                        <asp:Label ID="lblNoCopies" runat="server" />
                                    </td>
                                   
                                    

                                </tr>
                              

                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            <!-- END SAMPLE TABLE widget-->
        </div>
        <img src="img/KFNLLOGO.png" style="visibility: hidden; display: none" />
    </div>
</asp:Content>




