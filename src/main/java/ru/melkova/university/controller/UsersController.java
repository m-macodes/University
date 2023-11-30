package ru.melkova.university.controller;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
//import ru.melkova.university.service.UserService;

@Controller
@RequestMapping("/university")
@RequiredArgsConstructor
@Slf4j
public class UsersController {

//    private final UserService userService;

    @GetMapping("/users")
    public String getAllUsers(Model model) {
//        model.addAttribute("users", userService.getAllUsers());
        return "userList";
    }

    @GetMapping("/techers")
    public String getAllTeachers() {

        return "redirect:/";
    }

    @GetMapping("/students")
    public String getAllStudents() {

        return "redirect:/";
    }
}
