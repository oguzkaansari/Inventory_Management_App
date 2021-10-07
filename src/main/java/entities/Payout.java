package entities;

import lombok.Data;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import java.math.BigDecimal;
import java.sql.Date;

@Entity
@Data
public class Payout {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int payout_id;

    private String payout_title;
    private int payout_pay_method;
    private BigDecimal payout_price;
    private String payout_detail;
    private Date payout_date;

}
