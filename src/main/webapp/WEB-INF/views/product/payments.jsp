<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Title</title>
    <style>
        #shopbody {
            background-color: #f0f0f0;
            margin: 0 auto;
            width: 1050px;
        }
        .box {
            margin-top: 30px;
            padding: 30px 0px 20px 50px;
            background-color: #fff;
            border-radius: 10px;
            width:100%;
        }

        .box h2 {
            margin-top: 0;
            margin-bottom: 20px;
            font-size: 24px;
        }

        .fff {
            font-weight: bold;
            width: 120px;
        }

        .eee {
            padding-left: 20px;
            width:600px;
        }

        input[type="text"] {
            padding: 8px;
            border-radius: 5px;
            border: 1px solid #ccc;
            width: 150px;
            margin-bottom: 10px;
        }

        #emails, #firstnum, #firstnum2{
            width: 100px;
        }

        #delivery_info{
            width: 200px
        }

        input[type="checkbox"] {
            margin-right: 10px;
        }

        select {
            width: 100%;
            margin-bottom: 10px;
            padding: 8px;
            border-radius: 5px;
            border: 1px solid #ccc;
        }
        #paybutton {
            background-color: #1c7ae6;
            text-align:center;
            margin: 10px auto;
            width:100%;
            border:none;
            height: 50px;
            font-size:25px;
        }
        #delivery_info{
            width:300px;
        }
        #memo{
            width:300px
        }
        .product_image{
            margin-left:10px;
            padding: 10px;
        }
        .product_images{
            width:50px;
            height:75px;
            object-fit: cover;
        }
        .product_title{
            padding-left:50px;
            width:500px;
        }
        .stock{
            margin-left:10px;
            text-align:center;
        }

    </style>
    <!-- jQuery -->
    <script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
    <!-- iamport.payment.js -->
    <script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script>
        //???????????? ????????? ?????? ?????? ?????????
        $(document).ready(function(){
            $("#checkboxs").change(function(){
                if($("#checkboxs").is(":checked")){
                    $("#m_name").attr("value", "${minfo.MEMBER_NAME}");
                    $("#secnum2").attr("value", "${fn:split(minfo.MEMBER_PHONE,"-")[1]}");
                    $("#thrnum2").attr("value", "${fn:split(minfo.MEMBER_PHONE,"-")[2]}");
                    $("#sample6_postcode").attr("value", "${fn:split(minfo.MEMBER_ADDRESS,"/")[0]}");
                    $("#sample6_address").attr("value", "${fn:split(minfo.MEMBER_ADDRESS,"/")[1]}");
                    $("#sample6_detailAddress").attr("value", "${fn:split(minfo.MEMBER_ADDRESS,"/")[2]}");
                }
                else{
                    $("#m_name").attr("value", "");
                    $("#secnum2").attr("value", "");
                    $("#thrnum2").attr("value", "");
                    $("#sample6_postcode").attr("value", "");
                    $("#sample6_address").attr("value", "");
                    $("#sample6_detailAddress").attr("value", "");
                }
            });
        });

        //???????????? ????????????
        function sample6_execDaumPostcode() {
            new daum.Postcode({
                oncomplete: function(data) {
                    // ???????????? ???????????? ????????? ??????????????? ????????? ????????? ???????????? ??????.

                    // ??? ????????? ?????? ????????? ?????? ????????? ????????????.
                    // ???????????? ????????? ?????? ?????? ????????? ??????('')?????? ????????????, ?????? ???????????? ?????? ??????.
                    var addr = ''; // ?????? ??????
                    var extraAddr = ''; // ???????????? ??????

                    //???????????? ????????? ?????? ????????? ?????? ?????? ?????? ?????? ????????????.
                    if (data.userSelectedType === 'R') { // ???????????? ????????? ????????? ???????????? ??????
                        addr = data.roadAddress;
                    } else { // ???????????? ?????? ????????? ???????????? ??????(J)
                        addr = data.jibunAddress;
                    }

                    // ???????????? ????????? ????????? ????????? ???????????? ??????????????? ????????????.
                    if(data.userSelectedType === 'R'){
                        // ??????????????? ?????? ?????? ????????????. (???????????? ??????)
                        // ???????????? ?????? ????????? ????????? "???/???/???"??? ?????????.
                        if(data.bname !== '' && /[???|???|???]$/g.test(data.bname)){
                            extraAddr += data.bname;
                        }
                        // ???????????? ??????, ??????????????? ?????? ????????????.
                        if(data.buildingName !== '' && data.apartment === 'Y'){
                            extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                        }
                        // ????????? ??????????????? ?????? ??????, ???????????? ????????? ?????? ???????????? ?????????.
                        if(extraAddr !== ''){
                            extraAddr = ' (' + extraAddr + ')';
                        }
                        // ????????? ??????????????? ?????? ????????? ?????????.
                        document.getElementById("sample6_address").value += extraAddr;

                    } else {
                        document.getElementById("sample6_extraAddress").value = '';
                    }

                    // ??????????????? ?????? ????????? ?????? ????????? ?????????.
                    document.getElementById('sample6_postcode').value = data.zonecode;
                    document.getElementById("sample6_address").value = addr;
                    // ????????? ???????????? ????????? ????????????.
                    document.getElementById("sample6_detailAddress").focus();
                }
            }).open();
        }

        var time = new Date();
        var yyyy = time.getFullYear();
        var mm = time.getMonth()+1;
        var dd = time.getDay();
        var hh = time.getHours();
        var MM = time.getMinutes();
        var ss = time.getSeconds();
        var ms = time.getMilliseconds();
        var total = ''+yyyy + mm+dd+hh+MM+ss+ms+${minfo.MEMBER_NO};
        $(document).ready(function(){
            console.log(total);
            // $('payment_num').val(total);
            document.getElementById("payment_num").value = total;
        });

        function delivering(){
            if(document.frm.memo.value === "6"){
                document.frm.email2.readOnly = false;
                frm.delivery_info.value = "";
                frm.delivery_info.type = "text"
                frm.delivery_info.focus();
            }else if(document.frm.memo.value === "1"){
                frm.delivery_info.readOnly = true;
                frm.delivery_info.type = "text"
                frm.delivery_info.value = "?????? ?????????????????????.";
            }else if(document.frm.memo.value === "2"){
                frm.delivery_info.readOnly = true;
                frm.delivery_info.type = "text"
                frm.delivery_info.value = "?????? ??? ??????????????????.";
            }else if(document.frm.memo.value === "3"){
                frm.delivery_info.readOnly = true;
                frm.delivery_info.type = "text"
                frm.delivery_info.value = "?????? ??? ???????????? ???????????????.";
            }else if(document.frm.memo.value === "4"){
                frm.delivery_info.readOnly = true;
                frm.delivery_info.type = "text"
                frm.delivery_info.value = "?????? ??? ??? ?????? ???????????????.";
            }else if(document.frm.memo.value === "5"){
                frm.delivery_info.readOnly = true;
                frm.delivery_info.type = "text"
                frm.delivery_info.value = "?????? ??? ???????????? ???????????????.";
            }else{
                frm.delivery_info.readOnly = true;
                frm.delivery_info.type = "hidden"
                frm.delivery_info.value = "";
            }
        }
        function emailchang(){
            if(frm.emails.value === "1"){
                document.frm.email2.readOnly = false;
                frm.delivery_info.value = "";
                frm.delivery_info.focus();
            }else {
                frm.email2.readOnly = true;
                frm.email2.value = frm.emails.value;
            }
        }

        $(document).ready(function (){
            $("#paybutton").click(function (){
                var m_name = document.getElementById("m_name").value;
                var secnum2 = document.getElementById("secnum2").value;
                var thrnum2 = document.getElementById("thrnum2").value;
                var sample6_postcode = document.getElementById("sample6_postcode").value;
                var sample6_address = document.getElementById("sample6_address").value;
                var sample6_detailAddress = document.getElementById("sample6_detailAddress").value;
                var delivery_info = document.getElementById("delivery_info").value;
                if(m_name.length===0||secnum2.length===0||thrnum2.length===0||sample6_postcode.length===0||
                    sample6_address.length===0|| sample6_detailAddress.length===0||delivery_info.length===0){
                    alert("????????? ????????? ??? ????????? ?????????")
                    return false;
                }
            })
        })
    </script>
</head>
<body>
<header>
    <%@include file="../../tags/header.jsp"%>
</header>
<div id="shopbody">
    <form id="frm" name="frm" method="post" action="/com.solponge/member/${minfo.MEMBER_NO}/payments/pay">
        <div class="box">
            <h2>
                ????????????
            </h2>
            <input id="payment_num" name="payment_num" type="hidden"/>
            <table id="payinfo">
                <c:forEach items="${oinfo}" var="o">
                    <c:set var="pimg" value="img_${o.PRODUCT_NUM}"/>
                    <c:set var="ptit" value="title_${o.PRODUCT_NUM}"/>
                    <c:set var="ppri" value="price_${o.PRODUCT_NUM}"/>
                    <c:set var="psto" value="stock_${o.PRODUCT_NUM}"/>
                    <c:set var="cait" value="cartItem_${o.PRODUCT_NUM}"/>
                    <tr>
                        <td rowspan="2" class="product_image"><img src="${pinfo.get(pimg)}" class="product_images"> </td>
                        <td class="product_title">${pinfo.get(ptit)}</td>
                        <td class="stock">????????????</td>
                    </tr>
                    <tr>
                        <td class="product_title">?????? : ${pinfo.get(ppri)}</td>
                        <td class="stock">${pinfo.get(psto)}</td>
                    </tr>
                    <input type="hidden" value="${o.PRODUCT_NUM}" class="product_num" name="product_num">
                    <input type="hidden" value="${pinfo.get(psto)}" class="payment_stock" name="payment_stock">
                    <input type="hidden" value="${pinfo.get(ppri)}" class="product_price" name="product_price">
                    <input type="hidden" value="${pinfo.get(cait)}" class="cartItem_num" name="cartItem_num">
                </c:forEach>
                <tr>
                    <td colspan="3" style="text-align: right; padding-right: 50px;">?????? ?????? : ${total_price}(????????? ??????)</td>
                    <input type="hidden" value="${total_price}" name="total_price">
                </tr>

            </table>
        </div>

        <div class="box">
            <h2>
                ????????? ??????
            </h2>
            <table>
                <tr>
                    <td class="fff">????????? ???</td>
                    <td class="eee">
                        <input type="text" value="${minfo.MEMBER_NAME}" size="20" id="member_name" name="member_name"/>
                    </td>
                </tr>
                <tr>
                    <td class="fff">?????????</td>
                    <td class="eee">
                        <select name="firstnum" size="1" id="firstnum">
                            <option value="010">010</option>
                            <option value="011">011</option>
                            <option value="013">013</option>
                            <option value="017">017</option>
                            <option value="018">018</option>
                        </select>-&nbsp;<input type="text" size="4" maxlength="4" minlength="4" name="secnum" id="secnum" value="${fn:split(minfo.MEMBER_PHONE,"-")[1]}">-
                        <input type="text" size="4" maxlength="4" minlength="4" name="thrnum" id="thrnum" value="${fn:split(minfo.MEMBER_PHONE,"-")[2]}">
                    </td>
                </tr>
                <tr>
                    <td class="fff">???????????????</td>
                    <td class="eee">
                        <input type="text" value="${fn:split(minfo.MEMBER_EMAIL,"@")[0]}" size="16" id="email1" name="email1"/> @
                        <input type="text" size="20" id="email2" value="${fn:split(minfo.MEMBER_EMAIL,"@")[1]}" name="email2"/>
                        <select name="emails" id="emails" size="1" onchange="emailchang()">
                            <option value="" selected>???????????????</option>
                            <option value="naver.com">naver.com</option>
                            <option value="hanmail.net">hanmail.net</option>
                            <option value="gmail.com">gmail.com</option>
                            <option value="nate.com">nate.com</option>
                            <option value="1">????????????</option>
                        </select>
                    </td>
                </tr>
            </table>
        </div>
        <div class="box">
            <h2>
                ????????? ??????
            </h2>
            <table>
                <tr>
                    <td colspan="2">
                        <input type="checkbox" id="checkboxs"/> ????????? ????????? ??????
                    </td>
                </tr>
                <tr>
                    <td class="fff">??????</td>
                    <td class="eee">
                        <input type="text" size="20" id="m_name" name="m_name"/>
                    </td>
                </tr>
                <tr>
                    <td class="fff">?????????</td>
                    <td class="eee">
                        <select name="firstnum2" size="1" id="firstnum2">
                            <option value="010">010</option>
                            <option value="011">011</option>
                            <option value="013">013</option>
                            <option value="017">017</option>
                            <option value="018">018</option>
                        </select> -&nbsp;<input type="text" size="4" maxlength="4" minlength="4" name="secnum2" id="secnum2">-
                        <input type="text" size="4" maxlength="4" minlength="4" name="thrnum2" id="thrnum2">
                    </td>
                </tr>
                <tr>
                    <td class="fff">??????</td>
                    <td class="eee">
                        <input type="text" id="sample6_postcode" placeholder="????????????" readonly name="sample6_postcode">
                        <input type="button" onclick="sample6_execDaumPostcode()" value="???????????? ??????"/><br/>
                        <input type="text" id="sample6_address" placeholder="??????" readonly name="sample6_address">
                        <input type="text" id="sample6_detailAddress" placeholder="????????????" name="sample6_detailAddress">
                    </td>
                </tr>
                <tr>
                    <td class="fff">????????????</td>
                    <td class="eee">
                        <select id="memo" name="memo" onchange="delivering()">
                            <option value="0" selected>????????? ??????????????? ????????? ?????????.</option>
                            <option value="1">?????? ?????????????????????.
                            </option>
                            <option value="2">?????? ??? ??????????????????.
                            </option>
                            <option value="3">?????? ??? ???????????? ???????????????.
                            </option>
                            <option value="4">?????? ??? ??? ?????? ???????????????.
                            </option>
                            <option value="5">?????? ??? ???????????? ???????????????.
                            </option>
                            <option value="6">?????? ??????</option>
                        </select>
                        <input type="hidden" placeholder="?????? 50??? ????????? ???????????????." id="delivery_info" name="delivery_info"/>
                    </td>
                </tr>
            </table>
        </div>
        <div>
            <button id="paybutton" type="submit"> ???????????? </button>
        </div>
    </form>
</div>
<footer>
    <%@include file="../../tags/footer.jsp" %>
</footer>
</body>
</html>