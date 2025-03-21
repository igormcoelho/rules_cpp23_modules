## CXX = clang++-19
## CXX = g++-15
CXX_GCC=g++-15
CXX_CLANG=clang++-19
CXXFLAGS_GCC   += -std=c++23  -fmodules -U_FORTIFY_SOURCE -fstack-protector -Wall  -Wunused-but-set-parameter -Wno-free-nonheap-object  -fno-omit-frame-pointer '-std=c++23' -fPIC
CXXFLAGS_CLANG += -std=c++23 -stdlib=libc++ -U_FORTIFY_SOURCE -fstack-protector -Wall -Wthread-safety -Wself-assign -Wunused-but-set-parameter -Wno-free-nonheap-object -fcolor-diagnostics -fno-omit-frame-pointer '-std=c++23' -fPIC

COMPILE= -c -fmodules -fsearch-include-path bits/std.cc # --precompile

all: example_clang example_gcc

example_gcc:   main.cc std_gcm algorithm_gcm 
	echo "BUILDING HELLO WORLD ON GCC"
	$(CXX_GCC) $(CXXFLAGS_GCC) -o $@ main.cc

std_gcm: 
	$(CXX_GCC) $(CXXFLAGS_GCC)  ${COMPILE} $^

algorithm_gcm: algorithm.cppm 
	# rm -rf gcm.cache
	$(CXX_GCC) $(CXXFLAGS_GCC)  -c  $^  


example_clang: std.pcm algorithm.pcm main.cc
	echo "BUILDING HELLO WORLD ON CLANG"
	$(CXX_CLANG) $(CXXFLAGS_CLANG) -fmodule-file=std=std.pcm -fmodule-file=algorithm=algorithm.pcm  -o $@ $^

std.pcm: /usr/lib/llvm-19/share/libc++/v1/std.cppm 
	$(CXX_CLANG) $(CXXFLAGS_CLANG) -Wno-reserved-identifier -Wno-reserved-module-identifier --precompile -o $@ $^

algorithm.pcm: algorithm.cppm std.pcm
	$(CXX_CLANG) $(CXXFLAGS_CLANG) -fmodule-file=std=std.pcm -Wno-reserved-identifier -Wno-reserved-module-identifier --precompile -o $@ $^

clean:
	rm -rf *.pcm
	rm -rf *.gcm
	rm -rf *gcm
	rm -rf gcm.cache
	rm -rf hello_world_*
