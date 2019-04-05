<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script>
	function modifyPwd(){
		//alert(1);
		//逻辑：
		//1:根据id,pass,查找当前账号的密码是否正确
		//2:用新密码去更新数据库，完成修改密码逻辑
		//获取id,pass
		let id=${user.id};
		let oldPass=$('#oldPass').val();
		let newPass=$('#newPass').val();
		//将其封装成一个json对象
		let params={"id":id,"oldPass":oldPass,"newPass":newPass};
		$.post('${pageContext.request.contextPath}/front/user/modifyPwd',params,function(data){


			 if(data=='success'){
				//返回登录页面继续登录
                 alert("修改密码成功");
                 window.location = "${pageContext.request.contextPath}/showLogin";
			}
			else{
			    alert("修改密码失败");
                 window.location = "${pageContext.request.contextPath}/front/user/findJobByParams";
			} 
		});
		
		
		
	}
	
	//退出登录
    function loginOut() {
        $.ajax({
            method: 'post',
            url: '${pageContext.request.contextPath}/loginOut',
            success: function () {
                alert('你已退出该系统');
                //返回登录页重新登录
                window.location = "${pageContext.request.contextPath}/showLogin";
            }

        });

    }
	$(document).ready(function(){
		 $('#modForm').bootstrapValidator({
		        message: 'This value is not valid',
		        feedbackIcons: {
		            valid: 'glyphicon glyphicon-ok',
		            invalid: 'glyphicon glyphicon-remove',
		            validating: 'glyphicon glyphicon-refresh'
		        },
		        fields:{
					
		        
		        	oldPass:{
		        		validators:{
		        			 notEmpty: {//判断是否为空
						            message: '旧密码不能为空'
						     }
				         
		        		}
		        		
		        	},
		        	newPass:{
		        		validators:{
		        			 notEmpty: {//判断是否为空
						            message: '旧密码不能为空'
						     }
				         
		        		}
		        		
		        	},
		        	rePass:{
		        		validators:{
		        			 notEmpty: {//判断是否为空
						            message: '确认密码不能为空'
						     },
						     //校验确认密码必须和登录密码相同
						     identical:{
						    	 
						    	 field:'newPass',
						    	 message:'两次输入的密码不一致'
						     }
		        		}
		        		
		        	}
		        }
		        	
		    });
	
	});
	
	
</script>
<div class="col-sm-3">
        <div class="panel panel-default">
          <div class="panel-heading">
             <img alt="" src="${pageContext.request.contextPath}/images/user.png">
           <span class="font-style"> 欢迎您：${user.userName}</span>
          </div>
        <div class="panel-body">
          <div class="col-sm-12">
            <ul class="nav nav-pills nav-stacked">
            <li><a class="btn btn-link" data-toggle="modal" data-target="#modfiyPWD" style="text-align: left;">修改登录密码</a></li>
            <li><a onclick="loginOut()" style="cursor: pointer;">退出</a></li>
          </ul>
          </div>
        </div>
      </div>
      <div class="panel panel-default">
          <div class="panel-heading">
             <img alt="" src="${pageContext.request.contextPath}/images/message.png"> 
           <span class="font-style">&nbsp;联系我们：</span>
          </div>
        <div class="panel-body">
          <address class="padding-left-10 font-info">
          <strong>联系地址：</strong><br>
          南京市江宁区弘景大道3601号<br>
          <strong>联系电话：</strong><br>
           025-12345678
        </address>
        </div>
      </div>
      </div>
    
    
    <!-- 密码修改model窗口 -->
    <div class="modal fade" id="modfiyPWD" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
          <h4 class="modal-title" id="myModalLabel">用户密码修改</h4>
        </div>
        <form  class="form-horizontal" method="post" id="modForm" >
          <div class="modal-body">
           <div class="form-group">
             <label class="col-sm-3 control-label">登录密码：</label>
             <div class="col-sm-6">
               <input class="form-control" type="password" id="oldPass" name="oldPass">
             </div>
             <label class="col-sm-3 control-label error-info" style="text-align:left;">*不可为空</label>
          </div>
           <div class="form-group">
             <label class="col-sm-3 control-label">新的密码：</label>
             <div class="col-sm-6">
               <input class="form-control" type="password" id="newPass" name="newPass">
             </div>
             <label class="col-sm-3 control-label error-info" style="text-align:left;">*不可为空</label>
          </div>
           <div class="form-group">
             <label class="col-sm-3 control-label">重复密码：</label>
             <div class="col-sm-6">
               <input class="form-control" type="password" id="rePass" name="rePass">
             </div>
             <label class="col-sm-3 control-label error-info" style="text-align:left;">*不可为空</label>
          </div>
          </div>
          <div class="modal-footer">
              <button type="button" class="btn btn-default" data-dismiss="modal" aria-label="Close">关&nbsp;&nbsp;闭</button>
              <button type="reset" class="btn btn-default">重&nbsp;&nbsp;置</button>
              <button type="submit" class="btn btn-default" onclick="modifyPwd()" disabled="disabled">修&nbsp;&nbsp;改</button>
        </div>
      </form>
      </div>
    </div>
  </div>
  <!-- MODEL结束 -->