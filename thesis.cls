% !TEX encoding = UTF-8 Unicode
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
\RequirePackage{subfigure} % @TODO deprecate
\RequirePackage[titles,subfigure]{tocloft} % Customize ToC
\RequirePackage[parfill]{parskip} %
\RequirePackage[]{natbib} % Bibliography
\RequirePackage{hyperref} % Hyperlinks
\RequirePackage{ulem} % Underlined, remember to reset emph back to normal

% As we need to calculate the width of the localized word `table` as this is
% used as an offset in the LoT. Same issue for the LoF.
\newlength{\figurelength}
\newlength{\tablelength}

\ifx\template\undefined
  \newcommand{\template}{template}
  \PackageWarning{thesis}{Using default thesis path, you should define it.}
\fi

\DeclareOption{finnish}{%
  \def\LANGUAGE{\sFinnish}
  \setlength{\figurelength}{\widthof{Figuuri~99.~}}
  \setlength{\tablelength}{\widthof{Taulukko~99.~}}
  % This gets called at begin{document} by bibtex
  \main@language{finnish}%
}
\DeclareOption{swedish}{%
  \def\LANGUAGE{\sSwedish}%
  \setlength{\figurelength}{\widthof{Figur~99.~}}%
  \setlength{\tablelength}{\widthof{Tabell~99.~}}%
  \main@language{swedish}%
}
\DeclareOption{english}{%
  \def\LANGUAGE{\sEnglish}%
  \setlength{\figurelength}{\widthof{Figuuri~99.~}}%
  \setlength{\tablelength}{\widthof{Taulukko~99.~}}%
  \main@language{english}%
}

\newif\ifisListing
\DeclareOption{listing}{\isListingtrue}

\newif\ifisSyntax
\DeclareOption{syntax}{\isSyntaxtrue}

% Pass stuff through to article but remember if we did so we can use arcadas
% defaults otherwise.
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ExecuteOptions{swedish}
\ProcessOptions\relax

% Look for images in a couple of places
\graphicspath{{\template/}{./images/}}

% Define a pagecount command which will be used in the bibtex bst to determine
% the order of p. and the pagecount (i.e., s. 123 in Swedish, 123 p. in
% English)
\newcommand{\pagecount}[2]{#1 #2}

% }}}
%% Listings & Syntax etc. {{{

\ifisListing
  \input{\template/helpers/lststyles}
\fi

\ifisSyntax
  \input{\template/helpers/syntax}
\fi

%% }}}
%% Hyperlinks {{{
\hypersetup{
  colorlinks=true,
  urlcolor=black,
  filecolor=black,
  citecolor=black,
  linkcolor=black,
  linktoc=all
}

% Reset emph back to normal due to ulem package.
\normalem

% Underline URLs
\useunder{\uline}{\ulined}{}
\makeatletter
\def\url@ulstyle{\def\UrlFont{\ulined}}
\makeatother
\urlstyle{ul}

%% }}}
%% Layout and Typography {{{

\geometry{%
% Top and bottom margin uses 2.5cm.
  top=2.5cm,
  bottom=5.4cm, % 2.5cm + 0.9cm.
% Left and right margin used 3cm.
  left=3cm,
  right=3cm,
% The footer has a height of 0.9cm.
  nohead,
  footskip=0.1cm}

% No paragraph indentation.
\setlength{\parindent}{0pt}

% One empty.
\setlength{\parskip}{\baselineskip}

% Line height 1.5.
\setstretch{1.5}

% Use plain page numbers in the footer.
\pagestyle{plain}

% Use arabic numerals for page numbers.
\pagenumbering{arabic}

% Level 1 titles use uppercased 17pt bold instead pf 14pt as the specification
% states.
\titleformat{\section}{%
  \Large\bf\fontfamily{phv}\selectfont}{\thesection}{1em}{\MakeUppercase}

% Level 2 titles use 17pt bold instead pf 14pt as the specification states.
\titleformat{\subsection}{%
  \Large\bf\fontfamily{phv}\selectfont}{\thesubsection}{1em}{}

% Level 3 titles use 14pt bold instead pf 12pt as the specification states.
\titleformat{\subsubsection}{%
  \large\bf\fontfamily{phv}\selectfont}{\thesubsubsection}{1em}{}

% Titles has 24pt spacing above and 12pt spacing beneath. However as
% paragraphs should use a \blanklineskip beneath and 0pt above, we need to
% tailor this a bit by looking at the example provided.
\titlespacing*{\section}{0pt}{10pt}{0pt}
\titlespacing*{\subsection}{0pt}{10pt}{0pt}
\titlespacing*{\subsubsection}{0pt}{10pt}{0pt}

% Caption styles arent specified further than that they should be italic.
% We define our own style which is aligned to the left with a size of 10pt
% ftp://ctan.tug.org/ctan/macros/latex2e/contrib/caption/caption-eng.pdf
\captionsetup[table]{%
  position=top, labelsep=period,%
  singlelinecheck=false, justification=justified,% align left
  textfont=it, labelfont=it, font=footnotesize}
\captionsetup[figure]{%
  position=bottom, labelsep=period,%
  singlelinecheck=false, justification=justified,% align left
  textfont=it, labelfont=it, font=footnotesize}

% Citations

% Use 10pt and a 1.5 lineheight even though the specification tells us to use
% 1.
\renewenvironment{quote}{%
  \list{}{%
    \onehalfspacing\footnotesize\leftmargin0.5cm}
  \item\relax}{%
    \endlist}

% Remove comma from inline citations.
\bibpunct[ ]{(}{)}{,}{a}{}{,}

%% }}}
%% Colors {{{

% Used for the background  
%Cover pre autumn  2014
%\definecolor{orange}{RGB}          {247,149,70}
%\definecolor{orangeSaturated}{RGB} {202,162,130}
%\definecolor{gray}{RGB}            {241,241,241}
%\definecolor{white}{RGB}           {255,255,255}

% Cover post autumn 2014
\definecolor{coverBlack}{RGB}          {0,0,0}

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
  % Swap order of p. and the number in english.
  \renewcommand{\pagecount}[2] {#2 #1}%
}
\addto\captionsswedish{%
  \def\sDegreeThesis           {Examensarbete}%
  \def\sDegreeProgramme        {Utbildningsprogram:}%
  \def\sIdentification         {Identifikationsnummer:}%
  \def\sAuthor                 {F\"orfattare:}%
  \def\sTitle                  {Arbetets namn:}%
  \def\sSupervisor             {Handledare (Arcada):}%
  \def\sCommissionedBy         {Uppdragsgivare:}%
  \def\sAbstract               {Sammandrag:}%
  \def\sKeywords               {Nyckelord:}%
  \def\sPageCount              {Sidantal:}%
  \def\sLanguage               {Spr\aa k:}%
  \def\sDateAcceptance         {Datum f\"or godk\"annande:}%
  \def\sFinnish                {Finska}%
  \def\sEnglish                {Engelska}%
  \def\sSwedish                {Svenska}%
  \def\sFigure                 {Figur}%
  \def\sTable                  {Tabell}%
  \renewcommand\listfigurename {Figurer}%
  \renewcommand\listtablename  {Tabeller}%
  \renewcommand\refname        {K\"allor}%
  \renewcommand{\pagecount}[2] {#2 #1}%
}
\addto\captionsfinnish{%
  \def\sDegreeThesis           {Opinn\"ayte}%
  \def\sDegreeProgramme        {Koulutusohjelma:}%
  \def\sIdentification         {Tunnistenumero:}%
  \def\sAuthor                 {Tekij\"a:}%
  \def\sTitle                  {Ty\"on nimi:}%
  \def\sSupervisor             {Ty\"on ohjaaja (Arcada):}%
  \def\sCommissionedBy         {Toimeksiantaja:}%
  \def\sAbstract               {Tiivistelm\"a:}%
  \def\sKeywords               {Avainsanat:}%
  \def\sPageCount              {Sivum\"a\"ar\"a:}%
  \def\sLanguage               {Kieli:}%
  \def\sDateAcceptance         {Hyv\"aksymisp\"aiv\"am\"a\"ar\"a:}%
  \def\sFinnish                {Suomi}%
  \def\sEnglish                {Englanti}%
  \def\sSwedish                {Ruotsi}%
  \def\sFigure                 {Figuuri}%
  \def\sTable                  {Taulukko}%
  \renewcommand\listfigurename {Figuurit}%
  \renewcommand\listtablename  {Taulukkot}%
  \renewcommand{\pagecount}[2] {#1 #2}%
}

%% }}}
%% Background bar {{{

\newcommand\cbox[2]{%
  \colorbox{#1}{\parbox[b][\paperheight]{#2}{\vfill\hfill}}%
}
\newcommand\backgroundbar{
  \put(0,0){%
    \cbox{coverBlack}{1.3cm}%
%Pre autumn 2014    
%    \cbox{orange}{1.3cm}%
%    \cbox{gray}{1pt}%
%    \hspace{-4pt}%
%    \cbox{orangeSaturated}{1pt}%
%    \hspace{-6pt}%
%    \cbox{white}{5pt}%
  }
}

% }}}
%% Title {{{

% As the ubuntu repository doesn't contain the latest version of geometry which
% has the command \newgeometry, we need to do an ugly hack which requires the
% title page to be printed first
\addtolength\textheight{3cm}

\renewcommand{\maketitle}{%
  \AddToShipoutPicture*{\backgroundbar}
  \begin{adjustwidth}{-0.5cm}{}\begin{spacing}{2.0}
    \vspace*{-1.75cm}
    \includegraphics[width=4.72cm]{logo.pdf}

    \vspace*{6.35cm}

    % Title of the document is 20pt bold
    {\LARGE\bf\fontfamily{phv}\selectfont \TITLE}

    % Subheading of the document is 17pt
    {\Large \SUBHEADING}

    \vspace{1.7cm}

    \begin{large} % 14pt
      \AUTHOR

      \vspace*{\fill}
      \begin{adjustwidth}{}{-2.5cm}
        \begin{flushright}
          \onehalfspacing
          \LEVEL\\
          \PROGRAMME\\
          \DATE\\
        \end{flushright}%
      \end{adjustwidth}%
    \end{large}
  \end{spacing}\end{adjustwidth}
  \addtolength\textheight{-3cm} % Reset to original textheight
}
%% }}}
%% Tables (tocloft) {{{

% Don't show page numbering on the table pages
\addtocontents{toc}{\protect\thispagestyle{empty}}
\addtocontents{lof}{\protect\thispagestyle{empty}}
\addtocontents{lot}{\protect\thispagestyle{empty}}

% LoF entries are numbered with `Figure ~Number.`
\setlength{\cftfigindent}{0cm} % Remove indentation
\setlength{\cftfignumwidth}{\figurelength}
\renewcommand*\cftfigpresnum{\sFigure~}
\renewcommand{\cftfigaftersnum}{.~}

% LoF entries are numbered with `Table ~Number.`
\setlength{\cfttabindent}{0cm} % Remove indentation
\setlength{\cfttabnumwidth}{\tablelength}
\renewcommand*\cfttabpresnum{\sTable~}
\renewcommand{\cfttabaftersnum}{.~}

% Change space between numbering and ToC titles
\makeatletter
\renewcommand*\l@section{\@dottedtocline{3}{0cm}{1cm}}
\renewcommand*\l@subsection{\@dottedtocline{3}{0.39cm}{1.2cm}}
\renewcommand*\l@subsubsection{\@dottedtocline{3}{0.78cm}{1.5cm}}
\makeatother

% Style section titles
\makeatletter
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

\let\stdl@subsubsection\l@subsubsection
\renewcommand*{\l@subsubsection}[2]{%
  \stdl@subsubsection{%
    \it\fontsize{11pt}{0pt}\fontfamily{phv}\selectfont{#1}}{%
    \it\fontsize{11pt}{0pt}\fontfamily{phv}\selectfont{#2}}%
}
\makeatother

% Append section titles with dots
\renewcommand{\cftsecdotsep}{\cftdotsep}

% Override main commands
\makeatletter
\let\stdtableofcontents\tableofcontents
\renewcommand*{\tableofcontents}{
  \stdtableofcontents
  \newpage
}
\makeatother

%% }}}
%% Abstract {{{

\newcommand{\coljoin}[1]{\multicolumn{2}{ !{\VRule[2pt]} l !{\VRule[2pt]} }{#1}}
\newcommand{\thickrule}{\specialrule{2pt}{0pt}{0pt}}
\newcommand\VRule[1][\arrayrulewidth]{\vrule width #1}
\newcommand{\vthickrule}{\vrule width 2pt}
\renewenvironment{abstract}[1]{%
  \expandafter\otherlanguage\expandafter{#1}%
  \pagestyle{empty}
  \newpage
    \normalsize
    \singlespacing
    \renewcommand{\arraystretch}{1.1}
    \begin{tabularx}{\textwidth}{ !{\vthickrule} p{5cm} | X !{\vthickrule} }
      \thickrule
      \coljoin{\MakeUppercase\LEVEL}          \\ \hline
      \coljoin{\UNIVERSITY}                   \\ \hline
      \coljoin{}                              \\ \hline
      \sDegreeProgramme    & \PROGRAMME       \\ \hline
      \coljoin{}                              \\ \hline
      \sIdentification     & \IDENTIFICATION  \\ \hline
      \sAuthor             & \AUTHOR          \\ \hline
      \sTitle              & \TITLE           \\ \hline
      \sSupervisor         & \SUPERVISOR      \\ \hline
      \coljoin{}                              \\ \hline
      \sCommissionedBy     & \COMMISSIONEDBY  \\ \hline
      \coljoin{}                              \\ \thickrule
      \coljoin{\sAbstract}                    \\ %todo do this in a nicer way
    \end{tabularx}%
    \vskip -16pt%
    \tabularx{\textwidth}{ !{\vthickrule} X !{\vthickrule} }%
}{%
    \endtabularx
    \vskip -16pt%
    \begin{tabularx}{\textwidth}{ !{\vthickrule} p{5cm} | X !{\vthickrule} }
      \thickrule
      \sKeywords           & \KEYWORDS          \\ \hline
      \sPageCount          & \PAGECOUNT         \\ \hline
      \sLanguage           & \LANGUAGE          \\ \hline
      \sDateAcceptance     & \DATEACCEPTANCE    \\ \thickrule
    \end{tabularx}
    \endotherlanguage
    \pagestyle{empty}
    \newpage
}
%% }}}
%% Bibliography {{{

% Because of a compatability issue between natbib and older versions of makebst
% we need to renew these commands not to trigger the following error:
%   ! Extra }, or forgotten \endgroup.
%   \par ...m \@noitemerr {\@@par }\fi \else {\@@par }
% @see http://www.latex-community.org/forum/viewtopic.php?f=19&t=10955

% \renewcommand{\bibAnnoteFile}[1]{%
% \IfFileExists{#1}{\begin{quotation}\noindent\texts c{Key:} #1\\
% \textsc{Annotation:}\ \input{#1}\end{quotation}}{}}
%
% \renewcommand{\bibAnnote}[2]{%
% \begin{quotation}\noindent\textsc{Key:} #1\\
% \textsc{Annotation:}\ #2\end{quotation}}

\bibliographystyle{\template/bibliography/bibliography}
\setlength{\bibsep}{\baselineskip}

\let\stdbibliography\bibliography
\renewcommand*{\bibliography}[1]{
  \newpage
  \begingroup
  \singlespacing
  \raggedright
  \stdbibliography{#1}
  \endgroup
  \addcontentsline{toc}{section}{\refname}
}
\makeatother

%% }}}
