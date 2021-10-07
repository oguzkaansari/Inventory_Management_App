package entities;

import lombok.Data;

import javax.persistence.*;
import java.math.BigDecimal;

@Entity
@Data
public class Indent {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int i_id;

    @OneToOne
    private Product product;

    private double i_amount;
    private BigDecimal i_price;

}
