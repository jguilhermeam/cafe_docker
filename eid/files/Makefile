########################################
#              Makefile                #
#                                      #
#  Roles:                              #
#        all -> compila e executa      #
#               teste com programa C   #
#                                      #
#        List -> compila modulo Lista  #
#                                      #
#        clean -> remove binarios      #
#                                      #
#        compile-> gera nova versao    #
#                  da biblioteca JNI   #
#                                      #
########################################
FLAGS = -Wall -Werror

run: compileEXE
	gcc -I/${JAVA_HOME}/include/ -I/${JAVA_HOME}/include/linux -o ${JARO_WINKLER_DIR}/jaroWinkler.exe jakoInterface.c ${JARO_WINKLER_DIR}/List.o
	${JARO_WINKLER_DIR}/jaroWinkler.exe

compileEXE: List jakoInterface.c JaroWinklerConciliationAlgorithm.c
	gcc -I/${JAVA_HOME}/include/ -I/${JAVA_HOME}/include/linux -o ${JARO_WINKLER_DIR}/jaroWinkler.exe jakoInterface.c ${JARO_WINKLER_DIR}/List.o

List: List.c List.h
	gcc -fPIC -c -o ${JARO_WINKLER_DIR}/List.o List.c

clean:
	rm ${JARO_WINKLER_DIR}/List.o; rm ${JARO_WINKLER_DIR}/libJaroWinklerLib.so; rm ${JARO_WINKLER_DIR}/jaroWinkler.exe

compile: JaroWinklerConciliationAlgorithm.c List
	gcc -fPIC  -o ${JARO_WINKLER_DIR}/libJaroWinklerLib.so -shared -Wl,-soname,JaroWinklerLib -I/${JAVA_HOME}/include/ -I/${JAVA_HOME}/include/linux JaroWinklerConciliationAlgorithm.c ${JARO_WINKLER_DIR}/List.o -lc

valgrind: compileEXE
	valgrind --leak-check=full --show-reachable=yes --log-file=relatorio.txt -v --tool=memcheck ${JARO_WINKLER_DIR}/jaroWinkler.exe
