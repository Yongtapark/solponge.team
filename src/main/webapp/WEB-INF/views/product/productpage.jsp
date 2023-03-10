<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport"
          content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description"
          content="Start your development with Pigga landing page.">
    <meta name="author" content="Devcrud">
    <title>Home Shopping Site</title>
    <link rel="stylesheet" href="/css/hdcss.css">

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <style>
        #product_sale_info {
            margin: 0 auto;
            width: 1000px;
            /* height: 1000px; */
            /* border: solid 1px; */
        }

        #product_sale_info_left {
            width: 380px;
            margin-left: 55px;
            margin-right: 50px; /* reduce margin-right to 20px */
            margin-bottom: 30px;
            float: left;
        }

        #product_sale_info_left img {
            width: 380px;
            height: 519px;
        }
        #product_sale_info_right {
            width: 440px;
            padding-left: 20px; /* add padding-left to 20px */
            float: left; /* add float:left to align right */
            margin-bottom: 30px;
        }
        #product_sale_info_right td {
            padding: 10px;
            margin: 10px;
        }
        #quantity {
            float: left;
            padding-right: 40px;
        }
        #button_prt {
            margin: 30px;
        }
        #buy_button {
            margin-right: 10px;
            background-color: rgb(102, 153, 255);
            border-color: rgb(102, 153, 255);
            border-radius: 7%;
            border: none;
            width: 146px;
            height: 46px;
            color: rgb(256, 256, 256);
            font-size: 16px;
        }
        #cart_button {
            background-color: rgb(198, 217, 255);
            border-color: rgb(198, 217, 255);
            border-radius: 7%;
            border: none;
            width: 146px;
            height: 46px;
            font-size: 16px;
        }
        #product_details{
            margin: 30px;
            /*float: clear;*/
            clear: both;
        }
        .detail_tit {
            font-size: 28px;
            color: rgb(102, 153, 255);
        }
    </style>
    <script type="application/javascript">
        function count(type) {
            // ????????? ????????? element
            const resultElement = document.getElementById('quantity');
            // ?????? ?????? ?????? ??????

            const num1 = document.getElementById('remaining_stock');
            console.log(num1);
            // ?????? ????????? ????????? ???
            let number = parseInt(resultElement.innerText);
            let number2 = parseInt(num1.innerText);

            // ?????????/??????
            if (type === 'plus') {
                if (number == number2) {
                    number = parseInt(number);
                } else {
                    number = parseInt(number) + 1;
                }
            } else if (type === 'minus') {
                if (number == 1) {
                    number = parseInt(number);
                } else {
                    number = parseInt(number) - 1;
                }
            }
            // ?????? ??????
            resultElement.innerText = number;
            document.getElementById("quantityinput").value = number;

        }
        window.onload = function cal() {
            var today = new Date();
            var dayOfWeek = today.getDay(); // Sunday = 0, Saturday = 6
            if (dayOfWeek === 6) {
                // Saturday
                today.setDate(today.getDate() + 2); // Add 2 days to get to Monday
            } else if (dayOfWeek === 0) {
                // Sunday
                today.setDate(today.getDate() + 1); // Add 1 day to get to Monday
            }
            var date = today.getFullYear() + '-' + (today.getMonth() + 1) + '-' + today.getDate();
            var options = { month: 'long', day: 'numeric' };
            var formattedDate = today.toLocaleDateString('ko-KR', options);
            document.getElementById('date').innerHTML = formattedDate;

        };

        function addToCart() {
            // ????????? ?????? ??????
            var isLogin = <%= session.getAttribute("loginMember") != null %>;

            if(!isLogin) {
                alert("???????????? ???????????????!");
                location.href="/loginForm.jsp";
                return false;
            }

            // ??????????????? ???????????? ?????? ?????????
            alert("??????????????? ???????????????!");
        }
    </script>
</head>
<body data-spy="scroll" data-target=".navbar" data-offset="40" id="home">
<header>
    <%@include file="../../tags/header.jsp"%>
</header>
<div id="product_sale_info">
    <div id="product_sale_info_left">
        <img src="${productVo.product_img}" />
    </div>
    <form method="POST" action="/com.solponge/product/${productVo.product_num}">
        <div id="product_sale_info_right">
            <h3>${productVo.product_title}</h3>
            <hr />
            <table style="padding-left: 20px;">
                <tr>
                    <td>??????</td>
                    <td>${productVo.product_writer}</td>
                </tr>
                <tr>
                    <td>??????</td>
                    <td>${productVo.product_date}</td>
                </tr>
                <tr>
                    <td>?????????</td>
                    <td>${productVo.product_page}</td>
                </tr>
                <tr>
                    <td>??????</td>
                    <td>${productVo.product_price}???</td>
                </tr>
                <tr>
                    <td>?????????</td>
                    <td>2500???</td>
                </tr>
                <tr>
                    <td>??????</td>
                    <td id="remaining_stock">${productVo.product_stock}</td>
                </tr>
                <tr>
                    <td>??????</td>
                    <td>
                        <div id="quantity">1</div>
                        <%--                        <input type="hidden" name="quantityinput" value="1">--%>
                        <input type="hidden" id="quantityinput" name="quantityinput" value="1">
                        <input type="button" onclick='count("plus")' value="+" />
                        <input type="button" onclick='count("minus")' value="-" />
                    </td>
                </tr>
            </table>
            <script></script>
            <div id="button_prt">
                <c:if test="${productVo.product_stock==0}">
                    <button id="buy_button" type="submit" name="button1" value="Button 1" disabled>????????????</button>
                    <button id="cart_button" type="submit" name="button2" value="Button 2" onclick="addToCart()" disabled>???????????? ??????</button>
                </c:if>
                <c:if test="${productVo.product_stock!=0}">
                    <button id="buy_button" type="submit" name="button1" value="Button 1">????????????</button>
                    <button id="cart_button" type="submit" name="button2" value="Button 2" onclick="addToCart()">???????????? ??????</button>
                </c:if>
            </div>
        </div>
    </form>

    <div id="product_details">
        ${productVo.product_code}
    </div>
</div>
<%--sssss--%>

<footer>
    <%@include file="../../tags/footer.jsp" %>
</footer>
</body>
</html>