package entities;


import lombok.Data;

import javax.persistence.*;
import java.math.BigDecimal;
import java.sql.Date;
import java.util.Set;

@Entity
@Data
public class Ticket {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int t_id;

    private long t_code;

    @OneToOne
    private Customer customer;

    @OneToMany(cascade = CascadeType.ALL, orphanRemoval = true)
    private Set<Indent> indents;

    private int t_status; // 1 ise ödendi 0 ise ödenmedi
    private int t_pay_method;
    private BigDecimal t_price;
    private Date t_date;

}
