package de.aformatik.dfdemo.server.repository

import de.aformatik.dfdemo.server.model.UserDao
import org.springframework.data.jpa.repository.JpaRepository

interface UserRepository : JpaRepository<UserDao, Long>