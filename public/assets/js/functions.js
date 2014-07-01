$(document).ready(function() {

	$(".signup").click(function() {
		$("#signin").hide();
		$("#signup").show();
	});

	$(".signin").click(function() {
		$("#signup").hide();
		$("#signin").show();
	});

	$(".submit").click(function(e) {
		var p = $("#password").val();
		var pc = $("#password_confirm").val();

		if(p != pc){
      e.preventDefault();
      alert("Passwords don't match"); 
		}
	});
	

});
	