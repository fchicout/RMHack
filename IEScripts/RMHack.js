



function PopulateStudents(){
	var nome, matricula, sql;
	var bruteRows = document.frames[2].document.getElementById('dgAlunos').rows
	var ano = parseInt(document.frames[2].document.getElementById('ControlaMenu1_lbPerLetivo').innerText.split(' ')[2].split('.')[0]);
	var periodo = parseInt(document.frames[2].document.getElementById('ControlaMenu1_lbPerLetivo').innerText.split(' ')[2].split('.')[1]);
	var turno = document.frames[2].document.getElementById('lblNomeTurno').innerText;
	var curso = document.frames[2].document.getElementById('lblNomeCurso').innerText;
	var disciplina = document.frames[2].document.getElementById('lblNomeDisciplina').innerText;
	var conn = new ActiveXObject('ADODB.Connection');
	var rst = new ActiveXObject('ADODB.RecordSet');
	conn.Open("Provider=SQLOLEDB;Data Source=(local);Initial Catalog=RMHack;Integrated Security=SSPI", "","")
	for(var i = 1; i<bruteRows.length; i++){ 
		nome = bruteRows[i].cells[2].innerText; 
		matricula = bruteRows[i].cells[1].innerText;
		sql = "INSERT INTO [dbo].[Tabelao] ([aluno],[matricula],[disciplina],[curso],[turno],[ano],[periodo]) VALUES (\'"+ nome +"\',"+ matricula +",\'"+ disciplina +"\',\'"+ curso +"\',\'"+ turno +"\',"+ ano +","+ periodo +")";
		try{
			rst.Open(sql, conn);
		} catch(e){
			if ((new RegExp("UNIQUE")).test(e.message)){
				alert('Aluno ' + nome + ' já está registrado na disciplina ' + disciplina + " neste período.\nAluno não armazenado.");
			}
		}
	}
}

function GetEtapa(etapa){
	var step = parseInt(etapa);
	switch(step){
		case 1:
			return 'nota1';
		case 2:
			return 'nota2';
		case 3:
			return 'nota3';
		case 4:
			return 'nota4';
		case 5:
			return 'nota5';
		case 6:
			return 'nota6';
		case 7:
			return 'nota7';
		case 8:
			return 'nota8';
		case 9:
			return 'nota9';
		case 10:
			return 'nota10';
		case 11:
			return 'rec1';
		case 12:
			return 'rec2';
		case 13:
			return 'rec3';
		case 14:
			return 'rec4';
		case 15:
			return 'rec5';
		case 16:
			return 'rec6';
		case 17:
			return 'rec7';
		case 18:
			return 'rec8';
		case 19:
			return 'rec9';
		case 20:
			return 'rec10';
	}
	
}

function GrabCompetences(){
	var sql, score;
	var conn = new ActiveXObject('ADODB.Connection');
	var rs = new ActiveXObject('ADODB.RecordSet');
	var curso = document.frames[2].document.getElementById('lblNomeCurso').innerText;
	var disciplina = document.frames[2].document.getElementById('lblNomeDisciplina').innerText;
	var ano = parseInt(document.frames[2].document.getElementById('ControlaMenu1_lbPerLetivo').innerText.split(' ')[2].split('.')[0]);
	var periodo = parseInt(document.frames[2].document.getElementById('ControlaMenu1_lbPerLetivo').innerText.split(' ')[2].split('.')[1]);
	var ddlCompetences = document.frames[2].document.getElementById('ddlEtapaNota');
	var competence = ddlCompetences.options[ddlCompetences.selectedIndex].value;
	var bruteRows = document.frames[2].document.getElementById('dgAlunos').rows;
	conn.Open("Provider=SQLOLEDB;Data Source=(local);Initial Catalog=RMHack;Integrated Security=SSPI", "","");
	for(var i = 1; i<bruteRows.length; i++){ 
		sql = "SELECT matricula, "+ GetEtapa(competence) +" FROM dbo.Tabelao WHERE disciplina =\'" + disciplina + "\' AND periodo="+ periodo +" AND ano="+ ano +" AND matricula=\'"+bruteRows[i].cells[1].innerText+"\'";
		rs.open(sql, conn);
		if(!rs.bof){
			rs.MoveFirst();
			untreatedScore = rs.fields(GetEtapa(competence));
			score = (untreatedScore==null)?'':untreatedScore;
			bruteRows[i].cells[4].getElementsByTagName('input')[0].value = score;
		}
		rs.close();
	}
}

; GrabCompetences();

function GrabPresences(mes, codigoTurma, disciplina){
	var conn = new ActiveXObject('ADODB.Connection');
	var rst = new ActiveXObject('ADODB.RecordSet');
	conn.Open("Provider=SQLOLEDB;Data Source=(local);Initial Catalog=RMHack;Integrated Security=SSPI", "","")
}