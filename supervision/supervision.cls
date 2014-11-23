\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{supervision}
    [2014/11/23 Supervision work class (Daniel Chatfield)]

\RequirePackage{etoolbox} % Provides lots of useful commands, needs to be at
                          % the top as we use several commands

\newtoggle{ShowSolutions}
\newtoggle{InQuestions}
\newtoggle{InParts}


%% Keep track of which environments we are in (used by setnumber to determine
%% which counter to set)
\AtBeginEnvironment{questions}{\toggletrue{InQuestions}}
\AtBeginEnvironment{parts}{\toggletrue{InParts}}

%% By default show solutions
\toggletrue{ShowSolutions}

%% Our custom options
\DeclareOption{hide_solutions}{
    \togglefalse{ShowSolutions}
}
\DeclareOption{answers}{
    \ClassWarning{supervision}{Ignoring option 'answers', use `hide_solutions`
    instead}
}

%% Packade options
\DeclareOption{sansserif}{
    \PassOptionsToPackage{\CurrentOption}{paxcommands}
}
\DeclareOption{neverindent}{
    \PassOptionsToPackage{\CurrentOption}{paxcommands}
}

%% If we don't know what this option is then pass it to the exam class
\DeclareOption*{
    \PassOptionsToClass{\CurrentOption}{exam}
}

%% Default options
\ExecuteOptions{12pt}

%% Process passed options
\ProcessOptions\relax

%% Check whether we should show the answers
\iftoggle{ShowSolutions}{%
    \PassOptionsToClass{answers}{exam}
}

%% Load additional packages
\RequirePackage[utf8]{inputenc} % converts unicode into latex
\RequirePackage{graphicx}
\RequirePackage{xcolor}

%% Load exam class
\LoadClass[a4paper]{exam}

%% Setup document



%% Command to set question
\newcommand{\SetQuestionNumber}[1]{
    % Check if in part environment
    \iftoggle{InParts}{
        \setcounter{partno}{#1}
        \addtocounter{partno}{-1}
    } {
        \iftoggle{InQuestions}{
            \setcounter{question}{#1}
            \addtocounter{question}{-1}
        } {
            \ClassError{supervision}{Cannot use '\\setquestionno' outside questions environment}
        }
    }

}


\endinput