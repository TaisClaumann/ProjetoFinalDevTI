package com.devti.aulas.repositores;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.devti.aulas.model.Cidade;
import com.devti.aulas.model.Cliente;

public interface ClienteRepository extends JpaRepository<Cliente, Integer>{
	
	public List<Cliente> findAllByNomeContainingOrCidadeNomeContaining(String nome, String nomeCidade);

}
