$(function(){
    //用户名密码登陆和短信登陆的切换
    $('#btn-sms-back').click(function(){
        $('#login-account').css('display','none');
        $('#login-sms').css('display','block');
    });
    $('#btn-account-back').click(function(){
        $('#login-sms').css('display','none');
        $('#login-account').css('display','block');
    });
    
});
$(function(){
    //用户名密码登陆和短信登陆的切换
    $('#btn-sms-back-m').click(function(){
        $('#login-account-m').css('display','none');
        $('#login-sms-m').css('display','block');
    });
    $('#btn-account-back-m').click(function(){
        $('#login-sms-m').css('display','none');
        $('#login-account-m').css('display','block');
    });

});