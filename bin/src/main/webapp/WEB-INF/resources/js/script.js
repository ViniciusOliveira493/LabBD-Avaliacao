var tabela = document.getElementById("tbJogos");
var linhas = tabela.getElementsByTagName("tr");

for(var i = 0;i < linhas.length;i++){
	var linha = linhas[i];	
	linha.addEventListener("click",function(){	
		for(var j = 0;j<linhas.length;j++){		
			var linhaj = linhas[j];
			linhaj.classList.remove("selected");
		}
		this.classList.toggle("selected");
	});
}

var btnVer = document.getElementById("btnVisualizarJogo");
btnVer.addEventListener("click",function(){
	var itens = tabela.getElementsByClassName("selected");
	if(itens.length==1){
		var selected = itens[0];
		selected = selected.getElementsByTagName("td")
		
		var jogo = new Object();
		jogo.timeA = selected[0].innerHTML.trim();
		jogo.timeB = selected[2].innerHTML.trim();
		jogo.data = selected[5].innerHTML.trim();
		
		fetch("avaliacao1/jogos",{
			method:"POST",
			headers:{"Content-Type": "application/json"},
			body : JSON.stringify(jogo),
		});
	}
});