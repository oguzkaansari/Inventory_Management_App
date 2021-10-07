let globalCustomerArr = [];
let globalProductArr = [];
let selectedCustomerId = 0;
let selectedProduct;
let selectedCustomer;
let ticketData = {}
let indentArr = [];
let ticketCode;
let ticketPrice = 0;
let isDataExist; // true :  Fiþ var ama ödenmemiþ fiþ yok.

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

function getProducts() {

    if(globalProductArr.length === 0){
        $.ajax({
            url: './product-get',
            type: 'GET',
            dataType: 'JSON',
            success: function (data) {
                globalProductArr = data;
                createProductListBox(data);
            },
            error: function (err) {
                console.log(err)
            }
        })
    }else {
        createProductListBox(globalProductArr);
    }

}

getCustomers();
getProducts();

function getTicketData(cu_id) {
    $.ajax({
        url: './ticket-get?cu_id='+cu_id,
        type: 'GET',
        dataType: 'JSON',
        success: function (data) {

            if(jQuery.isEmptyObject(data)){
                ticketCode = codeGenerator();
                indentArr = [];
                ticketData = {};
                createRow();
            }else{
                selectedCustomer = data[0].customer;
                for (let i = 0; i < data.length; i++){
                    if(data[i].t_status === 0){ // fiþ ödenmemiþse
                        ticketData = data[i];
                        ticketCode = ticketData.t_code;
                        ticketPrice = parseInt(ticketData.t_price);
                    }
                }
                if(jQuery.isEmptyObject(ticketData)){
                    ticketCode = codeGenerator();
                    indentArr = [];
                }else{
                    indentArr = ticketData.indents;
                }
                isDataExist = true;
                createRow();
            }
            $("#tcode").val(ticketCode);

        },
        error: function (err) {
            console.log(err);
        }
    })
}

$("#cselect").on('change', function () {
    selectedCustomerId = this.value;
    ticketData = [];
    getTicketData(selectedCustomerId);
});

$("#pselect").on('change', function () {
    const selectedProductId = this.value;

    for(let i = 0; i < globalProductArr.length; i++){
        const product = globalProductArr[i];
        if(product.p_id === parseInt(selectedProductId)){
            $("#punit_label").text(product.p_unit);
            selectedProduct = product;
            $( "#punit" ).prop( "disabled", false );
        }
    }

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

function createProductListBox(data) {

    let html = ``;
    for (let i = 0; i < data.length; i++) {
        const itm = data[i];
        html += `<option value="`+itm.p_id+`" data-subtext="`+itm.p_code+`">`+itm.p_title+`</option>`;
    }
    $('#pselect').append(html);
    $("#pselect").selectpicker("refresh");
}

$('#order_add_form').submit( ( event ) => {
    event.preventDefault();

    const amount = $("#punit").val();
    if(ticketData === []){
        alert("Lütfen müþteri seçin");
        return;
    }
    if(jQuery.isEmptyObject(selectedProduct)){
        alert("Lütfen ürün seçin");
        return;
    }
    if(amount > selectedProduct.p_stock){
        alert("Yeterli stok yok!");
        return;
    }
    //selectedProduct.p_stock -= amount;
    let indentData = {
        product: selectedProduct,
        i_amount: amount,
        i_price: selectedProduct.p_sell_price * amount
    };
    ticketPrice += indentData.i_price;
    indentArr.push(indentData);
    fncReset();
    createRow();
})

function saveOrder() {

        let obj = {
        t_code: ticketCode,
        customer: selectedCustomer,
        indents: indentArr,
        t_status: 0,
        t_pay_method: 0,
        t_price: ticketPrice,
        t_date: "1111-11-11"
    }
    if(!jQuery.isEmptyObject(ticketData)){
        obj["t_id"] = ticketData.t_id;
    }

    $.ajax({
        url: './ticket-post',
        type: 'POST',
        data: { obj: JSON.stringify(obj)},
        dataType: 'JSON',
        success: function (data) {
            if ( data > 0 ) {
                alert("Ýþlem Baþarýlý");
                fncReset();
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

function codeGenerator() {
    const date = new Date();
    const time = date.getTime();
    return time.toString().substring(4);
}

function fncReset() {
    //$('#order_add_form').trigger("reset");
    $('#punit').trigger("reset");
    $("#pselect").selectpicker("refresh");

}

function createRow() {

    let html = ``;

    for(let i = 0; i < indentArr.length; i++){
        const itm = indentArr[i];
        let id = 0;
        let state;
        if(!itm.i_id){
            state = "Eklenmedi";
        }else{
            state = "Eklendi";
            id = itm.i_id;
        }

        html += `<tr role="row" class="odd">
                        <td>`+itm.product.p_title+`</td>
                        <td>`+itm.i_amount+`</td>
                        <td>`+itm.i_price+`</td>
                        <td>`+ticketCode+`</td>
                        <td>`+state+`</td>
                        <td class="text-right" >
                            <div class="btn-group" role="group" aria-label="Basic mixed styles example">
                                <button onclick="deleteOrder(`+id+`, this.parentNode.parentNode.parentNode)" type="button" class="btn btn-outline-primary "><i class="far fa-trash-alt"></i></button>
                            </div>
                        </td>
                    </tr>`;

    }
    $('#tBodyOrder').html(html);

}
function deleteOrder(i_id, tr) {

    if(i_id === 0){
        removeRow(tr.rowIndex);
    }else{
        let answer = confirm("Silmek istediðinizden emin misiniz?");
        if(answer){
            $.ajax({
                url: './ticket-order-delete?t_id='+ticketData.t_id + `&i_id=`+i_id,
                type: 'DELETE',
                dataType: 'text',
                success: function (data) {
                    if ( data !== "0" ) {
                        //getTicketData(selectedCustomerId);
                        fncReset();
                        removeRow(tr.rowIndex);
                        createRow();
                    }else {
                        alert("Silme sýrasýnda bir hata oluþtu!");
                    }
                },
                error: function (err) {
                    console.log(err)
                }
            })
        }
    }


}

function removeRow(index) {
    for( let i = 0; i < indentArr.length; i++){

        if ( i === index-1) {
            ticketPrice -= parseInt(indentArr[i].i_price);
            indentArr.splice(i, 1);
            createRow();
            break;
        }
    }
}
