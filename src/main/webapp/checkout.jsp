<%@ page import="utils.AuthUtil" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<% AuthUtil.checkLoggedIn(request, response, 0);%>

<!doctype html>
<html lang="en">

<head>
    <title>Kasa Yönetimi</title>
    <jsp:include page="inc/css.jsp"></jsp:include>
</head>

<body>
<div class="wrapper d-flex align-items-stretch">
    <jsp:include page="inc/sideBar.jsp"></jsp:include>
    <!-- Page Content  -->
    <div id="content" class="p-4 p-md-5">
        <jsp:include page="inc/topMenu.jsp"></jsp:include>
        <h3 class="mb-3">
            Kasa
            <small class="h6">Kasa Hareketleri</small>
        </h3>

        <div class="row">

            <div class="col-sm-4 mb-3">
                <div class="card cardBackground1" id="card">
                    <div class="card-body">
                        <div style="display: flex; justify-content: space-between;">
                            <h5 style="align-self: center;">Toplam Kasaya Giren</h5>
                            <h4 id="c_total_in"><strong>  </strong></h4>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-sm-4 mb-3">
                <div class="card cardBackground2" id="card">
                    <div class="card-body">
                        <div style="display: flex; justify-content: space-between;">
                            <h5 style="align-self: center;">Toplam Kasadan Çıkan</h5>
                            <h4 id="c_total_out"><strong>  </strong></h4>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-sm-4 mb-3">
                <div class="card cardBackground3" id="card">
                    <div class="card-body">
                        <div style="display: flex; justify-content: space-between;">
                            <h5 style="align-self: center;"> Kasada Kalan</h5>
                            <h4 id="c_total"><strong> </strong></h4>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-sm-4 mb-3">
                <div class="card cardBackground4" id="card">
                    <div class="card-body">
                        <div style="display: flex; justify-content: space-between;">
                            <h5 style="align-self: center;"> Bugün Kasaya Giriş</h5>
                            <h4 id="c_today_in"><strong> </strong></h4>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-sm-4 mb-3">
                <div class="card cardBackground4" id="card">
                    <div class="card-body">
                        <div style="display: flex; justify-content: space-between;">
                            <h5 style="align-self: center;"> Bugün Kasadan Çıkan</h5>
                            <h4 id="c_today_out"><strong> </strong></h4>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-sm-4 mb-3">
                <a href="payIn.jsp">
                    <div class="card cardBackground4" id="card">
                        <div class="card-body">
                            <div style="display: flex; justify-content: space-between;">
                                <h5 style="align-self: center;"> Kasa Yönetimi</h5>
                                <i class="fas fa-link fa-2x" style="color: white; align-self: center;"></i>
                            </div>
                        </div>
                    </div>
                </a>
            </div>



        </div>

        <div class="main-card mb-3 card mainCart">
            <div class="card-header cardHeader">Arama / Rapor</div>

            <form class="row p-3" id="checkout_form">

                <div class="col-md-3 mb-3">
                    <label for="cselect" class="form-label">Müşteri Seçiniz</label>
                    <select name="cselect" id="cselect" class="selectpicker" data-width="100%" data-show-subtext="true" data-live-search="true">
                        <option value="0" >Tümü</option>
                    </select>
                </div>
                <div class="col-md-3 mb-3">
                    <label for="type" class="form-label">Tür</label>
                    <select class="selectpicker" name="type" id="type" data-width="100%" data-show-subtext="true" data-live-search="true">
                        <option value="1">Giriş</option>
                        <option value="2">Çıkış</option>
                    </select>
                </div>

                <div class="col-md-3 mb-3">
                    <label for="startDate" class="form-label">Başlama Tarihi</label>
                    <input type="date" name="startDate" id="startDate" class="form-control" />
                </div>

                <div class="col-md-3 mb-3">
                    <label for="endDate" class="form-label">Bitiş Tarihi</label>
                    <input type="date" name="endDate" id="endDate" class="form-control" />
                </div>

                <div class="col-md-3">
                    <button type="submit" class="col btn btn-outline-primary">Listele</button>
                </div>
            </form>
        </div>

        <div class="main-card mb-3 card mainCart">
            <div class="card-header cardHeader">Arama Sonuçları</div>
            <div class="table-responsive">
                <table id="tCheckout" class="align-middle mb-0 table table-borderless table-striped table-hover">

                </table>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="checkOutModal" data-bs-backdrop="static" tabindex="-1" role="dialog" aria-labelledby="cu_name" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable modal-lg">
        <div class="modal-content" id="checkOutModalDiv">

            <div class="modal-footer">
                <button type="button" class="btn btn-primary" data-bs-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>

<jsp:include page="inc/js.jsp"></jsp:include>
<script src="js/checkout.js"></script>
</body>

</html>