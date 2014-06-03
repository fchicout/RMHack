-----------------------------------------------------------------
-- Estrutras de armazenamento de dados --------------------------
-----------------------------------------------------------------
USE [RMHack]
GO
/****** Object:  Table [dbo].[Alunos]    Script Date: 11/12/2013 01:20:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Alunos](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[idCurso] [int] NULL,
	[matricula] [nchar](10) NULL,
	[nome] [nvarchar](250) NULL,
 CONSTRAINT [PK_Alunos] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Cursos]    Script Date: 11/12/2013 01:20:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cursos](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[sigla] [nvarchar](5) NULL,
	[nomeCompleto] [nvarchar](80) NULL,
 CONSTRAINT [PK_Cursos] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Faltas]    Script Date: 11/12/2013 01:20:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Faltas](
	[idAluno] [int] NOT NULL,
	[idTurma] [int] NOT NULL,
	[dataAula] [date] NOT NULL,
	[aula1] [bit] NULL,
	[aula2] [bit] NULL,
	[aula3] [bit] NULL,
	[aula4] [bit] NULL,
	[aula5] [bit] NULL,
 CONSTRAINT [PK_Faltas] PRIMARY KEY CLUSTERED 
(
	[idAluno] ASC,
	[idTurma] ASC,
	[dataAula] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Tabelao]    Script Date: 11/12/2013 01:20:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tabelao](
	[aluno] [nvarchar](250) NOT NULL,
	[matricula] [nchar](10) NOT NULL,
	[disciplina] [nvarchar](250) NOT NULL,
	[curso] [nvarchar](5) NOT NULL,
	[turno] [nchar](5) NOT NULL,
	[ano] [smallint] NOT NULL,
	[periodo] [tinyint] NOT NULL,
	[nota1] [nchar](3) NULL,
	[nota2] [nchar](3) NULL,
	[nota3] [nchar](3) NULL,
	[nota4] [nchar](3) NULL,
	[nota5] [nchar](3) NULL,
	[nota6] [nchar](3) NULL,
	[nota7] [nchar](3) NULL,
	[nota8] [nchar](3) NULL,
	[nota9] [nchar](3) NULL,
	[nota10] [nchar](3) NULL,
	[rec1] [nchar](3) NULL,
	[rec2] [nchar](3) NULL,
	[rec3] [nchar](3) NULL,
	[rec4] [nchar](3) NULL,
	[rec5] [nchar](3) NULL,
	[rec6] [nchar](3) NULL,
	[rec7] [nchar](3) NULL,
	[rec8] [nchar](3) NULL,
	[rec9] [nchar](3) NULL,
	[rec10] [nchar](3) NULL,
 CONSTRAINT [UNQ_Tabelao] UNIQUE NONCLUSTERED 
(
	[matricula] ASC,
	[disciplina] ASC,
	[ano] ASC,
	[periodo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Turmas]    Script Date: 11/12/2013 01:20:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Turmas](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[idCurso] [int] NULL,
	[disciplina] [nvarchar](250) NULL,
	[turno] [nchar](5) NULL,
	[ano] [smallint] NULL,
	[periodo] [tinyint] NULL,
 CONSTRAINT [PK_Turmas] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
ALTER TABLE [dbo].[Alunos]  WITH CHECK ADD  CONSTRAINT [FK_Alunos_Cursos] FOREIGN KEY([idCurso])
REFERENCES [dbo].[Cursos] ([id])
GO
ALTER TABLE [dbo].[Alunos] CHECK CONSTRAINT [FK_Alunos_Cursos]
GO
ALTER TABLE [dbo].[Faltas]  WITH CHECK ADD  CONSTRAINT [FK_Faltas_Alunos] FOREIGN KEY([idAluno])
REFERENCES [dbo].[Alunos] ([id])
GO
ALTER TABLE [dbo].[Faltas] CHECK CONSTRAINT [FK_Faltas_Alunos]
GO
ALTER TABLE [dbo].[Faltas]  WITH CHECK ADD  CONSTRAINT [FK_Faltas_Turmas] FOREIGN KEY([idTurma])
REFERENCES [dbo].[Turmas] ([id])
GO
ALTER TABLE [dbo].[Faltas] CHECK CONSTRAINT [FK_Faltas_Turmas]
GO
ALTER TABLE [dbo].[Turmas]  WITH CHECK ADD  CONSTRAINT [FK_Turmas_Cursos] FOREIGN KEY([idCurso])
REFERENCES [dbo].[Cursos] ([id])
GO
ALTER TABLE [dbo].[Turmas] CHECK CONSTRAINT [FK_Turmas_Cursos]
GO

-----------------------------------------------------------------
-- Estrutras de programação -------------------------------------
-----------------------------------------------------------------


CREATE FUNCTION ufn_getCursoId(@s_curso NVARCHAR(5))
RETURNS INT
AS
BEGIN
	DECLARE @cursoId AS INT
	SET @cursoId = (SELECT id FROM Cursos WHERE sigla=@s_curso)
	RETURN @cursoId
END
GO
-- Atualiza os dados dos cursos 
CREATE PROCEDURE usp_updateCourses
AS
BEGIN
	INSERT INTO Cursos (sigla)
	((SELECT DISTINCT t.curso AS sigla FROM dbo.Tabelao t)
	EXCEPT
	(SELECT c.sigla FROM Cursos c))
END
GO
CREATE PROCEDURE usp_updateAlunos
AS
BEGIN
	INSERT INTO Alunos (idCurso, matricula, nome) 
	  (SELECT DISTINCT dbo.ufn_getCursoId(t.curso) AS cursoId,
			 t.matricula,
			 t.aluno
		FROM Tabelao t)
	EXCEPT
	  (SELECT a.idCurso AS cursoId,
			  a.matricula,
			  a.nome AS aluno
		 FROM Alunos a
	  )
END
GO

CREATE PROCEDURE usp_updateTurmas
AS
BEGIN
	INSERT INTO Turmas (idCurso, disciplina, turno, ano, periodo)
	 (SELECT DISTINCT dbo.ufn_getCursoId(t.curso) AS cursoId,
			 t.disciplina,
			 t.turno,
			 t.ano,
			 t.periodo
		FROM Tabelao t)
	EXCEPT
	 (SELECT tm.idCurso, 
			 tm.disciplina,
			 tm.turno,
			 tm.ano,
			 tm.periodo
		FROM Turmas tm
	 )
END
GO


--TODO: Retornar o id da turma pelo seu código e nome da disciplina
CREATE FUNCTION ufn_getTurmaIdByCodeAndDiscipline(@code AS NVARCHAR(10))
AS
BEGIN
	
END
GO

--TODO: Retornar o id da turma pelos outro dados dela (será necessário????)
CREATE FUNCTION ufn_getTurmaIdByCodeAndDiscipline(@code AS NVARCHAR(10))
AS
BEGIN
	
END
GO

CREATE FUNCTION ufn_DashboardFaltas(@turmaId INT)
RETURNS @dashboard TABLE( Mes INT, 
			  TotalPresencas INT,
			  TotalAulas INT
			)
AS
BEGIN
	INSERT INTO @dashboard (Mes, TotalPresencas, TotalAulas)
	 (SELECT MONTH(f.dataAula) AS Mes,
			 SUM(CONVERT(INT,f.aula1)+CONVERT(INT,f.aula2)+CONVERT(INT,f.aula3)+CONVERT(INT,f.aula4)+CONVERT(INT,f.aula5)) AS TotalPresencas,
			 COUNT(CONVERT(INT,f.aula1)+CONVERT(INT,f.aula2)+CONVERT(INT,f.aula3)+CONVERT(INT,f.aula4)+CONVERT(INT,f.aula5)) as TotalAulas
		FROM Alunos a INNER JOIN Faltas f 
							ON (a.id = f.idAluno)
					INNER JOIN Turmas t
							ON (f.idTurma = t.id)
	   WHERE t.id = @turmaId
	GROUP BY MONTH(f.dataAula))
	RETURN
END





select * from ufn_DashboardFaltas(1)