let select_id = 0
$('#product_add_form').submit( ( event ) => {
    event.preventDefault();

    const title = $("#ptitle").val()
    const bprice = $("#bprice").val()
    const sprice = $("#sprice").val()
    const code = $("#pcode").val()
    const tax = $("#ptax").val()
    const unit = $("#punit option:selected").text()
    const stock = $("#pstock").val()
    const detail = $("#pdetail").val()

    const obj = {
        p_title: title,
        p_buy_price: bprice,
        p_sell_price: sprice,
        p_code: code,
        p_tax: tax,
        p_unit: unit,
        p_stock: stock,
        p_detail: detail,
    }

    if ( select_id !== 0 ) {
        // update
        obj["p_id"] = select_id;
    }
    $.ajax({
        url: './product-post',
        type: 'POST',
        data: { obj: JSON.stringify(obj) },
        dataType: 'JSON',
        success: function (data) {
            if ( data > 0 ) {
                alert("Ýþlem Baþarýlý")
                fncReset();
            }else {
                alert("Ýþlem sýrasýnda hata oluþtu!");
            }
        },
        error: function (err) {
            console.log(err)
            alert("Ekleme iþlemi sýrasýnda bir hata oluþtu!");
        }
    })


})

function allProducts() {

    $.ajax({
        url: './product-get',
        type: 'GET',
        dataType: 'JSON',
        success: function (data) {
            createRow(data);
        },
        error: function (err) {
            console.log(err)
        }
    })

}

let globalArr = []
function createRow( data ) {
    globalArr = data;
    let html = ``;
    for (let i = 0; i < data.length; i++) {
        const itm = data[i];
        html += `<tr role="row" class="odd">
            <td>`+itm.p_id+`</td>
            <td>`+itm.p_title+`</td>
            <td>`+itm.p_code+`</td>
            <td>`+itm.p_buy_price+`</td>
            <td>`+itm.p_sell_price+`</td>
            <td>`+itm.p_tax+`</td>
            <td>`+itm.p_unit+`</td>
            <td>`+itm.p_stock+`</td>
            <td>`+itm.p_detail+`</td>

            <td class="text-right" >
              <div class="btn-group" role="group" aria-label="Basic mixed styles example">
                <button onclick="fncProductDelete(`+itm.p_id+`)" type="button" class="btn btn-outline-primary "><i class="far fa-trash-alt"></i></button>
                <button onclick="fncProductDetail(`+i+`)" data-bs-toggle="modal" data-bs-target="#productDetailModal" type="button" class="btn btn-outline-primary "><i class="far fa-file-alt"></i></button>
                <button onclick="fncProductUpdate(`+i+`)" type="button" class="btn btn-outline-primary "><i class="fas fa-pencil-alt"></i></button>
              </div>
            </td>
          </tr>`;
    }
    $('#tBodyProduct').html(html);
}

function codeGenerator() {
    const date = new Date();
    const time = date.getTime();
    const key = time.toString().substring(4);
    $('#pcode').val( key )
}
allProducts();

function fncReset() {
    select_id = 0;
    $('#product_add_form').trigger("reset");
    codeGenerator();
    allProducts();
}

function fncProductDelete( p_id ) {
    let answer = confirm("Silmek istediðinizden emin misniz?");
    if ( answer ) {

        $.ajax({
            url: './product-delete?p_id='+p_id,
            type: 'DELETE',
            dataType: 'text',
            success: function (data) {
                if ( data !== "0" ) {
                    fncReset();
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

function fncProductDetail(i){
    const itm = globalArr[i];
    $("#p_title").text(itm.p_title + " - " + itm.p_id); //item içindeki cu_namei jspde cu_name e atar
    $("#p_buy_price").text(itm.p_buy_price);
    $("#p_sell_price").text(itm.p_sell_price);
    $("#p_code").text(itm.p_code);
    $("#p_tax").text(itm.p_tax);
    $("#p_unit").text(itm.p_unit);
    $("#p_stock").text(itm.p_stock);
    $("#p_detail").text(itm.p_detail);
}

function fncProductUpdate( i ) {
    const itm = globalArr[i];
    select_id = itm.p_id;
    $("#ptitle").val(itm.p_title)
    $("#bprice").val(itm.p_buy_price)
    $("#sprice").val(itm.p_sell_price)
    $("#pcode").val(itm.p_code)
    $("#ptax").val(itm.p_tax)
    $("#punit").val(itm.p_unit)
    $("#pstock").val(itm.p_stock)
    $("#pdetail").val(itm.p_detail)

}
