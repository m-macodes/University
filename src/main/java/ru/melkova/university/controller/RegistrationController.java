package ru.melkova.university.controller;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import ru.melkova.university.data.form.RegistrationForm;
import ru.melkova.university.data.repository.RoleRepository;
import ru.melkova.university.data.repository.UserRepository;
import ru.melkova.university.service.YandexApiService;

@Controller
@RequestMapping("/register")
@Slf4j
@RequiredArgsConstructor
public class RegistrationController {
    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;
    private final RoleRepository roleRepository;
    private final YandexApiService yandexAPIService;
//    private final CountryRepository countryRepository;

    @GetMapping
    public String registerForm() {
        return "registration";
    }

    @PostMapping
    public String processRegistration(RegistrationForm form, Model model) {
//        if (userRepository.findUserByEmail(form.getEmail()).isPresent()) {
//            model.addAttribute("emailError", true);
//            return "registration";
//        }
//        if (!form.getPassword().equals(form.getConfirmPassword())) {
//            model.addAttribute("passwordError", true);
//            return "registration";
//        }
//        System.out.println(form.getAddress());
        System.out.println(yandexAPIService.getComponents("Томская область, Северск, улица Калинина, 50").block());
//        System.out.println(yandexAPIService.getAddressData(form.getAddress()));



//        User user = form.toUser(passwordEncoder);
//        System.out.println(form);

//        if (userRepository.findUserByEmail(user.getEmail()).isEmpty()) {
////            user.getAddress().setCountry(countryRepository.findCountryByName(form.getCountry()).get());
//            user.setRole(roleRepository.findByName("ENROLLEE").get());
//            userRepository.save(user);
//            log.info("User added " + user);
//        }
        return "redirect:/login";
    }
}
