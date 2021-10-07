let globalCustomerArr = [];
let selectedCustomerId = 0;
let ticketData = {};
let ticketArr = [];
let saved = true;
let firsTime = true;

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

function getTicketData(cu_id) {
    $.ajax({
        url: './ticket-get?cu_id='+cu_id,
        type: 'GET',
        dataType: 'JSON',
        success: function (data) {

            if(jQuery.isEmptyObject(data)){
                fncFormReset();
                fncArrReset();
                alert("Seçtiðiniz müþteriye ait bir fiþ bulunamadý!");
                return;
                //createRow();
            }else{
                fncArrReset();

                for (let i = 0; i < data.length; i++){
                    if(data[i].t_status === 0){ // fiþ ödenmemiþse
                        ticketData = data[i];
                        ticketCode = data[i].t_code;
                        ticketPrice = data[i].t_price
                    }else{
                        ticketArr[i] = data[i];
                    }
                }
                if(jQuery.isEmptyObject(ticketData)){
                    alert("Müþterinin ödenmemiþ fiþi bulunmamaktadýr.");
                    fncArrReset();
                    fncFormReset();
                    return;
                }
                firsTime = false;
                createRow();
            }
            $("#tcode").val(ticketData.t_code);
            $("#tprice").val(ticketData.t_price);

        },
        error: function (err) {
            console.log(err);
        }
    })
}

$("#cselect").on('change', function () {
    if(!saved && !firsTime){
        let conf = confirm("Kaydedilmemiþ bir ödemeniz var. Kaydetmeden devam etmek istiyor musunuz!");
        if(!conf){
            $("#cselect").val(selectedCustomerId.toString());
            $("#cselect").selectpicker("refresh");
            return;
        }
    }
    selectedCustomerId = this.value;
    getTicketData(selectedCustomerId);

});

$("#tpaymethod").on('change', function () {
    ticketData.t_pay_method = this.value;
});

function createCustomerListBox(data) {

    let html = ``;
    for (let i = 0; i < data.length; i++) {
        const itm = data[i];
        html += `<option value="`+itm.cu_id+`" data-subtext="`+itm.cu_code+`">`+itm.cu_name+" "+itm.cu_surname+`</option>`;
    }
    $("#cselect").append(html);
    $("#cselect").selectpicker("refresh");
}

$("#ticket-pay-form").submit( ( event ) => {
    event.preventDefault();

    if(jQuery.isEmptyObject(ticketData)){
        alert("Lütfen müþteri seçin");
        return;
    }
    if(ticketData.t_pay_method === 0 || ticketData.t_pay_method === "0"){
        alert("Lütfen ödeme yöntemi seçin");
        return;
    }

    for(let i = 0; i < ticketArr.length; i++){
        if(ticketArr[i].t_id === ticketData.t_id){
            alert("Fiþ zaten eklenmiþ!");
            return;
        }
    }
    ticketArr.push(ticketData);
    saved = false;
    fncFormReset();
    createRow();
});


function createRow() {

    let html = ``;
    ticketArr = ticketArr.reverse();
    for(let i = 0; i < ticketArr.length; i++){
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
                        <td>`+p_method+`</td> `;

        let btnHtml = `<td class="text-center" >
                            <div class="btn-group" role="group" aria-label="Basic mixed styles example">
                                <button onclick="fncTicketDetail(`+i+`)" type="button" class="btn btn-outline-primary"><i class="far fa-file-alt"></i></button>                                
                            </div>
                        </td>                     
                    </tr>`;
        if(itm.t_status === 0){
            btnHtml = `<td class="text-center" >
                            <div class="btn-group" role="group" aria-label="Basic mixed styles example">
                                <button onclick="fncTicketDetail(`+i+`)" type="button" class="btn btn-outline-primary"><i class="far fa-file-alt"></i></button>                                
                                <button onclick="removeRow(`+i+`)" type="button" class="btn btn-outline-primary"><i class="far fa-trash-alt"></i></button>                                
                            </div>
                        </td>                     
                    </tr>`;
        }
        html += btnHtml;
    }
    $('#tBodyTicket').html(html);

}

function removeRow(index) {
    const revTicketArr = ticketArr.reverse();
    for( let i = 0; i < revTicketArr.length; i++){

        if ( i === index-1) {
            revTicketArr.splice(i, 1);
            createRow();
            saved = true;
            break;
        }
    }
}

function payTicket() {

    ticketData.t_status = 1;

    const date = new Date();
    ticketData.t_date = date.toISOString().slice(0, 10);

    $.ajax({
        url: './ticket-post',
        type: 'POST',
        data: { obj: JSON.stringify(ticketData)},
        dataType: 'JSON',
        success: function (data) {
            if ( data > 0 ) {
                alert("Ýþlem Baþarýlý");
                saved = true;
                fncFormReset();
                fncArrReset();
                getTicketData(selectedCustomerId);
            }else {
                alert("Ýþlem sýrasýnda hata oluþtu!");
            }
        },
        error: function (err) {
            console.log(err)
            alert("Ekleme iþlemi sýrasýnda bir hata oluþtu!");
        }
    });

}

function fncFormReset() {
    $('#ticket-pay-form').trigger("reset");
    $("#cselect").selectpicker("refresh");
    $("#tpaymethod").selectpicker("refresh");
}

function fncArrReset() {
    ticketData = {};
    ticketArr = [];
}



function fncTicketDetail(index) {

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
    $('#payInModalDiv').html(html);
    $('#payInModal').modal('toggle');

}
