<%@ page import="utils.AuthUtil" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% AuthUtil.checkLoggedIn(request, response, 0);%>

<!doctype html>
<html lang="en">

<head>
    <title>Sipariş</title>
    <jsp:include page="inc/css.jsp"></jsp:include>
</head>

<body>
<div class="wrapper d-flex align-items-stretch">
    <jsp:include page="inc/sideBar.jsp"></jsp:include>
    <!-- Page Content  -->
    <div id="content" class="p-4 p-md-5">
        <jsp:include page="inc/topMenu.jsp"></jsp:include>
        <h3 class="mb-3">
            Satış Yap
            <small class="h6">Satış Yönetim Paneli</small>
        </h3>

        <div class="main-card mb-3 card mainCart">
            <div class="card-header cardHeader">Yeni Satış</div>

            <form class="row p-3" id="order_add_form">

                <div class="col-md-3 mb-3">
                    <label for="cselect" class="form-label">Müşteriler</label>
                    <select id="cselect" class="selectpicker" data-width="100%" data-show-subtext="true" data-live-search="true">
                        <option value="0" >Müşteri Seçin</option>

                    </select>
                </div>

                <div class="col-md-3 mb-3">
                    <label for="pselect" class="form-label">Ürünler</label>
                    <select id="pselect" class="selectpicker" data-width="100%" data-show-subtext="true" data-live-search="true">
                        <option value="0" >Ürün Seçin</option>

                    </select>
                </div>


                <div class="col-md-3 mb-3">
                    <label id="punit_label" for="punit" class="form-label">Birim</label>
                    <input type="number" min="1" name="punit" id="punit" class="form-control" required disabled/>
                </div>


                <div class="col-md-3 mb-3">
                    <label for="tcode" class="form-label"> Fiş No.</label>
                    <input type="number" name="tcode" id="tcode" class="form-control" readonly/>
                </div>

                <div class="btn-group col-md-3 " role="group">
                    <button type="submit" class="btn btn-outline-primary mr-1">Ekle</button>
                </div>
            </form>
        </div>


        <div class="main-card mb-3 card mainCart">
            <div class="card-header cardHeader">Sepet Ürünleri</div>


            <div class="table-responsive">
                <table id="tableOrder" class="align-middle mb-0 table table-borderless table-striped table-hover">
                    <thead>
                    <tr>
                        <th>Ürün</th>
                        <th>Miktar</th>
                        <th>Ücret</th>
                        <th>Fiş No</th>
                        <th>Durum</th>
                        <th class="text-center" style="width: 55px;" >Sil</th>
                    </tr>
                    </thead>
                    <tbody id="tBodyOrder">
                    <!-- for loop  -->

                    </tbody>
                </table>
            </div>
        </div>

        <div class="btn-group col-md-3 " role="group">
            <button onclick="saveOrder()" type="button" class="btn btn-outline-primary mr-1">Satışı Tamamla</button>
        </div>

    </div>
</div>

<jsp:include page="inc/js.jsp"></jsp:include>
<script src="js/order.js"></script>
</body>

</html>