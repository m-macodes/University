package ru.melkova.university.controller;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import ru.melkova.university.data.form.RegistrationForm;
import ru.melkova.university.data.repository.UserRepository;

@Controller
@RequestMapping("/register")
@Slf4j
@RequiredArgsConstructor
public class RegistrationController {
    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;
//    private final RoleRepository roleRepository;
//    private final CountryRepository countryRepository;

    @GetMapping
    public String registerForm() {
        return "registration";
    }

    @PostMapping
    public String processRegistration(RegistrationForm form) {
//        User user = form.toUser(passwordEncoder, roleRepository.findByName("STUDENT").get());
//        if (userRepository.findUserByEmail(user.getEmail()).isEmpty()) {
//            user.getAddress().setCountry(countryRepository.findCountryByName(form.getCountry()).get());
//            user.setRole(roleRepository.findByName("STUDENT").get());
//            userRepository.save(user);
//            log.info("User added " + user);
//        }
        return "redirect:/login";
    }
}
