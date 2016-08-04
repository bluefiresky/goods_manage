// ***************************** For Show ********************************
// Event
$('#account_modify_submit').click(function(){
  let tip = check_form_data();
  if (tip != null) {
    form_error_tip(tip);
  }else{
    $('#account_modify_form').submit();
  }
})

// Function
function form_error_tip(error){
  $('#form_error_tip').html(error);
}

function check_form_data(){
  let tip = null;
  let password = $('#account_password').val();
  let confirm_password = $('#account_password_confirm').val();
  if (password == "" || password == null || password == undefined) {
    tip = "密码不能为空";
  }else if (confirm_password == "" || confirm_password == null || confirm_password == undefined) {
    tip = "确认密码不能为空";
  }else if (password.trim() != confirm_password.trim()) {
    tip = "两次输入的密码不一致";
  }
  return tip;
}
