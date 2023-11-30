package ru.melkova.university.data.form;

import lombok.Data;
import org.springframework.security.crypto.password.PasswordEncoder;
import ru.melkova.university.data.domain.User;

@Data
public class RegistrationForm {

    private String email;
    private String password;
    private String name;
    private String surname;
    private String patronymic;
    private String phoneNumber;
    private String country;
    private String city;
    private String street;
    private String buildingNumber;
    private String apartmentNumber;

    public User toUser(PasswordEncoder passwordEncoder) {
//        Address address = Address.builder()
//                .city(city)
//                .street(street)
//                .buildingNumber(buildingNumber)
//                .apartmentNumber(apartmentNumber)
//                .build();
        return User.builder()
                .email(email)
                .password(passwordEncoder.encode(password))
                .name(name)
                .surname(surname)
                .patronymic(patronymic)
                .phoneNumber(phoneNumber)
//                .address(address)
                .build();
    }
}
