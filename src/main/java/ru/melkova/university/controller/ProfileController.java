package ru.melkova.university.controller;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import ru.melkova.university.service.UserService;

@Controller
@RequestMapping("/university/user")
@Slf4j
@RequiredArgsConstructor
public class ProfileController {

    private final UserService userService;

    @GetMapping("/{id}")
    public String userPage(Model model, @PathVariable String id) {
//        userService.getUserById(id).ifPresent(value -> model.addAttribute("user", value));
//        model.addAttribute();
        return "profile";
    }
}
