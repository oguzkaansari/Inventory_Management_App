package entities;

import lombok.Data;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import java.math.BigDecimal;

@Entity
@Data
public class Dashboard {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int d_id;

    private int cu_count;
    private int i_count;
    private int p_count;

}
