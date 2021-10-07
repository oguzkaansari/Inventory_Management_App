<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html lang="en">
<head>
    <title>Giriş</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="stylesheet" href="dist/css/bootstrap.min.css" />
    <link rel="stylesheet" href="css/fontawesome-free-5.15.4-web/css/all.min.css">
    <link href="https://fonts.googleapis.com/css?family=Roboto:300,400&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="css/login.css">
    <link rel="stylesheet" href="fonts/icomoon/style.css">
    <link rel="stylesheet" href="css/owl.carousel.min.css">
    <link rel="stylesheet" href="css/site.css">
</head>
<body>

<div class="content">
    <div class="container">
        <div class="row">
            <div class="col-md-6 order-md-2">
                <img src="images/undraw_file_sync_ot38.svg" alt="Image" class="img-fluid">
            </div>
            <div class="col-md-6 contents">
                <div class="row justify-content-center">
                    <div class="col-md-8">
                        <div class="mb-4">
                            <h3><b>Yönetici Girişi</b></h3>
                            <p class="mb-4">Depo ve Stok Yönetim uygulamasına giriş için bilgileri giriniz!</p>
                        </div>
                        <form id="login_form" method="post">
                            <div class="form-floating mb-3">
                                <input type="email" class="form-control" id="email" placeholder="E-Mail"/>
                                <label for="email">E-Mail</label>
                            </div>
                            <div class="form-floating mb-3">
                                <input type="password" class="form-control" id="password" placeholder="Şifre" />
                                <label for="password">Şifre</label>
                            </div>

                            <div class="d-flex mb-1 align-items-center">
                                <label class="control control--checkbox mb-0"><span class="caption">Beni Hatırla</span>
                                    <input type="checkbox" checked="checked" id="rememberMe"/>
                                    <div class="control__indicator"></div>
                                </label>
                            </div>

                            <div class="d-flex mb-4 align-items-center">
                                <div class="invalid-feedback" style="display: block;">
                                    <b id="loginerror" style="color: #a71d2a"></b>
                                </div>
                            </div>


                            <input type="submit" value="Giriş Yap" class="btn text-white btn-block btn-primary">

                        </form>



                    </div>
                </div>

            </div>

        </div>
    </div>
</div>

<!-- Login Modal -->


<jsp:include page="inc/js.jsp"></jsp:include>
<script src="js/login.js"></script>

</body>
</html>