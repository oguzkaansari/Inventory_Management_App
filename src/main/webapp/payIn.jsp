<%@ page import="utils.AuthUtil" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% AuthUtil.checkLoggedIn(request, response, 0);%>


<!doctype html>
<html lang="en">

<head>
  <title>Kasa Yönetimi / Ödeme Girişi</title>
  <jsp:include page="inc/css.jsp"></jsp:include>
</head>

<body>

<div class="wrapper d-flex align-items-stretch">
  <jsp:include page="inc/sideBar.jsp"></jsp:include>
  <div id="content" class="p-4 p-md-5">
    <jsp:include page="inc/topMenu.jsp"></jsp:include>
    <h3 class="mb-3">
      <a href="payOut.jsp" class="btn btn-danger float-right">Ödeme Çıkışı</a>
      Kasa Yönetimi
      <small class="h6">Ödeme Girişi</small>
    </h3>


    <div class="main-card mb-3 card mainCart">
      <div class="card-header cardHeader">Ödeme Ekle</div>

      <form class="row p-3" id="ticket-pay-form">

        <div class="col-md-3 mb-3">
          <label for="cselect" class="form-label">Müşteriler</label>
          <select id="cselect" class="selectpicker" data-width="100%" data-show-subtext="true" data-live-search="true">
            <option value="0" >Müşteri Seçin</option>

          </select>
        </div>

        <div class="col-md-3 mb-3">
          <label for="tcode" class="form-label"> Fiş No.</label>
          <input type="number" name="tcode" id="tcode" class="form-control" readonly/>
        </div>

        <div class="col-md-3 mb-3">
          <label for="tprice" class="form-label">Ödeme Tutarı</label>
          <input type="number" name="tprice" id="tprice" class="form-control" readonly/>
        </div>
        <div class="col-md-3 mb-3">
          <label for="tpaymethod" class="form-label">Ödeme Türü</label>
          <select class="selectpicker" name="tpaymethod" id="tpaymethod" data-width="100%">
            <option value="0">Ödeme Türünü Seçiniz</option>
            <option value="1">Nakit</option>
            <option value="2">Kredi Kartı</option>
            <option value="3">Havale</option>
            <option value="4">EFT</option>
            <option value="5">Banka Çeki</option>
          </select>
        </div>




        <div class="btn-group col-md-3 " role="group">
          <button type="submit" class="btn btn-outline-primary mr-1">Ekle</button>
        </div>
      </form>
    </div>


    <div class="main-card mb-3 card mainCart">
      <div class="card-header cardHeader">Ödeme Giriş Listesi</div>

      <div class="row mt-3" style="padding-right: 15px; padding-left: 15px;">
        <div class="col-sm-3"></div>
        <div class="col-sm-3"></div>
        <div class="col-sm-3"></div>
        <div class="col-sm-3">
          <div class="input-group flex-nowrap">
            <span class="input-group-text" id="addon-wrapping"><i class="fas fa-search"></i></span>
            <input type="text" class="form-control" placeholder="Arama.." aria-label="Username" aria-describedby="addon-wrapping">
            <button class="btn btn-outline-primary">Ara</button>
          </div>
        </div>



      </div>
      <div class="table-responsive">
        <table class="align-middle mb-0 table table-borderless table-striped table-hover">
          <thead>
          <tr>
            <th>Id</th>
            <th>Adı</th>
            <th>Soyadı</th>
            <th>Fiş No</th>
            <th>Ödeme Tutarı</th>
            <th>Ödeme Türü</th>
            <th class="text-center" style="width: 155px;" >Yönetim</th>
          </tr>
          </thead>
          <tbody id="tBodyTicket">

          </tbody>
        </table>
      </div>
    </div>
    <div class="btn-group col-md-3 " role="group">
      <button onclick="payTicket()" type="button" class="btn btn-outline-primary mr-1">Ödemeyi Tamamla</button>
    </div>

  </div>
</div>

<div class="modal fade" id="payInModal" data-bs-backdrop="static" tabindex="-1" role="dialog" aria-labelledby="cu_name" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable modal-lg">
    <div class="modal-content" id="payInModalDiv">

      <div class="modal-footer">
        <button type="button" class="btn btn-primary" data-bs-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>

<jsp:include page="inc/js.jsp"></jsp:include>
<script src="js/payin.js"></script>

</body>

</html>

