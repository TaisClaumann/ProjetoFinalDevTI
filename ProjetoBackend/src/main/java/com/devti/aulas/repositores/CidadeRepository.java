package com.devti.aulas.repositores;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.devti.aulas.model.Cidade;

public interface CidadeRepository extends JpaRepository<Cidade, Integer> {
	
	public List<Cidade> findAllByNomeContainingOrUfContaining(String cidadeNome, String uf);

}
