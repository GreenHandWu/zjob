$(function(){
    $(".user-setting li").click(function(){
        $(".user-setting li").removeClass("active");
        $(this).addClass("active");
        var panelId = "#"+$(this).attr("name");
        $("#userPanel > div").css({'display':'none'});
        $(panelId).css({'display':'block'});

    });

    $('#file').change(function() {
        $("#showImg").attr("src", window.URL.createObjectURL(this.files[0]));
    });
});

function openFileInput(){
	$('#file').click();
}
