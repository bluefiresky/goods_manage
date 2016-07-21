$('#import_order_excel').click(function(){
  path = $('#upfile').val();
  importXLS(path)
})

$('#order_submit').click(function(){
  let receive_date = new Date($('#order_receive_date').val()).getTime();
  console.log(receive_date);
  // $('#order_form_div form').submit();
})

function importXLS(fileName)
{
     console.log(fileName);
     objCon = new ActiveXObject("ADODB.Connection");
     objCon.Provider = "Microsoft.Jet.OLEDB.4.0";
     objCon.ConnectionString = "Data Source=" + fileName + ";Extended Properties=Excel 8.0;";
     objCon.CursorLocation = 1;
     objCon.Open;
     var strQuery;
     //Get the SheetName
     var strSheetName = "Sheet1$";
     var rsTemp =   new ActiveXObject("ADODB.Recordset");
     rsTemp = objCon.OpenSchema(20);
     if(!rsTemp.EOF)
     strSheetName = rsTemp.Fields("Table_Name").Value;
     rsTemp = null;
     rsExcel =   new ActiveXObject("ADODB.Recordset");
     strQuery = "SELECT * FROM [" + strSheetName + "]";
     rsExcel.ActiveConnection = objCon;
     rsExcel.Open(strQuery);
     while(!rsExcel.EOF)
     {
     for(i = 0;i<rsExcel.Fields.Count;++i)
     {
       console.log(rsExcel.Fields(i).value);
    //  alert(rsExcel.Fields(i).value);
     }
     rsExcel.MoveNext;
     }
     // Close the connection and dispose the file
     objCon.Close;
     objCon =null;
     rsExcel = null;
}

Date.prototype.Format = function (fmt) { //author: meizz
    var o = {
        "M+": this.getMonth() + 1, //月份
        "d+": this.getDate(), //日
        "h+": this.getHours(), //小时
        "m+": this.getMinutes(), //分
        "s+": this.getSeconds(), //秒
        "q+": Math.floor((this.getMonth() + 3) / 3), //季度
        "S": this.getMilliseconds() //毫秒
    };
    if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
    for (var k in o)
    if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
    return fmt;
}
