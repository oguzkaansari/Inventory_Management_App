let select_id = 0;
$('#payout_add_form').submit( ( event ) => {
    event.preventDefault();

    const title = $("#payOutTitle").val();
    const method = $("#payOutType").val();
    const price = $("#payOutPrice").val();
    const detail = $("#payOutDetail").val();

    const base_date = new Date();
    const date = base_date.toISOString().slice(0, 10);


    const obj = {
        payout_title: title,
        payout_pay_method: method,
        payout_price: price,
        payout_detail: detail,
        payout_date: date
    }

    if ( select_id !== 0 ) {
        // update
        obj["payout_id"] = select_id;
    }
    $.ajax({
        url: './payout-post',
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
            alert("Ýþlem iþlemi sýrýsýnda bir hata oluþtu!");
        }
    })
})

function allPayouts() {

    $.ajax({
        url: './payout-get' ,
        type: 'GET',
        dataType: 'Json',
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
            <td>`+p_method+`</td>
            <td>`+itm.payout_price+`</td>
            <td>`+itm.payout_date+`</td>
            <td>`+itm.payout_detail+`</td>
            <td class="text-right" >
              <div class="btn-group" role="group" aria-label="Basic mixed styles example">
                <button onclick="fncPayoutDelete(`+itm.payout_id+`)" type="button" class="btn btn-outline-primary "><i class="far fa-trash-alt"></i></button>
                <button onclick="fncPayoutDetail(`+i+`)" data-bs-toggle="modal" data-bs-target="#payoutDetailModal" type="button" class="btn btn-outline-primary "><i class="far fa-file-alt"></i></button>
                <button onclick="fncPayoutUpdate(`+i+`)" type="button" class="btn btn-outline-primary "><i class="fas fa-pencil-alt"></i></button>
              </div>
            </td>
          </tr>`;
    }
    $('#tBodyPayout').html(html);
}

allPayouts();

function fncReset() {
    select_id = 0;
    $('#payout_add_form').trigger("reset");
    allPayouts();
}

function fncPayoutDelete( p_id ) {
    let answer = confirm("Silmek istediðinizden emin misniz?");
    if ( answer ) {

        $.ajax({
            url: './payout-delete?payout_id='+p_id,
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

function fncPayoutDetail(i){
    const itm = globalArr[i];
    $("#payOutTitleModal").text(itm.payout_title)
    $("#payOutTypeModal").text(itm.payout_pay_method)
    $("#payOutPriceModal").text(itm.payout_price)
    $("#payOutDetailsModal").text(itm.payout_detail)
}

function fncPayoutUpdate( i ) {
    const itm = globalArr[i];
    select_id = itm.p_id;
    $("#payOutTitle").val(itm.payout_title)
    $("#payOutType").val(itm.payout_pay_method)
    $("#payOutPrice").val(itm.payout_price)
    $("#payOutDetail").val(itm.payout_detail)

}
