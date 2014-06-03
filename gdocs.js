var init = function(){
	var tt = document.createElement('script');
	tt.src = "//cdnjs.cloudflare.com/ajax/libs/tabletop.js/1.3.5/tabletop.js";
	document.getElementsByTagName('head')[0].appendChild(tt);
};

init();

Tabletop.init({
	key : 'https://docs.google.com/spreadsheets/d/14h_bBHXosaM8eQaLi0GI1T6_zssV1uNqSWYp50BYfTA/pubhtml',
	callback : grabCompetenceData,
	simpleSheet : false
});

var grabCompetenceData = function(data, tabletop){
	var curso = frames[2].document.getElementById('lblNomeCurso').innerText;
	var ddlCompetences = frames[2].document.getElementById('ddlEtapaNota');
	var competence = ddlCompetences.options[ddlCompetences.selectedIndex].innerText.replace('Rec','r').replace('Comp','c');

	var disciplina = frames[2].document.getElementById('lblNomeDisciplina').innerText;
	var sheetName = frames[2].document.getElementById('lblNomeTurma').innerText+'-'+disciplina;
	var bruteRows = frames[2].document.getElementById('dgAlunos').rows;

	var gsheetData = tabletop.sheets(sheetName).all();
																       
	for(var j = 0; j< gsheetData.length; j++ ){
		for(var i = 1; i<bruteRows.length; i++){
		       if(gsheetData[j].estudante === bruteRows[i].cells[2].innerText){
			       score = gsheetData[j][competence];
				       bruteRows[i].cells[4].getElementsByTagName('input')[0].value = score;
		       }
	       }
	}
};
