## CXX = clang++-19
## CXX = g++-15
CXX_GCC=g++-15
CXX_CLANG=clang++-19
CXXFLAGS_GCC   += -std=c++23  -fmodules -U_FORTIFY_SOURCE -fstack-protector -Wall  -Wunused-but-set-parameter -Wno-free-nonheap-object  -fno-omit-frame-pointer '-std=c++23' -fPIC
CXXFLAGS_CLANG += -std=c++23 -stdlib=libc++ -U_FORTIFY_SOURCE -fstack-protector -Wall -Wthread-safety -Wself-assign -Wunused-but-set-parameter -Wno-free-nonheap-object -fcolor-diagnostics -fno-omit-frame-pointer '-std=c++23' -fPIC

COMPILE= -c -fmodules -fsearch-include-path bits/std.cc # --precompile

all: trans_clang trans_gcc

trans_gcc:   main.cc std_gcm b_gcm a_gcm 
	echo "BUILDING HELLO WORLD ON GCC"
	$(CXX_GCC) $(CXXFLAGS_GCC) -o $@ main.cc

std_gcm: 
	$(CXX_GCC) $(CXXFLAGS_GCC)  ${COMPILE} $^

a_gcm: a.cppm 
	# rm -rf gcm.cache
	$(CXX_GCC) $(CXXFLAGS_GCC)  -c  $^  

b_gcm: b.cppm 
	# rm -rf gcm.cache
	$(CXX_GCC) $(CXXFLAGS_GCC)  -c  $^  


trans_clang: std.pcm b.pcm a.pcm  main.cc
	echo "BUILDING HELLO WORLD ON CLANG"
	$(CXX_CLANG) $(CXXFLAGS_CLANG) -fmodule-file=std=std.pcm -fmodule-file=a=a.pcm -fmodule-file=b=b.pcm  -o $@ $^

std.pcm: /usr/lib/llvm-19/share/libc++/v1/std.cppm 
	$(CXX_CLANG) $(CXXFLAGS_CLANG) -Wno-reserved-identifier -Wno-reserved-module-identifier --precompile -o $@ $^

a.pcm: std.pcm b.pcm a.cppm 
	echo "Building Module A"
	$(CXX_CLANG) $(CXXFLAGS_CLANG) -fmodule-file=std=std.pcm -fmodule-file=b=b.pcm -Wno-reserved-identifier -Wno-reserved-module-identifier --precompile -o $@ $^

b.pcm: std.pcm b.cppm 
	echo "Building Module B"
	$(CXX_CLANG) $(CXXFLAGS_CLANG) -fmodule-file=std=std.pcm -Wno-reserved-identifier -Wno-reserved-module-identifier --precompile -o $@ $^

clean:
	rm -rf *.pcm
	rm -rf *.gcm
	rm -rf *gcm
	rm -rf gcm.cache
	rm -rf hello_world_*
