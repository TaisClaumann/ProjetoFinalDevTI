package com.devti.aulas.resouces;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.devti.aulas.model.Cidade;
import com.devti.aulas.model.Cliente;
import com.devti.aulas.services.ClienteService;

import io.swagger.annotations.ApiOperation;

@RestController
@RequestMapping("/cliente")
public class ClienteResource {
	
	@Autowired
	ClienteService service;
	
	@GetMapping
	@ApiOperation("Lista todos os clientes")
	public List<Cliente> listarTodos() {
		return service.listarTodos();
	}
	
	@PostMapping
	@ApiOperation("Insere um novo cliente")
	public void inserirCliente(@RequestBody Cliente c) {
		service.inserirCliente(c);
	}
	
	@PutMapping
	@ApiOperation("Altera um cliente")
	public Cliente alterarCliente(@RequestBody Cliente c, @RequestParam int id) {
		c.setId(id);
		return service.alterar(c);
	}
	
	@DeleteMapping("/{id}")
	@ApiOperation("Exclui um cliente do banco de dados")
	public void excluirCliente(@PathVariable("id") int id) {
		service.excluir(id);
	}
	
	@GetMapping("/sugest/{nome}")
	@ApiOperation("Busca um cliente de acordo com o que o usuário digita")
	public List<Cliente> buscarPorNomeCliente(@PathVariable("nome") String nome) {
		return service.buscarClientePorNome(nome);
	}
}
