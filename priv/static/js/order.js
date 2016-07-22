// Event
$('#import_order_excel').click(function(){
  path = $('#upfile').val();
  importXLS(path)
})

$('#order_submit').click(function(){
  let purchase_date = new Date($('#order_purchase_date').val()).getTime();
  let receive_date = new Date($('#order_receive_date').val()).getTime();
  let install_date = new Date($('#order_install_date').val()).getTime();
  let dispatching_date_local = new Date($('#order_dispatching_date_local').val()).getTime();
  let dispatching_date_service = new Date($('#order_dispatching_date_service').val()).getTime();

  let tip = check_form_data(purchase_date, receive_date, install_date, dispatching_date_local, dispatching_date_service);
  if (tip != null) {
    form_error_tip(tip);
  }else{
    $('#order_purchase_date').val(purchase_date/1000);
    $('#order_receive_date').val(receive_date/1000);
    $('#order_install_date').val(install_date/1000);
    $('#order_dispatching_date_local').val(dispatching_date_local/1000);
    $('#order_dispatching_date_service').val(dispatching_date_service/1000);
    $('#order_form_div form').submit();
  }
})


// Function
function form_error_tip(error){
  $('#form_error_tip').html(error);
}

function check_form_data(purchase_date, receive_date, install_date, dispatching_date_local, dispatching_date_service){

  let tip = null;
  if (isNaN(purchase_date)) {
    tip = "购买日期输入格式错误";
  }else if (isNaN(receive_date)) {
    tip = "收获日期输入格式错误";
  }else if (isNaN(install_date)) {
    tip = "安装日期输入格式错误";
  }else if (isNaN(dispatching_date_local)) {
    tip = "网点派工日期输入格式错误";
  }else if (isNaN(dispatching_date_service)) {
    tip = "客服派工日期输入格式错误";
  }
  if (tip != null) {
    return tip;
  }
  let customer = $('#order_customer').val();
  let sales_department = $('#order_sales_department').val();
  let customer_address = $('#order_customer_address').val();
  let telephone = $('#order_telephone').val();
  let phone = $('#order_phone').val();
  // let customer_demand = $('#order_customer_demand').val();
  let goods_name = $('#order_goods_name').val();
  let receive_num = $('#order_receive_num').val();
  let order_no = $('#order_order_no').val();
  if (customer == "" || customer == null || customer == undefined) {
    tip = "客户名称不能为空";
  }else if (sales_department == "" || sales_department == null || sales_department == undefined) {
    tip = "销售部门不能为空";
  }else if (customer_address == "" || customer_address == null || customer_address == undefined) {
    tip = "客户地址不能为空";
  }else if (telephone == "" || telephone == null || telephone == undefined) {
    tip = "住宅电话不能为空";
  }else if (phone == "" || phone == null || phone == undefined) {
    tip = "联系电话不能为空";
  }else if (goods_name == "" || goods_name == null || goods_name == undefined) {
    tip = "商品名称称不能为空";
  }else if (receive_num == "" || receive_num == null || receive_num == undefined) {
    tip = "收获数量不能为空";
  }else if (order_no == "" || order_no == null || order_no == undefined) {
    tip = "提货单号不能为空";
  }
  return tip;
}

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
