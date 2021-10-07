package entities;

import lombok.Data;
import javax.persistence.*;
import java.math.BigDecimal;

@Entity
@Data
public class Product {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int p_id;

    private String p_title;
    private BigDecimal p_buy_price;
    private BigDecimal p_sell_price;
    private Long p_code;
    private double p_tax;
    private String p_unit;
    private double p_stock;
    private String p_detail;

}
