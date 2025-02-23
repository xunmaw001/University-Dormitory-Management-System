<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="zh-cn">

<head>
    <%@ include file="../../static/head.jsp" %>
    <link href="http://www.bootcss.com/p/bootstrap-datetimepicker/bootstrap-datetimepicker/css/datetimepicker.css"
          rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/bootstrap-select.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css" rel="stylesheet">
    <script type="text/javascript" charset="utf-8">
        window.UEDITOR_HOME_URL = "${pageContext.request.contextPath}/resources/ueditor/"; //UEDITOR_HOME_URL、config、all这三个顺序不能改变
    </script>
    <script type="text/javascript" charset="utf-8"
            src="${pageContext.request.contextPath}/resources/ueditor/ueditor.config.js"></script>
    <script type="text/javascript" charset="utf-8"
            src="${pageContext.request.contextPath}/resources/ueditor/ueditor.all.min.js"></script>
    <script type="text/javascript" charset="utf-8"
            src="${pageContext.request.contextPath}/resources/ueditor/lang/zh-cn/zh-cn.js"></script>
</head>
<style>
    .error {
        color: red;
    }
</style>
<body>
<!-- Pre Loader -->
<div class="loading">
    <div class="spinner">
        <div class="double-bounce1"></div>
        <div class="double-bounce2"></div>
    </div>
</div>
<!--/Pre Loader -->
<div class="wrapper">
    <!-- Page Content -->
    <div id="content">
        <!-- Top Navigation -->
        <%@ include file="../../static/topNav.jsp" %>
        <!-- Menu -->
        <div class="container menu-nav">
            <nav class="navbar navbar-expand-lg lochana-bg text-white">
                <button class="navbar-toggler" type="button" data-toggle="collapse"
                        data-target="#navbarSupportedContent"
                        aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="ti-menu text-white"></span>
                </button>

                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul id="navUl" class="navbar-nav mr-auto">

                    </ul>
                </div>
            </nav>
        </div>
        <!-- /Menu -->
        <!-- Breadcrumb -->
        <!-- Page Title -->
        <div class="container mt-0">
            <div class="row breadcrumb-bar">
                <div class="col-md-6">
                    <h3 class="block-title">编辑卫生检查</h3>
                </div>
                <div class="col-md-6">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item">
                            <a href="${pageContext.request.contextPath}/index.jsp">
                                <span class="ti-home"></span>
                            </a>
                        </li>
                        <li class="breadcrumb-item">卫生检查管理</li>
                        <li class="breadcrumb-item active">编辑卫生检查</li>
                    </ol>
                </div>
            </div>
        </div>
        <!-- /Page Title -->

        <!-- /Breadcrumb -->
        <!-- Main Content -->
        <div class="container">

            <div class="row">
                <!-- Widget Item -->
                <div class="col-md-12">
                    <div class="widget-area-2 lochana-box-shadow">
                        <h3 class="widget-title">卫生检查信息</h3>
                        <form id="addOrUpdateForm">
                            <div class="form-row">
                            <!-- 级联表的字段 -->
                                    <div class="form-group col-md-6 aaaaaa">
                                        <label>宿舍信息</label>
                                        <div>
                                            <select id="susheSelect" name="susheSelect"
                                                    class="selectpicker form-control"  data-live-search="true"
                                                    title="请选择" data-header="请选择" data-size="5" data-width="650px">
                                            </select>
                                        </div>
                                    </div>
                                    <div class="form-group col-md-6">
                                        <label>楼栋</label>
                                        <input id="building" name="building" class="form-control"
                                               placeholder="楼栋" readonly>
                                    </div>
                                    <div class="form-group col-md-6">
                                        <label>单元</label>
                                        <input id="unit" name="unit" class="form-control"
                                               placeholder="单元" readonly>
                                    </div>
                                    <div class="form-group col-md-6">
                                        <label>房间号</label>
                                        <input id="room" name="room" class="form-control"
                                               placeholder="房间号" readonly>
                                    </div>
                                    <div class="form-group col-md-6">
                                        <label>已住人员</label>
                                        <input id="susheNumber" name="susheNumber" class="form-control"
                                               placeholder="已住人员" readonly>
                                    </div>
                            <!-- 当前表的字段 -->
                                    <input id="updateId" name="id" type="hidden">
                                <input id="susheId" name="susheId" type="hidden">
                                    <div class="form-group col-md-6">
                                        <label>检查日期</label>
                                        <input id="weishengjianchaTime-input" name="weishengjianchaTime" type="text" class="form-control layui-input">
                                    </div>
                                    <div class="form-group col-md-6">
                                        <label>检查结果</label>
                                        <select id="weishengjianchaTypesSelect" name="weishengjianchaTypes" class="form-control">
                                        </select>
                                    </div>
                                    <div class="form-group  col-md-6">
                                        <label>备注</label>
                                        <input id="weishengjianchaContentupload" name="file" type="file">
                                        <script id="weishengjianchaContentEditor" type="text/plain"
                                                style="width:100%;height:230px;"></script>
                                        <script type = "text/javascript" >
                                        //建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例
                                        //相见文档配置属于你自己的编译器
                                        var weishengjianchaContentUe = UE.getEditor('weishengjianchaContentEditor', {
                                            toolbars: [
                                                [
                                                    'undo', //撤销
                                                    'bold', //加粗
                                                    'redo', //重做
                                                    'underline', //下划线
                                                    'horizontal', //分隔线
                                                    'inserttitle', //插入标题
                                                    'cleardoc', //清空文档
                                                    'fontfamily', //字体
                                                    'fontsize', //字号
                                                    'paragraph', //段落格式
                                                    'inserttable', //插入表格
                                                    'justifyleft', //居左对齐
                                                    'justifyright', //居右对齐
                                                    'justifycenter', //居中对
                                                    'justifyjustify', //两端对齐
                                                    'forecolor', //字体颜色
                                                    'fullscreen', //全屏
                                                    'edittip ', //编辑提示
                                                    'customstyle', //自定义标题
                                                ]
                                            ]
                                        });
                                        </script>
                                        <input type="hidden" name="weishengjianchaContent" id="weishengjianchaContent-input">
                                    </div>
                                    <div class="form-group col-md-12 mb-3">
                                        <button id="submitBtn" type="button" class="btn btn-primary btn-lg">提交</button>
                                        <button id="exitBtn" type="button" class="btn btn-primary btn-lg">返回</button>
                                    </div>
                            </div>
                        </form>
                    </div>
                </div>
                <!-- /Widget Item -->
            </div>
        </div>
        <!-- /Main Content -->
    </div>
    <!-- /Page Content -->
</div>
<!-- Back to Top -->
<a id="back-to-top" href="#" class="back-to-top">
    <span class="ti-angle-up"></span>
</a>
<!-- /Back to Top -->
<%@ include file="../../static/foot.jsp" %>
<script src="${pageContext.request.contextPath}/resources/js/vue.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/jquery.ui.widget.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/jquery.fileupload.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/jquery.form.js"></script>
<script type="text/javascript" charset="utf-8"
        src="${pageContext.request.contextPath}/resources/js/validate/jquery.validate.min.js"></script>
<script type="text/javascript" charset="utf-8"
        src="${pageContext.request.contextPath}/resources/js/validate/messages_zh.js"></script>
<script type="text/javascript" charset="utf-8"
        src="${pageContext.request.contextPath}/resources/js/validate/card.js"></script>
<script type="text/javascript" charset="utf-8"
        src="${pageContext.request.contextPath}/resources/js/datetimepicker/bootstrap-datetimepicker.min.js"></script>
<script type="text/javascript" charset="utf-8"
                 src="${pageContext.request.contextPath}/resources/js/bootstrap-select.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/laydate.js"></script>
<script>
    <%@ include file="../../utils/menu.jsp"%>
    <%@ include file="../../static/setMenu.js"%>
    <%@ include file="../../utils/baseUrl.jsp"%>

    var tableName = "weishengjiancha";
    var pageType = "add-or-update";
    var updateId = "";
    var crossTableId = -1;
    var crossTableName = '';
    var ruleForm = {};
    var crossRuleForm = {};


    // 下拉框数组
        <!-- 当前表的下拉框数组 -->
    var weishengjianchaTypesOptions = [];
        <!-- 级联表的下拉框数组 -->
    var susheOptions = [];

    var ruleForm = {};


    // 文件上传
    function upload() {

        <!-- 当前表的文件上传 -->

        $('#weishengjianchaContentupload').fileupload({
            url: baseUrl + 'file/upload',
            headers: {token: window.sessionStorage.getItem("token")},
            dataType: 'json',
            done: function (e, data) {
                UE.getEditor('weishengjianchaContentEditor').execCommand('insertHtml', '<img src=\"' + baseUrl + 'upload/' + data.result.file + '\" width=900 height=560>');
            }
        });


    }

    // 表单提交
    function submit() {
        if (validform() == true && compare() == true) {
            let data = {};
            getContent();
           if($("#susheId") !=null){
               var susheId = $("#susheId").val();
               if(susheId == null || susheId =='' || susheId == 'null'){
                   alert("宿舍不能为空");
                   return;
               }
           }
            let value = $('#addOrUpdateForm').serializeArray();
            $.each(value, function (index, item) {
                data[item.name] = item.value;
            });
            let json = JSON.stringify(data);
            var urlParam;
            var successMes = '';
            if (updateId != null && updateId != "null" && updateId != '') {
                urlParam = 'update';
                successMes = '修改成功';
            } else {
                urlParam = 'save';
                    successMes = '添加成功';
            }
            httpJson("weishengjiancha/" + urlParam, "POST", data, (res) => {
                if(res.code == 0){
                    window.sessionStorage.removeItem('addweishengjiancha');
                    window.sessionStorage.removeItem('updateId');
                    let flag = true;
                    if (flag) {
                        alert(successMes);
                    }
                    if (window.sessionStorage.getItem('onlyme') != null && window.sessionStorage.getItem('onlyme') == "true") {
                        window.sessionStorage.removeItem('onlyme');
                        window.sessionStorage.setItem("reload","reload");
                        window.parent.location.href = "${pageContext.request.contextPath}/index.jsp";
                    } else {
                        window.location.href = "list.jsp";
                    }
                }
            });
        } else {
            alert("表单未填完整或有错误");
        }
    }

    // 查询列表
        <!-- 查询当前表的所有列表 -->
        function weishengjianchaTypesSelect() {
            //填充下拉框选项
            http("dictionary/page?page=1&limit=100&sort=&order=&dicCode=weishengjiancha_types", "GET", {}, (res) => {
                if(res.code == 0){
                    weishengjianchaTypesOptions = res.data.list;
                }
            });
        }
        <!-- 查询级联表的所有列表 -->
        function susheSelect() {
            //填充下拉框选项
            http("sushe/page?page=1&limit=100&sort=&order=", "GET", {}, (res) => {
                if(res.code == 0){
                    susheOptions = res.data.list;
                }
            });
        }

        function susheSelectOne(id) {
            http("sushe/info/"+id, "GET", {}, (res) => {
                if(res.code == 0){
                ruleForm = res.data;
                susheShowImg();
                susheShowVideo();
                susheDataBind();
            }
        });
        }



    // 初始化下拉框
    <!-- 初始化当前表的下拉框 -->
        function initializationWeishengjianchatypesSelect(){
            var weishengjianchaTypesSelect = document.getElementById('weishengjianchaTypesSelect');
            if(weishengjianchaTypesSelect != null && weishengjianchaTypesOptions != null  && weishengjianchaTypesOptions.length > 0 ){
                for (var i = 0; i < weishengjianchaTypesOptions.length; i++) {
                    weishengjianchaTypesSelect.add(new Option(weishengjianchaTypesOptions[i].indexName,weishengjianchaTypesOptions[i].codeIndex));
                }
            }
        }

        function initializationsusheSelect() {
            var susheSelect = document.getElementById('susheSelect');
            if(susheSelect != null && susheOptions != null  && susheOptions.length > 0 ) {
                for (var i = 0; i < susheOptions.length; i++) {
                    susheSelect.add(new Option("楼栋:"+susheOptions[i].building+" 单元:"+susheOptions[i].unit+" 房间:"+susheOptions[i].room, susheOptions[i].id));
                }

                $("#susheSelect").change(function(e) {
                        susheSelectOne(e.target.value);
                });
            }

        }



    // 下拉框选项回显
    function setSelectOption() {

        <!-- 当前表的下拉框回显 -->

        var weishengjianchaTypesSelect = document.getElementById("weishengjianchaTypesSelect");
        if(weishengjianchaTypesSelect != null && weishengjianchaTypesOptions != null  && weishengjianchaTypesOptions.length > 0 ) {
            for (var i = 0; i < weishengjianchaTypesOptions.length; i++) {
                if (weishengjianchaTypesOptions[i].codeIndex == ruleForm.weishengjianchaTypes) {//下拉框value对比,如果一致就赋值汉字
                        weishengjianchaTypesSelect.options[i].selected = true;
                }
            }
        }
        <!--  级联表的下拉框回显  -->
            var susheSelect = document.getElementById("susheSelect");
            if(susheSelect != null && susheOptions != null  && susheOptions.length > 0 ) {
                for (var i = 0; i < susheOptions.length; i++) {
                    if (susheOptions[i].id == ruleForm.susheId) {//下拉框value对比,如果一致就赋值汉字
                        susheSelect.options[i+1].selected = true;
                        $("#susheSelect" ).selectpicker('refresh');
                    }
                }
            }
    }


    // 填充富文本框
    function setContent() {

        <!-- 当前表的填充富文本框 -->
        if (ruleForm.weishengjianchaContent != null && ruleForm.weishengjianchaContent != 'null' && ruleForm.weishengjianchaContent != '' && $("#weishengjianchaContentupload").length>0) {

            var weishengjianchaContentUeditor = UE.getEditor('weishengjianchaContentEditor');
            weishengjianchaContentUeditor.ready(function () {
                var mes = '';
                if(ruleForm.weishengjianchaContent != null){
                    mes = ''+ ruleForm.weishengjianchaContent;
                    mes = mes.replace(/\n/g, "<br>");
                }
                weishengjianchaContentUeditor.setContent(mes);
            });
        }
    }
    // 获取富文本框内容
    function getContent() {

        <!-- 获取当前表的富文本框内容 -->
        if($("#weishengjianchaContentupload").length>0) {
            var weishengjianchaContentEditor = UE.getEditor('weishengjianchaContentEditor');
            if (weishengjianchaContentEditor.hasContents()) {
                $('#weishengjianchaContent-input').attr('value', weishengjianchaContentEditor.getPlainTxt());
            }
        }
    }
    //数字检查
        <!-- 当前表的数字检查 -->

    function exit() {
        window.sessionStorage.removeItem("updateId");
        window.sessionStorage.removeItem('addweishengjiancha');
        window.location.href = "list.jsp";
    }
    // 表单校验
    function validform() {
        return $("#addOrUpdateForm").validate({
            rules: {
                susheId: "required",
                weishengjianchaTime: "required",
                weishengjianchaTypes: "required",
                weishengjianchaContent: "required",
                insertTime: "required",
            },
            messages: {
                susheId: "宿舍不能为空",
                weishengjianchaTime: "检查日期不能为空",
                weishengjianchaTypes: "检查结果不能为空",
                weishengjianchaContent: "备注不能为空",
                insertTime: "添加时间不能为空",
            }
        }).form();
    }

    // 获取当前详情
    function getDetails() {
        var addweishengjiancha = window.sessionStorage.getItem("addweishengjiancha");
        if (addweishengjiancha != null && addweishengjiancha != "" && addweishengjiancha != "null") {
            //注册表单验证
            $(validform());
            $('#submitBtn').text('新增');

        } else {
            $('#submitBtn').text('修改');
            var userId = window.sessionStorage.getItem('userId');
            updateId = userId;//先赋值登录用户id
            var uId  = window.sessionStorage.getItem('updateId');//获取修改传过来的id
            if (uId != null && uId != "" && uId != "null") {
                //如果修改id不为空就赋值修改id
                updateId = uId;
            }
            window.sessionStorage.removeItem('updateId');
            http("weishengjiancha/info/" + updateId, "GET", {}, (res) => {
                if(res.code == 0)
                {
                    ruleForm = res.data
                    // 是/否下拉框回显
                    setSelectOption();
                    // 设置图片src
                    showImg();
                    // 设置视频src
                    showVideo();
                    // 数据填充
                    dataBind();
                    // 富文本框回显
                    setContent();
                    //注册表单验证
                    $(validform());
                }

            });
        }
    }

    // 清除可能会重复渲染的selection
    function clear(className) {
        var elements = document.getElementsByClassName(className);
        for (var i = elements.length - 1; i >= 0; i--) {
            elements[i].parentNode.removeChild(elements[i]);
        }
    }

    function dateTimePick() {
            laydate.render({
                elem: '#weishengjianchaTime-input'
                ,type: 'date'
            });
            laydate.render({
                elem: '#insertTime-input'
                ,type: 'datetime'
            });
    }


    function dataBind() {


    <!--  级联表的数据回显  -->
        susheDataBind();


    <!--  当前表的数据回显  -->
        $("#updateId").val(ruleForm.id);
        $("#susheId").val(ruleForm.susheId);
        $("#weishengjianchaTime-input").val(ruleForm.weishengjianchaTime);
        $("#weishengjianchaContent").val(ruleForm.weishengjianchaContent);
        $("#insertTime-input").val(ruleForm.insertTime);

    }
    <!--  级联表的数据回显  -->
    function susheDataBind(){

                    <!-- 把id赋值给当前表的id-->
        $("#susheId").val(ruleForm.id);

        $("#building").val(ruleForm.building);
        $("#unit").val(ruleForm.unit);
        $("#room").val(ruleForm.room);
        $("#susheNumber").val(ruleForm.susheNumber);
    }


    //图片显示
    function showImg() {
        <!--  当前表的图片  -->

        <!--  级联表的图片  -->
        susheShowImg();
    }


    <!--  级联表的图片  -->

    function susheShowImg() {
    }



    //视频回显
    function showVideo() {
    <!--  当前表的视频  -->

    <!--  级联表的视频  -->
        susheShowVideo();
    }


    <!--  级联表的视频  -->

    function susheShowVideo() {
    }



    $(document).ready(function () {
        //设置右上角用户名
        $('.dropdown-menu h5').html(window.sessionStorage.getItem('username'))
        //设置项目名
        $('.sidebar-header h3 a').html(projectName)
        //设置导航栏菜单
        setMenu();
        $('#exitBtn').on('click', function (e) {
            e.preventDefault();
            exit();
        });
        //初始化时间插件
        dateTimePick();
        //查询所有下拉框
            <!--  当前表的下拉框  -->
            weishengjianchaTypesSelect();
            <!-- 查询级联表的下拉框(用id做option,用名字及其他参数做名字级联修改) -->
            susheSelect();



        // 初始化下拉框
            <!--  初始化当前表的下拉框  -->
            initializationWeishengjianchatypesSelect();
            <!--  初始化级联表的下拉框  -->
            initializationsusheSelect();

        $(".selectpicker" ).selectpicker('refresh');
        getDetails();
        //初始化上传按钮
        upload();
    <%@ include file="../../static/myInfo.js"%>
                $('#submitBtn').on('click', function (e) {
                    e.preventDefault();
                    //console.log("点击了...提交按钮");
                    submit();
                });
        readonly();
        window.sessionStorage.removeItem('addweishengjiancha');
    });

    function readonly() {
        if (window.sessionStorage.getItem('role') == '管理员') {
            //$('#jifen').attr('readonly', 'readonly');
            //$('#role').attr('style', 'pointer-events: none;');
        }else{
            // $(".aaaaaa").remove();
        }
    }

    //比较大小
    function compare() {
        var largerVal = null;
        var smallerVal = null;
        if (largerVal != null && smallerVal != null) {
            if (largerVal <= smallerVal) {
                alert(smallerName + '不能大于等于' + largerName);
                return false;
            }
        }
        return true;
    }


    // 用户登出
    <%@ include file="../../static/logout.jsp"%>
</script>
</body>

</html>