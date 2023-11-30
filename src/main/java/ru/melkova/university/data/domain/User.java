package ru.melkova.university.data.domain;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Collection;

@Entity
@Data
@Table(name = "users", schema = "public", catalog = "university")
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class User {
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Id
    @Column(name = "id")
    private int id;
    @Basic
    @Column(name = "email")
    private String email;
    @Basic
    @Column(name = "password")
    private String password;
    @Basic
    @Column(name = "name")
    private String name;
    @Basic
    @Column(name = "surname")
    private String surname;
    @Basic
    @Column(name = "patronymic")
    private String patronymic;
    @Basic
    @Column(name = "phone_number")
    private String phoneNumber;

    @ManyToOne
    @JoinColumn(name = "role", referencedColumnName = "id")
    private Role role;

//    @ManyToOne(cascade=CascadeType.ALL)
//    @JoinColumn(name = "address", referencedColumnName = "id", nullable = false)
//    private Address address;
}
