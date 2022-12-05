package com.devti.aulas.resouces;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
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
import com.devti.aulas.services.CidadeService;

import io.swagger.annotations.ApiOperation;


@RestController
@RequestMapping("/cidade")
public class CidadeResource {
	
	@Autowired
	CidadeService service;
	
	@PostMapping
	@ApiOperation("Insere uma cidade")
	public void inserirCidade(@RequestBody Cidade c) {
		service.incluirCidade(c);
	}
	
	@PutMapping
	@ApiOperation("Altera uma cidade")
	public Cidade alterar(@RequestBody Cidade c, @RequestParam("id") int id) {
		c.setId(id);
		return service.alterar(c);
	}
	
	@DeleteMapping("/{id}")
	@ApiOperation("Exclui uma cidade do banco de dados")
	public void excluir(@PathVariable("id") int id) {
		service.excluir(id);
	}
	
	@GetMapping
	@ApiOperation("Lista todas as cidades")
	public List<Cidade> listarTodas() {
		return service.listarTodas();
	}
	
	@GetMapping("/sugest/{nome}")
	@ApiOperation("Busca uma cidade de acordo com o que o usuário digita")
	public List<Cidade> buscarPorNomeCidade(@PathVariable("nome") String cidadeNome) {
		return service.buscarCidadePorNome(cidadeNome);
	}
}
