
# Default goal.

all : Main

Main : AbsSyntax.hs LexSyntax.hs ParSyntax.hs PrintSyntax.hs TypeChecker.hs Interpreter.hs Main.hs
	ghc Main.hs -o interpreter

# Rules for cleaning generated files.

clean :
	-rm -f *.hi *.o *.log *.aux *.dvi