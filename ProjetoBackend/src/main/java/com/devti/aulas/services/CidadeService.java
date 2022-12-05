package com.devti.aulas.services;

import java.util.List;
import java.util.Objects;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.devti.aulas.model.Cidade;
import com.devti.aulas.repositores.CidadeRepository;



@Service
public class CidadeService {
	
	@Autowired
	CidadeRepository rep;
	
	public Cidade incluirCidade(Cidade c) {
		return rep.save(c);
	}
	
	public List<Cidade> listarTodas() {
		return rep.findAll();
	}
	
	public Cidade alterar(Cidade c) {
		return rep.save(c);
	}
	
	public void excluir(Integer id) {
		Cidade cidadeExcluir = rep.findById(id).get();
		if(cidadeExcluir != null) {
			rep.delete(cidadeExcluir);
		}
	}
	
	public List<Cidade> buscarCidadePorNome(String cidadeNome) {
		return rep.findAllByNomeContainingOrUfContaining(cidadeNome, cidadeNome);
	}
} 
