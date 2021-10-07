let globalCustomerArr = [];
let selectedCustomerId = 0;
let ticketArr = [];
let payoutArr = [];
let type;

function checkOutInit() {

    $.ajax({
        url: './checkout-get',
        type: 'GET',
        dataType: 'JSON',
        success: function (data) {

            $("#c_total_in").text(data[0].check_out_total_in);
            $("#c_total_out").text(data[0].check_out_total_out);
            $("#c_total").text(data[0].check_out_total.toString());
            $("#c_today_in").text(data[0].check_out_today_in);
            $("#c_today_out").text(data[0].check_out_today_out);

        },
        error: function (err) {
            console.log(err)
        }
    })
}
checkOutInit();

function getCustomers() {

    if(globalCustomerArr.length === 0){
        $.ajax({
            url: './customer-get',
            type: 'GET',
            dataType: 'JSON',
            success: function (data) {
                globalCustomerArr = data;
                createCustomerListBox(data);
            },
            error: function (err) {
                console.log(err)
            }
        })
    }else {
        createCustomerListBox(globalCustomerArr);
    }
}
getCustomers();
function createCustomerListBox(data) {

    let html = ``;
    for (let i = 0; i < data.length; i++) {
        const itm = data[i];
        html += `<option value="`+itm.cu_id+`" data-subtext="`+itm.cu_code+`">`+itm.cu_name+" "+itm.cu_surname+`</option>`;
    }
    $("#cselect").append(html);
    $("#cselect").selectpicker("refresh");

}

$("#cselect").on('change', function () {
    selectedCustomerId = this.value;
    $("#type").val("1");
    $("#type").prop('disabled', true);
    $("#type").selectpicker("refresh");
    type = parseInt("1");
});

$("#type").on('change', function () {
    if(this.value === "2"){
        $("#cselect").val("0");
        $("#cselect").prop('disabled', true);
        type = parseInt("2");
    }
    if(this.value === "1"){
        $("#cselect").prop('disabled', false);
        type = parseInt("1");
    }
    $("#cselect").selectpicker("refresh");

});

function getTicketData(cu_id) {

    $.ajax({
        url: './ticket-get?cu_id='+cu_id,
        type: 'GET',
        dataType: 'JSON',
        success: function (data) {
            for (let i = 0; i < data.length; i++){
                if(data[i].t_status === 1){ // fiþ ödenmemiþse
                    ticketArr[i] = data[i];
                }
            }
        },
        error: function (err) {
            console.log(err);
        }
    })
}

function getPayouts() {

    $.ajax({
        url: './payout-get',
        type: 'GET',
        dataType: 'Json',
        success: function (data) {
            payoutArr = data;
        },
        error: function (err) {
            console.log(err)
        }
    })

}

function createTable() {

        if(type === 1){ // giriþ kayýtlarý
            let html = `<thead>
                      <tr>
                        <th>Id</th>
                        <th>Adý</th>
                        <th>Soyadý</th>
                        <th>Fiþ No</th>
                        <th>Ödeme Tutarý</th>
                        <th>Ödeme Türü</th>
                        <th class="text-center" style="width: 155px;" >Detay</th>
                      </tr>
                      </thead>
                      <tbody>`;
            for(let i = 0; i < ticketArr.length; i++) {
                const itm = ticketArr[i];
                let p_method;
                switch (parseInt(itm.t_pay_method)) {
                    case 1:
                        p_method = "Nakit";
                        break;
                    case 2:
                        p_method = "Kredi Kartý";
                        break;
                    case 3:
                        p_method = "Havale";
                        break;
                    case 4:
                        p_method = "EFT";
                        break;
                    case 5:
                        p_method = "Banka Çeki";
                        break;
                }

                html += `<tr role="row" class="odd">
                        <td>`+itm.t_id+`</td>
                        <td>`+itm.customer.cu_name+`</td>
                        <td>`+itm.customer.cu_surname+`</td>
                        <td>`+itm.t_code+`</td>
                        <td>`+itm.t_price+`</td>
                        <td>`+p_method+`</td>
                        <td class="text-center" >
                            <div class="btn-group" role="group" aria-label="Basic mixed styles example">
                                <button onclick="createModel(`+i+`, 1)" type="button" class="btn btn-outline-primary"><i class="far fa-file-alt"></i></button>                                
                            </div>
                        </td>  
                    </tr>`;
            }
            html += `</tbody>`;
            $('#tCheckout').html(html);
        }

        if(type === 2){ // çýkýþ kayýtlarý

            let html = `<thead>
                  <tr>
                    <th>Id</th>
                    <th>Baþlýk</th>
                    <th>Ödeme Türü</th>
                    <th>Ödeme Tutarý</th>
                    <th>Ödeme Tarihi</th>
                    <th>Ödeme Detayý</th>
        
                    <th class="text-center" style="width: 155px;" >Detay</th>
                  </tr>
                  </thead>
                  <tbody>`;


            for(let i = 0; i < payoutArr.length; i++) {
                const itm = payoutArr[i];
                let p_method;
                switch (parseInt(itm.payout_pay_method)) {
                    case 1:
                        p_method = "Nakit";
                        break;
                    case 2:
                        p_method = "Kredi Kartý";
                        break;
                    case 3:
                        p_method = "Havale";
                        break;
                    case 4:
                        p_method = "EFT";
                        break;
                    case 5:
                        p_method = "Banka Çeki";
                        break;
                }

                html += `<tr role="row" class="odd">
                        <td>`+itm.payout_id+`</td>
                        <td>`+itm.payout_title+`</td>
                        <td>`+p_method.toString()+`</td>
                        <td>`+itm.payout_price+`</td>
                        <td>`+itm.payout_date+`</td>
                        <td>`+itm.payout_detail+`</td>
                        <td class="text-right" >
                          <div class="btn-group" role="group" aria-label="Basic mixed styles example">
                            <button onclick="createModel(`+i+`, 2)" type="button" class="btn btn-outline-primary "><i class="far fa-file-alt"></i></button>
                          </div>
                        </td>
                    </tr>`;

            }
            html += `</tbody>`;
            $('#tCheckout').html(html);
        }
}

function createModel(index, typ) {

    if(typ === 1){

        const ticket = ticketArr[index];
        
        let html = ``;
        html += `<div class="modal-header">
                    <h5 class="modal-title" style="color: black">Fiþ bilgisi</h5>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
               <div class="modal-body">
                <div class="row">
                    <div class="col-sm-3 ml-auto">
                        <label><b>Fiþ No.</b></label>
                        <h4>`+ticket.t_code+`</h4>
                    </div>

                    <div class="col-sm-3 ml-auto">
                        <label><b>Müþteri Adý</b></label>
                        <h4>`+ticket.customer.cu_name + " " + ticket.customer.cu_surname+`</h4>
                    </div>

                    <div class="col-sm-3 ml-auto">
                        <label><b>Tutar</b></label>
                        <h4>`+ticket.t_price+`</h4>
                    </div>
                </div>
                <div class="row">
                    <div class="table-responsive">
                        <table class="align-middle mb-0 table table-borderless table-striped table-hover">
                          <thead>
                          <tr>
                            <th>Baþlýk</th>
                            <th>Miktar</th>
                            <th>Ücret</th>
                          </tr>
                          </thead>
                          <tbody>`;


        for(let i = 0; i < ticket.indents.length; i++) {
            const indent = ticket.indents[i];
            let p_method;
            switch (parseInt(ticket.t_pay_method)) {
                case 1:
                    p_method = "Nakit";
                    break;
                case 2:
                    p_method = "Kredi Kartý";
                    break;
                case 3:
                    p_method = "Havale";
                    break;
                case 4:
                    p_method = "EFT";
                    break;
                case 5:
                    p_method = "Banka Çeki";
                    break;
            }

            html += ` <tr role="row" class="odd">
                        <td>`+indent.product.p_title+`</td>
                        <td>`+indent.i_amount+`</td>
                        <td>`+indent.i_price+`</td>
                    </tr>`;
        }
        html += `</tbody></table></div></div></div>`;
        $('#checkOutModalDiv').html(html);
    }

    if(typ === 2){

        const payout = payoutArr[index];
        let p_method;
        switch (parseInt(payout.payout_pay_method)) {
            case 1:
                p_method = "Nakit";
                break;
            case 2:
                p_method = "Kredi Kartý";
                break;
            case 3:
                p_method = "Havale";
                break;
            case 4:
                p_method = "EFT";
                break;
            case 5:
                p_method = "Banka Çeki";
                break;
        }
        let html = `<div class="modal-header">
                    <h5 class="modal-title" style="color: black">Fiþ bilgisi</h5>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
               <div class="modal-body">
                    <div class="row">
                      <div class="col-sm-3 ml-auto">
                        <label><b>Baþlýk</b></label>
                        <h4>`+payout.payout_title+`</h4>
                      </div>
            
                      <div class="col-sm-3 ml-auto">
                        <label><b>Ödeme Türü</b></label>
                        <h4>`+payout.payout_pay_method+`</h4>
                      </div>
            
                      <div class="col-sm-3 ml-auto">
                        <label><b>Ücret</b></label>
                        <h4>`+payout.payout_price+`</h4>
                      </div>                    
                    </div>
                    <div class="row">
                      <div class="col-sm-4"></div>
                      <div class="col-sm-4 ml-auto">
                        <label><b>Detay</b></label>
                        <h4>`+payout.payout_detail+`</h4>
                      </div>
                      <div class="col-sm-4"></div>
                    </div>
               </div>`;

        $('#checkOutModalDiv').html(html);
    }
    $('#checkOutModal').modal('toggle');

}

$("#checkout_form").submit( ( event ) => {
    event.preventDefault();

    const startDate = $("#startDate").val();
    const endDate = $("#endDate").val();
    if(type === 1){
        getTicketData(selectedCustomerId);
    }
    if(type === 2){
        getPayouts();
    }
    createTable();
    $("#cselect").val("0");
    $("#type").val("1");
    $("#cselect").prop('disabled', false);
    $("#type").prop('disabled', false);
    $("#cselect").selectpicker("refresh");
    $("#type").selectpicker("refresh");

});
