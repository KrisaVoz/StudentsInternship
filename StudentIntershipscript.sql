USE [StudentsIntershipDB]
GO
/****** Object:  Table [dbo].[Agreements]    Script Date: 26.11.2023 14:08:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Agreements](
	[AgreementNumber] [nvarchar](50) NOT NULL,
	[AgreementType] [int] NOT NULL,
	[DateOfAgreement] [date] NULL,
	[CompanyName] [nvarchar](max) NOT NULL,
	[CompanyINN] [nvarchar](50) NULL,
	[CompanyLegalAddress] [nvarchar](max) NULL,
	[ContactPerson] [nvarchar](1000) NULL,
	[ContactNumber] [nvarchar](500) NULL,
	[AgreementStartDate] [date] NULL,
	[AgreementEndDate] [date] NULL,
	[Prolongation] [bit] NOT NULL,
	[NumberOfPeople] [int] NULL,
	[Remark] [nvarchar](max) NULL,
	[IsRegistrationRequired] [bit] NOT NULL,
 CONSTRAINT [PK_Agreements] PRIMARY KEY CLUSTERED 
(
	[AgreementNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AgreementSpeciality]    Script Date: 26.11.2023 14:08:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AgreementSpeciality](
	[AgreementID] [nvarchar](50) NOT NULL,
	[SpecialityID] [nvarchar](50) NOT NULL,
	[DateOfAdding] [date] NULL,
 CONSTRAINT [PK_AgreementSpeciality_1] PRIMARY KEY CLUSTERED 
(
	[AgreementID] ASC,
	[SpecialityID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AgreementTypes]    Script Date: 26.11.2023 14:08:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AgreementTypes](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[AgreementTypeName] [nvarchar](500) NOT NULL,
 CONSTRAINT [PK_AgreementTypes] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EducationalOrganisations]    Script Date: 26.11.2023 14:08:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EducationalOrganisations](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](250) NOT NULL,
 CONSTRAINT [PK_Organisations] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Groups]    Script Date: 26.11.2023 14:08:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Groups](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[GroupNumberName] [nvarchar](500) NOT NULL,
	[Speciality] [nvarchar](50) NULL,
	[EducationalOrganisation] [int] NOT NULL,
 CONSTRAINT [PK_Groups] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PracticeDistributions]    Script Date: 26.11.2023 14:08:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PracticeDistributions](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[PracticeScheduleID] [int] NOT NULL,
	[AgreementID] [nvarchar](50) NOT NULL,
	[IsInTheSameCompany] [bit] NOT NULL,
 CONSTRAINT [PK_PracticeDistributions] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PracticeSchedules]    Script Date: 26.11.2023 14:08:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PracticeSchedules](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[GroupID] [int] NOT NULL,
	[PracticeStartDate] [date] NOT NULL,
	[PracticeEndDate] [date] NOT NULL,
	[PracticeSubject] [int] NOT NULL,
 CONSTRAINT [PK_PracticeSchedules] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PracticeSubjects]    Script Date: 26.11.2023 14:08:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PracticeSubjects](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[PracticeSubjectName] [nvarchar](1000) NOT NULL,
 CONSTRAINT [PK_PracticeSubjects] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Specialties]    Script Date: 26.11.2023 14:08:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Specialties](
	[SpecialityNumber] [nvarchar](50) NOT NULL,
	[SpecialityName] [nvarchar](1000) NOT NULL,
 CONSTRAINT [PK_Specialties] PRIMARY KEY CLUSTERED 
(
	[SpecialityNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Students]    Script Date: 26.11.2023 14:08:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Students](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](500) NOT NULL,
	[Surname] [nvarchar](500) NOT NULL,
	[Patronymic] [nvarchar](500) NULL,
	[Phone] [nvarchar](300) NULL,
	[ResidenceRegistration] [bit] NOT NULL,
	[Course] [int] NULL,
	[GroupNumber] [int] NULL,
 CONSTRAINT [PK_Students] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[StudentsDistribution]    Script Date: 26.11.2023 14:08:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StudentsDistribution](
	[PracticeDistributionsID] [int] NOT NULL,
	[StudentID] [int] NOT NULL,
	[DateOfAdding] [date] NULL,
 CONSTRAINT [PK_StudentsDistribution] PRIMARY KEY CLUSTERED 
(
	[PracticeDistributionsID] ASC,
	[StudentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[AgreementTypes] ON 

INSERT [dbo].[AgreementTypes] ([ID], [AgreementTypeName]) VALUES (1, N'Краткосрочный')
INSERT [dbo].[AgreementTypes] ([ID], [AgreementTypeName]) VALUES (2, N'Долгосрочный')
INSERT [dbo].[AgreementTypes] ([ID], [AgreementTypeName]) VALUES (3, N'Бессрочный')
INSERT [dbo].[AgreementTypes] ([ID], [AgreementTypeName]) VALUES (4, N'Иной')
SET IDENTITY_INSERT [dbo].[AgreementTypes] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_PracticeDistributions]    Script Date: 26.11.2023 14:08:20 ******/
ALTER TABLE [dbo].[PracticeDistributions] ADD  CONSTRAINT [IX_PracticeDistributions] UNIQUE NONCLUSTERED 
(
	[AgreementID] ASC,
	[PracticeScheduleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Agreements]  WITH CHECK ADD  CONSTRAINT [FK_Agreements_AgreementTypes] FOREIGN KEY([AgreementType])
REFERENCES [dbo].[AgreementTypes] ([ID])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[Agreements] CHECK CONSTRAINT [FK_Agreements_AgreementTypes]
GO
ALTER TABLE [dbo].[AgreementSpeciality]  WITH CHECK ADD  CONSTRAINT [FK_AgreementSpeciality_Agreements] FOREIGN KEY([AgreementID])
REFERENCES [dbo].[Agreements] ([AgreementNumber])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AgreementSpeciality] CHECK CONSTRAINT [FK_AgreementSpeciality_Agreements]
GO
ALTER TABLE [dbo].[AgreementSpeciality]  WITH CHECK ADD  CONSTRAINT [FK_AgreementSpeciality_Specialties] FOREIGN KEY([SpecialityID])
REFERENCES [dbo].[Specialties] ([SpecialityNumber])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AgreementSpeciality] CHECK CONSTRAINT [FK_AgreementSpeciality_Specialties]
GO
ALTER TABLE [dbo].[Groups]  WITH CHECK ADD  CONSTRAINT [FK_Groups_EducationalOrganisations] FOREIGN KEY([EducationalOrganisation])
REFERENCES [dbo].[EducationalOrganisations] ([ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Groups] CHECK CONSTRAINT [FK_Groups_EducationalOrganisations]
GO
ALTER TABLE [dbo].[Groups]  WITH CHECK ADD  CONSTRAINT [FK_Groups_Specialties] FOREIGN KEY([Speciality])
REFERENCES [dbo].[Specialties] ([SpecialityNumber])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[Groups] CHECK CONSTRAINT [FK_Groups_Specialties]
GO
ALTER TABLE [dbo].[PracticeDistributions]  WITH CHECK ADD  CONSTRAINT [FK_PracticeDistributions_Agreements] FOREIGN KEY([AgreementID])
REFERENCES [dbo].[Agreements] ([AgreementNumber])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[PracticeDistributions] CHECK CONSTRAINT [FK_PracticeDistributions_Agreements]
GO
ALTER TABLE [dbo].[PracticeDistributions]  WITH CHECK ADD  CONSTRAINT [FK_PracticeDistributions_PracticeSchedules] FOREIGN KEY([PracticeScheduleID])
REFERENCES [dbo].[PracticeSchedules] ([ID])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[PracticeDistributions] CHECK CONSTRAINT [FK_PracticeDistributions_PracticeSchedules]
GO
ALTER TABLE [dbo].[PracticeSchedules]  WITH CHECK ADD  CONSTRAINT [FK_PracticeSchedules_Groups] FOREIGN KEY([GroupID])
REFERENCES [dbo].[Groups] ([ID])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[PracticeSchedules] CHECK CONSTRAINT [FK_PracticeSchedules_Groups]
GO
ALTER TABLE [dbo].[PracticeSchedules]  WITH CHECK ADD  CONSTRAINT [FK_PracticeSchedules_PracticeSubjects] FOREIGN KEY([PracticeSubject])
REFERENCES [dbo].[PracticeSubjects] ([ID])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[PracticeSchedules] CHECK CONSTRAINT [FK_PracticeSchedules_PracticeSubjects]
GO
ALTER TABLE [dbo].[Students]  WITH CHECK ADD  CONSTRAINT [FK_Students_Groups] FOREIGN KEY([GroupNumber])
REFERENCES [dbo].[Groups] ([ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Students] CHECK CONSTRAINT [FK_Students_Groups]
GO
ALTER TABLE [dbo].[StudentsDistribution]  WITH CHECK ADD  CONSTRAINT [FK_StudentsDistribution_PracticeDistributions] FOREIGN KEY([PracticeDistributionsID])
REFERENCES [dbo].[PracticeDistributions] ([ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[StudentsDistribution] CHECK CONSTRAINT [FK_StudentsDistribution_PracticeDistributions]
GO
ALTER TABLE [dbo].[StudentsDistribution]  WITH CHECK ADD  CONSTRAINT [FK_StudentsDistributions_Students] FOREIGN KEY([StudentID])
REFERENCES [dbo].[Students] ([ID])
GO
ALTER TABLE [dbo].[StudentsDistribution] CHECK CONSTRAINT [FK_StudentsDistributions_Students]
GO
