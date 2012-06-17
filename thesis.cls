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
\LoadClass{article}
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
\RequirePackage{setspace} % Line spacing
\RequirePackage{titlesec} % Customize section titles
\RequirePackage[titles]{tocloft} % Customize ToC

\newif\if@finnish
\newif\if@swedish
\newif\if@english
\newif\if@emptyfirstpagenumber

\DeclareOption{finnish}{\@finnishtrue}
\DeclareOption{swedish}{\@swedishtrue}
\DeclareOption{english}{\@englishtrue}
\DeclareOption{emptyfirstpagenumber}{\@emptyfirstpagenumbertrue}

% Look for images in a couple of places
\graphicspath{{./}{../}{./images/}{../images/}}

% Pass stuff through to article but remember if we did so we can use arcadas
% defaults otherwise.

\newif\if@defaulttypesize
\newif\if@defaultpaper
\newif\if@defaulttitlepage
\@defaulttypesizetrue
\@defaultpapertrue
\@defaulttitlepagetrue

\DeclareOption{10pt}{
  \@defaulttypesizefalse
  \PassOptionsToClass{10pt}{article}}
\DeclareOption{11pt}{
  \@defaulttypesizefalse
  \PassOptionsToClass{11pt}{article}}

\DeclareOption{a5paper}{
  \@defaultpaperfalse
  \PassOptionsToClass{a5paper}{article}}
\DeclareOption{b5paper}{
  \@defaultpaperfalse
  \PassOptionsToClass{b5paper}{article}}
\DeclareOption{letterpaper}{
  \@defaultpaperfalse
  \PassOptionsToClass{letterpaper}{article}}
\DeclareOption{legalpaper}{
  \@defaultpaperfalse
  \PassOptionsToClass{legalpaper}{article}}
\DeclareOption{executivepaper}{
  \@defaultpaperfalse
  \PassOptionsToClass{executivepaper}{article}}

\DeclareOption{notitlepage}{
  \@defaulttitlepagefalse
  \PassOptionsToClass{notitlepage}{article}}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}

% Use defaults if not otherwise specified
\ProcessOptions\relax
\if@defaulttypesize
  \PassOptionsToClass{12pt}{article}
\fi
\if@defaultpaper
  \PassOptionsToClass{a4paper}{article}
\fi
\if@defaulttitlepage
  \PassOptionsToClass{titlepage}{article}
\fi
\ProcessOptions\relax

% }}}
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
\addtolength{\figurelength}{5ex}
\addtolength{\tablelength}{3ex}

%% }}}
%% Localization  {{{

\addto\captionsenglish{%
  \def\sDegreeThesis    {Degree Thesis}%
  \def\sDegreeProgramme {Degree Programme:}%
  \def\sIdentification  {Identification number:}%
  \def\sAuthor          {Author:}%
  \def\sTitle           {Title:}%
  \def\sSupervisor      {Supervisor (Arcada):}%
  \def\sCommissionedBy  {Commissioned by:}%
  \def\sAbstract        {Abstract:}%
  \def\sKeywords        {Keywords:}%
  \def\sPageCount       {Number of pages:}%
  \def\sLanguage        {Language:}%
  \def\sDateAcceptance  {Date of acceptance:}%
  \def\sFinnish         {Finnish}%
  \def\sEnglish         {English}%
  \def\sSwedish         {Swedish}%
  \def\sFigure          {Figure}%
  \def\sTable           {Table}%
}
\addto\captionsswedish{%
  \def\sDegreeThesis    {Examensarbete}%
  \def\sDegreeProgramme {Utbildningsprogram:}%
  \def\sIdentification  {Identifikationsnummer:}%
  \def\sAuthor          {Författare:}%
  \def\sTitle           {Arbetets namn:}%
  \def\sSupervisor      {Handledare (Arcada):}%
  \def\sCommissionedBy  {Uppdragsgivare:}%
  \def\sAbstract        {Sammandrag:}%
  \def\sKeywords        {Nyckelord:}%
  \def\sPageCount       {Sidantal:}%
  \def\sLanguage        {Språk:}%
  \def\sDateAcceptance  {Datum för godkännande:}%
  \def\sFinnish         {Finska}%
  \def\sEnglish         {Engelska}%
  \def\sSwedish         {Svenska}%
  \def\sFigure          {Figur}%
  \def\sTable           {Tabell}%
}
\addto\captionsfinnish{ %
  \def\sDegreeThesis    {Opinnäyte}%
  \def\sDegreeProgramme {Koulutusohjelma:}%
  \def\sIdentification  {Tunnistenumero:}%
  \def\sAuthor          {Tekijä:}%
  \def\sTitle           {Työn nimi:}%
  \def\sSupervisor      {Työn ohjaaja (Arcada):}%
  \def\sCommissionedBy  {Toimeksiantaja:}%
  \def\sAbstract        {Tiivistelmä:}%
  \def\sKeywords        {Avainsanat:}%
  \def\sPageCount       {Sivumäärä:}%
  \def\sLanguage        {Kieli:}%
  \def\sDateAcceptance  {Hyväksymispäivämäärä:}%
  \def\sFinnish         {Suomi}%
  \def\sEnglish         {Englanti}%
  \def\sSwedish         {Ruotsi}%
  \def\sFigure          {Figuuri}%
  \def\sTable           {Taulukko}%
}

%% }}}
%% Basic page layout {{{
\geometry{
  top=2.5cm,
  left=3cm,
  right=3cm,
  bottom=2.5cm,
  nohead,
  textwidth=15cm, % 21cm
  textheight=23.8cm,% 29.7cm
  footskip=-0.9cm}
\setlength{\parindent}{0pt}
\setlength{\parskip}{1ex}
\pagestyle{plain}
\pagenumbering{arabic}
\titleformat{\section}{%
  \LARGE\bf\fontfamily{phv}\selectfont}{\thesection}{1em}{\MakeUppercase}
\titleformat{\subsection}{%
  \LARGE\bf\fontfamily{phv}\selectfont}{\thesubsection}{1em}{}
\titleformat{\subsubsection}{%
  \Large\bf\fontfamily{phv}\selectfont}{\thesubsubsection}{1em}{}

%\titleformat{\section}{\LARGE\bf\MakeUppercase\fontfamily{phv}\selectfont}{\thesection}{1em}{}

%% }}}
%% Values passed through commands {{{

\newcommand{\university}[1]     {\gdef\@university{#1}}
\newcommand{\level}[1]          {\gdef\@level{#1}}
\newcommand{\subheading}[1]     {\gdef\@subheading{#1}}
\newcommand{\programme}[1]      {\gdef\@programme{#1}}
\newcommand{\thesisLanguage}[1] {\gdef\@thesisLanguage{#1}}
\newcommand{\identification}[1] {\gdef\@identification{#1}}
\newcommand{\supervisor}[1]     {\gdef\@supervisor{#1}}
\newcommand{\commissionedBy}[1] {\gdef\@commissionedBy{#1}}
\newcommand{\keywords}[1]       {\gdef\@keywords{#1}}

\university{Arcada}
\subheading{}
\level{}
\programme{}
\identification{}
\supervisor{}
\commissionedBy{}
\keywords{}

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
    \cbox{orange}{2cm}%
    \cbox{gray}{1pt}%
    \hspace{-4pt}%
    \cbox{orangeSaturated}{1pt}%
    \hspace{-5pt}%
    \cbox{white}{5pt}%
  }
}

% }}}
%% Title {{{

\renewcommand{\maketitle}{\
  \AddToShipoutPicture*{\backgroundbar}

  \vspace*{-1.75cm}
  \includegraphics[width=4.72cm]{logo.pdf}

  \vspace*{6.35cm}

  {\doublespacing\huge\bf\fontfamily{phv}\selectfont \@title}

  {\LARGE \@subheading}

  \vspace{1.7cm}

  \Large % 14pt

  \@author

  \vspace*{\fill}

  \begin{flushright}
    \@level\\
    \@programme\\
    \@date\\
  \end{flushright}%
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
\renewcommand*\l@section{\@dottedtocline{3}{0cm}{2.3em}}
\renewcommand*\l@subsection{\@dottedtocline{3}{0.39cm}{3em}}
\renewcommand*\l@subsubsection{\@dottedtocline{3}{0.78cm}{3.3em}}

% Style section titles
\let\stdl@section\l@section
\renewcommand*{\l@section}[2]{%
  \onehalfspace%
  \stdl@section{%
    \bf\LARGE\fontfamily{phv}\selectfont{#1}}{%
    \bf\LARGE\fontfamily{phv}\selectfont{#2}}%
}

% Style subsection titles
\let\stdl@subsection\l@subsection
\renewcommand*{\l@subsection}[2]{%
  \onehalfspace%
  \stdl@subsection{%
    \Large\fontfamily{phv}\selectfont{#1}}{%
    \Large\fontfamily{phv}\selectfont{#2}}%
}

% Style subsection titles
\let\stdl@subsubsection\l@subsubsection
\renewcommand*{\l@subsubsection}[2]{%
  \setstretch{0.8}%
  \stdl@subsubsection{%
    \Large\it\fontfamily{phv}\selectfont{#1}}{%
    \Large\it\fontfamily{phv}\selectfont{#2}}%
}

% Append section titles with dots
\renewcommand{\cftsecdotsep}{\cftdotsep}

% Override main commands
\let\stdl@tableofcontents\tableofcontents
\renewcommand*{\tableofcontents}{
  \stdl@tableofcontents
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
    \renewcommand{\arraystretch}{1.2}
    \begin{tabularx}{\textwidth}{ !{\vthickrule} p{5cm} | X !{\vthickrule} }
      \thickrule
      \coljoin{\MakeUppercase\@level}         \\ \hline% todo uppercase
      \coljoin{\@university}                  \\ \hline
      \coljoin{}                              \\ \hline
      \sDegreeProgramme    & \@programme      \\ \hline
      \coljoin{}                              \\ \hline
      \sIdentification     & \@identification \\ \hline
      \sAuthor             & \@author         \\ \hline
      \sTitle              & \@title          \\ \hline
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
      \sKeywords           & \@keywords       \\ \hline
      \sPageCount          & ..               \\ \hline %todo automagic
       \sLanguage          & \@thesisLanguage \\ \hline %todo language
      \sDateAcceptance     &                  \\ \thickrule
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
}


%% }}}

\endinput
%%
