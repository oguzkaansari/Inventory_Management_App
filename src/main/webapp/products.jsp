<%@ page import="utils.AuthUtil" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% AuthUtil.checkLoggedIn(request, response, 0);%>

<!doctype html>
<html lang="en">

<head>
  <title>Stok</title>
  <jsp:include page="inc/css.jsp"></jsp:include>
</head>

<body>
<div class="wrapper d-flex align-items-stretch">
  <jsp:include page="inc/sideBar.jsp"></jsp:include>
  <!-- Page Content  -->
  <div id="content" class="p-4 p-md-5">
    <jsp:include page="inc/topMenu.jsp"></jsp:include>
    <h3 class="mb-3">
      Ürünler
      <small class="h6">Ürün Paneli</small>
    </h3>

    <div class="main-card mb-3 card mainCart">
      <div class="card-header cardHeader">Ürün Ekle</div>

      <form class="row p-3" id="product_add_form">
        <div class="col-md-3 mb-3">
          <label for="ptitle" class="form-label">Başlık</label>
          <input type="text" name="ptitle" id="ptitle" class="form-control" />
        </div>
        <div class="col-md-3 mb-3">
          <label for="bprice" class="form-label">Alış Fiyatı</label>
          <input type="number" min="0" step="0.01" name="bprice" id="bprice" class="form-control" />
        </div>
        <div class="col-md-3 mb-3">
          <label for="sprice" class="form-label">Satış Fiyatı</label>
          <input type="number" min="0" step="0.01" name="sprice" id="sprice" class="form-control" />
        </div>
        <div class="col-md-3 mb-3">
          <label for="pcode" class="form-label">Ürün Kodu</label>
          <input type="number" name="pcode" id="pcode" class="form-control" />
        </div>


        <div class="col-md-3 mb-3">
          <label for="ptax" class="form-label">KDV</label>
          <select class="form-select" name="ptax" id="ptax">
            <option value="-1">Seçiniz</option>
            <option value="0">Dahil</option>
            <option value="1">%1</option>
            <option value="2">%8</option>
            <option value="3">%18</option>
          </select>
        </div>

        <div class="col-md-3 mb-3">
          <label for="punit" class="form-label">Birim</label>
          <select class="form-select" name="punit" id="punit">
            <option value="-1">Seçiniz</option>
            <option value="0">Adet</option>
            <option value="1">KG</option>
            <option value="2">Metre</option>
            <option value="3">Paket</option>
            <option value="4">Litre</option>
          </select>
        </div>

        <div class="col-md-3 mb-3">
          <label for="pstock" class="form-label">Miktar</label>
          <input type="number" name="pstock" id="pstock" class="form-control" />
        </div>

        <div class="col-md-3 mb-3">
          <label for="pdetail" class="form-label">Ürün Detay</label>
          <input type="text" name="pdetail" id="pdetail" class="form-control" />
        </div>


        <div class="btn-group col-md-3 " role="group">
          <button type="submit" class="btn btn-outline-primary mr-1">Gönder</button>
          <button onclick="fncReset()" type="button" class="btn btn-outline-primary">Temizle</button>
        </div>
      </form>
    </div>


    <div class="main-card mb-3 card mainCart">
      <div class="card-header cardHeader">Ürün Listesi</div>

      <div class="table-responsive">
        <table class="align-middle mb-0 table table-borderless table-striped table-hover">
          <thead>
          <tr>
            <th>Id</th>
            <th>Başlık</th>
            <th>Kod</th>
            <th>Alış Fiyatı</th>
            <th>Satış Fiyatı</th>
            <th>KDV</th>
            <th>Birim</th>
            <th>Stok</th>
            <th>Detay</th>
            <th class="text-center" style="width: 155px;" >Yönetim</th>
          </tr>
          </thead>
          <tbody id="tBodyProduct">

          </tbody>
        </table>
      </div>
    </div>

  </div>
</div>

<div class="modal fade" id="productDetailModal" data-bs-backdrop="static" tabindex="-1" role="dialog" aria-labelledby="p_title" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" style="color: black" id="cu_name">Modal title</h5>
        <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <div class="row">
          <div class="col-sm-3 ml-auto">
            <label><b>Ürün Başlığı</b></label>
            <h4 id="p_title">---</h4>
          </div>

          <div class="col-sm-3 ml-auto">
            <label><b>Ürün kodu</b></label>
            <h4 id="p_code">---</h4>
          </div>

          <div class="col-sm-3 ml-auto">
            <label><b>Alış Fiyatı</b></label>
            <h4 id="p_buy_price">---</h4>
          </div>
        </div>
        <div class="row">
          <div class="col-sm-3 ml-auto">
            <label><b>Satış Fiyatı</b></label>
            <h4 id="p_sell_price">---</h4>
          </div>

          <div class="col-sm-3 ml-auto">
            <label><b>KDV</b></label>
            <h4 id="p_tax">---</h4>
          </div>

          <div class="col-sm-3 ml-auto">
            <label><b>Birim</b></label>
            <h4 id="p_unit">---</h4>
          </div>
        </div>
        <div class="row">
          <div class="col-sm-3 ml-auto">
            <label><b>Stok Miktarı</b></label>
            <h4 id="p_stock">---</h4>
          </div>
          <div class="col-sm-3 ml-auto">
            <label><b>Ürün Detayı</b></label>
            <h4 id="p_detail">---</h4>
          </div>
          <div class="col-sm-3 ml-auto"></div>
        </div>

      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary" data-bs-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>


<jsp:include page="inc/js.jsp"></jsp:include>
<script src="js/product.js"></script>
</body>

</html>
