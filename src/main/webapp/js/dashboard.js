function dashBoardInit() {

    $.ajax({
        url: './dashboard-get',
        type: 'GET',
        dataType: 'JSON',
        success: function (data) {

            $("#cu_count").text(data[0].cu_count);
            $("#i_count").text(data[0].i_count);
            $("#p_count").text(data[0].p_count);

        },
        error: function (err) {
            console.log(err)
        }
    })

}

function getCheckOut() {

    $.ajax({
        url: './checkout-get',
        type: 'GET',
        dataType: 'JSON',
        success: function (data) {

            $("#checkout_total").text(data[0].check_out_total);
            $("#checkout_today_in").text(data[0].check_out_today_in);
            $("#checkout_today_out").text(data[0].check_out_today_out);

        },
        error: function (err) {
            console.log(err)
        }
    })

}

dashBoardInit();
getCheckOut();

function allProducts() {

    $.ajax({
        url: './product-get',
        type: 'GET',
        dataType: 'JSON',
        success: function (data) {
            createProductRow(data);
        },
        error: function (err) {
            console.log(err)
        }
    })

}
function getTickets(cu_id){
    $.ajax({
        url: './ticket-get?cu_id='+cu_id,
        type: 'GET',
        dataType: 'JSON',
        success: function (data) {
            ticketArray = [];
            for(let i = 0; i < data.length; i++){
                if(data[i].t_status === 1){
                    ticketArray.push(data[i])
                }
            }
            createTicketRow(ticketArray);
        },
        error: function (err) {
            console.log(err);
        }
    })
}

allProducts();
for(let i = 5; i > 0; i--){
    getTickets(i);
}




function createProductRow( data ) {
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
          </tr>`;
    }
    $('#tBodyProductDashBoard').html(html);
}

function createTicketRow(data) {

    let html = ``;
    for (let i = 0; i < data.length; i++) {
        const itm = data[i];

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
          </tr>`;
    }

    $('#tBodyTicketDashBoard').html(html);
}
