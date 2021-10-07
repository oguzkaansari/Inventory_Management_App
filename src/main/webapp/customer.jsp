<%@ page import="utils.AuthUtil" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% AuthUtil.checkLoggedIn(request, response, 0);%>

<!doctype html>
<html lang="en">

<head>
  <title>Müşteri</title>
  <jsp:include page="inc/css.jsp"></jsp:include>
</head>

<body>
<div class="wrapper d-flex align-items-stretch">
  <jsp:include page="inc/sideBar.jsp"></jsp:include>
  <!-- Page Content  -->
  <div id="content" class="p-4 p-md-5">
    <jsp:include page="inc/topMenu.jsp"></jsp:include>

    <h3 class="mb-3">
      Müşteriler
      <small class="h6">Müşteri Paneli</small>
    </h3>

    <div class="main-card mb-3 card mainCart">
      <div class="card-header cardHeader">Müşteri Ekle</div>

      <form class="row p-3" id="customer_add_form">
        <div class="col-md-3 mb-3">
          <label for="cname" class="form-label">Adı</label>
          <input type="text" name="cname" id="cname" class="form-control" required/>
        </div>
        <div class="col-md-3 mb-3">
          <label for="csurname" class="form-label">Soyadı</label>
          <input type="text" name="csurname" id="csurname" class="form-control" required/>
        </div>
        <div class="col-md-3 mb-3">
          <label for="ctitle" class="form-label">Ünvan (Şirket)</label>
          <input type="text" name="ctitle" id="ctitle" class="form-control" />
        </div>
        <div class="col-md-3 mb-3">
          <label for="ccode" class="form-label">Müşteri Kodu</label>
          <input type="number" name="ccode" id="ccode" class="form-control" required/>
        </div>

        <div class="col-md-3 mb-3">
          <label for="ctype" class="form-label">Müşteri Türü</label>
          <select class="form-select" name="ctype" id="ctype" required>
            <option value="">Seçiniz</option>
            <option value="1">Kurumsal</option>
            <option value="2">Bireysel</option>
          </select>
        </div>

        <div class="col-md-3 mb-3">
          <label for="ctax" class="form-label">Vergi No / Tc No</label>
          <input type="number" name="ctax" id="ctax" class="form-control" required/>
        </div>

        <div class="col-md-3 mb-3">
          <label for="ctax_administration" class="form-label">Vergi Dairesi</label>
          <input type="text" name="ctax_administration" id="ctax_administration" class="form-control" />
        </div>

        <div class="col-md-3 mb-3">
          <label for="caddress" class="form-label">Adres</label>
          <input type="text" name="caddress" id="caddress" class="form-control" />
        </div>

        <div class="col-md-3 mb-3">
          <label for="cmobile_phone" class="form-label">Cep Telefonu</label>
          <input type="text" name="cmobile_phone" id="cmobile_phone" class="form-control" required/>
        </div>

        <div class="col-md-3 mb-3">
          <label for="cphone" class="form-label">Sabit Telefonu</label>
          <input type="text" name="cphone" id="cphone" class="form-control" />
        </div>

        <div class="col-md-3 mb-3">
          <label for="cemail" class="form-label">E-Mail</label>
          <input type="email" name="cemail" id="cemail" class="form-control" />
        </div>

        <div class="col-md-3 mb-3">
          <label for="cpassword" class="form-label">Şifre</label>
          <input type="password" name="cpassword" id="cpassword" class="form-control" />
        </div>

        <div class="btn-group col-md-3 " role="group">
          <button type="submit" class="btn btn-outline-primary mr-1">Gönder</button>
          <button onclick="fncReset()" type="button" class="btn btn-outline-primary">Temizle</button>
        </div>
      </form>
    </div>

    <div class="main-card mb-3 card mainCart">
      <div class="card-header cardHeader">Müşteri Listesi</div>

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
            <th>Ünvan</th>
            <th>Kod</th>
            <th>Türü</th>
            <th>Telefon</th>
            <th>Mail</th>
            <th class="text-center" style="width: 155px;" >Yönetim</th>
          </tr>
          </thead>
          <tbody id="tBodyCustomer">

          </tbody>
        </table>
      </div>
    </div>


  </div>
</div>


<!-- Modal -->
<div class="modal fade" id="customerDetailModal" data-bs-backdrop="static" tabindex="-1" role="dialog" aria-labelledby="cu_name" aria-hidden="true">
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
              <label><b>Müşteri Kodu</b></label>
              <h4 id="cu_code">---</h4>
            </div>

            <div class="col-sm-3 ml-auto">
              <label><b>Müşteri Türü</b></label>
              <h4 id="cu_status">---</h4>
            </div>

            <div class="col-sm-3 ml-auto">
              <label><b>Ünvan</b></label>
              <h4 id="cu_company_title">---</h4>
            </div>
          </div>
        <div class="row">
          <div class="col-sm-3 ml-auto">
            <label><b>Tel. No.</b></label>
            <h4 id="cu_mobile">---</h4>
          </div>

          <div class="col-sm-3 ml-auto">
            <label><b>Sabit No.</b></label>
            <h4 id="cu_phone">---</h4>
          </div>

          <div class="col-sm-3 ml-auto">
            <label><b>E-Posta</b></label>
            <h4 id="cu_email">---</h4>
          </div>
        </div>
        <div class="row">
          <div class="col-sm-3 ml-auto">
            <label><b>Vergi No / T.C. No</b></label>
            <h4 id="cu_tax_number">---</h4>
          </div>
          <div class="col-sm-3 ml-auto">
            <label><b>Vergi Dairesi</b></label>
            <h4 id="cu_tax_administration">---</h4>
          </div>
          <div class="col-sm-3 ml-auto">
            <label><b>Adres</b></label>
            <h4 id="cu_address">---</h4>
          </div>
        </div>

      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary" data-bs-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>

<jsp:include page="inc/js.jsp"></jsp:include>
<script src="js/customer.js"></script>
</body>

</html>