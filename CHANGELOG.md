### 2.1.3 / 2018-11-22

#### 1 minor enhancement

  * created binstubs for binary and setup
  * removed hoe dependency
  * Updated docs

### 2.1.2 / 2018-06-28

#### 1 patch enhancement

  * updated dependencies

### 2.1.1 / 2018-04-29

#### 1 misc enhancement

  * updated documentation and projects url

### 2.1.0 / 2017-11-06

#### 6 minor enhancements

  * LCV#3: Use more communicative variable names
  * LCV#4: Use Codeclimates new V2 engine
  * LCV#5: Fix Rubocop and Reek
  * LCV#6: Cleanup Rakefile
  * LCV#1: Add option to choose between mail backends
  * LCV#2: Change license to GPL3

### 2.0.1 / 2017-05-16

#### Added thunderbird support

### 2.0.0 / 2017-02-27

#### 1 major enhancement

  * Bug-9: Using of XDG directories instead of .latex_curriculum_vitae
  * Using regular tempdir instead using the datadir directly
  * Fixed shorten url: Check if no url is given

### 1.3.1 / 2017-02-23

#### 1 minor enhancement

  * updated dependencies and docs

### 1.3.0 / 2016-10-13

#### 3 major enhancements

  * added bitly_user and bitly_apikey to config (LCV-4 URL of job offer)
  * added method for shorting urls (LCV-4 URL of job offer)
  * Mailer Pony now uses TLS with Port 587

### 1.2.2 / 2016-10-12

#### 2 minor enhancement

  * removed cleanup dir (fix LCV-2 Implement a split funktion)
  * write csv before preview in pdf viewer (LCV-3 Move up the csv method)

### 1.2.1 / 2016-10-05

#### 1 minor enhancement

  * shortened support targetlock for entityfile

### 1.2.0 / 2016-08-08

#### 2 major enhancement

  * reworked bwanschreiben.tex (entityfile.rb and letter.rb)
  * fixed LCV-1 - use pdf_combine instead of LaTeX solution

### 1 minor enhancement

  * fixed setup (Now the backup and restore of the control files in .latex_curriculum_vitae works

### 1.1.4 / 2016-08-06

#### 1 minor enhancement

  * updated dependencies from gemnasium

### 1.1.3 / 2016-02-08

#### 1 minor enhancement

  * updated dependencies from gemnasium

### 1.1.2 / 2016-02-03

#### 3 minor enhancement

  * added three targetblocks (support,doku,kaufm) for three kind of jobs.
  * now pdf reader can configured in the config
  * added signature to the outgoing mail

### 1.1.1 / 2015-10-21

#### 1 minor enhancement

  * cleanup code

### 1.1.0 / 2015-10-20

#### 3 minor enhancements

  * LCV-7: Add mailer
  * LCV-9: latexcv.rb: Use not File.expand
  * LCV-10: Build a upgrade option

### 1.0.0 / 2015-10-03

#### 1 bug fix

  * Fixed install routine

#### 3 feature requests

  * fix LCV-6: Added LatexCurriculumVitae::Letter (Class for compile the motivational letter)
  * fix LCV-7: Allow to name the pdf output file (instead of hardcoded "Bewerbungsunterlagen_Manns")
  * fix LCV-8: Make LCV more dynamic (added variable "letter". If this is set, the program merges the motivational
    letter with the cv.
  * Extended gui for asking about street and city (company)
  * Added 4 variables to latex_curriculum_vitae.cfg: name_of_letter, name_of_resume, name_of_cover and name_of_pdf.
  * Extended personal_data.tex for containing all relevant infos for compiling the letter and the cover.
  * Changed LaTEX sources for using the personal_data.tex to build the cover and the letter.
  * Reworked documentation

### 0.1.3 / 2015-09-05

#### 2 minor enhancements

  * The installed gem doesn't use $HOME for sysconfdir
  * fixed color issue

### 0.1.1 / 2015-09-04

#### 1 major enhancement

  * Birthday!