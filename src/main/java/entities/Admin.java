package entities;

import lombok.Data;

import javax.persistence.*;

@Entity
@Data
public class Admin {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int a_id;

    @Column(unique = true)
    private String email;

    private String password;
    private boolean remember_me;
}
