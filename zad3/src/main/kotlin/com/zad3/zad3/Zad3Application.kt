package com.zad3.zad3

import org.springframework.beans.factory.annotation.Autowired
import org.springframework.boot.autoconfigure.SpringBootApplication
import org.springframework.boot.runApplication
import org.springframework.http.HttpStatus
import org.springframework.http.MediaType
import org.springframework.http.ResponseEntity
import org.springframework.stereotype.Component
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.PostMapping
import org.springframework.web.bind.annotation.RequestBody
import org.springframework.web.bind.annotation.RestController

@SpringBootApplication
class Zad3Application

fun main(args: Array<String>) {
	runApplication<Zad3Application>(*args)
}

@RestController
class AuthController
@Autowired constructor(
	private val authService: AuthService
)
{
	@PostMapping("/login", produces = [MediaType.TEXT_PLAIN_VALUE])
	fun login(@RequestBody loginForm: LoginForm): ResponseEntity<String> {
		return if(this.authService.login(loginForm.login, loginForm.password)) {
			ResponseEntity("Success!", HttpStatus.OK)
		} else {
			ResponseEntity("Auth error", HttpStatus.UNAUTHORIZED)
		}
	}

	@GetMapping("/logout")
	fun logout(): ResponseEntity<String> {
		return ResponseEntity("Success!", HttpStatus.OK)
	}
}

@Component("authService")
object AuthService {
	private val users = listOf(LoginForm("test", "test"))

	fun login(login: String, password: String): Boolean {
		return users.contains(LoginForm(login, password))
	}
}

data class LoginForm(val login: String, val password: String)