$('#login_form').submit( ( event ) => {
    event.preventDefault();

    const email = $("#email").val();
    const password = $("#password").val();

    let remember_me = false;
    if ($('#rememberMe').is(":checked")){
        remember_me = true;
    }

    const obj = {
        email: email,
        password: password,
        remember_me: remember_me
    }

    $.ajax({
        url: './admin-login',
        type: 'POST',
        data: { obj: JSON.stringify(obj) },
        dataType: 'JSON',
        success: function (data) {
            if(data.loginResult){
                window.location.replace("http://localhost:8080/DepoProject_war_exploded/dashboard.jsp");
            }
            $("#loginerror").text(data.error);
        },
        error: function (err) {
            console.log(err)
            alert("Giriþ yapýlamadý!");
        }
    })

})