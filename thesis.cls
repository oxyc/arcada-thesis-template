% vim: tw=78:ts=2:sw=2:et:fdm=marker:wrap

%%
%% This is file `thesis.cls',
%%
%% \CharacterTable
%%  {Upper-case    \A\B\C\D\E\F\G\H\I\J\K\L\M\N\O\P\Q\R\S\T\U\V\W\X\Y\Z
%%   Lower-case    \a\b\c\d\e\f\g\h\i\j\k\l\m\n\o\p\q\r\s\t\u\v\w\x\y\z
%%   Digits        \0\1\2\3\4\5\6\7\8\9
%%   Exclamation   \!     Double quote  \"     Hash (number) \#
%%   Dollar        \$     Percent       \%     Ampersand     \&
%%   Acute accent  \'     Left paren    \(     Right paren   \)
%%   Asterisk      \*     Plus          \+     Comma         \,
%%   Minus         \-     Point         \.     Solidus       \/
%%   Colon         \:     Semicolon     \;     Less than     \<
%%   Equals        \=     Greater than  \>     Question mark \?
%%   Commercial at \@     Left bracket  \[     Backslash     \\
%%   Right bracket \]     Circumflex    \^     Underscore    \_
%%   Grave accent  \`     Left brace    \{     Vertical bar  \|
%%   Right brace   \}     Tilde         \~}
\NeedsTeXFormat{LaTeX2e}[2000/06/01]
\ProvidesClass{thesis}
  [2012/06/12 Document class for Arcada thesis]

%% Preamble {{{

%% Load packages
\LoadClass[a4paper,12pt]{article}
\RequirePackage{latexsym}
\RequirePackage[utf8]{inputenc}
\RequirePackage[T1]{fontenc}
\RequirePackage{pslatex} % Use Times
\RequirePackage[swedish,finnish,english]{babel}
\RequirePackage{geometry}
\RequirePackage{graphicx}
\RequirePackage{eso-pic}
\RequirePackage{color}
\RequirePackage{tabularx}
\RequirePackage{booktabs}
\RequirePackage{array}
\RequirePackage{xifthen}
\RequirePackage{caption} % Position captions
\RequirePackage{changepage} % As we cant rely on latest geometry package.
\RequirePackage{lastpage} % Get page count
\RequirePackage{setspace} % Line spacing
\RequirePackage{titlesec} % Customize section titles
\RequirePackage[titles]{tocloft} % Customize ToC

\newif\if@finnish
\newif\if@swedish
\newif\if@english

\DeclareOption{finnish}{\@finnishtrue}
\DeclareOption{swedish}{\@swedishtrue}
\DeclareOption{english}{\@englishtrue}

% Look for images in a couple of places
\graphicspath{{./}{../}{./images/}{../images/}}

% Pass stuff through to article but remember if we did so we can use arcadas
% defaults otherwise.
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax

% }}}
%% Basic page layout {{{
\geometry{
  top=2.5cm,
  left=3cm,
  right=3cm,
  bottom=3.4cm, % 2.5cm + 0.9cm
  nohead,
  footskip=0.9cm}
\setlength{\parindent}{0pt}
\setlength{\parskip}{1ex}
\setstretch{1.5}
\pagestyle{plain}
\pagenumbering{arabic}
\titleformat{\section}{%
  \Large\bf\fontfamily{phv}\selectfont}{\thesection}{1em}{\MakeUppercase}
\titleformat{\subsection}{%
  \Large\bf\fontfamily{phv}\selectfont}{\thesubsection}{1em}{}
\titleformat{\subsubsection}{%
  \large\bf\fontfamily{phv}\selectfont}{\thesubsubsection}{1em}{}

\captionsetup[table]{%
  position=top, labelsep=period,%
  singlelinecheck=false, justification=justified,% align left
  textfont=it, labelfont=it, font=footnotesize}

\captionsetup[figure]{%
  position=bottom, labelsep=period,%
  singlelinecheck=false, justification=justified,% align left
  textfont=it, labelfont=it, font=footnotesize}

%% }}}
%% Language {{{

\newlength{\figurelength}
\newlength{\tablelength}
\newcommand{\defaultlanguage}[1]{\gdef\@defaultlanguage{#1}}
\newcommand{\setdefaultlanguage}{%
  \if@english
    \selectlanguage{english}
    \setlength{\figurelength}{\widthof{Figuuri~99.~}}
    \setlength{\tablelength}{\widthof{Taulukko~99.~}}
  \else
    \if@swedish
      \selectlanguage{swedish}
      \setlength{\figurelength}{\widthof{Figur~99.~}}
      \setlength{\tablelength}{\widthof{Tabell~99.~}}
    \else
      \if@finnish
        \selectlanguage{finnish}
        \setlength{\figurelength}{\widthof{Figuuri~99.~}}
        \setlength{\tablelength}{\widthof{Taulukko~99.~}}
      \else
        \selectlanguage{english}
        \setlength{\figurelength}{\widthof{Figuuri~99.~}}
        \setlength{\tablelength}{\widthof{Taulukko~99.~}}
      \fi
    \fi
  \fi
}
\setdefaultlanguage

%% }}}
%% Localization  {{{

\addto\captionsenglish{%
  \def\sDegreeThesis           {Degree Thesis}%
  \def\sDegreeProgramme        {Degree Programme:}%
  \def\sIdentification         {Identification number:}%
  \def\sAuthor                 {Author:}%
  \def\sTitle                  {Title:}%
  \def\sSupervisor             {Supervisor (Arcada):}%
  \def\sCommissionedBy         {Commissioned by:}%
  \def\sAbstract               {Abstract:}%
  \def\sKeywords               {Keywords:}%
  \def\sPageCount              {Number of pages:}%
  \def\sLanguage               {Language:}%
  \def\sDateAcceptance         {Date of acceptance:}%
  \def\sFinnish                {Finnish}%
  \def\sEnglish                {English}%
  \def\sSwedish                {Swedish}%
  \def\sFigure                 {Figure}%
  \def\sTable                  {Table}%
  \renewcommand\listfigurename {Figures}%
  \renewcommand\listtablename  {Tables}%
}
\addto\captionsswedish{%
  \def\sDegreeThesis           {Examensarbete}%
  \def\sDegreeProgramme        {Utbildningsprogram:}%
  \def\sIdentification         {Identifikationsnummer:}%
  \def\sAuthor                 {Författare:}%
  \def\sTitle                  {Arbetets namn:}%
  \def\sSupervisor             {Handledare (Arcada):}%
  \def\sCommissionedBy         {Uppdragsgivare:}%
  \def\sAbstract               {Sammandrag:}%
  \def\sKeywords               {Nyckelord:}%
  \def\sPageCount              {Sidantal:}%
  \def\sLanguage               {Språk:}%
  \def\sDateAcceptance         {Datum för godkännande:}%
  \def\sFinnish                {Finska}%
  \def\sEnglish                {Engelska}%
  \def\sSwedish                {Svenska}%
  \def\sFigure                 {Figur}%
  \def\sTable                  {Tabell}%
  \renewcommand\listfigurename {Figurer}%
  \renewcommand\listtablename  {Tabeller}%
}
\addto\captionsfinnish{%
  \def\sDegreeThesis           {Opinnäyte}%
  \def\sDegreeProgramme        {Koulutusohjelma:}%
  \def\sIdentification         {Tunnistenumero:}%
  \def\sAuthor                 {Tekijä:}%
  \def\sTitle                  {Työn nimi:}%
  \def\sSupervisor             {Työn ohjaaja (Arcada):}%
  \def\sCommissionedBy         {Toimeksiantaja:}%
  \def\sAbstract               {Tiivistelmä:}%
  \def\sKeywords               {Avainsanat:}%
  \def\sPageCount              {Sivumäärä:}%
  \def\sLanguage               {Kieli:}%
  \def\sDateAcceptance         {Hyväksymispäivämäärä:}%
  \def\sFinnish                {Suomi}%
  \def\sEnglish                {Englanti}%
  \def\sSwedish                {Ruotsi}%
  \def\sFigure                 {Figuuri}%
  \def\sTable                  {Taulukko}%
  \renewcommand\listfigurename {Figuurit}%
  \renewcommand\listtablename  {Taulukkot}%
}

%% }}}
%% Background bar {{{

\definecolor{orange}{RGB}          {247,149,70}
\definecolor{orangeSaturated}{RGB} {202,162,130}
\definecolor{gray}{RGB}            {241,241,241}
\definecolor{white}{RGB}           {255,255,255}
\newcommand\cbox[2]{%
  \colorbox{#1}{\parbox[b][\paperheight]{#2}{\vfill\hfill}}%
}
\newcommand\backgroundbar{
  \put(0,0){%
    \cbox{orange}{1.3cm}%
    \cbox{gray}{1pt}%
    \hspace{-4pt}%
    \cbox{orangeSaturated}{1pt}%
    \hspace{-6pt}%
    \cbox{white}{5pt}%
  }
}

% }}}
%% Values passed through commands {{{

\newcommand{\university}[1]     {\gdef\@university{#1}}
\newcommand{\programme}[1]      {\gdef\@programme{#1}}
\newcommand{\level}[1]          {\gdef\@level{#1}}
\newcommand{\subheading}[1]     {\gdef\@subheading{#1}}
\newcommand{\thesisLanguage}[1] {\gdef\@thesisLanguage{#1}}
\newcommand{\identification}[1] {\gdef\@identification{#1}}
\newcommand{\supervisor}[1]     {\gdef\@supervisor{#1}}
\newcommand{\commissionedBy}[1] {\gdef\@commissionedBy{#1}}
\newcommand{\dateAcceptance}[1] {\gdef\@dateAcceptance{#1}}

\university{Arcada}
\programme{}
\level{}
\subheading{}
\identification{}
\supervisor{}
\commissionedBy{}
\dateAcceptance{}

% Set some languagespecific values
\if@finnish
  \thesisLanguage{\sFinnish}
\else\if@english
  \thesisLanguage{\sEnglish}
\else\if@swedish
  \thesisLanguage{\sSwedish}
\else
  \thesisLanguage{\sEnglish}
\fi\fi\fi

%% }}}
%% Title {{{

% As the ubuntu repository doesn't contain the latest version of geometry which
% has the command \newgeometry, we need to do an ugly hack which requires the
% title page to be printed first
\addtolength\textheight{3cm}

\renewcommand{\maketitle}{
  \AddToShipoutPicture*{\backgroundbar}
  \begin{adjustwidth}{-0.5cm}{}\begin{spacing}{2.0}
    \vspace*{-1.75cm}
    \includegraphics[width=4.72cm]{logo.pdf}

    \vspace*{6.35cm}

    {\LARGE\bf\fontfamily{phv}\selectfont \@title}

    {\Large \@subheading}

    \vspace{1.7cm}

    \begin{large} % 14pt
      \@author

      \vspace*{\fill}
      \begin{adjustwidth}{}{-2.5cm}
        \begin{flushright}
          \onehalfspacing
          \@level\\
          \@programme\\
          \@date\\
        \end{flushright}%
      \end{adjustwidth}%
    \end{large}
  \end{spacing}\end{adjustwidth}
  \addtolength\textheight{-3cm} % Reset to original textheight
}
%% }}}
%% ToC / LoF / LoT {{{
% Don't show page numbering.
\addtocontents{toc}{\protect\thispagestyle{empty}}
\addtocontents{lof}{\protect\thispagestyle{empty}}
\addtocontents{lot}{\protect\thispagestyle{empty}}

% Make dots more compact
% \renewcommand\@dotsep{0}

% Style LoF
\setlength{\cftfigindent}{0cm} % Remove indent
\setlength{\cftfignumwidth}{\figurelength}
\renewcommand*\cftfigpresnum{\sFigure~}
\renewcommand{\cftfigaftersnum}{.~}

% Style LoT
\setlength{\cfttabindent}{0cm} % Remove indent
\setlength{\cfttabnumwidth}{\tablelength}
\renewcommand*\cfttabpresnum{\sTable~}
\renewcommand{\cfttabaftersnum}{.~}

% Change space between numbering and ToC titles
\renewcommand*\l@section{\@dottedtocline{3}{0cm}{1cm}}
\renewcommand*\l@subsection{\@dottedtocline{3}{0.39cm}{1.2cm}}
\renewcommand*\l@subsubsection{\@dottedtocline{3}{0.78cm}{1.5cm}}

% Style section titles
\let\stdl@section\l@section
\renewcommand*{\l@section}[2]{%
  \doublespacing%
  \stdl@section{%
    \bf\fontsize{12pt}{6pt}\fontfamily{phv}\selectfont{#1}}{%
    \bf\fontsize{12pt}{6pt}\fontfamily{phv}\selectfont{#2}}%
}

% Style subsection titles
\let\stdl@subsection\l@subsection
\renewcommand*{\l@subsection}[2]{%
  \singlespace%
  \stdl@subsection{%
    \fontsize{11pt}{0pt}\fontfamily{phv}\selectfont{#1}}{%
    \fontsize{11pt}{0pt}\fontfamily{phv}\selectfont{#2}}%
}

% Style subsection titles
\let\stdl@subsubsection\l@subsubsection
\renewcommand*{\l@subsubsection}[2]{%
  \singlespace%
  \stdl@subsubsection{%
    \it\fontsize{11pt}{0pt}\fontfamily{phv}\selectfont{#1}}{%
    \it\fontsize{11pt}{0pt}\fontfamily{phv}\selectfont{#2}}%
}

% Append section titles with dots
\renewcommand{\cftsecdotsep}{\cftdotsep}

% Override main commands
\let\stdtableofcontents\tableofcontents
\renewcommand*{\tableofcontents}{
  \setdefaultlanguage
  \stdtableofcontents
  \newpage
}

%% }}}
%% Abstract {{{

\newcommand{\coljoin}[1]{\multicolumn{2}{ !{\VRule[2pt]} l !{\VRule[2pt]} }{#1}}
\newcommand{\thickrule}{\specialrule{2pt}{0pt}{0pt}}
\newcommand\VRule[1][\arrayrulewidth]{\vrule width #1}
\newcommand{\vthickrule}{\vrule width 2pt}
\renewenvironment{abstract}[1]{%
  \ifthenelse{\isempty{#1}}{}{\selectlanguage{#1}}
  \pagestyle{empty}
  \newpage
    \normalsize
    \singlespacing
    \renewcommand{\arraystretch}{1.1}
    \begin{tabularx}{\textwidth}{ !{\vthickrule} p{5cm} | X !{\vthickrule} }
      \thickrule
      \coljoin{\MakeUppercase\level}          \\ \hline
      \coljoin{\@university}                  \\ \hline
      \coljoin{}                              \\ \hline
      \sDegreeProgramme    & \programme       \\ \hline
      \coljoin{}                              \\ \hline
      \sIdentification     & \@identification \\ \hline
      \sAuthor             & \@author         \\ \hline
      \sTitle              & \title           \\ \hline
      \sSupervisor         & \@supervisor     \\ \hline
      \coljoin{}                              \\ \hline
      \sCommissionedBy     & \@commissionedBy \\ \hline
      \coljoin{}                              \\ \thickrule
      \coljoin{\sAbstract}                    \\ %todo do this in a nicer way
    \end{tabularx}
    \vskip -7px%
    \tabularx{\textwidth}{ !{\vthickrule} X !{\vthickrule} }%
}{
    \endtabularx
    \vskip -7px%
    \begin{tabularx}{\textwidth}{ !{\vthickrule} p{5cm} | X !{\vthickrule} }
      \thickrule
      \sKeywords           & \keywords          \\ \hline
      \sPageCount          & \pageref{LastPage} \\ \hline
      \sLanguage           & \@thesisLanguage   \\ \hline
      \sDateAcceptance     & \@dateAcceptance   \\ \thickrule
    \end{tabularx}
    \setdefaultlanguage
    \pagestyle{empty}
    \newpage
}
%% }}}
%% Bibliography {{{

\bibliographystyle{plain}

\let\stdl@bibliography\bibliography
\renewcommand*{\bibliography}[1]{
  \newpage
  \thispagestyle{empty}
  \stdl@bibliography{#1}
  \addcontentsline{toc}{section}{\refname}
}

%% }}}

\endinput
%%
