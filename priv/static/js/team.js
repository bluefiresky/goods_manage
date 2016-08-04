// ************************* For Index**************************
// Event
$('#team_create').click(function(){
  window.location.href="/teams/new"
})

$('#team_submit').click(function(){
  let tip = check_form_data();
  if (tip != null) {
    form_error_tip(tip);
  }else{
    $('#team_form_div form').submit();
  }
})

// Function
function form_error_tip(error){
  $('#form_error_tip').html(error);
}

function check_form_data(){
  let tip = null;
  let name = $('#team_name').val();
  let phone = $('#team_phone').val();
  if (name == "" || name == null || name == undefined) {
    tip = "安装队名称不能为空";
  }else if (phone == "" || phone == null || phone == undefined) {
    tip = "联系电话不能为空";
  }
  return tip;
}
