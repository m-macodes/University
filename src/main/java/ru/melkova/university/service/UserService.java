package ru.melkova.university.service;

import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import ru.melkova.university.data.domain.User;
import ru.melkova.university.data.repository.RoleRepository;
import ru.melkova.university.data.repository.UserRepository;

import java.util.Collections;
import java.util.Optional;
import java.util.Set;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class UserService implements UserDetailsService {
    private final UserRepository userRepository;
    private final RoleRepository roleRepository;

    public Optional<User> findUserByEmail(String email) {
        return userRepository.findUserByEmail(email);
    }

    @Override
    @Transactional
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        User user = findUserByEmail(username).orElseThrow(() -> new UsernameNotFoundException(
                String.format("Пользователь '%s' не найден", username)
        ));
        return new org.springframework.security.core.userdetails.User(
                user.getEmail(),
                user.getPassword(),
                Collections.singleton(new SimpleGrantedAuthority(user.getRole().getName()))
//                user.getRoles().stream().map(role -> new SimpleGrantedAuthority(role.getName())).collect(Collectors.toList())
        );
    }

    public Optional<User> getUserById(String id) {
        return userRepository.findById(Long.valueOf(id));
    }

    public Iterable<User> getAllUsers() {
        return userRepository.findAll();
    }

//    public Object getInfo(String id) {
//        User user = getUserById(id).get();
//        switch (user.getRole().getName()) {
//            case "STUDENT" : return
//        }
//    }

    public void createNewUser(User user) {
        user.setRole(roleRepository.findByName("STUDENT").get());
        userRepository.save(user);
    }
}
