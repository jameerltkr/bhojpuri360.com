<%@ Page Language="C#" Debug="true" ValidateRequest="false" MaintainScrollPositionOnPostback="True" %>

<%--<%@ Register Assembly="obout_ComboBox" Namespace="Obout.ComboBox" TagPrefix="cc2" %>--%>
<%@ Register Assembly="obout_Grid_NET" Namespace="Obout.Grid" TagPrefix="cc1" %>
<%@ Register TagPrefix="cc1" Namespace="Obout.Interface" Assembly="obout_Interface" %>
<%@ Register Assembly="obout_Calendar2_Net" Namespace="OboutInc.Calendar2" TagPrefix="obout" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script type="text/javascript">
    String.prototype.trim = function () {
        return this.replace(/^\s+|\s+$/g, '');
    }
    function Grid1_BeforeEdit(sender, record) {

        // Defining max length ----------------
        if (document.getElementById("Grid1_tplRowEdit_ctl00_txt_Comments_Personal_Safety_Commitment") != null)
            document.getElementById('Grid1_tplRowEdit_ctl00_txt_Comments_Personal_Safety_Commitment').setAttribute('maxlength', '500');

        if (document.getElementById("Grid1_tplRowEdit_ctl00_txt_Comments_Positive_Observation") != null)
            document.getElementById('Grid1_tplRowEdit_ctl00_txt_Comments_Positive_Observation').setAttribute('maxlength', '500');

        if (document.getElementById("Grid1_tplRowEdit_ctl00_txt_Comments_Environment_Is_Everything") != null)
            document.getElementById('Grid1_tplRowEdit_ctl00_txt_Comments_Environment_Is_Everything').setAttribute('maxlength', '500')

        if (document.getElementById("Grid1_tplRowEdit_ctl00_txt_Comments_Positive_Observation") != null)
            document.getElementById('Grid1_tplRowEdit_ctl00_txt_Comments_Positive_Observation').setAttribute('maxlength', '500');

        if (document.getElementById("Grid1_tplRowEdit_ctl00_txt_Comments_SWA") != null)
            document.getElementById('Grid1_tplRowEdit_ctl00_txt_Comments_SWA').setAttribute('maxlength', '500');

        if (document.getElementById("Grid1_tplRowEdit_ctl00_txt_Safety_Slogan") != null)
            document.getElementById('Grid1_tplRowEdit_ctl00_txt_Safety_Slogan').setAttribute('maxlength', '64');

        //-------------------------

        // setting style--------------
        if (document.getElementById("ob_iTtxtDateContainer") != null) {
            document.getElementById("ob_iTtxtDateContainer").setAttribute('style', 'margin-bottom:5px;width:80px;');
        }

        if (document.getElementById("Grid1_tplRowEdit_ctl00_lst__Reported_To") != null)
            var shiftLength = document.getElementById('Grid1_tplRowEdit_ctl00_lst__Reported_To').getElementsByTagName("input").length;
        for (var i = 0; i <= shiftLength - 1; i++) {
            document.getElementById("Grid1_tplRowEdit_ctl00_lst__Reported_To_" + i).setAttribute('style', 'float: left;margin-top: 0px;');
        }
        //---------------------------

        debugger;
        var Url = record.Image_URL;
        if ((Url != null) || (Url != "")) {
            var stindex = Url.indexOf('href="');
            if (stindex == -1) {
                stindex = Url.indexOf('href=');
                stindex += 8;
            }
            else {
                stindex += 6;
            }
            var endindex = Url.indexOf('">');
            if (endindex == -1) {
                endindex = Url.indexOf('.tif');
                endindex += 4;
            }
            Url = Url.substring(stindex, endindex);
            document.getElementById("Grid1_tplRowEdit_ctl00_CardImageFront").src = "TifHandler.ashx?imageURL=" + Url + "&pageNum=1" + "&rotation=0";
            document.getElementById("Grid1_tplRowEdit_ctl00_CardImageBack").src = "TifHandler.ashx?imageURL=" + Url + "&pageNum=2" + "&rotation=0";
        }
        //Automation for Radio Buttons
        var RadiobuttonArray = [];
        RadiobuttonArray = GetAllRadioButtons();
        var i = 0;
        var j = 0;
        for (j = 0; j < RadiobuttonArray.length; j++) {
            var str = RadiobuttonArray[j];
            var index = str.indexOf('lst_');
            if (index != -1) {
                var radioname = RadiobuttonArray[j].substring(index + 4, RadiobuttonArray[j].length);

                if (radioname.indexOf('_Reported_To') >= 0)
                    radioname = "Reported_To";
                if (radioname.indexOf('_Reported_To') >= 0)
                    radioname = "Reported_To";

                if (radioname.indexOf('_Item_Corrected_Environment') >= 0)
                    radioname = "Item_Corrected_Environment";
                if (radioname.indexOf('_Item_Not_Corrected_Environment') >= 0)
                    radioname = "Item_Not_Corrected_Environment";

                if (radioname.indexOf('_Item_Corrected_SWA') >= 0)
                    radioname = "Item_Corrected_SWA";
                if (radioname.indexOf('_Item_Not_Corrected_SWA') >= 0)
                    radioname = "Item_Not_Corrected_SWA";

                var data = eval('record.' + radioname);
                var val = document.getElementsByName(RadiobuttonArray[j]);
                GetValueFromHiddenField(data, val);
            }
        }
        //Automation for Check Boxes
        //debugger;
        //var CheckBoxArray = [];
        //CheckBoxArray = GetAllCheckBox();
        //i = 0;
        //j = 0;
        //var MatchCaseValue = "X";
        //for (j = 0; j < CheckBoxArray.length; j++) {

        //    var str = CheckBoxArray[j];
        //    var index = str.indexOf('chk_');
        //    if (index != -1) {
        //        var checkboxname = CheckBoxArray[j].substring(index + 4, CheckBoxArray[j].length);
        //        var data = eval('record.' + checkboxname);
        //        //var val = document.getElementsByName(CheckBoxArray[j]);

        //        if (data.trim().toLowerCase() == MatchCaseValue.toLowerCase()) {
        //            checkCheckBox("chk_" + checkboxname);
        //        }
        //        else {
        //            UNcheckCheckBox("chk_" + checkboxname);
        //        }
        //    }
        //}
        //        data = record.Observation;
        //        if (data == "X") {
        //            checkCheckBox("chk_Observation");
        //        }
        //        else {
        //            UNcheckCheckBox("chk_Observation");
        //        }
        //        data = record.Near_Miss;
        //        if (data == "X") {
        //            checkCheckBox("chk_Near_Miss");
        //        }
        //        else {
        //            UNcheckCheckBox("chk_Near_Miss");
        //        }
        //        data = record.Feedback_Given1;
        //        if (data == "X") {
        //            checkCheckBox("chk_Feedback_Given1");
        //        }
        //        else {
        //            UNcheckCheckBox("chk_Feedback_Given1");
        //        }
        //        data = record.Feedback_Given2;
        //        if (data == "X") {
        //            checkCheckBox("chk_Feedback_Given2");
        //        }
        //        else {
        //            UNcheckCheckBox("chk_Feedback_Given2");
        //        }

        //        data = record.Feedback_Given3;
        //        if (data == "X") {
        //            checkCheckBox("chk_Feedback_Given3");
        //        }
        //        else {
        //            UNcheckCheckBox("chk_Feedback_Given3");
        //        }



        return true;
    }

    function GetAllRadioButtons() {
        var inputs = document.forms["form1"].getElementsByTagName("input");
        var radioes = [];
        for (var i = 0; i < inputs.length; i++) {
            if (inputs[i].type == 'radio') {
                radioes.push(inputs[i].name);
            }
        }
        var arr = DistinctArray(radioes);
        return arr;
    }

    function GetAllCheckBox() {
        var inputs = document.forms["form1"].getElementsByTagName("input");
        var radioes = [];
        for (var i = 0; i < inputs.length; i++) {
            if (inputs[i].type == 'checkbox') {
                radioes.push(inputs[i].name);
            }
        }
        var arr = DistinctArray(radioes);
        return arr;
    }

    function DistinctArray(Array) {
        var arr = [];
        for (var i = 0; i < Array.length; i++) {
            if (arr.indexOf(Array[i]) == -1) {
                arr.push(Array[i]);
            }
        }
        return arr;
    }


    function PassTextDatatoDropDown(ddlId, desiredValue) {
        var Dropdownid = eval(ddlId);

        for (var i = 0; i < Dropdownid.options.length; i++) {
            if (Dropdownid.options[i].text.toLowerCase() == desiredValue.toLowerCase()) {
                Dropdownid.selectedIndex(i);
                //  Dropdownid.SelectedIndex = i;
                break;
            }
        }
    }

    function PassValueDatatoDropDown(ddlId, desiredValue) {
        var Dropdownid = eval(ddlId);

        for (var i = 0; i < Dropdownid.options.length; i++) {
            if (Dropdownid.options[i].value.toLowerCase() == desiredValue.toLowerCase()) {
                Dropdownid.selectedIndex(i);
                //  Dropdownid.SelectedIndex = i;
                break;
            }
        }
    }

    function GetSelectedTextFromDropDown(DropdownId) {
        var ddlId = eval(DropdownId);
        var returntxt = "";
        var val = ddlId.value()
        for (var i = 0; i < ddlId.options.length; i++) {
            if (ddlId.options[i].value == val) {
                returntxt = ddlId.options[i].text;
                //  Dropdownid.SelectedIndex = i;
                break;
            }
        }

        return returntxt;

    }

    function OnBeforeUpdate(record) {

        var RadiobuttonArray = [];
        RadiobuttonArray = GetAllRadioButtons();
        var j = 0;
        for (j = 0; j < RadiobuttonArray.length; j++) {
            var str = RadiobuttonArray[j];
            var index = str.indexOf('lst_');
            if (index != -1) {
                var radioname = RadiobuttonArray[j].substring(index + 4, RadiobuttonArray[j].length);
                var hdnfieldid = "hdn_" + radioname;
                var val = document.getElementsByName(RadiobuttonArray[j]);
                GetValueFromRadiobuttonList(val, hdnfieldid);
            }
        }

        var CheckBoxArray = [];
        CheckBoxArray = GetAllCheckBox();
        j = 0;
        var MatchCaseValue = "X";
        for (j = 0; j < CheckBoxArray.length; j++) {
            var str = CheckBoxArray[j];
            var index = str.indexOf('chk_');
            if (index != -1) {
                var Checkname = CheckBoxArray[j].substring(index + 4, CheckBoxArray[j].length);
                var hdnfieldid = "hdn_" + Checkname;
                var val = document.getElementsByName(RadiobuttonArray[j]);

                if (IsCheckboxCheck("chk_" + Checkname)) {
                    document.getElementById(hdnfieldid).value = MatchCaseValue;
                }
                else {
                    document.getElementById(hdnfieldid).value = "";
                }
            }
        }

        //  checkboxes

        // if (IsCheckboxCheck("chk_Feedback_Given")) {
        //     document.getElementById("hdn_Feedback_Given").value = "Y";
        // }
        // else {
        //     document.getElementById("hdn_Feedback_Given").value = "";
        // }


    }




    function GetValueFromHiddenField(data, val) {
        for (i = 0; i < val.length; i++) {
            if (val[i].value == data) {
                val[i].checked = true;
            } else { val[i].checked = false; }
        }
    }

    function GetValueFromRadiobuttonList(val, hdnid) {
        for (var i = 0; i < val.length; i++) {
            if (val[i].checked == true) {
                document.getElementById(hdnid).value = val[i].value;
            }
        }
    }

    function checkCheckBox(checkBoxId) {
        var checkBox = eval(checkBoxId);
        checkBox.checked(true);
    }

    function UNcheckCheckBox(checkBoxId) {
        var checkBox = eval(checkBoxId);
        checkBox.checked(false);
    }

    function IsCheckboxCheck(checkBoxId) {
        var checkBox = eval(checkBoxId);
        var isChecked = checkBox.checked();
        return isChecked;
    }

</script>
<script runat="server">
    String aff_key = string.Empty;
    String admin_id = string.Empty;
    String date1Str = string.Empty;
    String date2Str = string.Empty;
    String backURL = string.Empty;
    String report_filter_term = string.Empty;
    String report_filter = string.Empty;
    String testStr = string.Empty;

    void Page_Load(object sender, EventArgs e)
    {
        //aff_key = Request.QueryString["aff_key"] != null ? Request.QueryString["aff_key"] : string.Empty;
        //admin_id = Request.QueryString["sid"] != null ? Request.QueryString["sid"] : string.Empty;
        //date1Str = Request.QueryString["date1"] != null ? Request.QueryString["date1"] : string.Empty;
        //date2Str = Request.QueryString["date2"] != null ? Request.QueryString["date2"] : string.Empty;
        //backURL = Request.QueryString["backURL"] != null ? Request.QueryString["backURL"] : string.Empty;
        //report_filter = Request.QueryString["report_filter"] != null ? Request.QueryString["report_filter"] : string.Empty;
        //report_filter_term = Request.QueryString["report_filter_term"] != null ? Request.QueryString["report_filter_term"] : string.Empty;

        //SqlDataSource1.SelectParameters["affiliate_key"].DefaultValue = aff_key;
        //SqlDataSource1.SelectParameters["sid"].DefaultValue = admin_id;
        //SqlDataSource1.SelectParameters["start_date"].DefaultValue = date1Str;
        //SqlDataSource1.SelectParameters["end_date"].DefaultValue = date2Str;

        //if (report_filter_term.Length > 0)
        //{
        //    SqlDataSource1.SelectParameters["filter"].DefaultValue = report_filter;
        //    SqlDataSource1.SelectParameters["filter_value"].DefaultValue = report_filter_term;
        //}

        //Set it so page doesn't cache
        System.Web.UI.HtmlControls.HtmlMeta META = new System.Web.UI.HtmlControls.HtmlMeta();
        META.HttpEquiv = "Pragma";
        META.Content = "no-cache";
        Page.Header.Controls.Add(META);
        Response.Expires = -1;
        Response.CacheControl = "no-cache";
    }


    void UpdateRecord(object sender, GridRecordEventArgs e)
    {

        try
        {

            string Sql = "update JWT_Phillips66_Rodeo_RAPP_2015 set Date=@Date,Scan_Date=@Scan_Date,Image_URL=@Image_URL,Yes_No_Card=@Yes_No_Card,Company_Name_on_Form=@Company_Name_on_Form,Name_of_Company=(case when ISNULL(@Name_of_Company,'')='' then (select Company_Name_LU FROM JWT_LU_Company where PKCompanyID=@FKCompanyID) else @Name_of_Company end),Name_of_Observer=@Name_of_Observer,Name_Reported_To=@Name_Reported_To,Reported_To=@Reported_To,_101_WAP_Signed_After_Site_Rev=@_101_WAP_Signed_After_Site_Rev,_102_All_Try_Points_Energy_Free=@_102_All_Try_Points_Energy_Free,_103_Permit_Attendant_at_Conf_Spc=@_103_Permit_Attendant_at_Conf_Spc,_104_100_Fall_Protection_Used=@_104_100_Fall_Protection_Used,_105_Safety_Devices_100_Used=@_105_Safety_Devices_100_Used,_201_Safety_Conscious=@_201_Safety_Conscious,_202_Good_Housekeeping=@_202_Good_Housekeeping,_203_Procedures_Followed_Correctly=@_203_Procedures_Followed_Correctly,_204_Proper_PPE_Being_Used=@_204_Proper_PPE_Being_Used,_205_20_Second_Scan_Used=@_205_20_Second_Scan_Used,_206_Try_Point_Tested=@_206_Try_Point_Tested,_207_Safe_Work_Pstns_Used=@_207_Safe_Work_Pstns_Used,_208_Fall_Potential_Eliminated=@_208_Fall_Potential_Eliminated,_209_Correct_Body_Pstns_Used=@_209_Correct_Body_Pstns_Used,_210_Worker_Out_of_Line_of_Fire=@_210_Worker_Out_of_Line_of_Fire,_211_Other=@_211_Other,_301_Proper_Eye_Face_Protection=@_301_Proper_Eye_Face_Protection,_302_Proper_Gloves_Used=@_302_Proper_Gloves_Used,_303_Proper_Hearing_Protection=@_303_Proper_Hearing_Protection,_304_Respiratory_Protection_Correct=@_304_Respiratory_Protection_Correct,_305_FRC_Worn_Correctly=@_305_FRC_Worn_Correctly,_306_Fall_Protection_Worn_Properly=@_306_Fall_Protection_Worn_Properly,_307_Proper_Foot_Protection=@_307_Proper_Foot_Protection,_308_Other=@_308_Other,_401_Traffic_Signs_Obeyed=@_401_Traffic_Signs_Obeyed,_402_Parked_with_Wheel_Chocks=@_402_Parked_with_Wheel_Chocks,_403_Seat_Belts_Worn_While_Moving=@_403_Seat_Belts_Worn_While_Moving,_404_Cell_Phone_Not_in_Use=@_404_Cell_Phone_Not_in_Use,_405_Speed_Limit_Obeyed=@_405_Speed_Limit_Obeyed,_406_Other=@_406_Other,_501_Used_Correctly=@_501_Used_Correctly,_502_Used_Safely=@_502_Used_Safely,_503_Safety_Guards_In_Place=@_503_Safety_Guards_In_Place,_504_Dropped_Object_Prev_In_Place=@_504_Dropped_Object_Prev_In_Place,_505_Other=@_505_Other,_601_Good_List_of_Task_Steps=@_601_Good_List_of_Task_Steps,_602_Hzrds_of_Each_Step_Identified=@_602_Hzrds_of_Each_Step_Identified,_603_Mitigation_Measures_Specific=@_603_Mitigation_Measures_Specific,_604_Sfty_Shwr_Eye_Wash_Tested=@_604_Sfty_Shwr_Eye_Wash_Tested,_605_Mid_Shift_Rev_Conducted=@_605_Mid_Shift_Rev_Conducted,_701_Area_Left_in_Safe_Condition=@_701_Area_Left_in_Safe_Condition,_702_Area_Equip_Not_Deteriorated=@_702_Area_Equip_Not_Deteriorated,_703_Equip_Working_Properly=@_703_Equip_Working_Properly,_704_Good_Housekeeping=@_704_Good_Housekeeping,_705_Labeling_Correct=@_705_Labeling_Correct,_706_Sign_Placards_Labels_Correct=@_706_Sign_Placards_Labels_Correct,_707_Environmental_Conditions_Safe=@_707_Environmental_Conditions_Safe,_708_Broken_Equipment_Removed=@_708_Broken_Equipment_Removed,_709_Equipment_Not_Leaking=@_709_Equipment_Not_Leaking,_710_Electrical_Equipment_Safe=@_710_Electrical_Equipment_Safe,_711_Job_Complete=@_711_Job_Complete,_712_Other=@_712_Other,Item_Safety_Commit_Num=@Item_Safety_Commit_Num,Comments_Personal_Safety_Commitment=@Comments_Personal_Safety_Commitment,Item_Positive_OBS_Num=@Item_Positive_OBS_Num,Comments_Positive_Observation=@Comments_Positive_Observation,Item_Corrected_Environment=@Item_Corrected_Environment,Item_Not_Corrected_Environment=@Item_Not_Corrected_Environment,Action_Item_Status_Environment=@Action_Item_Status_Environment,Action_Completed_Date_Environment=@Action_Completed_Date_Environment,Item_Environment_Num=@Item_Environment_Num,Comments_Environment_Is_Everything=@Comments_Environment_Is_Everything,Item_Corrected_SWA=@Item_Corrected_SWA,Item_Not_Corrected_SWA=@Item_Not_Corrected_SWA,Action_Item_Status_SWA=@Action_Item_Status_SWA,Action_Completed_Date_SWA=@Action_Completed_Date_SWA,Item_SWA_Num=@Item_SWA_Num,Comments_SWA=@Comments_SWA,Safety_Slogan=@Safety_Slogan,Image_File=@Image_File,Inserted_By=@Inserted_By,Updated_By=@Updated_By,Updated_On=@Updated_On,Created=@Created,SC_ID=@SC_ID,Source_ID=@Source_ID,Template_ID=@Template_ID,FKLocationID=@FKLocationID,FKCompanyID=@FKCompanyID";

            System.Data.SqlClient.SqlConnection conn = new System.Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings["pjengConnectionString1"].ConnectionString);

            System.Data.SqlClient.SqlCommand comm = new System.Data.SqlClient.SqlCommand(Sql, conn);

            comm.CommandType = System.Data.CommandType.Text;

            conn.Open();

            comm.Parameters.AddWithValue("@iCount", e.Record["iCount"]);
            comm.Parameters.AddWithValue("@Date", e.Record["Date"]);
            comm.Parameters.AddWithValue("@Scan_Date", e.Record["Scan_Date"]);


            comm.Parameters.AddWithValue("@Image_URL", e.Record["Image_URL"]);
            comm.Parameters.AddWithValue("@Yes_No_Card", e.Record["Yes_No_Card"]);



            comm.Parameters.AddWithValue("@Company_Name_on_Form", e.Record["Company_Name_on_Form"]);
            comm.Parameters.AddWithValue("@Name_of_Company", e.Record["FKCompanyID"].Equals("999") ? e.Record["Company_Name_on_Form"] : null);
            comm.Parameters.AddWithValue("@Name_of_Observer", e.Record["Name_of_Observer"]);

            comm.Parameters.AddWithValue("@Name_Reported_To", e.Record["Name_Reported_To"]);


            comm.Parameters.AddWithValue("@Reported_To", e.Record["Reported_To"]);



            comm.Parameters.AddWithValue("@_101_WAP_Signed_After_Site_Rev", e.Record["_101_WAP_Signed_After_Site_Rev"]);





            comm.Parameters.AddWithValue("@_102_All_Try_Points_Energy_Free", e.Record["_102_All_Try_Points_Energy_Free"]);
            comm.Parameters.AddWithValue("@_103_Permit_Attendant_at_Conf_Spc", e.Record["_103_Permit_Attendant_at_Conf_Spc"]);




            comm.Parameters.AddWithValue("@_104_100_Fall_Protection_Used", e.Record["_104_100_Fall_Protection_Used"]);
            comm.Parameters.AddWithValue("@_105_Safety_Devices_100_Used", e.Record["_105_Safety_Devices_100_Used"]);
            comm.Parameters.AddWithValue("@_201_Safety_Conscious", e.Record["_201_Safety_Conscious"]);
            comm.Parameters.AddWithValue("@_202_Good_Housekeeping", e.Record["_202_Good_Housekeeping"]);
            comm.Parameters.AddWithValue("@_203_Procedures_Followed_Correctly", e.Record["_203_Procedures_Followed_Correctly"]);
            comm.Parameters.AddWithValue("@_204_Proper_PPE_Being_Used", e.Record["_204_Proper_PPE_Being_Used"]);
            comm.Parameters.AddWithValue("@_205_20_Second_Scan_Used", e.Record["_205_20_Second_Scan_Used"]);
            comm.Parameters.AddWithValue("@_206_Try_Point_Tested", e.Record["_206_Try_Point_Tested"]);
            comm.Parameters.AddWithValue("@_207_Safe_Work_Pstns_Used", e.Record["_207_Safe_Work_Pstns_Used"]);
            comm.Parameters.AddWithValue("@_208_Fall_Potential_Eliminated", e.Record["_208_Fall_Potential_Eliminated"]);
            comm.Parameters.AddWithValue("@_209_Correct_Body_Pstns_Used", e.Record["_209_Correct_Body_Pstns_Used"]);
            comm.Parameters.AddWithValue("@_210_Worker_Out_of_Line_of_Fire", e.Record["_210_Worker_Out_of_Line_of_Fire"]);
            comm.Parameters.AddWithValue("@_211_Other", e.Record["_211_Other"]);
            comm.Parameters.AddWithValue("@_301_Proper_Eye_Face_Protection", e.Record["_301_Proper_Eye_Face_Protection"]);
            comm.Parameters.AddWithValue("@_302_Proper_Gloves_Used", e.Record["_302_Proper_Gloves_Used"]);
            comm.Parameters.AddWithValue("@_303_Proper_Hearing_Protection", e.Record["_303_Proper_Hearing_Protection"]);
            comm.Parameters.AddWithValue("@_304_Respiratory_Protection_Correct", e.Record["_304_Respiratory_Protection_Correct"]);
            comm.Parameters.AddWithValue("@_305_FRC_Worn_Correctly", e.Record["_305_FRC_Worn_Correctly"]);
            comm.Parameters.AddWithValue("@_306_Fall_Protection_Worn_Properly", e.Record["_306_Fall_Protection_Worn_Properly"]);
            comm.Parameters.AddWithValue("@_307_Proper_Foot_Protection", e.Record["_307_Proper_Foot_Protection"]);
            comm.Parameters.AddWithValue("@_308_Other", e.Record["_308_Other"]);
            comm.Parameters.AddWithValue("@_401_Traffic_Signs_Obeyed", e.Record["_401_Traffic_Signs_Obeyed"]);
            comm.Parameters.AddWithValue("@_402_Parked_with_Wheel_Chocks", e.Record["_402_Parked_with_Wheel_Chocks"]);
            comm.Parameters.AddWithValue("@_403_Seat_Belts_Worn_While_Moving", e.Record["_403_Seat_Belts_Worn_While_Moving"]);
            comm.Parameters.AddWithValue("@_404_Cell_Phone_Not_in_Use", e.Record["_404_Cell_Phone_Not_in_Use"]);
            comm.Parameters.AddWithValue("@_405_Speed_Limit_Obeyed", e.Record["_405_Speed_Limit_Obeyed"]);
            comm.Parameters.AddWithValue("@_406_Other", e.Record["_406_Other"]);
            comm.Parameters.AddWithValue("@_501_Used_Correctly", e.Record["_501_Used_Correctly"]);
            comm.Parameters.AddWithValue("@_502_Used_Safely", e.Record["_502_Used_Safely"]);
            comm.Parameters.AddWithValue("@_503_Safety_Guards_In_Place", e.Record["_503_Safety_Guards_In_Place"]);
            comm.Parameters.AddWithValue("@_504_Dropped_Object_Prev_In_Place", e.Record["_504_Dropped_Object_Prev_In_Place"]);
            comm.Parameters.AddWithValue("@_505_Other", e.Record["_505_Other"]);
            comm.Parameters.AddWithValue("@_601_Good_List_of_Task_Steps", e.Record["_601_Good_List_of_Task_Steps"]);
            comm.Parameters.AddWithValue("@_602_Hzrds_of_Each_Step_Identified", e.Record["_602_Hzrds_of_Each_Step_Identified"]);
            comm.Parameters.AddWithValue("@_603_Mitigation_Measures_Specific", e.Record["_603_Mitigation_Measures_Specific"]);
            comm.Parameters.AddWithValue("@_604_Sfty_Shwr_Eye_Wash_Tested", e.Record["_604_Sfty_Shwr_Eye_Wash_Tested"]);
            comm.Parameters.AddWithValue("@_605_Mid_Shift_Rev_Conducted", e.Record["_605_Mid_Shift_Rev_Conducted"]);
            comm.Parameters.AddWithValue("@_701_Area_Left_in_Safe_Condition", e.Record["_701_Area_Left_in_Safe_Condition"]);
            comm.Parameters.AddWithValue("@_702_Area_Equip_Not_Deteriorated", e.Record["_702_Area_Equip_Not_Deteriorated"]);
            comm.Parameters.AddWithValue("@_703_Equip_Working_Properly", e.Record["_703_Equip_Working_Properly"]);

            comm.Parameters.AddWithValue("@_704_Good_Housekeeping", e.Record["_704_Good_Housekeeping"]);
            comm.Parameters.AddWithValue("@_705_Labeling_Correct", e.Record["_705_Labeling_Correct"]);
            comm.Parameters.AddWithValue("@_706_Sign_Placards_Labels_Correct", e.Record["_706_Sign_Placards_Labels_Correct"]);
            comm.Parameters.AddWithValue("@_707_Environmental_Conditions_Safe", e.Record["_707_Environmental_Conditions_Safe"]);
            comm.Parameters.AddWithValue("@_708_Broken_Equipment_Removed", e.Record["_708_Broken_Equipment_Removed"]);
            comm.Parameters.AddWithValue("@_709_Equipment_Not_Leaking", e.Record["_709_Equipment_Not_Leaking"]);
            comm.Parameters.AddWithValue("@_710_Electrical_Equipment_Safe", e.Record["_710_Electrical_Equipment_Safe"]);
            comm.Parameters.AddWithValue("@_711_Job_Complete", e.Record["_711_Job_Complete"]);
            comm.Parameters.AddWithValue("@_712_Other", e.Record["_712_Other"]);

            comm.Parameters.AddWithValue("@Item_Safety_Commit_Num", e.Record["Item_Safety_Commit_Num"]);
            comm.Parameters.AddWithValue("@Comments_Personal_Safety_Commitment", e.Record["Comments_Personal_Safety_Commitment"]);
            comm.Parameters.AddWithValue("@Item_Positive_OBS_Num", e.Record["Item_Positive_OBS_Num"]);
            comm.Parameters.AddWithValue("@Comments_Positive_Observation", e.Record["Comments_Positive_Observation"]);
            comm.Parameters.AddWithValue("@Item_Corrected_Environment", e.Record["Item_Corrected_Environment"]);
            comm.Parameters.AddWithValue("@Item_Not_Corrected_Environment", e.Record["Item_Not_Corrected_Environment"]);
            comm.Parameters.AddWithValue("@Action_Item_Status_Environment", e.Record["Action_Item_Status_Environment"]);
            comm.Parameters.AddWithValue("@Action_Completed_Date_Environment", e.Record["Action_Completed_Date_Environment"]);
            comm.Parameters.AddWithValue("@Item_Environment_Num", e.Record["Item_Environment_Num"]);





            comm.Parameters.AddWithValue("@Comments_Environment_Is_Everything", e.Record["Comments_Environment_Is_Everything"]);
            comm.Parameters.AddWithValue("@Item_Corrected_SWA", e.Record["Item_Corrected_SWA"]);



            comm.Parameters.AddWithValue("@Item_Not_Corrected_SWA", e.Record["Item_Not_Corrected_SWA"]);
            comm.Parameters.AddWithValue("@Action_Item_Status_SWA", e.Record["Action_Item_Status_SWA"]);
            comm.Parameters.AddWithValue("@Action_Completed_Date_SWA", e.Record["Action_Completed_Date_SWA"]);
            comm.Parameters.AddWithValue("@Item_SWA_Num", e.Record["Item_SWA_Num"]);
            comm.Parameters.AddWithValue("@Comments_SWA", e.Record["Comments_SWA"]);
            comm.Parameters.AddWithValue("@Safety_Slogan", e.Record["Safety_Slogan"]);
            comm.Parameters.AddWithValue("@Image_File", e.Record["Image_File"]);
            comm.Parameters.AddWithValue("@Inserted_By", e.Record["Inserted_By"]);
            comm.Parameters.AddWithValue("@Updated_By", e.Record["Updated_By"]);
            comm.Parameters.AddWithValue("@Updated_On", e.Record["Updated_On"]);
            comm.Parameters.AddWithValue("@Created", e.Record["Created"]);
            comm.Parameters.AddWithValue("@SC_ID", e.Record["SC_ID"]);

            comm.Parameters.AddWithValue("@Source_ID", "scan");
            comm.Parameters.AddWithValue("@Template_ID", "03152768");
            comm.Parameters.AddWithValue("@FKLocationID", e.Record["FKLocationID"]);
            comm.Parameters.AddWithValue("@FKCompanyID", e.Record["FKCompanyID"]);

            string yesNoCard = "Y";

            if (e.Record["_101_WAP_Signed_After_Site_Rev"].Equals("N"))
            { yesNoCard = "N"; }
            else if (e.Record["_102_All_Try_Points_Energy_Free"].Equals("N"))
            { yesNoCard = "N"; }
            else if (e.Record["_103_Permit_Attendant_at_Conf_Spc"].Equals("N"))
            { yesNoCard = "N"; }
            else if (e.Record["_104_100_Fall_Protection_Used"].Equals("N"))
            { yesNoCard = "N"; }
            else if (e.Record["_105_Safety_Devices_100_Used"].Equals("N"))
            { yesNoCard = "N"; }
            else if (e.Record["_201_Safety_Conscious"].Equals("N"))
            { yesNoCard = "N"; }
            else if (e.Record["_202_Good_Housekeeping"].Equals("N"))
            { yesNoCard = "N"; }
            else if (e.Record["_203_Procedures_Followed_Correctly"].Equals("N"))
            { yesNoCard = "N"; }
            else if (e.Record["_204_Proper_PPE_Being_Used"].Equals("N"))
            { yesNoCard = "N"; }
            else if (e.Record["_205_20_Second_Scan_Used"].Equals("N"))
            { yesNoCard = "N"; }
            else if (e.Record["_206_Try_Point_Tested"].Equals("N"))
            { yesNoCard = "N"; }
            else if (e.Record["_207_Safe_Work_Pstns_Used"].Equals("N"))
            { yesNoCard = "N"; }
            else if (e.Record["_208_Fall_Potential_Eliminated"].Equals("N"))
            { yesNoCard = "N"; }
            else if (e.Record["_209_Correct_Body_Pstns_Used"].Equals("N"))
            { yesNoCard = "N"; }
            else if (e.Record["_210_Worker_Out_of_Line_of_Fire"].Equals("N"))
            { yesNoCard = "N"; }
            else if (e.Record["_211_Other"].Equals("N"))
            { yesNoCard = "N"; }
            else if (e.Record["_301_Proper_Eye_Face_Protection"].Equals("N"))
            { yesNoCard = "N"; }
            else if (e.Record["_302_Proper_Gloves_Used"].Equals("N"))
            { yesNoCard = "N"; }
            else if (e.Record["_303_Proper_Hearing_Protection"].Equals("N"))
            { yesNoCard = "N"; }
            else if (e.Record["_304_Respiratory_Protection_Correct"].Equals("N"))
            { yesNoCard = "N"; }
            else if (e.Record["_305_FRC_Worn_Correctly"].Equals("N"))
            { yesNoCard = "N"; }
            else if (e.Record["_306_Fall_Protection_Worn_Properly"].Equals("N"))
            { yesNoCard = "N"; }
            else if (e.Record["_307_Proper_Foot_Protection"].Equals("N"))
            { yesNoCard = "N"; }
            else if (e.Record["_308_Other"].Equals("N"))
            { yesNoCard = "N"; }
            else if (e.Record["_401_Traffic_Signs_Obeyed"].Equals("N"))
            { yesNoCard = "N"; }
            else if (e.Record["_402_Parked_with_Wheel_Chocks"].Equals("N"))
            { yesNoCard = "N"; }
            else if (e.Record["_403_Seat_Belts_Worn_While_Moving"].Equals("N"))
            { yesNoCard = "N"; }
            else if (e.Record["_404_Cell_Phone_Not_in_Use"].Equals("N"))
            { yesNoCard = "N"; }
            else if (e.Record["_405_Speed_Limit_Obeyed"].Equals("N"))
            { yesNoCard = "N"; }
            else if (e.Record["_406_Other"].Equals("N"))
            { yesNoCard = "N"; }
            else if (e.Record["_501_Used_Correctly"].Equals("N"))
            { yesNoCard = "N"; }
            else if (e.Record["_502_Used_Safely"].Equals("N"))
            { yesNoCard = "N"; }
            else if (e.Record["_503_Safety_Guards_In_Place"].Equals("N"))
            { yesNoCard = "N"; }
            else if (e.Record["_504_Dropped_Object_Prev_In_Place"].Equals("N"))
            { yesNoCard = "N"; }
            else if (e.Record["_505_Other"].Equals("N"))
            { yesNoCard = "N"; }
            else if (e.Record["_601_Good_List_of_Task_Steps"].Equals("N"))
            { yesNoCard = "N"; }
            else if (e.Record["_602_Hzrds_of_Each_Step_Identified"].Equals("N"))
            { yesNoCard = "N"; }
            else if (e.Record["_603_Mitigation_Measures_Specific"].Equals("N"))
            { yesNoCard = "N"; }
            else if (e.Record["_604_Sfty_Shwr_Eye_Wash_Tested"].Equals("N"))
            { yesNoCard = "N"; }
            else if (e.Record["_605_Mid_Shift_Rev_Conducted"].Equals("N"))
            { yesNoCard = "N"; }
            else if (e.Record["_701_Area_Left_in_Safe_Condition"].Equals("N"))
            { yesNoCard = "N"; }
            else if (e.Record["_702_Area_Equip_Not_Deteriorated"].Equals("N"))
            { yesNoCard = "N"; }
            else if (e.Record["_703_Equip_Working_Properly"].Equals("N"))
            { yesNoCard = "N"; }
            else if (e.Record["_704_Good_Housekeeping"].Equals("N"))
            { yesNoCard = "N"; }
            else if (e.Record["_705_Labeling_Correct"].Equals("N"))
            { yesNoCard = "N"; }
            else if (e.Record["_706_Sign_Placards_Labels_Correct"].Equals("N"))
            { yesNoCard = "N"; }
            else if (e.Record["_707_Environmental_Conditions_Safe"].Equals("N"))
            { yesNoCard = "N"; }
            else if (e.Record["_708_Broken_Equipment_Removed"].Equals("N"))
            { yesNoCard = "N"; }
            else if (e.Record["_709_Equipment_Not_Leaking"].Equals("N"))
            { yesNoCard = "N"; }
            else if (e.Record["_710_Electrical_Equipment_Safe"].Equals("N"))
            { yesNoCard = "N"; }
            else if (e.Record["_711_Job_Complete"].Equals("N"))
            { yesNoCard = "N"; }
            else if (e.Record["_712_Other"].Equals("N"))
            { yesNoCard = "N"; }

            comm.Parameters["@Yes_No_Card"].Value = yesNoCard;

            if (comm.Parameters["@Name_of_Company"].Value == null)
            {
                comm.Parameters["@Name_of_Company"].Value = DBNull.Value;
            }


            comm.ExecuteNonQuery();

            conn.Close();

        }

        catch
        {

        }

    }

    public string GetFullUrl(string imgURL)
    {
        if (imgURL.Contains("<a"))
        {
            var regex = new Regex("<a [^>]*href=(?:'(?<href>.*?)')|(?:\"(?<href>.*?)\")", RegexOptions.IgnoreCase);
            imgURL = regex.Matches(imgURL).OfType<Match>().Select(m => m.Groups["href"].Value).SingleOrDefault();
        }

        if (imgURL.ToLower().Contains("rptimages"))
        {
            imgURL = System.IO.Path.Combine("http://www.datainfoportal.com" + imgURL.Replace("\\", "/"));
        }
        else
        {
            imgURL = System.IO.Path.Combine("http://www.datainfoportal.com/RptImages" + imgURL.Replace("\\", "/"));
        }

        return imgURL;
    }

  
</script>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Phillips 66 Ponca City Edit Panel</title>
    <link href="Styles/premiere_blue/style.css" rel="stylesheet" />
    <link href="Calendar/styles/expedia/style.css" rel="stylesheet" />
    <style type="text/css">
        html, body, form
        {
            height: 96%;
            font-family: arial, helvetica, sans-serif;
            font-size: 12px;
            padding: 0;
            margin: 5px;
            background-color: #CCCCCC;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div style="width: 100%; margin: 0 auto;">
        <h3 style="text-decoration: underline; text-align: center; color: white;">
            Phillips 66 Ponca City Edit Panel</h3>
    </div>
    <div>
        <a href="<%=backURL%>" id="backurl"><u>CLICK HERE TO RETURN</u></a>
    </div>
    <cc1:Grid ID="Grid1" runat="server" Serialize="false" EnableRecordHover="true" EmbedFilterInSortExpression="True"
        AllowAddingRecords="False" AllowGrouping="True" AllowColumnResizing="true" AllowPaging="true"
        AllowSorting="true" Height="100%" Width="100%" PageSize="25" AllowFiltering="True"
        AllowRecordSelection="true" ShowGroupFooter="True" ShowGroupsInfo="True" AllowColumnReordering="True"
        ShowTotalNumberOfPages="True" AutoGenerateColumns="false" FolderStyle="Styles/style_13"
        DataSourceID="SqlDataSource1" OnUpdateCommand="UpdateRecord">
        <ClientSideEvents OnClientEdit="Grid1_BeforeEdit" OnBeforeClientUpdate="OnBeforeUpdate"
            ExposeSender="true" />
        <ScrollingSettings ScrollWidth="100%" ScrollHeight="100%" ScrollLeft="0" ScrollTop="0" />
        <Columns>
            <cc1:Column ID="Column18" HeaderText="EDIT" Width="115" AllowEdit="true" AllowDelete="false"
                runat="server" />
            <cc1:Column ID="Column1" DataField="iCount" HeaderText="iCount" runat="server">
                <TemplateSettings RowEditTemplateControlId="lbliCount" RowEditTemplateControlPropertyName="innerHTML" />
            </cc1:Column>
            <%-- Header --%>
            <cc1:Column ID="Column58" DataField="Date" HeaderText="Date" runat="server" DataFormatString="{0:MM/dd/yyyy}"
                ApplyFormatInEditMode="true">
                <TemplateSettings RowEditTemplateControlId="txtDate" RowEditTemplateControlPropertyName="value" />
            </cc1:Column>
            <cc1:Column ID="Column2" DataField="Image_URL" HeaderText="Image URL" ReadOnly="True"
                ParseHTML="true" runat="server">
                <TemplateSettings RowEditTemplateControlId="lblImage_URL" RowEditTemplateControlPropertyName="value" />
            </cc1:Column>
            <cc1:Column ID="Column3" DataField="Name_on_Form_Lead_Auditor" HeaderText="Name on Form Lead Auditor"
                runat="server">
                <TemplateSettings RowEditTemplateControlId="txtName_on_Form_Lead_Auditor" RowEditTemplateControlPropertyName="value" />
            </cc1:Column>
            <cc1:Column ID="Column4" DataField="Lead_Auditor_Name" HeaderText="Lead Auditor Name"
                runat="server">
                <TemplateSettings RowEditTemplateControlId="lblLead_Auditor_Name" RowEditTemplateControlPropertyName="innerHTML" />
            </cc1:Column>
            <cc1:Column ID="Column5" DataField="Lead_Auditor_Code" HeaderText="Lead Auditor Code/ISN"
                ReadOnly="true" runat="server">
            </cc1:Column>
            <cc1:Column ID="Column6" DataField="Name_on_Form_Auditor_A" HeaderText="Name on Form Auditor A"
                runat="server">
                <TemplateSettings RowEditTemplateControlId="txtName_on_Form_Auditor_A" RowEditTemplateControlPropertyName="value" />
            </cc1:Column>
            <cc1:Column ID="Column7" DataField="Auditor_A_Name" HeaderText="Auditor A Name" runat="server">
                <TemplateSettings RowEditTemplateControlId="lblAuditor_A_Name" RowEditTemplateControlPropertyName="innerHTML" />
            </cc1:Column>
            <cc1:Column ID="Column8" DataField="Auditor_A_Code" HeaderText="Auditor A Code/ISN"
                ReadOnly="true" runat="server">
            </cc1:Column>
            <cc1:Column ID="Column10" DataField="Name_on_Form_Auditor_B" HeaderText="Name on Form Auditor B"
                runat="server">
                <TemplateSettings RowEditTemplateControlId="txtName_on_Form_Auditor_B" RowEditTemplateControlPropertyName="value" />
            </cc1:Column>
            <cc1:Column ID="Column11" DataField="Auditor_B_Name" HeaderText="Auditor B Name"
                runat="server">
                <TemplateSettings RowEditTemplateControlId="lblAuditor_B_Name" RowEditTemplateControlPropertyName="innerHTML" />
            </cc1:Column>
            <cc1:Column ID="Column12" DataField="Auditor_B_Code" HeaderText="Auditor B Code/ISN"
                ReadOnly="true" runat="server">
            </cc1:Column>
            <cc1:Column ID="Column13" DataField="Name_on_Form_Auditor_C" HeaderText="Name on Form Auditor C"
                runat="server">
                <TemplateSettings RowEditTemplateControlId="txtName_on_Form_Auditor_C" RowEditTemplateControlPropertyName="value" />
            </cc1:Column>
            <cc1:Column ID="Column14" DataField="Auditor_C_Name" HeaderText="Auditor C Name"
                runat="server">
                <TemplateSettings RowEditTemplateControlId="lblAuditor_C_Name" RowEditTemplateControlPropertyName="innerHTML" />
            </cc1:Column>
            <cc1:Column ID="Column15" DataField="Auditor_C_Code" HeaderText="Auditor C Code/ISN"
                ReadOnly="true" runat="server">
            </cc1:Column>
            <cc1:Column ID="Column16" DataField="Form_Type" HeaderText="Form Type" runat="server">
                <TemplateSettings RowEditTemplateControlId="txtForm_Type" RowEditTemplateControlPropertyName="value" />
            </cc1:Column>
            <cc1:Column ID="Column20" DataField="Name_on_Form_Company_Audited_Name_1" HeaderText="Name on Form Company Audited Name 1"
                runat="server">
                <TemplateSettings RowEditTemplateControlId="txtName_on_Form_Company_Audited_Name_1"
                    RowEditTemplateControlPropertyName="value" />
            </cc1:Column>
            <cc1:Column ID="Column17" DataField="Company_Audited_Code_1" HeaderText="Company Audited Code 1"
                runat="server">
            </cc1:Column>
            <cc1:Column ID="Column19" DataField="Company_Audited_Name_1" HeaderText="Company Audited Name 1"
                runat="server">
                <TemplateSettings RowEditTemplateControlId="lblCompany_Audited_Name_1" RowEditTemplateControlPropertyName="innerHTML" />
            </cc1:Column>
            <cc1:Column ID="Column21" DataField="Name_on_Form_Company_Audited_Name_2" HeaderText="Name on Form Company Audited Name 2"
                runat="server">
                <TemplateSettings RowEditTemplateControlId="txtName_on_Form_Company_Audited_Name_2"
                    RowEditTemplateControlPropertyName="value" />
            </cc1:Column>
            <cc1:Column ID="Column22" DataField="Company_Audited_Code_2" HeaderText="Company Audited Code 2"
                runat="server">
            </cc1:Column>
            <cc1:Column ID="Column23" DataField="Company_Audited_Name_2" HeaderText="Company Audited Name 2"
                runat="server">
                <TemplateSettings RowEditTemplateControlId="lblCompany_Audited_Name_2" RowEditTemplateControlPropertyName="innerHTML" />
            </cc1:Column>
            <cc1:Column ID="Column24" DataField="Audit_Location" HeaderText="Audit Location"
                runat="server">
                <TemplateSettings RowEditTemplateControlId="txtAudit_Location" RowEditTemplateControlPropertyName="value" />
            </cc1:Column>
            <cc1:Column ID="Column25" DataField="A1" HeaderText="A1" runat="server">
                <TemplateSettings RowEditTemplateControlId="txtA1" RowEditTemplateControlPropertyName="value" />
            </cc1:Column>
            <cc1:Column ID="Column9" DataField="A2" HeaderText="A2" runat="server">
                <TemplateSettings RowEditTemplateControlId="txtA2" RowEditTemplateControlPropertyName="value" />
            </cc1:Column>
            <cc1:Column ID="Column63" DataField="A3" HeaderText="A3" runat="server">
                <TemplateSettings RowEditTemplateControlId="txtA3" RowEditTemplateControlPropertyName="value" />
            </cc1:Column>
            <cc1:Column ID="Column64" DataField="A4" HeaderText="A4" runat="server">
                <TemplateSettings RowEditTemplateControlId="txtA4" RowEditTemplateControlPropertyName="value" />
            </cc1:Column>
            <cc1:Column ID="Column65" DataField="A5" HeaderText="A5" runat="server">
                <TemplateSettings RowEditTemplateControlId="txtA5" RowEditTemplateControlPropertyName="value" />
            </cc1:Column>
            <cc1:Column ID="Column66" DataField="A6" HeaderText="A6" runat="server">
                <TemplateSettings RowEditTemplateControlId="txtA6" RowEditTemplateControlPropertyName="value" />
            </cc1:Column>
            <cc1:Column ID="Column26" DataField="B1" HeaderText="B1" runat="server">
                <TemplateSettings RowEditTemplateControlId="txtB1" RowEditTemplateControlPropertyName="value" />
            </cc1:Column>
            <cc1:Column ID="Column27" DataField="B2" HeaderText="B2" runat="server">
                <TemplateSettings RowEditTemplateControlId="txtB2" RowEditTemplateControlPropertyName="value" />
            </cc1:Column>
            <cc1:Column ID="Column28" DataField="B3" HeaderText="B3" runat="server">
                <TemplateSettings RowEditTemplateControlId="txtB3" RowEditTemplateControlPropertyName="value" />
            </cc1:Column>
            <cc1:Column ID="Column29" DataField="B4" HeaderText="B4" runat="server">
                <TemplateSettings RowEditTemplateControlId="txtB4" RowEditTemplateControlPropertyName="value" />
            </cc1:Column>
            <cc1:Column ID="Column30" DataField="B5" HeaderText="B5" runat="server">
                <TemplateSettings RowEditTemplateControlId="txtB5" RowEditTemplateControlPropertyName="value" />
            </cc1:Column>
            <cc1:Column ID="Column31" DataField="B6" HeaderText="B6" runat="server">
                <TemplateSettings RowEditTemplateControlId="txtB6" RowEditTemplateControlPropertyName="value" />
            </cc1:Column>
            <cc1:Column ID="Column32" DataField="B7" HeaderText="B7" runat="server">
                <TemplateSettings RowEditTemplateControlId="txtB7" RowEditTemplateControlPropertyName="value" />
            </cc1:Column>
            <cc1:Column ID="Column67" DataField="B8" HeaderText="B8" runat="server">
                <TemplateSettings RowEditTemplateControlId="txtB8" RowEditTemplateControlPropertyName="value" />
            </cc1:Column>
            <cc1:Column ID="Column33" DataField="C1" HeaderText="C1" runat="server">
                <TemplateSettings RowEditTemplateControlId="txtC1" RowEditTemplateControlPropertyName="value" />
            </cc1:Column>
            <cc1:Column ID="Column34" DataField="C2" HeaderText="C2" runat="server">
                <TemplateSettings RowEditTemplateControlId="txtC2" RowEditTemplateControlPropertyName="value" />
            </cc1:Column>
            <cc1:Column ID="Column35" DataField="C3" HeaderText="C3" runat="server">
                <TemplateSettings RowEditTemplateControlId="txtC3" RowEditTemplateControlPropertyName="value" />
            </cc1:Column>
            <cc1:Column ID="Column36" DataField="C4" HeaderText="C4" runat="server">
                <TemplateSettings RowEditTemplateControlId="txtC4" RowEditTemplateControlPropertyName="value" />
            </cc1:Column>
            <cc1:Column ID="Column37" DataField="C5" HeaderText="C5" runat="server">
                <TemplateSettings RowEditTemplateControlId="txtC5" RowEditTemplateControlPropertyName="value" />
            </cc1:Column>
            <cc1:Column ID="Column38" DataField="C6" HeaderText="C6" runat="server">
                <TemplateSettings RowEditTemplateControlId="txtC6" RowEditTemplateControlPropertyName="value" />
            </cc1:Column>
            <cc1:Column ID="Column39" DataField="C7" HeaderText="C7" runat="server">
                <TemplateSettings RowEditTemplateControlId="txtC7" RowEditTemplateControlPropertyName="value" />
            </cc1:Column>
            <cc1:Column ID="Column40" DataField="C8" HeaderText="C8" runat="server">
                <TemplateSettings RowEditTemplateControlId="txtC8" RowEditTemplateControlPropertyName="value" />
            </cc1:Column>
            <cc1:Column ID="Column41" DataField="C9" HeaderText="C9" runat="server">
                <TemplateSettings RowEditTemplateControlId="txtC9" RowEditTemplateControlPropertyName="value" />
            </cc1:Column>
            <cc1:Column ID="Column42" DataField="C10" HeaderText="C10" runat="server">
                <TemplateSettings RowEditTemplateControlId="txtC10" RowEditTemplateControlPropertyName="value" />
            </cc1:Column>
            <cc1:Column ID="Column43" DataField="C11" HeaderText="C11" runat="server">
                <TemplateSettings RowEditTemplateControlId="txtC11" RowEditTemplateControlPropertyName="value" />
            </cc1:Column>
            <cc1:Column ID="Column44" DataField="C12" HeaderText="C12" runat="server">
                <TemplateSettings RowEditTemplateControlId="txtC12" RowEditTemplateControlPropertyName="value" />
            </cc1:Column>
            <cc1:Column ID="Column45" DataField="C13" HeaderText="C13" runat="server">
                <TemplateSettings RowEditTemplateControlId="txtC13" RowEditTemplateControlPropertyName="value" />
            </cc1:Column>
            <cc1:Column ID="Column46" DataField="C14" HeaderText="C14" runat="server">
                <TemplateSettings RowEditTemplateControlId="txtC14" RowEditTemplateControlPropertyName="value" />
            </cc1:Column>
            <cc1:Column ID="Column47" DataField="C15" HeaderText="C15" runat="server">
                <TemplateSettings RowEditTemplateControlId="txtC15" RowEditTemplateControlPropertyName="value" />
            </cc1:Column>
            <cc1:Column ID="Column48" DataField="D1" HeaderText="D1" runat="server">
                <TemplateSettings RowEditTemplateControlId="txtD1" RowEditTemplateControlPropertyName="value" />
            </cc1:Column>
            <cc1:Column ID="Column49" DataField="D2" HeaderText="D2" runat="server">
                <TemplateSettings RowEditTemplateControlId="txtD2" RowEditTemplateControlPropertyName="value" />
            </cc1:Column>
            <cc1:Column ID="Column50" DataField="D3" HeaderText="D3" runat="server">
                <TemplateSettings RowEditTemplateControlId="txtD3" RowEditTemplateControlPropertyName="value" />
            </cc1:Column>
            <cc1:Column ID="Column51" DataField="D4" HeaderText="D4" runat="server">
                <TemplateSettings RowEditTemplateControlId="txtD4" RowEditTemplateControlPropertyName="value" />
            </cc1:Column>
            <cc1:Column ID="Column52" DataField="E1" HeaderText="E1" runat="server">
                <TemplateSettings RowEditTemplateControlId="txtE1" RowEditTemplateControlPropertyName="value" />
            </cc1:Column>
            <cc1:Column ID="Column53" DataField="E2" HeaderText="E2" runat="server">
                <TemplateSettings RowEditTemplateControlId="txtE2" RowEditTemplateControlPropertyName="value" />
            </cc1:Column>
            <cc1:Column ID="Column68" DataField="E3" HeaderText="E3" runat="server">
                <TemplateSettings RowEditTemplateControlId="txtE3" RowEditTemplateControlPropertyName="value" />
            </cc1:Column>
            <cc1:Column ID="Column69" DataField="E4" HeaderText="E4" runat="server">
                <TemplateSettings RowEditTemplateControlId="txtE4" RowEditTemplateControlPropertyName="value" />
            </cc1:Column>
            <cc1:Column ID="Column70" DataField="E5" HeaderText="E5" runat="server">
                <TemplateSettings RowEditTemplateControlId="txtE5" RowEditTemplateControlPropertyName="value" />
            </cc1:Column>
            <cc1:Column ID="Column71" DataField="E6" HeaderText="E6" runat="server">
                <TemplateSettings RowEditTemplateControlId="txtE6" RowEditTemplateControlPropertyName="value" />
            </cc1:Column>
            <cc1:Column ID="Column72" DataField="F1" HeaderText="F1" runat="server">
                <TemplateSettings RowEditTemplateControlId="txtF1" RowEditTemplateControlPropertyName="value" />
            </cc1:Column>
            <cc1:Column ID="Column73" DataField="F2" HeaderText="F2" runat="server">
                <TemplateSettings RowEditTemplateControlId="txtF2" RowEditTemplateControlPropertyName="value" />
            </cc1:Column>
            <cc1:Column ID="Column74" DataField="F3" HeaderText="F3" runat="server">
                <TemplateSettings RowEditTemplateControlId="txtF3" RowEditTemplateControlPropertyName="value" />
            </cc1:Column>
            <cc1:Column ID="Column75" DataField="F4" HeaderText="F4" runat="server">
                <TemplateSettings RowEditTemplateControlId="txtF4" RowEditTemplateControlPropertyName="value" />
            </cc1:Column>
            <cc1:Column ID="Column76" DataField="F5" HeaderText="F5" runat="server">
                <TemplateSettings RowEditTemplateControlId="txtF5" RowEditTemplateControlPropertyName="value" />
            </cc1:Column>
            <cc1:Column ID="Column77" DataField="F6" HeaderText="F6" runat="server">
                <TemplateSettings RowEditTemplateControlId="txtF6" RowEditTemplateControlPropertyName="value" />
            </cc1:Column>
            <cc1:Column ID="Column78" DataField="G1" HeaderText="G1" runat="server">
                <TemplateSettings RowEditTemplateControlId="txtG1" RowEditTemplateControlPropertyName="value" />
            </cc1:Column>
            <cc1:Column ID="Column79" DataField="G2" HeaderText="G2" runat="server">
                <TemplateSettings RowEditTemplateControlId="txtG2" RowEditTemplateControlPropertyName="value" />
            </cc1:Column>
            <cc1:Column ID="Column80" DataField="G3" HeaderText="G3" runat="server">
                <TemplateSettings RowEditTemplateControlId="txtG3" RowEditTemplateControlPropertyName="value" />
            </cc1:Column>
            <cc1:Column ID="Column81" DataField="G4" HeaderText="G4" runat="server">
                <TemplateSettings RowEditTemplateControlId="txtG4" RowEditTemplateControlPropertyName="value" />
            </cc1:Column>
            <cc1:Column ID="Column82" DataField="G5" HeaderText="G5" runat="server">
                <TemplateSettings RowEditTemplateControlId="txtG5" RowEditTemplateControlPropertyName="value" />
            </cc1:Column>
            <cc1:Column ID="Column83" DataField="G6" HeaderText="G6" runat="server">
                <TemplateSettings RowEditTemplateControlId="txtG6" RowEditTemplateControlPropertyName="value" />
            </cc1:Column>
            <cc1:Column ID="Column84" DataField="G7" HeaderText="G7" runat="server">
                <TemplateSettings RowEditTemplateControlId="txtG7" RowEditTemplateControlPropertyName="value" />
            </cc1:Column>
            <cc1:Column ID="Column144" DataField="H1" HeaderText="H1" runat="server">
                <TemplateSettings RowEditTemplateControlId="txtH1" RowEditTemplateControlPropertyName="value" />
            </cc1:Column>
            <cc1:Column ID="Column155" DataField="H2" HeaderText="H2" runat="server">
                <TemplateSettings RowEditTemplateControlId="txtH2" RowEditTemplateControlPropertyName="value" />
            </cc1:Column>
            <cc1:Column ID="Column156" DataField="H3" HeaderText="H3" runat="server">
                <TemplateSettings RowEditTemplateControlId="txtH3" RowEditTemplateControlPropertyName="value" />
            </cc1:Column>
            <cc1:Column ID="Column157" DataField="H4" HeaderText="H4" runat="server">
                <TemplateSettings RowEditTemplateControlId="txtH4" RowEditTemplateControlPropertyName="value" />
            </cc1:Column>
            <cc1:Column ID="Column158" DataField="H5" HeaderText="H5" runat="server">
                <TemplateSettings RowEditTemplateControlId="txtH5" RowEditTemplateControlPropertyName="value" />
            </cc1:Column>
            <cc1:Column ID="Column159" DataField="H6" HeaderText="H6" runat="server">
                <TemplateSettings RowEditTemplateControlId="txtH6" RowEditTemplateControlPropertyName="value" />
            </cc1:Column>
            <cc1:Column ID="Column160" DataField="H7" HeaderText="H7" runat="server">
                <TemplateSettings RowEditTemplateControlId="txtH7" RowEditTemplateControlPropertyName="value" />
            </cc1:Column>
            <cc1:Column ID="Column161" DataField="H8" HeaderText="H8" runat="server">
                <TemplateSettings RowEditTemplateControlId="txtH8" RowEditTemplateControlPropertyName="value" />
            </cc1:Column>
            <cc1:Column ID="Column85" DataField="I1" HeaderText="I1" runat="server">
                <TemplateSettings RowEditTemplateControlId="txtI1" RowEditTemplateControlPropertyName="value" />
            </cc1:Column>
            <cc1:Column ID="Column86" DataField="I2" HeaderText="I2" runat="server">
                <TemplateSettings RowEditTemplateControlId="txtI2" RowEditTemplateControlPropertyName="value" />
            </cc1:Column>
            <cc1:Column ID="Column87" DataField="I3" HeaderText="I3" runat="server">
                <TemplateSettings RowEditTemplateControlId="txtI3" RowEditTemplateControlPropertyName="value" />
            </cc1:Column>
            <cc1:Column ID="Column88" DataField="I4" HeaderText="I4" runat="server">
                <TemplateSettings RowEditTemplateControlId="txtI4" RowEditTemplateControlPropertyName="value" />
            </cc1:Column>
            <cc1:Column ID="Column89" DataField="I5" HeaderText="I5" runat="server">
                <TemplateSettings RowEditTemplateControlId="txtI5" RowEditTemplateControlPropertyName="value" />
            </cc1:Column>
            <cc1:Column ID="Column90" DataField="I6" HeaderText="I6" runat="server">
                <TemplateSettings RowEditTemplateControlId="txtI6" RowEditTemplateControlPropertyName="value" />
            </cc1:Column>
            <cc1:Column ID="Column91" DataField="I7" HeaderText="I7" runat="server">
                <TemplateSettings RowEditTemplateControlId="txtI7" RowEditTemplateControlPropertyName="value" />
            </cc1:Column>
            <cc1:Column ID="Column92" DataField="I8" HeaderText="I8" runat="server">
                <TemplateSettings RowEditTemplateControlId="txtI8" RowEditTemplateControlPropertyName="value" />
            </cc1:Column>
            <cc1:Column ID="Column93" DataField="I9" HeaderText="I9" runat="server">
                <TemplateSettings RowEditTemplateControlId="txtI9" RowEditTemplateControlPropertyName="value" />
            </cc1:Column>
            <cc1:Column ID="Column94" DataField="J1" HeaderText="J1" runat="server">
                <TemplateSettings RowEditTemplateControlId="txtJ1" RowEditTemplateControlPropertyName="value" />
            </cc1:Column>
            <cc1:Column ID="Column95" DataField="J2" HeaderText="J2" runat="server">
                <TemplateSettings RowEditTemplateControlId="txtJ2" RowEditTemplateControlPropertyName="value" />
            </cc1:Column>
            <cc1:Column ID="Column96" DataField="J3" HeaderText="J3" runat="server">
                <TemplateSettings RowEditTemplateControlId="txtJ3" RowEditTemplateControlPropertyName="value" />
            </cc1:Column>
            <cc1:Column ID="Column97" DataField="J4" HeaderText="J4" runat="server">
                <TemplateSettings RowEditTemplateControlId="txtJ4" RowEditTemplateControlPropertyName="value" />
            </cc1:Column>
            <cc1:Column ID="Column98" DataField="J5" HeaderText="J5" runat="server">
                <TemplateSettings RowEditTemplateControlId="txtJ5" RowEditTemplateControlPropertyName="value" />
            </cc1:Column>
            <cc1:Column ID="Column99" DataField="J6" HeaderText="J6" runat="server">
                <TemplateSettings RowEditTemplateControlId="txtJ6" RowEditTemplateControlPropertyName="value" />
            </cc1:Column>
            <cc1:Column ID="Column100" DataField="K1" HeaderText="K1" runat="server">
                <TemplateSettings RowEditTemplateControlId="txtK1" RowEditTemplateControlPropertyName="value" />
            </cc1:Column>
            <cc1:Column ID="Column101" DataField="K2" HeaderText="K2" runat="server">
                <TemplateSettings RowEditTemplateControlId="txtK2" RowEditTemplateControlPropertyName="value" />
            </cc1:Column>
            <cc1:Column ID="Column102" DataField="K3" HeaderText="K3" runat="server">
                <TemplateSettings RowEditTemplateControlId="txtK3" RowEditTemplateControlPropertyName="value" />
            </cc1:Column>
            <cc1:Column ID="Column103" DataField="K4" HeaderText="K4" runat="server">
                <TemplateSettings RowEditTemplateControlId="txtK4" RowEditTemplateControlPropertyName="value" />
            </cc1:Column>
            <cc1:Column ID="Column104" DataField="K5" HeaderText="K5" runat="server">
                <TemplateSettings RowEditTemplateControlId="txtK5" RowEditTemplateControlPropertyName="value" />
            </cc1:Column>
            <cc1:Column ID="Column105" DataField="K6" HeaderText="K6" runat="server">
                <TemplateSettings RowEditTemplateControlId="txtK6" RowEditTemplateControlPropertyName="value" />
            </cc1:Column>
            <cc1:Column ID="Column106" DataField="K7" HeaderText="K7" runat="server">
                <TemplateSettings RowEditTemplateControlId="txtK7" RowEditTemplateControlPropertyName="value" />
            </cc1:Column>
            <cc1:Column ID="Column145" DataField="K8" HeaderText="K8" runat="server">
                <TemplateSettings RowEditTemplateControlId="txtK8" RowEditTemplateControlPropertyName="value" />
            </cc1:Column>
            <cc1:Column ID="Column107" DataField="L1" HeaderText="L1" runat="server">
                <TemplateSettings RowEditTemplateControlId="txtL1" RowEditTemplateControlPropertyName="value" />
            </cc1:Column>
            <cc1:Column ID="Column108" DataField="L2" HeaderText="L2" runat="server">
                <TemplateSettings RowEditTemplateControlId="txtL2" RowEditTemplateControlPropertyName="value" />
            </cc1:Column>
            <cc1:Column ID="Column109" DataField="L3" HeaderText="L3" runat="server">
                <TemplateSettings RowEditTemplateControlId="txtL3" RowEditTemplateControlPropertyName="value" />
            </cc1:Column>
            <cc1:Column ID="Column110" DataField="L4" HeaderText="L4" runat="server">
                <TemplateSettings RowEditTemplateControlId="txtL4" RowEditTemplateControlPropertyName="value" />
            </cc1:Column>
            <cc1:Column ID="Column111" DataField="L5" HeaderText="L5" runat="server">
                <TemplateSettings RowEditTemplateControlId="txtL5" RowEditTemplateControlPropertyName="value" />
            </cc1:Column>
            <cc1:Column ID="Column112" DataField="M1" HeaderText="M1" runat="server">
                <TemplateSettings RowEditTemplateControlId="txtM1" RowEditTemplateControlPropertyName="value" />
            </cc1:Column>
            <cc1:Column ID="Column113" DataField="M2" HeaderText="M2" runat="server">
                <TemplateSettings RowEditTemplateControlId="txtM2" RowEditTemplateControlPropertyName="value" />
            </cc1:Column>
            <cc1:Column ID="Column114" DataField="M3" HeaderText="M3" runat="server">
                <TemplateSettings RowEditTemplateControlId="txtM3" RowEditTemplateControlPropertyName="value" />
            </cc1:Column>
            <cc1:Column ID="Column115" DataField="M4" HeaderText="M4" runat="server">
                <TemplateSettings RowEditTemplateControlId="txtM4" RowEditTemplateControlPropertyName="value" />
            </cc1:Column>
            <cc1:Column ID="Column116" DataField="M5" HeaderText="M5" runat="server">
                <TemplateSettings RowEditTemplateControlId="txtM5" RowEditTemplateControlPropertyName="value" />
            </cc1:Column>
            <cc1:Column ID="Column117" DataField="M6" HeaderText="M6" runat="server">
                <TemplateSettings RowEditTemplateControlId="txtM6" RowEditTemplateControlPropertyName="value" />
            </cc1:Column>
            <cc1:Column ID="Column118" DataField="N1" HeaderText="N1" runat="server">
                <TemplateSettings RowEditTemplateControlId="txtN1" RowEditTemplateControlPropertyName="value" />
            </cc1:Column>
            <cc1:Column ID="Column119" DataField="N2" HeaderText="N2" runat="server">
                <TemplateSettings RowEditTemplateControlId="txtN2" RowEditTemplateControlPropertyName="value" />
            </cc1:Column>
            <cc1:Column ID="Column120" DataField="N3" HeaderText="N3" runat="server">
                <TemplateSettings RowEditTemplateControlId="txtN3" RowEditTemplateControlPropertyName="value" />
            </cc1:Column>
            <cc1:Column ID="Column121" DataField="N4" HeaderText="N4" runat="server">
                <TemplateSettings RowEditTemplateControlId="txtN4" RowEditTemplateControlPropertyName="value" />
            </cc1:Column>
            <cc1:Column ID="Column122" DataField="N5" HeaderText="N5" runat="server">
                <TemplateSettings RowEditTemplateControlId="txtN5" RowEditTemplateControlPropertyName="value" />
            </cc1:Column>
            <cc1:Column ID="Column123" DataField="N6" HeaderText="N6" runat="server">
                <TemplateSettings RowEditTemplateControlId="txtN6" RowEditTemplateControlPropertyName="value" />
            </cc1:Column>
            <cc1:Column ID="Column124" DataField="N7" HeaderText="N7" runat="server">
                <TemplateSettings RowEditTemplateControlId="txtN7" RowEditTemplateControlPropertyName="value" />
            </cc1:Column>
            <cc1:Column ID="Column125" DataField="P1" HeaderText="P1" runat="server">
                <TemplateSettings RowEditTemplateControlId="txtP1" RowEditTemplateControlPropertyName="value" />
            </cc1:Column>
            <cc1:Column ID="Column126" DataField="P2" HeaderText="P2" runat="server">
                <TemplateSettings RowEditTemplateControlId="txtP2" RowEditTemplateControlPropertyName="value" />
            </cc1:Column>
            <cc1:Column ID="Column127" DataField="P3" HeaderText="P3" runat="server">
                <TemplateSettings RowEditTemplateControlId="txtP3" RowEditTemplateControlPropertyName="value" />
            </cc1:Column>
            <cc1:Column ID="Column128" DataField="P4" HeaderText="P4" runat="server">
                <TemplateSettings RowEditTemplateControlId="txtP4" RowEditTemplateControlPropertyName="value" />
            </cc1:Column>
            <cc1:Column ID="Column129" DataField="P5" HeaderText="P5" runat="server">
                <TemplateSettings RowEditTemplateControlId="txtP5" RowEditTemplateControlPropertyName="value" />
            </cc1:Column>
            <cc1:Column ID="Column130" DataField="Q1" HeaderText="Q1" runat="server">
                <TemplateSettings RowEditTemplateControlId="txtQ1" RowEditTemplateControlPropertyName="value" />
            </cc1:Column>
            <cc1:Column ID="Column131" DataField="Q2" HeaderText="Q2" runat="server">
                <TemplateSettings RowEditTemplateControlId="txtQ2" RowEditTemplateControlPropertyName="value" />
            </cc1:Column>
            <cc1:Column ID="Column132" DataField="Q3" HeaderText="Q3" runat="server">
                <TemplateSettings RowEditTemplateControlId="txtQ3" RowEditTemplateControlPropertyName="value" />
            </cc1:Column>
            <cc1:Column ID="Column133" DataField="Q4" HeaderText="Q4" runat="server">
                <TemplateSettings RowEditTemplateControlId="txtQ4" RowEditTemplateControlPropertyName="value" />
            </cc1:Column>
            <cc1:Column ID="Column146" DataField="O1" HeaderText="O1" runat="server">
                <TemplateSettings RowEditTemplateControlId="txtO1" RowEditTemplateControlPropertyName="value" />
            </cc1:Column>
            <cc1:Column ID="Column134" DataField="O2" HeaderText="O2" runat="server">
                <TemplateSettings RowEditTemplateControlId="txtO2" RowEditTemplateControlPropertyName="value" />
            </cc1:Column>
            <cc1:Column ID="Column135" DataField="O3" HeaderText="O3" runat="server">
                <TemplateSettings RowEditTemplateControlId="txtO3" RowEditTemplateControlPropertyName="value" />
            </cc1:Column>
            <cc1:Column ID="Column136" DataField="O4" HeaderText="O4" runat="server">
                <TemplateSettings RowEditTemplateControlId="txtO4" RowEditTemplateControlPropertyName="value" />
            </cc1:Column>
            <cc1:Column ID="Column137" DataField="O5" HeaderText="O5" runat="server">
                <TemplateSettings RowEditTemplateControlId="txtO5" RowEditTemplateControlPropertyName="value" />
            </cc1:Column>
            <cc1:Column ID="Column138" DataField="Corrected_1" HeaderText="Corrected 1" runat="server">
                <TemplateSettings RowEditTemplateControlId="txtCorrected_1" RowEditTemplateControlPropertyName="value" />
            </cc1:Column>
            <cc1:Column ID="Column139" DataField="Corrected_1_Text" HeaderText="Corrected 1 Text"
                runat="server">
                <TemplateSettings RowEditTemplateControlId="txtCorrected_1_Text" RowEditTemplateControlPropertyName="value" />
            </cc1:Column>
            <cc1:Column ID="Column147" DataField="Item1_Expected_Completion" HeaderText="Item 1 Expected Completion"
                runat="server">
                <TemplateSettings RowEditTemplateControlId="txtItem1_Expected_Completion" RowEditTemplateControlPropertyName="value" />
            </cc1:Column>
            <cc1:Column ID="Column148" DataField="Item1_Actual_Completion" HeaderText="Item 1 Actual Completion"
                runat="server">
                <TemplateSettings RowEditTemplateControlId="txtItem1_Actual_Completion" RowEditTemplateControlPropertyName="value" />
            </cc1:Column>
            <cc1:Column ID="Column162" DataField="Item1_Assigned_Name" HeaderText="Item 1 Assigned Name"
                runat="server">
                <TemplateSettings RowEditTemplateControlId="txtItem1_Assigned_Name" RowEditTemplateControlPropertyName="value" />
            </cc1:Column>
            <cc1:Column ID="Column163" DataField="Item1_Admin_Comments" HeaderText="Item 1 Admin Comments"
                runat="server">
                <TemplateSettings RowEditTemplateControlId="txtItem1_Admin_Comments" RowEditTemplateControlPropertyName="value" />
            </cc1:Column>
            <cc1:Column ID="Column140" DataField="Corrected_2" HeaderText="Corrected 2" runat="server">
                <TemplateSettings RowEditTemplateControlId="txtCorrected_2" RowEditTemplateControlPropertyName="value" />
            </cc1:Column>
            <cc1:Column ID="Column141" DataField="Corrected_2_Text" HeaderText="Corrected 2 Text"
                runat="server">
                <TemplateSettings RowEditTemplateControlId="txtCorrected_2_Text" RowEditTemplateControlPropertyName="value" />
            </cc1:Column>
            <cc1:Column ID="Column164" DataField="Item2_Expected_Completion" HeaderText="Item 2 Expected Completion"
                runat="server">
                <TemplateSettings RowEditTemplateControlId="txtItem2_Expected_Completion" RowEditTemplateControlPropertyName="value" />
            </cc1:Column>
            <cc1:Column ID="Column165" DataField="Item2_Actual_Completion" HeaderText="Item 2 Actual Completion"
                runat="server">
                <TemplateSettings RowEditTemplateControlId="txtItem2_Actual_Completion" RowEditTemplateControlPropertyName="value" />
            </cc1:Column>
            <cc1:Column ID="Column166" DataField="Item2_Assigned_Name" HeaderText="Item 2 Assigned Name"
                runat="server">
                <TemplateSettings RowEditTemplateControlId="txtItem2_Assigned_Name" RowEditTemplateControlPropertyName="value" />
            </cc1:Column>
            <cc1:Column ID="Column167" DataField="Item2_Admin_Comments" HeaderText="Item 2 Admin Comments"
                runat="server">
                <TemplateSettings RowEditTemplateControlId="txtItem2_Admin_Comments" RowEditTemplateControlPropertyName="value" />
            </cc1:Column>
            <cc1:Column ID="Column142" DataField="Corrected_3" HeaderText="Corrected 3" runat="server">
                <TemplateSettings RowEditTemplateControlId="txtCorrected_3" RowEditTemplateControlPropertyName="value" />
            </cc1:Column>
            <cc1:Column ID="Column143" DataField="Corrected_3_Text" HeaderText="Corrected 3 Text"
                runat="server">
                <TemplateSettings RowEditTemplateControlId="txtCorrected_3_Text" RowEditTemplateControlPropertyName="value" />
            </cc1:Column>
            <cc1:Column ID="Column168" DataField="Item3_Expected_Completion" HeaderText="Item 3 Expected Completion"
                runat="server">
                <TemplateSettings RowEditTemplateControlId="txtItem3_Expected_Completion" RowEditTemplateControlPropertyName="value" />
            </cc1:Column>
            <cc1:Column ID="Column169" DataField="Item3_Actual_Completion" HeaderText="Item 3 Actual Completion"
                runat="server">
                <TemplateSettings RowEditTemplateControlId="txtItem3_Actual_Completion" RowEditTemplateControlPropertyName="value" />
            </cc1:Column>
            <cc1:Column ID="Column170" DataField="Item3_Assigned_Name" HeaderText="Item 3 Assigned Name"
                runat="server">
                <TemplateSettings RowEditTemplateControlId="txtItem3_Assigned_Name" RowEditTemplateControlPropertyName="value" />
            </cc1:Column>
            <cc1:Column ID="Column171" DataField="Item3_Admin_Comments" HeaderText="Item 3 Admin Comments"
                runat="server">
                <TemplateSettings RowEditTemplateControlId="txtItem3_Admin_Comments" RowEditTemplateControlPropertyName="value" />
            </cc1:Column>
            <cc1:Column ID="Column54" DataField="Item_Num_Comments" HeaderText="Action Required Item Num Comments"
                runat="server">
                <TemplateSettings RowEditTemplateControlId="txtItem_Num_Comments" RowEditTemplateControlPropertyName="value" />
            </cc1:Column>
            <cc1:Column ID="Column55" DataField="Item_Company_Comments" HeaderText="Item Company Comments"
                runat="server">
                <TemplateSettings RowEditTemplateControlId="txtItem_Company_Comments" RowEditTemplateControlPropertyName="value" />
            </cc1:Column>
            <cc1:Column ID="Column59" DataField="Image_Files" HeaderText="Image Files" ReadOnly="true"
                runat="server">
                <TemplateSettings RowEditTemplateControlId="lblImage_Files" RowEditTemplateControlPropertyName="innerHTML" />
            </cc1:Column>
            <cc1:Column ID="Column60" DataField="Created" HeaderText="Created" ReadOnly="true"
                runat="server">
                <TemplateSettings RowEditTemplateControlId="lblCreated" RowEditTemplateControlPropertyName="innerHTML" />
            </cc1:Column>
            <cc1:Column ID="Column56" DataField="Image_URL" Width="700" HeaderText="Card Image Front"
                runat="server" ReadOnly="True">
                <TemplateSettings RowEditTemplateControlId="CardImageFront" RowEditTemplateControlPropertyName="src" />
            </cc1:Column>
            <cc1:Column ID="Column61" DataField="Image_URL" Width="700" HeaderText="Card Image Back"
                runat="server" ReadOnly="True">
                <TemplateSettings RowEditTemplateControlId="CardImageBack" RowEditTemplateControlPropertyName="src" />
            </cc1:Column>
            <cc1:Column ID="Column62" DataField="Image_URL" HeaderText="Card Image" runat="server">
                <TemplateSettings RowEditTemplateControlId="hlkImageURL" RowEditTemplateControlPropertyName="href"
                    TemplateId="tplImageURL" />
            </cc1:Column>
            <cc1:Column ID="Column149" DataField="FKEmployeeID_LA" Visible="false" runat="server">
                <TemplateSettings RowEditTemplateControlId="ddlFKEmployeeID_LA" RowEditTemplateControlPropertyName="value" />
            </cc1:Column>
            <cc1:Column ID="Column150" DataField="FKEmployeeID_A" Visible="false" runat="server">
                <TemplateSettings RowEditTemplateControlId="ddlFKEmployeeID_A" RowEditTemplateControlPropertyName="value" />
            </cc1:Column>
            <cc1:Column ID="Column151" DataField="FKEmployeeID_B" Visible="false" runat="server">
                <TemplateSettings RowEditTemplateControlId="ddlFKEmployeeID_B" RowEditTemplateControlPropertyName="value" />
            </cc1:Column>
            <cc1:Column ID="Column152" DataField="FKEmployeeID_C" Visible="false" runat="server">
                <TemplateSettings RowEditTemplateControlId="ddlFKEmployeeID_C" RowEditTemplateControlPropertyName="value" />
            </cc1:Column>
            <cc1:Column ID="Column153" DataField="FKCompanyID_1" Visible="false" runat="server">
                <TemplateSettings RowEditTemplateControlId="ddlFKCompanyID_1" RowEditTemplateControlPropertyName="value" />
            </cc1:Column>
            <cc1:Column ID="Column154" DataField="FKCompanyID_2" Visible="false" runat="server">
                <TemplateSettings RowEditTemplateControlId="ddlFKCompanyID_2" RowEditTemplateControlPropertyName="value" />
            </cc1:Column>
            <cc1:Column ID="Column57" DataField="DateINT" HeaderText="DateINT" Visible="false"
                runat="server">
            </cc1:Column>
            <%--<cc1:Column ID="Column226" DataField="Action_Required_Expected_Date" HeaderText="Action Required Expected Date"
                runat="server">
                <TemplateSettings RowEditTemplateControlId="txtAction_Required_Expected_Date" RowEditTemplateControlPropertyName="value" />
            </cc1:Column>
            <cc1:Column ID="Column235" DataField="Action_Required_Assigned_Name" HeaderText="Action Required Assigned Name"
                runat="server">
                <TemplateSettings RowEditTemplateControlId="txtAction_Required_Assigned_Name" RowEditTemplateControlPropertyName="value" />
            </cc1:Column>
            <cc1:Column ID="Column246" DataField="Action_Required_Date_Completed" HeaderText="Action Required Date Completed"
                runat="server">
                <TemplateSettings RowEditTemplateControlId="txtAction_Required_Date_Completed" RowEditTemplateControlPropertyName="value" />
            </cc1:Column>
            <cc1:Column ID="Column147" DataField="Action_Required_Admin_Comments" HeaderText="Action Required Admin Comments"
                runat="server">
                <TemplateSettings RowEditTemplateControlId="txtAction_Required_Admin_Comments" RowEditTemplateControlPropertyName="value" />
            </cc1:Column>--%>
        </Columns>
        <TemplateSettings RowEditTemplateId="tplRowEdit" />
        <Templates>
            <cc1:GridTemplate runat="server" ID="tplRowEdit">
                <Template>
                    <div style="margin: 0; padding: 0; background-color: #EBECEC; margin-top: 12px; height: 3420px;">
                        <div style="margin: 0; padding: 0; width: 530px; float: left; height: 1710px;">
                            <fieldset style="margin: 0; padding: 0; width: 520px; height: 1710px; background-color: #EBECEC;">
                                <legend>Front of Card</legend>
                                <div style="height: 1710px; padding: 5px;">
                                    <div style="text-align: center; padding-top: 8px; width: 510px;">
                                        <b>iCount:</b> &nbsp;&nbsp;&nbsp;<b><span id="lbliCount" style="width: 140px;"></span></b>
                                    </div>
                                    <div style="text-align: center; height: 20px; width: 510px;">
                                        <hr style="width: 50%;" />
                                    </div>
                                    <div style="clear: both; width: 235px; text-align: right; padding-left: 5px; padding-right: 5px;
                                        padding-top: 5px; float: left; font-weight: bold;">
                                        Card Date
                                    </div>
                                    <div style="float: left; padding-right: 15px;">
                                        <cc1:OboutTextBox runat="server" ID="txtDate" Width="80" FolderStyle="styles/premiere_blue/OboutTextBox"
                                            Text='<%# Container.Value %>' /><obout:Calendar ID="Calendar1" runat="server" StyleFolder="Calendar/styles/expedia"
                                                DatePickerMode="true" TextBoxId="txtDate" TextArrowLeft="" TextArrowRight=""
                                                DatePickerSynchronize="true" DatePickerImagePath="Calendar/styles/icon2.gif"
                                                DateFormat="MM/dd/yyyy" EnableViewState="true" AllowDeselect="false" />
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidatorFromDate" ControlToValidate="txtDate"
                                            runat="server" ErrorMessage="*" ForeColor="Red">
                                        </asp:RequiredFieldValidator>
                                        <asp:RegularExpressionValidator ID="FromDateValidator" ControlToValidate="txtDate"
                                            Display="Dynamic" EnableClientScript="true" runat="server" ValidationExpression="^([0-9]{1,2})[./-]+([0-9]{1,2})[./-]+([0-9]{2}|[0-9]{4})$"
                                            SetFocusOnError="true" ForeColor="Red">
                              Please enter date in mm/dd/yyyy format
                                        </asp:RegularExpressionValidator>
                                    </div>
                                    <div style="clear: both; width: 235px; text-align: right; padding-left: 5px; padding-right: 5px;
                                        padding-top: 4px; float: left; font-weight: bold;">
                                        Name on Form Lead Auditor
                                    </div>
                                    <div style="float: left; padding-right: 15px;">
                                        <cc1:OboutTextBox runat="server" ID="txtName_on_Form_Lead_Auditor" Width="120px"
                                            FolderStyle="styles/premiere_blue/OboutTextBox" />
                                    </div>
                                    <div style="clear: both; width: 235px; text-align: right; padding-left: 5px; padding-right: 5px;
                                        padding-top: 4px; float: left; font-weight: bold;">
                                        Lead Auditor Name
                                    </div>
                                    <div style="float: left; padding-right: 15px; padding-top: 4px;">
                                        <span id="lblLead_Auditor_Name" style="width: 160px;"></span>
                                    </div>
                                    <div style="clear: both; width: 235px; text-align: right; padding-left: 5px; padding-right: 5px;
                                        padding-top: 4px; float: left; font-weight: bold;">
                                        Lead Auditor Code
                                    </div>
                                    <div style="float: left; padding-right: 15px;">
                                        <cc1:OboutDropDownList Height="400" ID="ddlFKEmployeeID_LA" runat="server" DataSourceID="SqlDataSourceEmployee"
                                            DataTextField="Code_Name_Combo" DataValueField="PKEmployeeID" Width="245">
                                        </cc1:OboutDropDownList>
                                    </div>
                                    <div style="clear: both; width: 235px; text-align: right; padding-left: 5px; padding-right: 5px;
                                        padding-top: 4px; float: left; font-weight: bold;">
                                        Name on Form Auditor A
                                    </div>
                                    <div style="float: left; padding-right: 15px;">
                                        <cc1:OboutTextBox runat="server" ID="txtName_on_Form_Auditor_A" Width="120px" FolderStyle="styles/premiere_blue/OboutTextBox" />
                                    </div>
                                    <div style="clear: both; width: 235px; text-align: right; padding-left: 5px; padding-right: 5px;
                                        padding-top: 4px; float: left; font-weight: bold;">
                                        Auditor A Name
                                    </div>
                                    <div style="float: left; padding-right: 15px; padding-top: 4px;">
                                        <span id="lblAuditor_A_Name" style="width: 160px;"></span>
                                    </div>
                                    <div style="clear: both; width: 235px; text-align: right; padding-left: 5px; padding-right: 5px;
                                        padding-top: 4px; float: left; font-weight: bold;">
                                        Auditor A Code
                                    </div>
                                    <div style="float: left; padding-right: 15px;">
                                        <cc1:OboutDropDownList Height="400" ID="ddlFKEmployeeID_A" runat="server" DataSourceID="SqlDataSourceEmployee"
                                            DataTextField="Code_Name_Combo" DataValueField="PKEmployeeID" Width="245">
                                        </cc1:OboutDropDownList>
                                    </div>
                                    <div style="clear: both; width: 235px; text-align: right; padding-left: 5px; padding-right: 5px;
                                        padding-top: 4px; float: left; font-weight: bold;">
                                        Name on Form Audito B
                                    </div>
                                    <div style="float: left; padding-right: 15px;">
                                        <cc1:OboutTextBox runat="server" ID="txtName_on_Form_Auditor_B" Width="120px" FolderStyle="styles/premiere_blue/OboutTextBox" />
                                    </div>
                                    <div style="clear: both; width: 235px; text-align: right; padding-left: 5px; padding-right: 5px;
                                        padding-top: 4px; float: left; font-weight: bold;">
                                        Auditor B Name
                                    </div>
                                    <div style="float: left; padding-right: 15px; padding-top: 4px;">
                                        <span id="lblAuditor_B_Name" style="width: 160px;"></span>
                                    </div>
                                    <div style="clear: both; width: 235px; text-align: right; padding-left: 5px; padding-right: 5px;
                                        padding-top: 4px; float: left; font-weight: bold;">
                                        Auditor B Code
                                    </div>
                                    <div style="float: left; padding-right: 15px;">
                                        <cc1:OboutDropDownList Height="400" ID="ddlFKEmployeeID_B" runat="server" DataSourceID="SqlDataSourceEmployee"
                                            DataTextField="Code_Name_Combo" DataValueField="PKEmployeeID" Width="245">
                                        </cc1:OboutDropDownList>
                                    </div>
                                    <div style="clear: both; width: 235px; text-align: right; padding-left: 5px; padding-right: 5px;
                                        padding-top: 4px; float: left; font-weight: bold;">
                                        Name on Form Auditor C
                                    </div>
                                    <div style="float: left; padding-right: 15px;">
                                        <cc1:OboutTextBox runat="server" ID="txtName_on_Form_Auditor_C" Width="120px" FolderStyle="styles/premiere_blue/OboutTextBox" />
                                    </div>
                                    <div style="clear: both; width: 235px; text-align: right; padding-left: 5px; padding-right: 5px;
                                        padding-top: 4px; float: left; font-weight: bold;">
                                        Auditor C Name
                                    </div>
                                    <div style="float: left; padding-right: 15px; padding-top: 4px;">
                                        <span id="lblAuditor_C_Name" style="width: 160px;"></span>
                                    </div>
                                    <div style="clear: both; width: 235px; text-align: right; padding-left: 5px; padding-right: 5px;
                                        padding-top: 4px; float: left; font-weight: bold;">
                                        Auditor C Code
                                    </div>
                                    <div style="float: left; padding-right: 15px;">
                                        <cc1:OboutDropDownList Height="400" ID="ddlFKEmployeeID_C" runat="server" DataSourceID="SqlDataSourceEmployee"
                                            DataTextField="Code_Name_Combo" DataValueField="PKEmployeeID" Width="245">
                                        </cc1:OboutDropDownList>
                                    </div>
                                    <div style="clear: both; width: 235px; text-align: right; padding-left: 5px; padding-right: 5px;
                                        padding-top: 4px; float: left; font-weight: bold;">
                                        Name on Form Company Audited Name 1
                                    </div>
                                    <div style="float: left; padding-right: 15px;">
                                        <cc1:OboutTextBox runat="server" ID="txtName_on_Form_Company_Audited_Name_1" Width="120px"
                                            FolderStyle="styles/premiere_blue/OboutTextBox" />
                                    </div>
                                    <div style="clear: both; width: 235px; text-align: right; padding-left: 5px; padding-right: 5px;
                                        padding-top: 4px; float: left; font-weight: bold;">
                                        Company Audited Name 1
                                    </div>
                                    <div style="float: left; padding-right: 15px; padding-top: 4px;">
                                        <span id="lblCompany_Audited_Name_1" style="width: 160px;"></span>
                                    </div>
                                    <div style="clear: both; width: 235px; text-align: right; padding-left: 5px; padding-right: 5px;
                                        padding-top: 4px; float: left; font-weight: bold;">
                                        Company Audited Code 1
                                    </div>
                                    <div style="float: left; padding-right: 15px;">
                                        <cc1:OboutDropDownList Height="400" ID="ddlFKCompanyID_1" runat="server" DataSourceID="SqlDataSourceCompany"
                                            DataTextField="Code_Name_Combo" DataValueField="PKCompanyID" Width="245">
                                        </cc1:OboutDropDownList>
                                    </div>
                                    <div style="clear: both; width: 235px; text-align: right; padding-left: 5px; padding-right: 5px;
                                        padding-top: 4px; float: left; font-weight: bold;">
                                        Name on Form Company Audited Name 2
                                    </div>
                                    <div style="float: left; padding-right: 15px;">
                                        <cc1:OboutTextBox runat="server" ID="txtName_on_Form_Company_Audited_Name_2" Width="120px"
                                            FolderStyle="styles/premiere_blue/OboutTextBox" />
                                    </div>
                                    <div style="clear: both; width: 235px; text-align: right; padding-left: 5px; padding-right: 5px;
                                        padding-top: 4px; float: left; font-weight: bold;">
                                        Company Audited Name 2
                                    </div>
                                    <div style="float: left; padding-right: 15px; padding-top: 4px;">
                                        <span id="lblCompany_Audited_Name_2" style="width: 160px;"></span>
                                    </div>
                                    <div style="clear: both; width: 235px; text-align: right; padding-left: 5px; padding-right: 5px;
                                        padding-top: 4px; float: left; font-weight: bold;">
                                        Company Audited Code 2
                                    </div>
                                    <div style="float: left; padding-right: 15px;">
                                        <cc1:OboutDropDownList Height="400" ID="ddlFKCompanyID_2" runat="server" DataSourceID="SqlDataSourceCompany"
                                            DataTextField="Code_Name_Combo" DataValueField="PKCompanyID" Width="245">
                                        </cc1:OboutDropDownList>
                                    </div>
                                    <div style="clear: both; width: 235px; text-align: right; padding-left: 5px; padding-right: 5px;
                                        padding-top: 4px; float: left; font-weight: bold;">
                                        Audit Location
                                    </div>
                                    <div style="float: left; padding-right: 15px;">
                                        <cc1:OboutTextBox runat="server" ID="txtAudit_Location" Width="120px" FolderStyle="styles/premiere_blue/OboutTextBox" />
                                    </div>
                                    <div style="clear: both; width: 235px; text-align: right; padding-left: 5px; padding-right: 5px;
                                        padding-top: 4px; float: left; font-weight: bold;">
                                        Form Type
                                    </div>
                                    <div style="float: left; padding-right: 15px;">
                                        <cc1:OboutTextBox runat="server" ID="txtForm_Type" Width="120px" 
                                        FolderStyle="styles/premiere_blue/OboutTextBox" />
                                    </div>
                                    <div style="clear: both; width: 235px; text-align: right; padding-left: 5px; padding-right: 5px;
                                        padding-top: 4px; float: left; font-weight: bold;">
                                        A1
                                    </div>
                                    <div style="float: left; padding-right: 15px;">
                                        <cc1:OboutTextBox runat="server" ID="txtA1" Width="24px" FolderStyle="styles/premiere_blue/OboutTextBox" />
                                    </div>
                                    <div style="clear: both; width: 235px; text-align: right; padding-left: 5px; padding-right: 5px;
                                        padding-top: 4px; float: left; font-weight: bold;">
                                        A2
                                    </div>
                                    <div style="float: left; padding-right: 15px;">
                                        <cc1:OboutTextBox runat="server" ID="txtA2" Width="24px" FolderStyle="styles/premiere_blue/OboutTextBox" />
                                    </div>
                                    <div style="clear: both; width: 235px; text-align: right; padding-left: 5px; padding-right: 5px;
                                        padding-top: 4px; float: left; font-weight: bold;">
                                        A3
                                    </div>
                                    <div style="float: left; padding-right: 15px;">
                                        <cc1:OboutTextBox runat="server" ID="txtA3" Width="24px" FolderStyle="styles/premiere_blue/OboutTextBox" />
                                    </div>
                                    <div style="clear: both; width: 235px; text-align: right; padding-left: 5px; padding-right: 5px;
                                        padding-top: 4px; float: left; font-weight: bold;">
                                        A4
                                    </div>
                                    <div style="float: left; padding-right: 15px;">
                                        <cc1:OboutTextBox runat="server" ID="txtA4" Width="24px" FolderStyle="styles/premiere_blue/OboutTextBox" />
                                    </div>
                                    <div style="clear: both; width: 235px; text-align: right; padding-left: 5px; padding-right: 5px;
                                        padding-top: 4px; float: left; font-weight: bold;">
                                        A5
                                    </div>
                                    <div style="float: left; padding-right: 15px;">
                                        <cc1:OboutTextBox runat="server" ID="txtA5" Width="24px" FolderStyle="styles/premiere_blue/OboutTextBox" />
                                    </div>
                                    <div style="clear: both; width: 235px; text-align: right; padding-left: 5px; padding-right: 5px;
                                        padding-top: 4px; float: left; font-weight: bold;">
                                        A6
                                    </div>
                                    <div style="float: left; padding-right: 15px;">
                                        <cc1:OboutTextBox runat="server" ID="txtA6" Width="24px" FolderStyle="styles/premiere_blue/OboutTextBox" />
                                    </div>
                                    <div style="clear: both; width: 235px; text-align: right; padding-left: 5px; padding-right: 5px;
                                        padding-top: 4px; float: left; font-weight: bold;">
                                        B1
                                    </div>
                                    <div style="float: left; padding-right: 15px;">
                                        <cc1:OboutTextBox runat="server" ID="txtB1" Width="24px" FolderStyle="styles/premiere_blue/OboutTextBox" />
                                    </div>
                                    <div style="clear: both; width: 235px; text-align: right; padding-left: 5px; padding-right: 5px;
                                        padding-top: 4px; float: left; font-weight: bold;">
                                        B2
                                    </div>
                                    <div style="float: left; padding-right: 15px;">
                                        <cc1:OboutTextBox runat="server" ID="txtB2" Width="24px" FolderStyle="styles/premiere_blue/OboutTextBox" />
                                    </div>
                                    <div style="clear: both; width: 235px; text-align: right; padding-left: 5px; padding-right: 5px;
                                        padding-top: 4px; float: left; font-weight: bold;">
                                        B3
                                    </div>
                                    <div style="float: left; padding-right: 15px;">
                                        <cc1:OboutTextBox runat="server" ID="txtB3" Width="24px" FolderStyle="styles/premiere_blue/OboutTextBox" />
                                    </div>
                                    <div style="clear: both; width: 235px; text-align: right; padding-left: 5px; padding-right: 5px;
                                        padding-top: 4px; float: left; font-weight: bold;">
                                        B4
                                    </div>
                                    <div style="float: left; padding-right: 15px;">
                                        <cc1:OboutTextBox runat="server" ID="txtB4" Width="24px" FolderStyle="styles/premiere_blue/OboutTextBox" />
                                    </div>
                                    <div style="clear: both; width: 235px; text-align: right; padding-left: 5px; padding-right: 5px;
                                        padding-top: 4px; float: left; font-weight: bold;">
                                        B5
                                    </div>
                                    <div style="float: left; padding-right: 15px;">
                                        <cc1:OboutTextBox runat="server" ID="txtB5" Width="24px" FolderStyle="styles/premiere_blue/OboutTextBox" />
                                    </div>
                                    <div style="clear: both; width: 235px; text-align: right; padding-left: 5px; padding-right: 5px;
                                        padding-top: 4px; float: left; font-weight: bold;">
                                        B6
                                    </div>
                                    <div style="float: left; padding-right: 15px;">
                                        <cc1:OboutTextBox runat="server" ID="txtB6" Width="24px" FolderStyle="styles/premiere_blue/OboutTextBox" />
                                    </div>
                                    <div style="clear: both; width: 235px; text-align: right; padding-left: 5px; padding-right: 5px;
                                        padding-top: 4px; float: left; font-weight: bold;">
                                        B7
                                    </div>
                                    <div style="float: left; padding-right: 15px;">
                                        <cc1:OboutTextBox runat="server" ID="txtB7" Width="24px" FolderStyle="styles/premiere_blue/OboutTextBox" />
                                    </div>
                                    <div style="clear: both; width: 235px; text-align: right; padding-left: 5px; padding-right: 5px;
                                        padding-top: 4px; float: left; font-weight: bold;">
                                        B8
                                    </div>
                                    <div style="float: left; padding-right: 15px;">
                                        <cc1:OboutTextBox runat="server" ID="txtB8" Width="24px" FolderStyle="styles/premiere_blue/OboutTextBox" />
                                    </div>
                                    <div style="clear: both; width: 235px; text-align: right; padding-left: 5px; padding-right: 5px;
                                        padding-top: 4px; float: left; font-weight: bold;">
                                        C1
                                    </div>
                                    <div style="float: left; padding-right: 15px;">
                                        <cc1:OboutTextBox runat="server" ID="txtC1" Width="24px" FolderStyle="styles/premiere_blue/OboutTextBox" />
                                    </div>
                                    <div style="clear: both; width: 235px; text-align: right; padding-left: 5px; padding-right: 5px;
                                        padding-top: 4px; float: left; font-weight: bold;">
                                        C2
                                    </div>
                                    <div style="float: left; padding-right: 15px;">
                                        <cc1:OboutTextBox runat="server" ID="txtC2" Width="24px" FolderStyle="styles/premiere_blue/OboutTextBox" />
                                    </div>
                                    <div style="clear: both; width: 235px; text-align: right; padding-left: 5px; padding-right: 5px;
                                        padding-top: 4px; float: left; font-weight: bold;">
                                        C3
                                    </div>
                                    <div style="float: left; padding-right: 15px;">
                                        <cc1:OboutTextBox runat="server" ID="txtC3" Width="24px" FolderStyle="styles/premiere_blue/OboutTextBox" />
                                    </div>
                                    <div style="clear: both; width: 235px; text-align: right; padding-left: 5px; padding-right: 5px;
                                        padding-top: 4px; float: left; font-weight: bold;">
                                        C4
                                    </div>
                                    <div style="float: left; padding-right: 15px;">
                                        <cc1:OboutTextBox runat="server" ID="txtC4" Width="24px" FolderStyle="styles/premiere_blue/OboutTextBox" />
                                    </div>
                                    <div style="clear: both; width: 235px; text-align: right; padding-left: 5px; padding-right: 5px;
                                        padding-top: 4px; float: left; font-weight: bold;">
                                        C5
                                    </div>
                                    <div style="float: left; padding-right: 15px;">
                                        <cc1:OboutTextBox runat="server" ID="txtC5" Width="24px" FolderStyle="styles/premiere_blue/OboutTextBox" />
                                    </div>
                                    <div style="clear: both; width: 235px; text-align: right; padding-left: 5px; padding-right: 5px;
                                        padding-top: 4px; float: left; font-weight: bold;">
                                        C6
                                    </div>
                                    <div style="float: left; padding-right: 15px;">
                                        <cc1:OboutTextBox runat="server" ID="txtC6" Width="24px" FolderStyle="styles/premiere_blue/OboutTextBox" />
                                    </div>
                                    <div style="clear: both; width: 235px; text-align: right; padding-left: 5px; padding-right: 5px;
                                        padding-top: 4px; float: left; font-weight: bold;">
                                        C7
                                    </div>
                                    <div style="float: left; padding-right: 15px;">
                                        <cc1:OboutTextBox runat="server" ID="txtC7" Width="24px" FolderStyle="styles/premiere_blue/OboutTextBox" />
                                    </div>
                                    <div style="clear: both; width: 235px; text-align: right; padding-left: 5px; padding-right: 5px;
                                        padding-top: 4px; float: left; font-weight: bold;">
                                        C8
                                    </div>
                                    <div style="float: left; padding-right: 15px;">
                                        <cc1:OboutTextBox runat="server" ID="txtC8" Width="24px" FolderStyle="styles/premiere_blue/OboutTextBox" />
                                    </div>
                                    <div style="clear: both; width: 235px; text-align: right; padding-left: 5px; padding-right: 5px;
                                        padding-top: 4px; float: left; font-weight: bold;">
                                        C9
                                    </div>
                                    <div style="float: left; padding-right: 15px;">
                                        <cc1:OboutTextBox runat="server" ID="txtC9" Width="24px" FolderStyle="styles/premiere_blue/OboutTextBox" />
                                    </div>
                                    <div style="clear: both; width: 235px; text-align: right; padding-left: 5px; padding-right: 5px;
                                        padding-top: 4px; float: left; font-weight: bold;">
                                        C10
                                    </div>
                                    <div style="float: left; padding-right: 15px;">
                                        <cc1:OboutTextBox runat="server" ID="txtC10" Width="24px" FolderStyle="styles/premiere_blue/OboutTextBox" />
                                    </div>
                                    <div style="clear: both; width: 235px; text-align: right; padding-left: 5px; padding-right: 5px;
                                        padding-top: 4px; float: left; font-weight: bold;">
                                        C11
                                    </div>
                                    <div style="float: left; padding-right: 15px;">
                                        <cc1:OboutTextBox runat="server" ID="txtC11" Width="24px" FolderStyle="styles/premiere_blue/OboutTextBox" />
                                    </div>
                                    <div style="clear: both; width: 235px; text-align: right; padding-left: 5px; padding-right: 5px;
                                        padding-top: 4px; float: left; font-weight: bold;">
                                        C12
                                    </div>
                                    <div style="float: left; padding-right: 15px;">
                                        <cc1:OboutTextBox runat="server" ID="txtC12" Width="24px" FolderStyle="styles/premiere_blue/OboutTextBox" />
                                    </div>
                                    <div style="clear: both; width: 235px; text-align: right; padding-left: 5px; padding-right: 5px;
                                        padding-top: 4px; float: left; font-weight: bold;">
                                        C13
                                    </div>
                                    <div style="float: left; padding-right: 15px;">
                                        <cc1:OboutTextBox runat="server" ID="txtC13" Width="24px" FolderStyle="styles/premiere_blue/OboutTextBox" />
                                    </div>
                                    <div style="clear: both; width: 235px; text-align: right; padding-left: 5px; padding-right: 5px;
                                        padding-top: 4px; float: left; font-weight: bold;">
                                        C14
                                    </div>
                                    <div style="float: left; padding-right: 15px;">
                                        <cc1:OboutTextBox runat="server" ID="txtC14" Width="24px" FolderStyle="styles/premiere_blue/OboutTextBox" />
                                    </div>
                                    <div style="clear: both; width: 235px; text-align: right; padding-left: 5px; padding-right: 5px;
                                        padding-top: 4px; float: left; font-weight: bold;">
                                        C15
                                    </div>
                                    <div style="float: left; padding-right: 15px;">
                                        <cc1:OboutTextBox runat="server" ID="txtC15" Width="24px" FolderStyle="styles/premiere_blue/OboutTextBox" />
                                    </div>
                                    <div style="clear: both; width: 235px; text-align: right; padding-left: 5px; padding-right: 5px;
                                        padding-top: 4px; float: left; font-weight: bold;">
                                        D1
                                    </div>
                                    <div style="float: left; padding-right: 15px;">
                                        <cc1:OboutTextBox runat="server" ID="txtD1" Width="24px" FolderStyle="styles/premiere_blue/OboutTextBox" />
                                    </div>
                                    <div style="clear: both; width: 235px; text-align: right; padding-left: 5px; padding-right: 5px;
                                        padding-top: 4px; float: left; font-weight: bold;">
                                        D2
                                    </div>
                                    <div style="float: left; padding-right: 15px;">
                                        <cc1:OboutTextBox runat="server" ID="txtD2" Width="24px" FolderStyle="styles/premiere_blue/OboutTextBox" />
                                    </div>
                                    <div style="clear: both; width: 235px; text-align: right; padding-left: 5px; padding-right: 5px;
                                        padding-top: 4px; float: left; font-weight: bold;">
                                        D3
                                    </div>
                                    <div style="float: left; padding-right: 15px;">
                                        <cc1:OboutTextBox runat="server" ID="txtD3" Width="24px" FolderStyle="styles/premiere_blue/OboutTextBox" />
                                    </div>
                                    <div style="clear: both; width: 235px; text-align: right; padding-left: 5px; padding-right: 5px;
                                        padding-top: 4px; float: left; font-weight: bold;">
                                        D4
                                    </div>
                                    <div style="float: left; padding-right: 15px;">
                                        <cc1:OboutTextBox runat="server" ID="txtD4" Width="24px" FolderStyle="styles/premiere_blue/OboutTextBox" />
                                    </div>
                                    <div style="clear: both; width: 235px; text-align: right; padding-left: 5px; padding-right: 5px;
                                        padding-top: 4px; float: left; font-weight: bold;">
                                        E1
                                    </div>
                                    <div style="float: left; padding-right: 15px;">
                                        <cc1:OboutTextBox runat="server" ID="txtE1" Width="24px" FolderStyle="styles/premiere_blue/OboutTextBox" />
                                    </div>
                                    <div style="clear: both; width: 235px; text-align: right; padding-left: 5px; padding-right: 5px;
                                        padding-top: 4px; float: left; font-weight: bold;">
                                        E2
                                    </div>
                                    <div style="float: left; padding-right: 15px;">
                                        <cc1:OboutTextBox runat="server" ID="txtE2" Width="24px" FolderStyle="styles/premiere_blue/OboutTextBox" />
                                    </div>
                                    <div style="clear: both; width: 235px; text-align: right; padding-left: 5px; padding-right: 5px;
                                        padding-top: 4px; float: left; font-weight: bold;">
                                        E3
                                    </div>
                                    <div style="float: left; padding-right: 15px;">
                                        <cc1:OboutTextBox runat="server" ID="txtE3" Width="24px" FolderStyle="styles/premiere_blue/OboutTextBox" />
                                    </div>
                                    <div style="clear: both; width: 235px; text-align: right; padding-left: 5px; padding-right: 5px;
                                        padding-top: 4px; float: left; font-weight: bold;">
                                        E4
                                    </div>
                                    <div style="float: left; padding-right: 15px;">
                                        <cc1:OboutTextBox runat="server" ID="txtE4" Width="24px" FolderStyle="styles/premiere_blue/OboutTextBox" />
                                    </div>
                                    <div style="clear: both; width: 235px; text-align: right; padding-left: 5px; padding-right: 5px;
                                        padding-top: 4px; float: left; font-weight: bold;">
                                        E5
                                    </div>
                                    <div style="float: left; padding-right: 15px;">
                                        <cc1:OboutTextBox runat="server" ID="txtE5" Width="24px" FolderStyle="styles/premiere_blue/OboutTextBox" />
                                    </div>
                                    <div style="clear: both; width: 235px; text-align: right; padding-left: 5px; padding-right: 5px;
                                        padding-top: 4px; float: left; font-weight: bold;">
                                        E6
                                    </div>
                                    <div style="float: left; padding-right: 15px;">
                                        <cc1:OboutTextBox runat="server" ID="txtE6" Width="24px" FolderStyle="styles/premiere_blue/OboutTextBox" />
                                    </div>
                                    <div style="clear: both; width: 235px; text-align: right; padding-left: 5px; padding-right: 5px;
                                        padding-top: 4px; float: left; font-weight: bold;">
                                        F1
                                    </div>
                                    <div style="float: left; padding-right: 15px;">
                                        <cc1:OboutTextBox runat="server" ID="txtF1" Width="24px" FolderStyle="styles/premiere_blue/OboutTextBox" />
                                    </div>
                                    <div style="clear: both; width: 235px; text-align: right; padding-left: 5px; padding-right: 5px;
                                        padding-top: 4px; float: left; font-weight: bold;">
                                        F2
                                    </div>
                                    <div style="float: left; padding-right: 15px;">
                                        <cc1:OboutTextBox runat="server" ID="txtF2" Width="24px" FolderStyle="styles/premiere_blue/OboutTextBox" />
                                    </div>
                                    <div style="clear: both; width: 235px; text-align: right; padding-left: 5px; padding-right: 5px;
                                        padding-top: 4px; float: left; font-weight: bold;">
                                        F3
                                    </div>
                                    <div style="float: left; padding-right: 15px;">
                                        <cc1:OboutTextBox runat="server" ID="txtF3" Width="24px" FolderStyle="styles/premiere_blue/OboutTextBox" />
                                    </div>
                                    <div style="clear: both; width: 235px; text-align: right; padding-left: 5px; padding-right: 5px;
                                        padding-top: 4px; float: left; font-weight: bold;">
                                        F4
                                    </div>
                                    <div style="float: left; padding-right: 15px;">
                                        <cc1:OboutTextBox runat="server" ID="txtF4" Width="24px" FolderStyle="styles/premiere_blue/OboutTextBox" />
                                    </div>
                                    <div style="clear: both; width: 235px; text-align: right; padding-left: 5px; padding-right: 5px;
                                        padding-top: 4px; float: left; font-weight: bold;">
                                        F5
                                    </div>
                                    <div style="float: left; padding-right: 15px;">
                                        <cc1:OboutTextBox runat="server" ID="txtF5" Width="24px" FolderStyle="styles/premiere_blue/OboutTextBox" />
                                    </div>
                                    <div style="clear: both; width: 235px; text-align: right; padding-left: 5px; padding-right: 5px;
                                        padding-top: 4px; float: left; font-weight: bold;">
                                        F6
                                    </div>
                                    <div style="float: left; padding-right: 15px;">
                                        <cc1:OboutTextBox runat="server" ID="txtF6" Width="24px" FolderStyle="styles/premiere_blue/OboutTextBox" />
                                    </div>
                                    <div style="clear: both; width: 235px; text-align: right; padding-left: 5px; padding-right: 5px;
                                        padding-top: 4px; float: left; font-weight: bold;">
                                        G1
                                    </div>
                                    <div style="float: left; padding-right: 15px;">
                                        <cc1:OboutTextBox runat="server" ID="txtG1" Width="24px" FolderStyle="styles/premiere_blue/OboutTextBox" />
                                    </div>
                                    <div style="clear: both; width: 235px; text-align: right; padding-left: 5px; padding-right: 5px;
                                        padding-top: 4px; float: left; font-weight: bold;">
                                        G2
                                    </div>
                                    <div style="float: left; padding-right: 15px;">
                                        <cc1:OboutTextBox runat="server" ID="txtG2" Width="24px" FolderStyle="styles/premiere_blue/OboutTextBox" />
                                    </div>
                                    <div style="clear: both; width: 235px; text-align: right; padding-left: 5px; padding-right: 5px;
                                        padding-top: 4px; float: left; font-weight: bold;">
                                        G3
                                    </div>
                                    <div style="float: left; padding-right: 15px;">
                                        <cc1:OboutTextBox runat="server" ID="txtG3" Width="24px" FolderStyle="styles/premiere_blue/OboutTextBox" />
                                    </div>
                                    <div style="clear: both; width: 235px; text-align: right; padding-left: 5px; padding-right: 5px;
                                        padding-top: 4px; float: left; font-weight: bold;">
                                        G4
                                    </div>
                                    <div style="float: left; padding-right: 15px;">
                                        <cc1:OboutTextBox runat="server" ID="txtG4" Width="24px" FolderStyle="styles/premiere_blue/OboutTextBox" />
                                    </div>
                                    <div style="clear: both; width: 235px; text-align: right; padding-left: 5px; padding-right: 5px;
                                        padding-top: 4px; float: left; font-weight: bold;">
                                        G5
                                    </div>
                                    <div style="float: left; padding-right: 15px;">
                                        <cc1:OboutTextBox runat="server" ID="txtG5" Width="24px" FolderStyle="styles/premiere_blue/OboutTextBox" />
                                    </div>
                                    <div style="clear: both; width: 235px; text-align: right; padding-left: 5px; padding-right: 5px;
                                        padding-top: 4px; float: left; font-weight: bold;">
                                        G6
                                    </div>
                                    <div style="float: left; padding-right: 15px;">
                                        <cc1:OboutTextBox runat="server" ID="txtG6" Width="24px" FolderStyle="styles/premiere_blue/OboutTextBox" />
                                    </div>
                                    <div style="clear: both; width: 235px; text-align: right; padding-left: 5px; padding-right: 5px;
                                        padding-top: 4px; float: left; font-weight: bold;">
                                        G7
                                    </div>
                                    <div style="float: left; padding-right: 15px;">
                                        <cc1:OboutTextBox runat="server" ID="txtG7" Width="24px" FolderStyle="styles/premiere_blue/OboutTextBox" />
                                    </div>
                                    <div style="clear: both; width: 235px; text-align: right; padding-left: 5px; padding-right: 5px;
                                        padding-top: 4px; float: left; font-weight: bold;">
                                        H1
                                    </div>
                                    <div style="float: left; padding-right: 15px;">
                                        <cc1:OboutTextBox runat="server" ID="txtH1" Width="24px" FolderStyle="styles/premiere_blue/OboutTextBox" />
                                    </div>
                                    <div style="clear: both; width: 235px; text-align: right; padding-left: 5px; padding-right: 5px;
                                        padding-top: 4px; float: left; font-weight: bold;">
                                        H2
                                    </div>
                                    <div style="float: left; padding-right: 15px;">
                                        <cc1:OboutTextBox runat="server" ID="txtH2" Width="24px" FolderStyle="styles/premiere_blue/OboutTextBox" />
                                    </div>
                                    <div style="clear: both; width: 235px; text-align: right; padding-left: 5px; padding-right: 5px;
                                        padding-top: 4px; float: left; font-weight: bold;">
                                        H3
                                    </div>
                                    <div style="float: left; padding-right: 15px;">
                                        <cc1:OboutTextBox runat="server" ID="txtH3" Width="24px" FolderStyle="styles/premiere_blue/OboutTextBox" />
                                    </div>
                                    <div style="clear: both; width: 235px; text-align: right; padding-left: 5px; padding-right: 5px;
                                        padding-top: 4px; float: left; font-weight: bold;">
                                        H4
                                    </div>
                                    <div style="float: left; padding-right: 15px;">
                                        <cc1:OboutTextBox runat="server" ID="txtH4" Width="24px" FolderStyle="styles/premiere_blue/OboutTextBox" />
                                    </div>
                                    <div style="clear: both; width: 235px; text-align: right; padding-left: 5px; padding-right: 5px;
                                        padding-top: 4px; float: left; font-weight: bold;">
                                        H5
                                    </div>
                                    <div style="float: left; padding-right: 15px;">
                                        <cc1:OboutTextBox runat="server" ID="txtH5" Width="24px" FolderStyle="styles/premiere_blue/OboutTextBox" />
                                    </div>
                                    <div style="clear: both; width: 235px; text-align: right; padding-left: 5px; padding-right: 5px;
                                        padding-top: 4px; float: left; font-weight: bold;">
                                        H6
                                    </div>
                                    <div style="float: left; padding-right: 15px;">
                                        <cc1:OboutTextBox runat="server" ID="txtH6" Width="24px" FolderStyle="styles/premiere_blue/OboutTextBox" />
                                    </div>
                                    <div style="clear: both; width: 235px; text-align: right; padding-left: 5px; padding-right: 5px;
                                        padding-top: 4px; float: left; font-weight: bold;">
                                        H7
                                    </div>
                                    <div style="float: left; padding-right: 15px;">
                                        <cc1:OboutTextBox runat="server" ID="txtH7" Width="24px" FolderStyle="styles/premiere_blue/OboutTextBox" />
                                    </div>
                                    <div style="clear: both; width: 235px; text-align: right; padding-left: 5px; padding-right: 5px;
                                        padding-top: 4px; float: left; font-weight: bold;">
                                        H8
                                    </div>
                                    <div style="float: left; padding-right: 15px;">
                                        <cc1:OboutTextBox runat="server" ID="txtH8" Width="24px" FolderStyle="styles/premiere_blue/OboutTextBox" />
                                    </div>
                                    <div style="clear: both; width: 235px; text-align: right; padding-left: 5px; padding-right: 5px;
                                        padding-top: 4px; float: left; font-weight: bold;">
                                        I1
                                    </div>
                                    <div style="float: left; padding-right: 15px;">
                                        <cc1:OboutTextBox runat="server" ID="txtI1" Width="24px" FolderStyle="styles/premiere_blue/OboutTextBox" />
                                    </div>
                                    <div style="clear: both; width: 235px; text-align: right; padding-left: 5px; padding-right: 5px;
                                        padding-top: 4px; float: left; font-weight: bold;">
                                        I2
                                    </div>
                                    <div style="float: left; padding-right: 15px;">
                                        <cc1:OboutTextBox runat="server" ID="txtI2" Width="24px" FolderStyle="styles/premiere_blue/OboutTextBox" />
                                    </div>
                                    <div style="clear: both; width: 235px; text-align: right; padding-left: 5px; padding-right: 5px;
                                        padding-top: 4px; float: left; font-weight: bold;">
                                        I3
                                    </div>
                                    <div style="float: left; padding-right: 15px;">
                                        <cc1:OboutTextBox runat="server" ID="txtI3" Width="24px" FolderStyle="styles/premiere_blue/OboutTextBox" />
                                    </div>
                                    <div style="clear: both; width: 235px; text-align: right; padding-left: 5px; padding-right: 5px;
                                        padding-top: 4px; float: left; font-weight: bold;">
                                        I4
                                    </div>
                                    <div style="float: left; padding-right: 15px;">
                                        <cc1:OboutTextBox runat="server" ID="txtI4" Width="24px" FolderStyle="styles/premiere_blue/OboutTextBox" />
                                    </div>
                                    <div style="clear: both; width: 235px; text-align: right; padding-left: 5px; padding-right: 5px;
                                        padding-top: 4px; float: left; font-weight: bold;">
                                        I5
                                    </div>
                                    <div style="float: left; padding-right: 15px;">
                                        <cc1:OboutTextBox runat="server" ID="txtI5" Width="24px" FolderStyle="styles/premiere_blue/OboutTextBox" />
                                    </div>
                                    <div style="clear: both; width: 235px; text-align: right; padding-left: 5px; padding-right: 5px;
                                        padding-top: 4px; float: left; font-weight: bold;">
                                        I6
                                    </div>
                                    <div style="float: left; padding-right: 15px;">
                                        <cc1:OboutTextBox runat="server" ID="txtI6" Width="24px" FolderStyle="styles/premiere_blue/OboutTextBox" />
                                    </div>
                                    <div style="clear: both; width: 235px; text-align: right; padding-left: 5px; padding-right: 5px;
                                        padding-top: 4px; float: left; font-weight: bold;">
                                        I7
                                    </div>
                                    <div style="float: left; padding-right: 15px;">
                                        <cc1:OboutTextBox runat="server" ID="txtI7" Width="24px" FolderStyle="styles/premiere_blue/OboutTextBox" />
                                    </div>
                                    <div style="clear: both; width: 235px; text-align: right; padding-left: 5px; padding-right: 5px;
                                        padding-top: 4px; float: left; font-weight: bold;">
                                        I8
                                    </div>
                                    <div style="float: left; padding-right: 15px;">
                                        <cc1:OboutTextBox runat="server" ID="txtI8" Width="24px" FolderStyle="styles/premiere_blue/OboutTextBox" />
                                    </div>
                                    <div style="clear: both; width: 235px; text-align: right; padding-left: 5px; padding-right: 5px;
                                        padding-top: 4px; float: left; font-weight: bold;">
                                        I9
                                    </div>
                                    <div style="float: left; padding-right: 15px;">
                                        <cc1:OboutTextBox runat="server" ID="txtI9" Width="24px" FolderStyle="styles/premiere_blue/OboutTextBox" />
                                    </div>
                                </div>
                            </fieldset>
                        </div>
                        <div style="margin: 0; padding: 0; width: auto; float: left; height: 1710px;">
                            <fieldset style="margin: 0; padding: 0; width: auto; height: auto; background-color: #EBECEC;">
                                <legend>Front of Card</legend>
                                <asp:Image ID="CardImageFront" runat="server" />
                            </fieldset>
                        </div>
                        <div style="clear: both; margin: 0; padding: 0; width: 530px; float: left; height: 1710px;
                            margin-top: 10px;">
                            <fieldset style="margin: 0; padding: 0; width: 520px; height: 1710px; background-color: #EBECEC;">
                                <legend>Back of Card</legend>
                                <div style="height: 1420px; padding: 5px;">
                                    <div style="clear: both; width: 235px; text-align: right; padding-left: 5px; padding-right: 5px;
                                        padding-top: 4px; float: left; font-weight: bold;">
                                        J1
                                    </div>
                                    <div style="float: left; padding-right: 15px;">
                                        <cc1:OboutTextBox runat="server" ID="txtJ1" Width="24px" FolderStyle="styles/premiere_blue/OboutTextBox" />
                                    </div>
                                    <div style="clear: both; width: 235px; text-align: right; padding-left: 5px; padding-right: 5px;
                                        padding-top: 4px; float: left; font-weight: bold;">
                                        J2
                                    </div>
                                    <div style="float: left; padding-right: 15px;">
                                        <cc1:OboutTextBox runat="server" ID="txtJ2" Width="24px" FolderStyle="styles/premiere_blue/OboutTextBox" />
                                    </div>
                                    <div style="clear: both; width: 235px; text-align: right; padding-left: 5px; padding-right: 5px;
                                        padding-top: 4px; float: left; font-weight: bold;">
                                        J3
                                    </div>
                                    <div style="float: left; padding-right: 15px;">
                                        <cc1:OboutTextBox runat="server" ID="txtJ3" Width="24px" FolderStyle="styles/premiere_blue/OboutTextBox" />
                                    </div>
                                    <div style="clear: both; width: 235px; text-align: right; padding-left: 5px; padding-right: 5px;
                                        padding-top: 4px; float: left; font-weight: bold;">
                                        J4
                                    </div>
                                    <div style="float: left; padding-right: 15px;">
                                        <cc1:OboutTextBox runat="server" ID="txtJ4" Width="24px" FolderStyle="styles/premiere_blue/OboutTextBox" />
                                    </div>
                                    <div style="clear: both; width: 235px; text-align: right; padding-left: 5px; padding-right: 5px;
                                        padding-top: 4px; float: left; font-weight: bold;">
                                        J5
                                    </div>
                                    <div style="float: left; padding-right: 15px;">
                                        <cc1:OboutTextBox runat="server" ID="txtJ5" Width="24px" FolderStyle="styles/premiere_blue/OboutTextBox" />
                                    </div>
                                    <div style="clear: both; width: 235px; text-align: right; padding-left: 5px; padding-right: 5px;
                                        padding-top: 4px; float: left; font-weight: bold;">
                                        J6
                                    </div>
                                    <div style="float: left; padding-right: 15px;">
                                        <cc1:OboutTextBox runat="server" ID="txtJ6" Width="24px" FolderStyle="styles/premiere_blue/OboutTextBox" />
                                    </div>
                                    <div style="clear: both; width: 235px; text-align: right; padding-left: 5px; padding-right: 5px;
                                        padding-top: 4px; float: left; font-weight: bold;">
                                        K1
                                    </div>
                                    <div style="float: left; padding-right: 15px;">
                                        <cc1:OboutTextBox runat="server" ID="txtK1" Width="24px" FolderStyle="styles/premiere_blue/OboutTextBox" />
                                    </div>
                                    <div style="clear: both; width: 235px; text-align: right; padding-left: 5px; padding-right: 5px;
                                        padding-top: 4px; float: left; font-weight: bold;">
                                        K2
                                    </div>
                                    <div style="float: left; padding-right: 15px;">
                                        <cc1:OboutTextBox runat="server" ID="txtK2" Width="24px" FolderStyle="styles/premiere_blue/OboutTextBox" />
                                    </div>
                                    <div style="clear: both; width: 235px; text-align: right; padding-left: 5px; padding-right: 5px;
                                        padding-top: 4px; float: left; font-weight: bold;">
                                        K3
                                    </div>
                                    <div style="float: left; padding-right: 15px;">
                                        <cc1:OboutTextBox runat="server" ID="txtK3" Width="24px" FolderStyle="styles/premiere_blue/OboutTextBox" />
                                    </div>
                                    <div style="clear: both; width: 235px; text-align: right; padding-left: 5px; padding-right: 5px;
                                        padding-top: 4px; float: left; font-weight: bold;">
                                        K4
                                    </div>
                                    <div style="float: left; padding-right: 15px;">
                                        <cc1:OboutTextBox runat="server" ID="txtK4" Width="24px" FolderStyle="styles/premiere_blue/OboutTextBox" />
                                    </div>
                                    <div style="clear: both; width: 235px; text-align: right; padding-left: 5px; padding-right: 5px;
                                        padding-top: 4px; float: left; font-weight: bold;">
                                        K5
                                    </div>
                                    <div style="float: left; padding-right: 15px;">
                                        <cc1:OboutTextBox runat="server" ID="txtK5" Width="24px" FolderStyle="styles/premiere_blue/OboutTextBox" />
                                    </div>
                                    <div style="clear: both; width: 235px; text-align: right; padding-left: 5px; padding-right: 5px;
                                        padding-top: 4px; float: left; font-weight: bold;">
                                        K6
                                    </div>
                                    <div style="float: left; padding-right: 15px;">
                                        <cc1:OboutTextBox runat="server" ID="txtK6" Width="24px" FolderStyle="styles/premiere_blue/OboutTextBox" />
                                    </div>
                                    <div style="clear: both; width: 235px; text-align: right; padding-left: 5px; padding-right: 5px;
                                        padding-top: 4px; float: left; font-weight: bold;">
                                        K7
                                    </div>
                                    <div style="float: left; padding-right: 15px;">
                                        <cc1:OboutTextBox runat="server" ID="txtK7" Width="24px" FolderStyle="styles/premiere_blue/OboutTextBox" />
                                    </div>
                                    <div style="clear: both; width: 235px; text-align: right; padding-left: 5px; padding-right: 5px;
                                        padding-top: 4px; float: left; font-weight: bold;">
                                        K8
                                    </div>
                                    <div style="float: left; padding-right: 15px;">
                                        <cc1:OboutTextBox runat="server" ID="txtK8" Width="24px" FolderStyle="styles/premiere_blue/OboutTextBox" />
                                    </div>
                                    <div style="clear: both; width: 235px; text-align: right; padding-left: 5px; padding-right: 5px;
                                        padding-top: 4px; float: left; font-weight: bold;">
                                        L1
                                    </div>
                                    <div style="float: left; padding-right: 15px;">
                                        <cc1:OboutTextBox runat="server" ID="txtL1" Width="24px" FolderStyle="styles/premiere_blue/OboutTextBox" />
                                    </div>
                                    <div style="clear: both; width: 235px; text-align: right; padding-left: 5px; padding-right: 5px;
                                        padding-top: 4px; float: left; font-weight: bold;">
                                        L2
                                    </div>
                                    <div style="float: left; padding-right: 15px;">
                                        <cc1:OboutTextBox runat="server" ID="txtL2" Width="24px" FolderStyle="styles/premiere_blue/OboutTextBox" />
                                    </div>
                                    <div style="clear: both; width: 235px; text-align: right; padding-left: 5px; padding-right: 5px;
                                        padding-top: 4px; float: left; font-weight: bold;">
                                        L3
                                    </div>
                                    <div style="float: left; padding-right: 15px;">
                                        <cc1:OboutTextBox runat="server" ID="txtL3" Width="24px" FolderStyle="styles/premiere_blue/OboutTextBox" />
                                    </div>
                                    <div style="clear: both; width: 235px; text-align: right; padding-left: 5px; padding-right: 5px;
                                        padding-top: 4px; float: left; font-weight: bold;">
                                        L4
                                    </div>
                                    <div style="float: left; padding-right: 15px;">
                                        <cc1:OboutTextBox runat="server" ID="txtL4" Width="24px" FolderStyle="styles/premiere_blue/OboutTextBox" />
                                    </div>
                                    <div style="clear: both; width: 235px; text-align: right; padding-left: 5px; padding-right: 5px;
                                        padding-top: 4px; float: left; font-weight: bold;">
                                        L5
                                    </div>
                                    <div style="float: left; padding-right: 15px;">
                                        <cc1:OboutTextBox runat="server" ID="txtL5" Width="24px" FolderStyle="styles/premiere_blue/OboutTextBox" />
                                    </div>
                                    <div style="clear: both; width: 235px; text-align: right; padding-left: 5px; padding-right: 5px;
                                        padding-top: 4px; float: left; font-weight: bold;">
                                        L6
                                    </div>
                                    <div style="float: left; padding-right: 15px;">
                                        <cc1:OboutTextBox runat="server" ID="txtL6" Width="24px" FolderStyle="styles/premiere_blue/OboutTextBox" />
                                    </div>
                                    <div style="clear: both; width: 235px; text-align: right; padding-left: 5px; padding-right: 5px;
                                        padding-top: 4px; float: left; font-weight: bold;">
                                        M1
                                    </div>
                                    <div style="float: left; padding-right: 15px;">
                                        <cc1:OboutTextBox runat="server" ID="txtM1" Width="24px" FolderStyle="styles/premiere_blue/OboutTextBox" />
                                    </div>
                                    <div style="clear: both; width: 235px; text-align: right; padding-left: 5px; padding-right: 5px;
                                        padding-top: 4px; float: left; font-weight: bold;">
                                        M2
                                    </div>
                                    <div style="float: left; padding-right: 15px;">
                                        <cc1:OboutTextBox runat="server" ID="txtM2" Width="24px" FolderStyle="styles/premiere_blue/OboutTextBox" />
                                    </div>
                                    <div style="clear: both; width: 235px; text-align: right; padding-left: 5px; padding-right: 5px;
                                        padding-top: 4px; float: left; font-weight: bold;">
                                        M3
                                    </div>
                                    <div style="float: left; padding-right: 15px;">
                                        <cc1:OboutTextBox runat="server" ID="txtM3" Width="24px" FolderStyle="styles/premiere_blue/OboutTextBox" />
                                    </div>
                                    <div style="clear: both; width: 235px; text-align: right; padding-left: 5px; padding-right: 5px;
                                        padding-top: 4px; float: left; font-weight: bold;">
                                        M4
                                    </div>
                                    <div style="float: left; padding-right: 15px;">
                                        <cc1:OboutTextBox runat="server" ID="txtM4" Width="24px" FolderStyle="styles/premiere_blue/OboutTextBox" />
                                    </div>
                                    <div style="clear: both; width: 235px; text-align: right; padding-left: 5px; padding-right: 5px;
                                        padding-top: 4px; float: left; font-weight: bold;">
                                        M5
                                    </div>
                                    <div style="float: left; padding-right: 15px;">
                                        <cc1:OboutTextBox runat="server" ID="txtM5" Width="24px" FolderStyle="styles/premiere_blue/OboutTextBox" />
                                    </div>
                                    <div style="clear: both; width: 235px; text-align: right; padding-left: 5px; padding-right: 5px;
                                        padding-top: 4px; float: left; font-weight: bold;">
                                        M6
                                    </div>
                                    <div style="float: left; padding-right: 15px;">
                                        <cc1:OboutTextBox runat="server" ID="txtM6" Width="24px" FolderStyle="styles/premiere_blue/OboutTextBox" />
                                    </div>
                                    <div style="clear: both; width: 235px; text-align: right; padding-left: 5px; padding-right: 5px;
                                        padding-top: 4px; float: left; font-weight: bold;">
                                        N1
                                    </div>
                                    <div style="float: left; padding-right: 15px;">
                                        <cc1:OboutTextBox runat="server" ID="txtN1" Width="24px" FolderStyle="styles/premiere_blue/OboutTextBox" />
                                    </div>
                                    <div style="clear: both; width: 235px; text-align: right; padding-left: 5px; padding-right: 5px;
                                        padding-top: 4px; float: left; font-weight: bold;">
                                        N2
                                    </div>
                                    <div style="float: left; padding-right: 15px;">
                                        <cc1:OboutTextBox runat="server" ID="txtN2" Width="24px" FolderStyle="styles/premiere_blue/OboutTextBox" />
                                    </div>
                                    <div style="clear: both; width: 235px; text-align: right; padding-left: 5px; padding-right: 5px;
                                        padding-top: 4px; float: left; font-weight: bold;">
                                        N3
                                    </div>
                                    <div style="float: left; padding-right: 15px;">
                                        <cc1:OboutTextBox runat="server" ID="txtN3" Width="24px" FolderStyle="styles/premiere_blue/OboutTextBox" />
                                    </div>
                                    <div style="clear: both; width: 235px; text-align: right; padding-left: 5px; padding-right: 5px;
                                        padding-top: 4px; float: left; font-weight: bold;">
                                        N4
                                    </div>
                                    <div style="float: left; padding-right: 15px;">
                                        <cc1:OboutTextBox runat="server" ID="txtN4" Width="24px" FolderStyle="styles/premiere_blue/OboutTextBox" />
                                    </div>
                                    <div style="clear: both; width: 235px; text-align: right; padding-left: 5px; padding-right: 5px;
                                        padding-top: 4px; float: left; font-weight: bold;">
                                        N5
                                    </div>
                                    <div style="float: left; padding-right: 15px;">
                                        <cc1:OboutTextBox runat="server" ID="txtN5" Width="24px" FolderStyle="styles/premiere_blue/OboutTextBox" />
                                    </div>
                                    <div style="clear: both; width: 235px; text-align: right; padding-left: 5px; padding-right: 5px;
                                        padding-top: 4px; float: left; font-weight: bold;">
                                        N6
                                    </div>
                                    <div style="float: left; padding-right: 15px;">
                                        <cc1:OboutTextBox runat="server" ID="txtN6" Width="24px" FolderStyle="styles/premiere_blue/OboutTextBox" />
                                    </div>
                                    <div style="clear: both; width: 235px; text-align: right; padding-left: 5px; padding-right: 5px;
                                        padding-top: 4px; float: left; font-weight: bold;">
                                        N7
                                    </div>
                                    <div style="float: left; padding-right: 15px;">
                                        <cc1:OboutTextBox runat="server" ID="txtN7" Width="24px" FolderStyle="styles/premiere_blue/OboutTextBox" />
                                    </div>
                                    <div style="clear: both; width: 235px; text-align: right; padding-left: 5px; padding-right: 5px;
                                        padding-top: 4px; float: left; font-weight: bold;">
                                        P1
                                    </div>
                                    <div style="float: left; padding-right: 15px;">
                                        <cc1:OboutTextBox runat="server" ID="txtP1" Width="24px" FolderStyle="styles/premiere_blue/OboutTextBox" />
                                    </div>
                                    <div style="clear: both; width: 235px; text-align: right; padding-left: 5px; padding-right: 5px;
                                        padding-top: 4px; float: left; font-weight: bold;">
                                        P2
                                    </div>
                                    <div style="float: left; padding-right: 15px;">
                                        <cc1:OboutTextBox runat="server" ID="txtP2" Width="24px" FolderStyle="styles/premiere_blue/OboutTextBox" />
                                    </div>
                                    <div style="clear: both; width: 235px; text-align: right; padding-left: 5px; padding-right: 5px;
                                        padding-top: 4px; float: left; font-weight: bold;">
                                        P3
                                    </div>
                                    <div style="float: left; padding-right: 15px;">
                                        <cc1:OboutTextBox runat="server" ID="txtP3" Width="24px" FolderStyle="styles/premiere_blue/OboutTextBox" />
                                    </div>
                                    <div style="clear: both; width: 235px; text-align: right; padding-left: 5px; padding-right: 5px;
                                        padding-top: 4px; float: left; font-weight: bold;">
                                        P4
                                    </div>
                                    <div style="float: left; padding-right: 15px;">
                                        <cc1:OboutTextBox runat="server" ID="txtP4" Width="24px" FolderStyle="styles/premiere_blue/OboutTextBox" />
                                    </div>
                                    <div style="clear: both; width: 235px; text-align: right; padding-left: 5px; padding-right: 5px;
                                        padding-top: 4px; float: left; font-weight: bold;">
                                        P5
                                    </div>
                                    <div style="float: left; padding-right: 15px;">
                                        <cc1:OboutTextBox runat="server" ID="txtP5" Width="24px" FolderStyle="styles/premiere_blue/OboutTextBox" />
                                    </div>
                                    <div style="clear: both; width: 235px; text-align: right; padding-left: 5px; padding-right: 5px;
                                        padding-top: 4px; float: left; font-weight: bold;">
                                        Q1
                                    </div>
                                    <div style="float: left; padding-right: 15px;">
                                        <cc1:OboutTextBox runat="server" ID="txtQ1" Width="24px" FolderStyle="styles/premiere_blue/OboutTextBox" />
                                    </div>
                                    <div style="clear: both; width: 235px; text-align: right; padding-left: 5px; padding-right: 5px;
                                        padding-top: 4px; float: left; font-weight: bold;">
                                        Q2
                                    </div>
                                    <div style="float: left; padding-right: 15px;">
                                        <cc1:OboutTextBox runat="server" ID="txtQ2" Width="24px" FolderStyle="styles/premiere_blue/OboutTextBox" />
                                    </div>
                                    <div style="clear: both; width: 235px; text-align: right; padding-left: 5px; padding-right: 5px;
                                        padding-top: 4px; float: left; font-weight: bold;">
                                        Q3
                                    </div>
                                    <div style="float: left; padding-right: 15px;">
                                        <cc1:OboutTextBox runat="server" ID="txtQ3" Width="24px" FolderStyle="styles/premiere_blue/OboutTextBox" />
                                    </div>
                                    <div style="clear: both; width: 235px; text-align: right; padding-left: 5px; padding-right: 5px;
                                        padding-top: 4px; float: left; font-weight: bold;">
                                        Q4
                                    </div>
                                    <div style="float: left; padding-right: 15px;">
                                        <cc1:OboutTextBox runat="server" ID="txtQ4" Width="24px" FolderStyle="styles/premiere_blue/OboutTextBox" />
                                    </div>
                                    <div style="clear: both; width: 235px; text-align: right; padding-left: 5px; padding-right: 5px;
                                        padding-top: 4px; float: left; font-weight: bold;">
                                        O1
                                    </div>
                                    <div style="float: left; padding-right: 15px;">
                                        <cc1:OboutTextBox runat="server" ID="txtO1" Width="24px" FolderStyle="styles/premiere_blue/OboutTextBox" />
                                    </div>
                                    <div style="clear: both; width: 235px; text-align: right; padding-left: 5px; padding-right: 5px;
                                        padding-top: 4px; float: left; font-weight: bold;">
                                        O2
                                    </div>
                                    <div style="float: left; padding-right: 15px;">
                                        <cc1:OboutTextBox runat="server" ID="txtO2" Width="24px" FolderStyle="styles/premiere_blue/OboutTextBox" />
                                    </div>
                                    <div style="clear: both; width: 235px; text-align: right; padding-left: 5px; padding-right: 5px;
                                        padding-top: 4px; float: left; font-weight: bold;">
                                        O3
                                    </div>
                                    <div style="float: left; padding-right: 15px;">
                                        <cc1:OboutTextBox runat="server" ID="txtO3" Width="24px" FolderStyle="styles/premiere_blue/OboutTextBox" />
                                    </div>
                                    <div style="clear: both; width: 235px; text-align: right; padding-left: 5px; padding-right: 5px;
                                        padding-top: 4px; float: left; font-weight: bold;">
                                        O4
                                    </div>
                                    <div style="float: left; padding-right: 15px;">
                                        <cc1:OboutTextBox runat="server" ID="txtO4" Width="24px" FolderStyle="styles/premiere_blue/OboutTextBox" />
                                    </div>
                                    <div style="clear: both; width: 235px; text-align: right; padding-left: 5px; padding-right: 5px;
                                        padding-top: 4px; float: left; font-weight: bold;">
                                        O5
                                    </div>
                                    <div style="float: left; padding-right: 15px;">
                                        <cc1:OboutTextBox runat="server" ID="txtO5" Width="24px" FolderStyle="styles/premiere_blue/OboutTextBox" />
                                    </div>
                                    <div style="clear: both;">
                                        <lable style="font-weight: bold;">Corrected 1</lable>
                                        &nbsp;<cc1:OboutTextBox runat="server" ID="txtCorrected_1" Width="30px" FolderStyle="styles/premiere_blue/OboutTextBox" />
                                    </div>
                                    <div style="clear: both; margin-bottom: 5px;">
                                        <lable style="font-weight: bold;">Corrected 1 Text</lable>
                                        <br />
                                        <asp:TextBox ID="txtCorrected_1_Text" runat="server" TextMode="MultiLine" Width="500px"
                                            Height="51px"></asp:TextBox>
                                    </div>
                                    <div style="clear: both; width: 160px; text-align: right; padding-left: 5px; padding-right: 5px;
                                        padding-top: 2px; float: left; font-weight: bold;">
                                        Item 1 Expected Completion
                                    </div>
                                    <div style="float: left; padding-right: 15px;">
                                        <cc1:OboutTextBox runat="server" ID="txtItem1_Expected_Completion" Width="80" FolderStyle="styles/premiere_blue/OboutTextBox"
                                            Text='<%# Container.Value %>' /><obout:Calendar ID="Calendar2" runat="server" StyleFolder="Calendar/styles/expedia"
                                                DatePickerMode="true" TextBoxId="txtItem1_Expected_Completion" TextArrowLeft=""
                                                TextArrowRight="" DatePickerSynchronize="true" DatePickerImagePath="Calendar/styles/icon2.gif"
                                                DateFormat="MM/dd/yyyy" EnableViewState="true" AllowDeselect="false" />
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" ControlToValidate="txtItem1_Expected_Completion"
                                            Display="Dynamic" EnableClientScript="true" runat="server" ValidationExpression="^([0-9]{1,2})[./-]+([0-9]{1,2})[./-]+([0-9]{2}|[0-9]{4})$"
                                            SetFocusOnError="true" ForeColor="Red">
                              Please enter date in mm/dd/yyyy format
                                        </asp:RegularExpressionValidator>
                                    </div>
                                    <div style="clear: both; width: 160px; text-align: right; padding-left: 5px; padding-right: 5px;
                                        padding-top: 2px; float: left; font-weight: bold;">
                                        Item 1 Actual Completion
                                    </div>
                                    <div style="float: left; padding-right: 15px;">
                                        <cc1:OboutTextBox runat="server" ID="txtItem1_Actual_Completion" Width="80" FolderStyle="styles/premiere_blue/OboutTextBox"
                                            Text='<%# Container.Value %>' /><obout:Calendar ID="Calendar3" runat="server" StyleFolder="Calendar/styles/expedia"
                                                DatePickerMode="true" TextBoxId="txtItem1_Actual_Completion" TextArrowLeft=""
                                                TextArrowRight="" DatePickerSynchronize="true" DatePickerImagePath="Calendar/styles/icon2.gif"
                                                DateFormat="MM/dd/yyyy" EnableViewState="true" AllowDeselect="false" />
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator2" ControlToValidate="txtItem1_Actual_Completion"
                                            Display="Dynamic" EnableClientScript="true" runat="server" ValidationExpression="^([0-9]{1,2})[./-]+([0-9]{1,2})[./-]+([0-9]{2}|[0-9]{4})$"
                                            SetFocusOnError="true" ForeColor="Red">
                              Please enter date in mm/dd/yyyy format
                                        </asp:RegularExpressionValidator>
                                    </div>
                                    <div style="clear: both; width: 160px; text-align: right; padding-left: 5px; padding-right: 5px;
                                        padding-top: 6px; float: left; margin-bottom: 5px; font-weight: bold;">
                                        Item 1 Assigned Name
                                    </div>
                                    <div style="float: left; padding-right: 15px; padding-top: 5px; margin-bottom: 5px;">
                                        <cc1:OboutTextBox runat="server" ID="txtItem1_Assigned_Name" Width="120px" FolderStyle="styles/premiere_blue/OboutTextBox" />
                                    </div>
                                    <div style="clear: both; margin-bottom: 15px; margin-top: 10px;">
                                        <label style="font-weight: bold;">
                                            Item 1 Admin Comments</label><br />
                                        <asp:TextBox ID="txtItem1_Admin_Comments" runat="server" TextMode="MultiLine" Width="500px"
                                            Height="51px"></asp:TextBox>
                                    </div>
                                    <div>
                                        <label style="font-weight: bold;">
                                            Corrected 2</label>&nbsp;<cc1:OboutTextBox runat="server" ID="txtCorrected_2" Width="30px"
                                                FolderStyle="styles/premiere_blue/OboutTextBox" />
                                    </div>
                                    <div style="clear: both; margin-bottom: 5px;">
                                        <label style="font-weight: bold;">
                                            Corrected 2 Text</label><br />
                                        <asp:TextBox ID="txtCorrected_2_Text" runat="server" TextMode="MultiLine" Width="500px"
                                            Height="51px"></asp:TextBox>
                                    </div>
                                    <div style="clear: both; width: 160px; text-align: right; padding-left: 5px; padding-right: 5px;
                                        padding-top: 2px; float: left; font-weight: bold;">
                                        Item 2 Expected Completion
                                    </div>
                                    <div style="float: left; padding-right: 15px;">
                                        <cc1:OboutTextBox runat="server" ID="txtItem2_Expected_Completion" Width="80" FolderStyle="styles/premiere_blue/OboutTextBox"
                                            Text='<%# Container.Value %>' /><obout:Calendar ID="Calendar4" runat="server" StyleFolder="Calendar/styles/expedia"
                                                DatePickerMode="true" TextBoxId="txtItem2_Expected_Completion" TextArrowLeft=""
                                                TextArrowRight="" DatePickerSynchronize="true" DatePickerImagePath="Calendar/styles/icon2.gif"
                                                DateFormat="MM/dd/yyyy" EnableViewState="true" AllowDeselect="false" />
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator3" ControlToValidate="txtItem2_Expected_Completion"
                                            Display="Dynamic" EnableClientScript="true" runat="server" ValidationExpression="^([0-9]{1,2})[./-]+([0-9]{1,2})[./-]+([0-9]{2}|[0-9]{4})$"
                                            SetFocusOnError="true" ForeColor="Red">
                              Please enter date in mm/dd/yyyy format
                                        </asp:RegularExpressionValidator>
                                    </div>
                                    <div style="clear: both; width: 160px; text-align: right; padding-left: 5px; padding-right: 5px;
                                        padding-top: 2px; float: left; font-weight: bold;">
                                        Item 2 Actual Completion
                                    </div>
                                    <div style="float: left; padding-right: 15px;">
                                        <cc1:OboutTextBox runat="server" ID="txtItem2_Actual_Completion" Width="80" FolderStyle="styles/premiere_blue/OboutTextBox"
                                            Text='<%# Container.Value %>' /><obout:Calendar ID="Calendar5" runat="server" StyleFolder="Calendar/styles/expedia"
                                                DatePickerMode="true" TextBoxId="txtItem2_Actual_Completion" TextArrowLeft=""
                                                TextArrowRight="" DatePickerSynchronize="true" DatePickerImagePath="Calendar/styles/icon2.gif"
                                                DateFormat="MM/dd/yyyy" EnableViewState="true" AllowDeselect="false" />
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator4" ControlToValidate="txtItem2_Actual_Completion"
                                            Display="Dynamic" EnableClientScript="true" runat="server" ValidationExpression="^([0-9]{1,2})[./-]+([0-9]{1,2})[./-]+([0-9]{2}|[0-9]{4})$"
                                            SetFocusOnError="true" ForeColor="Red">
                              Please enter date in mm/dd/yyyy format
                                        </asp:RegularExpressionValidator>
                                    </div>
                                    <div style="clear: both; width: 160px; text-align: right; padding-left: 5px; padding-right: 5px;
                                        padding-top: 6px; float: left; margin-bottom: 5px; font-weight: bold;">
                                        Item 2 Assigned Name
                                    </div>
                                    <div style="float: left; padding-right: 15px; padding-top: 5px; margin-bottom: 5px;">
                                        <cc1:OboutTextBox runat="server" ID="txtItem2_Assigned_Name" Width="120px" FolderStyle="styles/premiere_blue/OboutTextBox" />
                                    </div>
                                    <div style="clear: both; margin-bottom: 15px; margin-top: 10px;">
                                        <label style="font-weight: bold;">
                                            Item 2 Admin Comments</label><br />
                                        <asp:TextBox ID="txtItem2_Admin_Comments" runat="server" TextMode="MultiLine" Width="500px"
                                            Height="51px"></asp:TextBox>
                                    </div>
                                    <div>
                                        <label style="font-weight: bold;">
                                            Corrected 3</label>&nbsp;<cc1:OboutTextBox runat="server" ID="txtCorrected_3" Width="30px"
                                                FolderStyle="styles/premiere_blue/OboutTextBox" />
                                    </div>
                                    <div style="clear: both; margin-bottom: 5px;">
                                        <label style="font-weight: bold;">
                                            Corrected 3 Text</label><br />
                                        <asp:TextBox ID="txtCorrected_3_Text" runat="server" TextMode="MultiLine" Width="500px"
                                            Height="51px"></asp:TextBox>
                                    </div>
                                    <div style="clear: both; width: 160px; text-align: right; padding-left: 5px; padding-right: 5px;
                                        padding-top: 2px; float: left; font-weight: bold;">
                                        Item 3 Expected Completion
                                    </div>
                                    <div style="float: left; padding-right: 15px;">
                                        <cc1:OboutTextBox runat="server" ID="txtItem3_Expected_Completion" Width="80" FolderStyle="styles/premiere_blue/OboutTextBox"
                                            Text='<%# Container.Value %>' /><obout:Calendar ID="Calendar6" runat="server" StyleFolder="Calendar/styles/expedia"
                                                DatePickerMode="true" TextBoxId="txtItem3_Expected_Completion" TextArrowLeft=""
                                                TextArrowRight="" DatePickerSynchronize="true" DatePickerImagePath="Calendar/styles/icon2.gif"
                                                DateFormat="MM/dd/yyyy" EnableViewState="true" AllowDeselect="false" />
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator5" ControlToValidate="txtItem3_Expected_Completion"
                                            Display="Dynamic" EnableClientScript="true" runat="server" ValidationExpression="^([0-9]{1,2})[./-]+([0-9]{1,2})[./-]+([0-9]{2}|[0-9]{4})$"
                                            SetFocusOnError="true" ForeColor="Red">
                              Please enter date in mm/dd/yyyy format
                                        </asp:RegularExpressionValidator>
                                    </div>
                                    <div style="clear: both; width: 160px; text-align: right; padding-left: 5px; padding-right: 5px;
                                        padding-top: 2px; float: left; font-weight: bold;">
                                        Item 3 Actual Completion
                                    </div>
                                    <div style="float: left; padding-right: 15px;">
                                        <cc1:OboutTextBox runat="server" ID="txtItem3_Actual_Completion" Width="80" FolderStyle="styles/premiere_blue/OboutTextBox"
                                            Text='<%# Container.Value %>' /><obout:Calendar ID="Calendar7" runat="server" StyleFolder="Calendar/styles/expedia"
                                                DatePickerMode="true" TextBoxId="txtItem3_Actual_Completion" TextArrowLeft=""
                                                TextArrowRight="" DatePickerSynchronize="true" DatePickerImagePath="Calendar/styles/icon2.gif"
                                                DateFormat="MM/dd/yyyy" EnableViewState="true" AllowDeselect="false" />
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator6" ControlToValidate="txtItem3_Actual_Completion"
                                            Display="Dynamic" EnableClientScript="true" runat="server" ValidationExpression="^([0-9]{1,2})[./-]+([0-9]{1,2})[./-]+([0-9]{2}|[0-9]{4})$"
                                            SetFocusOnError="true" ForeColor="Red">
                              Please enter date in mm/dd/yyyy format
                                        </asp:RegularExpressionValidator>
                                    </div>
                                    <div style="clear: both; width: 160px; text-align: right; padding-left: 5px; padding-right: 5px;
                                        padding-top: 6px; float: left; margin-bottom: 5px; font-weight: bold;">
                                        Item 3 Assigned Name
                                    </div>
                                    <div style="float: left; padding-right: 15px; padding-top: 5px; margin-bottom: 5px;">
                                        <cc1:OboutTextBox runat="server" ID="txtItem3_Assigned_Name" Width="120px" FolderStyle="styles/premiere_blue/OboutTextBox" />
                                    </div>
                                    <div style="clear: both; margin-bottom: 10px;">
                                        <label style="font-weight: bold;">
                                            Item 3 Admin Comments</label><br />
                                        <asp:TextBox ID="txtItem3_Admin_Comments" runat="server" TextMode="MultiLine" Width="500px"
                                            Height="51px"></asp:TextBox>
                                    </div>
                                    <div style="padding-left: 5px; padding-right: 5px; padding-top: 5px;">
                                        <div style="width: 135px; text-align: right; float: left; font-weight: bold; padding-top: 2px;
                                            padding-right: 5px;">
                                            Item Num Comments</div>
                                        <div style="float: left; text-align: left;">
                                            &nbsp;&nbsp;&nbsp;<cc1:OboutTextBox runat="server" ID="txtItem_Num_Comments" Width="80px"
                                                FolderStyle="styles/premiere_blue/OboutTextBox" /></div>
                                    </div>
                                    <div style="clear: both; padding-left: 5px; padding-right: 5px;">
                                        <div style="clear: both; width: 135px; text-align: right; padding-right: 5px; float: left;
                                            font-weight: bold; padding-top: 3px;">
                                            Item Company Comments</div>
                                        <div style="float: left; text-align: left;">
                                            &nbsp;&nbsp;&nbsp;<cc1:OboutTextBox runat="server" ID="txtItem_Company_Comments"
                                                Width="80px" FolderStyle="styles/premiere_blue/OboutTextBox" /></div>
                                    </div>
                                    <div style="clear: both; padding-left: 5px; padding-right: 5px; padding-top: 10px;">
                                        <label style="font-weight: bold;">
                                            Image File Name</label>&nbsp;&nbsp;&nbsp;<span id="lblImage_Files" style="width: 360px;"></span>
                                    </div>
                                    <div style="clear: both; padding-left: 5px; padding-right: 5px;">
                                        <label style="font-weight: bold;">
                                            Created</label>&nbsp;&nbsp;&nbsp; <span id="lblCreated" style="width: 160px;">
                                        </span>
                                    </div>
                                </div>
                            </fieldset>
                        </div>
                        <div style="margin: 0; padding: 0; width: auto; float: left; height: auto; margin-top: 10px;">
                            <fieldset style="margin: 0; padding: 0; width: auto; height: auto; background-color: #EBECEC;">
                                <legend>Back of Card</legend>
                                <asp:Image ID="CardImageBack" runat="server" />
                            </fieldset>
                        </div>
                    </div>
                    <asp:SqlDataSource ID="SqlDataSourceEmployee" runat="server" EnableViewState="true"
                        ConnectionString="<%$ ConnectionStrings:pjengConnectionString1 %>" SelectCommandType="StoredProcedure"
                        SelectCommand="sp_JWT_GetCustomersEmployeeByUGID">
                        <SelectParameters>
                            <asp:QueryStringParameter DefaultValue="" Name="UGID" QueryStringField="aff_key"
                                Type="String" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                    <asp:SqlDataSource ID="SqlDataSourceCompany" runat="server" EnableViewState="true"
                        ConnectionString="<%$ ConnectionStrings:pjengConnectionString1 %>" ProviderName="<%$ ConnectionStrings:pjengConnectionString1.ProviderName %>"
                        SelectCommandType="StoredProcedure" SelectCommand="sp_JWT_GetCustomersCompanyByUGID">
                        <SelectParameters>
                            <asp:QueryStringParameter DefaultValue="" Name="UGID" QueryStringField="aff_key"
                                Type="String" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </Template>
            </cc1:GridTemplate>
            <cc1:GridTemplate runat="server" ID="tplImageURL">
                <Template>
                    <asp:HyperLink ID="hlkImageURL" runat="server">Form Image</asp:HyperLink>
                </Template>
            </cc1:GridTemplate>
        </Templates>
    </cc1:Grid>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:pjengConnectionString1 %>"
        SelectCommand="

SELECT iCount
,[Image_URL]
,Date
,b.Name_LU AS Lead_Auditor_Name
,c.Name_LU AS Auditor_A_Name
,d.Name_LU AS Auditor_B_Name
,e.Name_LU AS Auditor_C_Name
,Name_on_Form_Lead_Auditor
,b.Employee_Code_LU AS Lead_Auditor_Code
,Name_on_Form_Auditor_A
,c.Employee_Code_LU AS Auditor_A_Code
,Name_on_Form_Auditor_B
,d.Employee_Code_LU AS Auditor_B_Code
,Name_on_Form_Auditor_C
,e.Employee_Code_LU AS Auditor_C_Code
,Form_Type
,f.Company_Name_LU AS Company_Audited_Name_1
,g.Company_Name_LU AS Company_Audited_Name_2
,f.Company_Code_LU AS Company_Audited_Code_1
,Name_on_Form_Company_Audited_Name_1
,g.Company_Code_LU AS Company_Audited_Code_2
,Name_on_Form_Company_Audited_Name_2
,Audit_Location
,A1
,A2
,A3
,A4
,A5
,A6
,B1
,B2
,B3
,B4
,B5
,B6
,B7
,B8
,C1
,C2
,C3
,C4
,C5
,C6
,C7
,C8
,C9
,C10
,C11
,C12
,C13
,C14
,C15
,D1
,D2
,D3
,D4
,E1
,E2
,E3
,E4
,E5
,E6
,F1
,F2
,F3
,F4
,F5
,F6
,G1
,G2
,G3
,G4
,G5
,G6
,G7
,H1
,H2
,H3
,H4
,H5
,H6
,H7
,H8
,I1
,I2
,I3
,I4
,I5
,I6
,I7
,I8
,I9
,J1
,J2
,J3
,J4
,J5
,J6
,K1
,K2
,K3
,K4
,K5
,K6
,K7
,K8
,L1
,L2
,L3
,L4
,L5
,M1
,M2
,M3
,M4
,M5
,M6
,N1
,N2
,N3
,N4
,N5
,N6
,N7
,O1
,O2
,O3
,O4
,O5
,P1
,P2
,P3
,P4
,P5
,Q1
,Q2
,Q3
,Q4
,Corrected_1
,Corrected_1_Text
,Corrected_2
,Corrected_2_Text
,Corrected_3
,Corrected_3_Text
,Item_Num_Comments
,Item_Company_Comments
,Item1_Expected_Completion
,Item1_Actual_Completion
,Item1_Assigned_Name
,Item1_Admin_Comments
,Item2_Expected_Completion
,Item2_Actual_Completion
,Item2_Assigned_Name
,Item2_Admin_Comments
,Item3_Expected_Completion
,Item3_Actual_Completion
,Item3_Assigned_Name
,Item3_Admin_Comments
,ImageFiles AS Image_Files
,Created
,DateINT
,FKEmployeeID_LA
,FKEmployeeID_A
,FKEmployeeID_B
,FKEmployeeID_C
,FKCompanyID_1
,FKCompanyID_2 
FROM JWT_Phillips66_PoncaCity a 
INNER JOIN JWT_LU_Employee b 
ON a.FKEmployeeID_LA = b.PKEmployeeID 
INNER JOIN JWT_LU_Employee c 
ON a.FKEmployeeID_A = c.PKEmployeeID 
INNER JOIN JWT_LU_Employee d 
ON a.FKEmployeeID_B = d.PKEmployeeID 
INNER JOIN JWT_LU_Employee e 
ON a.FKEmployeeID_C = e.PKEmployeeID 
INNER JOIN JWT_LU_Company f 
ON a.FKCompanyID_1 = f.PKCompanyID 
INNER JOIN JWT_LU_Company g 
ON a.FKCompanyID_2 = g.PKCompanyID"
        
                        >
                        <%--UpdateCommand="UPDATE [dbo].[JWT_Phillips66_PoncaCity]
                       SET [Date] = @Date
                          ,[DateINT] = CONVERT(VARCHAR(8), CAST(@Date AS DATETIME), 112)
                          ,[Name_on_Form_Lead_Auditor] = @Name_on_Form_Lead_Auditor
                          ,[FKEmployeeID_LA] = @FKEmployeeID_LA
                          ,[Name_on_Form_Auditor_A] = @Name_on_Form_Auditor_A
                          ,[FKEmployeeID_A] = @FKEmployeeID_A
                          ,[Name_on_Form_Auditor_B] = @Name_on_Form_Auditor_B
                          ,[FKEmployeeID_B] = @FKEmployeeID_B
                          ,[Name_on_Form_Auditor_C] = @Name_on_Form_Auditor_C
                          ,[FKEmployeeID_C] = @FKEmployeeID_C
                          ,[Form_Type] = @Form_Type
                          ,[FKCompanyID_1] = @FKCompanyID_1
                          ,[FKCompanyID_2] = @FKCompanyID_2
                          ,[Name_on_Form_Company_Audited_Name_1] = @Name_on_Form_Company_Audited_Name_1
                          ,[Name_on_Form_Company_Audited_Name_2] = @Name_on_Form_Company_Audited_Name_2
                          ,[Audit_Location] = @Audit_Location
                          ,[A1] = @A1
                          ,[A2] = @A2
                          ,[A3] = @A3
                          ,[A4] = @A4
                          ,[A5] = @A5
                          ,[A6] = @A6
                          ,[B1] = @B1
                          ,[B2] = @B2
                          ,[B3] = @B3
                          ,[B4] = @B4
                          ,[B5] = @B5
                          ,[B6] = @B6
                          ,[B7] = @B7
                          ,[B8] = @B8
                          ,[C1] = @C1
                          ,[C2] = @C2
                          ,[C3] = @C3
                          ,[C4] = @C4
                          ,[C5] = @C5
                          ,[C6] = @C6
                          ,[C7] = @C7
                          ,[C8] = @C8
                          ,[C9] = @C9
                          ,[C10] = @C10
                          ,[C11] = @C11
                          ,[C12] = @C12
                          ,[C13] = @C13
                          ,[C14] = @C14
                          ,[C15] = @C15
                          ,[D1] = @D1
                          ,[D2] = @D2
                          ,[D3] = @D3
                          ,[D4] = @D4
                          ,[E1] = @E1
                          ,[E2] = @E2
                          ,[E3] = @E3
                          ,[E4] = @E4
                          ,[E5] = @E5
                          ,[E6] = @E6
                          ,[F1] = @F1
                          ,[F2] = @F2
                          ,[F3] = @F3
                          ,[F4] = @F4
                          ,[F5] = @F5
                          ,[F6] = @F6
                          ,[G1] = @G1
                          ,[G2] = @G2
                          ,[G3] = @G3
                          ,[G4] = @G4
                          ,[G5] = @G5
                          ,[G6] = @G6
                          ,[G7] = @G7
                          ,[H1] = @H1
                          ,[H2] = @H2
                          ,[H3] = @H3
                          ,[H4] = @H4
                          ,[H5] = @H5
                          ,[H6] = @H6
                          ,[H7] = @H7
                          ,[H8] = @H8
                          ,[I1] = @I1
                          ,[I2] = @I2
                          ,[I3] = @I3
                          ,[I4] = @I4
                          ,[I5] = @I5
                          ,[I6] = @I6
                          ,[I7] = @I7
                          ,[I8] = @I8
                          ,[I9] = @I9
                          ,[J1] = @J1
                          ,[J2] = @J2
                          ,[J3] = @J3
                          ,[J4] = @J4
                          ,[J5] = @J5
                          ,[J6] = @J6
                          ,[K1] = @K1
                          ,[K2] = @K2
                          ,[K3] = @K3
                          ,[K4] = @K4
                          ,[K5] = @K5
                          ,[K6] = @K6
                          ,[K7] = @K7
                          ,[K8] = @K8
                          ,[L1] = @L1
                          ,[L2] = @L2
                          ,[L3] = @L3
                          ,[L4] = @L4
                          ,[L5] = @L5
                          ,[M1] = @M1
                          ,[M2] = @M2
                          ,[M3] = @M3
                          ,[M4] = @M4
                          ,[M5] = @M5
                          ,[M6] = @M6
                          ,[N1] = @N1
                          ,[N2] = @N2
                          ,[N3] = @N3
                          ,[N4] = @N4
                          ,[N5] = @N5
                          ,[N6] = @N6
                          ,[N7] = @N7
                          ,[P1] = @P1
                          ,[P2] = @P2
                          ,[P3] = @P3
                          ,[P4] = @P4
                          ,[P5] = @P5
                          ,[Q1] = @Q1
                          ,[O1] = @O1
                          ,[Q2] = @Q2
                          ,[Q3] = @Q3
                          ,[Q4] = @Q4
                          ,[O2] = @O2
                          ,[O3] = @O3
                          ,[O4] = @O4
                          ,[O5] = @O5
                          ,[Corrected_1] = @Corrected_1
                          ,[Corrected_1_Text] = @Corrected_1_Text
                          ,[Corrected_2] = @Corrected_2
                          ,[Corrected_2_Text] = @Corrected_2_Text
                          ,[Corrected_3] = @Corrected_3
                          ,[Corrected_3_Text] = @Corrected_3_Text
                          ,[Item_Num_Comments] = @Item_Num_Comments
                          ,[Item_Company_Comments] = @Item_Company_Comments
                          ,[Item1_Expected_Completion] = @Item1_Expected_Completion
                          ,[Item1_Actual_Completion] = @Item1_Actual_Completion
                          ,[Item1_Assigned_Name] = @Item1_Assigned_Name
                          ,[Item1_Admin_Comments] = @Item1_Admin_Comments
                          ,[Item2_Expected_Completion] = @Item2_Expected_Completion
                          ,[Item2_Actual_Completion] = @Item2_Actual_Completion
                          ,[Item2_Assigned_Name] = @Item2_Assigned_Name
                          ,[Item2_Admin_Comments] = @Item2_Admin_Comments
                          ,[Item3_Expected_Completion] = @Item3_Expected_Completion
                          ,[Item3_Actual_Completion] = @Item3_Actual_Completion
                          ,[Item3_Assigned_Name] = @Item3_Assigned_Name
                          ,[Item3_Admin_Comments] = @Item3_Admin_Comments
			            Where iCount = @iCount"--%>
       <%-- <SelectParameters>
            <asp:QueryStringParameter Name="affiliate_key" QueryStringField="aff_key" Type="String" />
            <asp:QueryStringParameter Name="r_type" QueryStringField="rtype" Type="String" DefaultValue="1" />
            <asp:QueryStringParameter Name="start_date" QueryStringField="date1" Type="DateTime"
                DefaultValue="" />
            <asp:QueryStringParameter Name="end_date" QueryStringField="date2" Type="DateTime"
                DefaultValue="" />
            <asp:QueryStringParameter Name="course_id" QueryStringField="cid" Type="Int32" DefaultValue="0" />
            <asp:Parameter Name="allChild" Type="Int16" DefaultValue="1" />
            <asp:QueryStringParameter Name="sid" QueryStringField="sid" Type="String" DefaultValue="" />
            <asp:Parameter Name="smart_key" Type="String" DefaultValue="none" />
            <asp:Parameter Name="Express" Type="Int16" DefaultValue="0" />
            <asp:QueryStringParameter Name="filter" QueryStringField="report_filter" Type="String"
                DefaultValue="  " />
            <asp:QueryStringParameter Name="filter_value" QueryStringField="report_filter_term"
                Type="String" DefaultValue="  " />
            <asp:QueryStringParameter Name="DateType" QueryStringField="dt" Type="String" DefaultValue="1" />
        </SelectParameters>--%>
        <UpdateParameters>
            <asp:Parameter Name="iCount" Type="String" />
            <asp:Parameter Name="Date" DbType="Date" />
            <asp:Parameter Name="Name_on_Form_Lead_Auditor" Type="String" />
            <asp:Parameter Name="FKEmployeeID_LA" Type="Int32" />
            <asp:Parameter Name="Name_on_Form_Auditor_A" Type="String" />
            <asp:Parameter Name="FKEmployeeID_A" Type="Int32" />
            <asp:Parameter Name="Name_on_Form_Auditor_B" Type="String" />
            <asp:Parameter Name="FKEmployeeID_B" Type="Int32" />
            <asp:Parameter Name="Name_on_Form_Auditor_C" Type="String" />
            <asp:Parameter Name="FKEmployeeID_C" Type="Int32" />
            <asp:Parameter Name="Form_Type" Type="String" />
            <asp:Parameter Name="FKCompanyID_1" Type="Int32" />
            <asp:Parameter Name="FKCompanyID_2" Type="Int32" />
            <asp:Parameter Name="Name_on_Form_Company_Audited_Name_1" Type="String" />
            <asp:Parameter Name="Name_on_Form_Company_Audited_Name_2" Type="String" />
            <asp:Parameter Name="Audit_Location" Type="String" />
            <asp:Parameter Name="A1" Type="String" />
            <asp:Parameter Name="A2" Type="String" />
            <asp:Parameter Name="A3" Type="String" />
            <asp:Parameter Name="A4" Type="String" />
            <asp:Parameter Name="A5" Type="String" />
            <asp:Parameter Name="A6" Type="String" />
            <asp:Parameter Name="B1" Type="String" />
            <asp:Parameter Name="B2" Type="String" />
            <asp:Parameter Name="B3" Type="String" />
            <asp:Parameter Name="B4" Type="String" />
            <asp:Parameter Name="B5" Type="String" />
            <asp:Parameter Name="B6" Type="String" />
            <asp:Parameter Name="B7" Type="String" />
            <asp:Parameter Name="B8" Type="String" />
            <asp:Parameter Name="C1" Type="String" />
            <asp:Parameter Name="C2" Type="String" />
            <asp:Parameter Name="C3" Type="String" />
            <asp:Parameter Name="C4" Type="String" />
            <asp:Parameter Name="C5" Type="String" />
            <asp:Parameter Name="C6" Type="String" />
            <asp:Parameter Name="C7" Type="String" />
            <asp:Parameter Name="C8" Type="String" />
            <asp:Parameter Name="C9" Type="String" />
            <asp:Parameter Name="C10" Type="String" />
            <asp:Parameter Name="C11" Type="String" />
            <asp:Parameter Name="C12" Type="String" />
            <asp:Parameter Name="C13" Type="String" />
            <asp:Parameter Name="C14" Type="String" />
            <asp:Parameter Name="C15" Type="String" />
            <asp:Parameter Name="D1" Type="String" />
            <asp:Parameter Name="D2" Type="String" />
            <asp:Parameter Name="D3" Type="String" />
            <asp:Parameter Name="D4" Type="String" />
            <asp:Parameter Name="E1" Type="String" />
            <asp:Parameter Name="E2" Type="String" />
            <asp:Parameter Name="E3" Type="String" />
            <asp:Parameter Name="E4" Type="String" />
            <asp:Parameter Name="E5" Type="String" />
            <asp:Parameter Name="E6" Type="String" />
            <asp:Parameter Name="F1" Type="String" />
            <asp:Parameter Name="F2" Type="String" />
            <asp:Parameter Name="F3" Type="String" />
            <asp:Parameter Name="F4" Type="String" />
            <asp:Parameter Name="F5" Type="String" />
            <asp:Parameter Name="F6" Type="String" />
            <asp:Parameter Name="G1" Type="String" />
            <asp:Parameter Name="G2" Type="String" />
            <asp:Parameter Name="G3" Type="String" />
            <asp:Parameter Name="G4" Type="String" />
            <asp:Parameter Name="G5" Type="String" />
            <asp:Parameter Name="G6" Type="String" />
            <asp:Parameter Name="G7" Type="String" />
            <asp:Parameter Name="H1" Type="String" />
            <asp:Parameter Name="H2" Type="String" />
            <asp:Parameter Name="H3" Type="String" />
            <asp:Parameter Name="H4" Type="String" />
            <asp:Parameter Name="H5" Type="String" />
            <asp:Parameter Name="H6" Type="String" />
            <asp:Parameter Name="H7" Type="String" />
            <asp:Parameter Name="H8" Type="String" />
            <asp:Parameter Name="I1" Type="String" />
            <asp:Parameter Name="I2" Type="String" />
            <asp:Parameter Name="I3" Type="String" />
            <asp:Parameter Name="I4" Type="String" />
            <asp:Parameter Name="I5" Type="String" />
            <asp:Parameter Name="I6" Type="String" />
            <asp:Parameter Name="I7" Type="String" />
            <asp:Parameter Name="I8" Type="String" />
            <asp:Parameter Name="I9" Type="String" />
            <asp:Parameter Name="J1" Type="String" />
            <asp:Parameter Name="J2" Type="String" />
            <asp:Parameter Name="J3" Type="String" />
            <asp:Parameter Name="J4" Type="String" />
            <asp:Parameter Name="J5" Type="String" />
            <asp:Parameter Name="J6" Type="String" />
            <asp:Parameter Name="K1" Type="String" />
            <asp:Parameter Name="K2" Type="String" />
            <asp:Parameter Name="K3" Type="String" />
            <asp:Parameter Name="K4" Type="String" />
            <asp:Parameter Name="K5" Type="String" />
            <asp:Parameter Name="K6" Type="String" />
            <asp:Parameter Name="K7" Type="String" />
            <asp:Parameter Name="K8" Type="String" />
            <asp:Parameter Name="L1" Type="String" />
            <asp:Parameter Name="L2" Type="String" />
            <asp:Parameter Name="L3" Type="String" />
            <asp:Parameter Name="L4" Type="String" />
            <asp:Parameter Name="L5" Type="String" />
            <asp:Parameter Name="M1" Type="String" />
            <asp:Parameter Name="M2" Type="String" />
            <asp:Parameter Name="M3" Type="String" />
            <asp:Parameter Name="M4" Type="String" />
            <asp:Parameter Name="M5" Type="String" />
            <asp:Parameter Name="M6" Type="String" />
            <asp:Parameter Name="N1" Type="String" />
            <asp:Parameter Name="N2" Type="String" />
            <asp:Parameter Name="N3" Type="String" />
            <asp:Parameter Name="N4" Type="String" />
            <asp:Parameter Name="N5" Type="String" />
            <asp:Parameter Name="N6" Type="String" />
            <asp:Parameter Name="N7" Type="String" />
            <asp:Parameter Name="P1" Type="String" />
            <asp:Parameter Name="P2" Type="String" />
            <asp:Parameter Name="P3" Type="String" />
            <asp:Parameter Name="P4" Type="String" />
            <asp:Parameter Name="P5" Type="String" />
            <asp:Parameter Name="Q1" Type="String" />
            <asp:Parameter Name="O1" Type="String" />
            <asp:Parameter Name="Q2" Type="String" />
            <asp:Parameter Name="Q3" Type="String" />
            <asp:Parameter Name="Q4" Type="String" />
            <asp:Parameter Name="O2" Type="String" />
            <asp:Parameter Name="O3" Type="String" />
            <asp:Parameter Name="O4" Type="String" />
            <asp:Parameter Name="O5" Type="String" />
            <asp:Parameter Name="Corrected_1" Type="String" />
            <asp:Parameter Name="Corrected_1_Text" Type="String" />
            <asp:Parameter Name="Corrected_2" Type="String" />
            <asp:Parameter Name="Corrected_2_Text" Type="String" />
            <asp:Parameter Name="Corrected_3" Type="String" />
            <asp:Parameter Name="Corrected_3_Text" Type="String" />
            <asp:Parameter Name="Item_Num_Comments" Type="String" />
            <asp:Parameter Name="Item_Company_Comments" Type="String" />
            <asp:Parameter Name="Item1_Expected_Completion" DbType="Date" />
            <asp:Parameter Name="Item1_Actual_Completion" DbType="Date" />
            <asp:Parameter Name="Item1_Assigned_Name" Type="String" />
            <asp:Parameter Name="Item1_Admin_Comments" Type="String" />
            <asp:Parameter Name="Item2_Expected_Completion" DbType="Date" />
            <asp:Parameter Name="Item2_Actual_Completion" DbType="Date" />
            <asp:Parameter Name="Item2_Assigned_Name" Type="String" />
            <asp:Parameter Name="Item2_Admin_Comments" Type="String" />
            <asp:Parameter Name="Item3_Expected_Completion" DbType="Date" />
            <asp:Parameter Name="Item3_Actual_Completion" DbType="Date" />
            <asp:Parameter Name="Item3_Assigned_Name" Type="String" />
            <asp:Parameter Name="Item3_Admin_Comments" Type="String" />
        </UpdateParameters>
    </asp:SqlDataSource>
    </form>
</body>
</html>
<script type="text/javascript">
    var t;

    function scrollSelectedRecord() {
        if (typeof (grid1) == 'undefined') {
            t = window.seAction_Item_Statusout("scrollSelectedRecord()", 500);
            return;
        }
        if (grid1 != null) {
            if (grid1.Rows != null) {
                if (grid1.PageSelectedRecords != null && grid1.PageSelectedRecords.length > 0) {
                    for (var i = 0; i < grid1.Rows.length; i++) {
                        if (grid1.Rows[i].Cells['SupplierID'].Value == grid1.PageSelectedRecords[0].SupplierID) {
                            grid1.GridBodyContainer.firstChild.firstChild.childNodes[1].childNodes[i].scrollIntoView(true);
                        }
                    }
                }
            } else {
                t = window.setTimeout("scrollSelectedRecord()", 500);
                return;
            }

            window.clearTimeout(t);
        }
    }
    scrollSelectedRecord();

</script>
