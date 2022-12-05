package com.devti.aulas.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.devti.aulas.model.Cidade;
import com.devti.aulas.model.Cliente;
import com.devti.aulas.repositores.ClienteRepository;

@Service
public class ClienteService {
	
	@Autowired
	ClienteRepository rep;
	
	public Cliente inserirCliente(Cliente c) {
		return rep.save(c);
	}
	
	public Cliente alterar(Cliente c) {
		return rep.save(c);
	}
	
	public List<Cliente> listarTodos() {
		return rep.findAll();
	}
	
	public void excluir (Integer id) {
		Cliente clienteExcluir = rep.findById(id).get();
		if(clienteExcluir != null) {
			rep.delete(clienteExcluir);
		}
	}
	
	public List<Cliente> buscarClientePorNome(String nome) {
		return rep.findAllByNomeContainingOrCidadeNomeContaining(nome, nome);
	}
}
