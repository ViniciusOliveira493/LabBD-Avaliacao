var jogos = document.cookie
var jogo = JSON.parse(getCookie("jogo"));

var txtTimeA = document.getElementById("txtTimeA");
var txtTimeB = document.getElementById("txtTimeB");
var golsA = document.getElementById("txtGolsTimeA");
var golsB = document.getElementById("txtGolsTimeB");
var data = document.getElementById("txtDataJogo");
var btn = document.getElementById("btnAtualizar");

txtTimeA.value = jogo.timeA;
txtTimeB.value = jogo.timeB;
golsA.value = jogo.GolsA;
golsB.value = jogo.GolsB;
data.value = parseDateFromDMYToYMD(jogo.data)

txtTimeA.readOnly = true;
txtTimeB.readOnly = true;
data.readOnly = true;

btn.addEventListener("click",function(){
	var jogo = new Object();
	jogo.timeA = txtTimeA.value;
	jogo.timeB = txtTimeB.value;
	jogo.golsA = golsA.value;
	jogo.golsB = golsB.value;
	jogo.data = data.value;
	
	var json = JSON.stringify(jogo);
	fetch("jogos",{
		method:"PUT",
		headers:{"Content-Type": "application/json"},
		body:json,
	});
});
//deleteCookie("jogo");


function deleteCookie(name){
	document.cookie = name+ "=" + "" + ";expires="+new Date()+";path=/";
}

//W3Schools
function getCookie(name) {
  let cookie = {};
  document.cookie.split(';').forEach(function(el) {
    let [key,value] = el.split('=');
    cookie[key.trim()] = value;
  })
  return cookie[name];
}

function parseDateFromDMYToYMD(date){
	var split = date.split("/");
	var data = "";
	for(var i = split.length-1;i>-1;i--){
		data+=split[i];
		if(i>0){
			data+="-";
		}
	}
	return data;
}