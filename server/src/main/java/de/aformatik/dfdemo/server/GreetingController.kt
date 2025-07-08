package de.aformatik.dfdemo.server

import de.aformatik.dfdemo.server.model.UserDao
import de.aformatik.dfdemo.server.repository.UserRepository
import org.springframework.web.bind.annotation.*

@RestController
@RequestMapping("/api/users")
class GreetingController(private val userRepository: UserRepository) {

    @GetMapping
    fun getAllUsers(): List<UserDao> = userRepository.findAll()

    @PostMapping
    fun createUser(@RequestBody user: UserDao): UserDao = userRepository.save(user)

    @GetMapping("/{id}")
    fun getUserById(@PathVariable id: Long): UserDao? = userRepository.findById(id).orElse(null)
}