CXX = g++

# -Q is a good option for debugging
CFLAGS  = -Wall -g -ggdb -DNDEBUG
#CFLAGS  = -O3 -Wall -pedantic -ansi -march=pentium4 -Woverloaded-virtual -felide-constructors -DNDEBUG -ffast-math -fomit-frame-pointer
CFLAGS_DB = -ggdb3 -pg -Wall -pedantic -ansi# -march=pentium4 -Woverloaded-virtual -felide-constructors
CFLAGS_XB = -O3 -Wall -pedantic -ansi -march=pentium4 -Woverloaded-virtual -felide-constructors -DNDEBUG -DXBOARD -ffast-math -fomit-frame-pointer
CFLAGS_DB_XB = -ggdb3 -pg -Wall -pedantic -ansi -march=pentium4 -Woverloaded-virtual -felide-constructors -DXBOARD

CFLAGS_NALIMOV = -O3 -DNDEBUG -Wall -ansi -march=pentium4 -Woverloaded-virtual -felide-constructors
CFLAGS_NALIMOV_DB = -Wall -ansi -march=pentium4 -Woverloaded-virtual -felide-constructors

#TEST = -ggdb3 -O3 -Wall -pedantic -ansi -march=pentium4 -Woverloaded-virtual -felide-constructors -ffast-math -fno-strict-aliasing

TEST = -ggdb3 -O3 -pg -Wall -pedantic -ansi -march=pentium4 -Woverloaded-virtual -felide-constructors

# tilf�j chess.o ?
# put endgame_database.o tilbage (f�r chess.o)
MODS = board.o endgame_table_bdd.o mapping_of_wildcards.o \
endgame_run_length_encoding.o run_length_encoding/bit_stream.o \
endgame_clustering_functions.o endgame_Nalimov.o board_2.o endgame_castling.o \
endgame_piece_enumerations.o endgame_square_permutations.o \
binary_decision_diagram.o endgame_database.o endgame_indexing.o endgame_en_passant.o \
 \
chess.o \
 \
cpu_communication_module.o xboard_listener.o streams.o help_functions.o settings.o \
move_and_undo.o board_tables.o board_move_tables.o \
board_2_plus.o static_exchange_evaluation.o \
board_3.o \
 \
cpu_evaluation_1.o cpu_evaluation_2.o cpu_evaluation_2_const.o cpu_evaluation_3.o \
cpu_search_1.o cpu_search_2.o cpu_search_3.o \
cpu_engines.o cpu_search.o engine.o \
 \
file_loader.o parser.o test_suite.o \
hash_value.o hash_table.o transposition_table_content.o opening_library.o \
game_phase.o piece_values.o unsigned_long_long.o \
 \
my_vector.o clustering_algorithm.o bdd_compression.o

all: chess

chess: $(MODS)
	g++ $(MODS) -o $@
#-g -ggdb3

%.o: %.cxx
	$(CXX) $(CFLAGS) -c -o $@ $<

#endgame_Nalimov.o:
#	$(CXX) -c $(CFLAGS_NALIMOV) $< -o $@

#board.o: board.cxx
#	$(CXX) $(CFLAGS) -c -o $@ $<

%.d: %.cxx
	g++ -MM $< -o $@

include ${MODS:.o=.d}

clean:
	-rm -f *.o

#clean:
#	-/bin/rm -f *.d
#	-rm -f *~
#	-rm -f *.o

#rm -f test *~ *.d *.o */*~ */*.d */*.o

#rm -f test *~ *.d *.o .\#* \#* a.out chess core tmp.* .nfs* incoming.txt big_output.txt probe_Nalimov/*~ probe_Nalimov/test help_programs/*~ help_programs/test help_programs/a.out run_length_encoding/*~ run_length_encoding/*.o

#gprof chess -b --ignore-non-functions >profiling.txt

# http://www.gnu.org/software/make/manual/make.html#Automatic-Variables