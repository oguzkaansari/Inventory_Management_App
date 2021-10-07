package entities;

import lombok.Data;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import java.math.BigDecimal;

@Entity
@Data
public class Checkout {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int check_out_id;

    private BigDecimal check_out_total;
    private BigDecimal check_out_total_in;
    private BigDecimal check_out_total_out;
    private BigDecimal check_out_today_in;
    private BigDecimal check_out_today_out;

}
