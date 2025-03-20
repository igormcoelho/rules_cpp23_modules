# CXX = clang++-19
CXX = g++-15
CXX_GCC=g++-15
CXX_CLANG=clang++-19
CXXFLAGS_GCC   += -std=c++23  -fmodules -U_FORTIFY_SOURCE -fstack-protector -Wall  -Wunused-but-set-parameter -Wno-free-nonheap-object  -fno-omit-frame-pointer '-std=c++23' -fPIC
CXXFLAGS_CLANG += -std=c++23 -stdlib=libc++ -U_FORTIFY_SOURCE -fstack-protector -Wall -Wthread-safety -Wself-assign -Wunused-but-set-parameter -Wno-free-nonheap-object -fcolor-diagnostics -fno-omit-frame-pointer '-std=c++23' -fPIC

# clang only: -Wthread-safety  -Wself-assign -fcolor-diagnostics -stdlib=libc++
COMPILE= -c -fmodules -fsearch-include-path bits/std.cc # --precompile

all: hello_world_clang hello_world_gcc

hello_world_gcc:   main.cc std_gcm hello_gcm # std.gcm hello.gcm -fmodule-mapper=module-all.mapper 
	echo "BUILDING HELLO WORLD ON GCC"
	$(CXX_GCC) $(CXXFLAGS_GCC) -o $@ main.cc

std_gcm: 
	$(CXX_GCC) $(CXXFLAGS_GCC)  ${COMPILE} $^

hello_gcm: hello.cppm # std.gcm #  # -fmodule-mapper=module.mapper
	# rm -rf gcm.cache
	$(CXX_GCC) $(CXXFLAGS_GCC)  -c  $^  


hello_world_clang: std.pcm hello.pcm main.cc
	echo "BUILDING HELLO WORLD ON CLANG"
	$(CXX_CLANG) $(CXXFLAGS_CLANG) -fmodule-file=std=std.pcm -fmodule-file=hello=hello.pcm  -o $@ $^

std.pcm: /usr/lib/llvm-19/share/libc++/v1/std.cppm 
	$(CXX_CLANG) $(CXXFLAGS_CLANG) -Wno-reserved-identifier -Wno-reserved-module-identifier --precompile -o $@ $^

hello.pcm: hello.cppm std.pcm
	$(CXX_CLANG) $(CXXFLAGS_CLANG) -fmodule-file=std=std.pcm -Wno-reserved-identifier -Wno-reserved-module-identifier --precompile -o $@ $^


# clang-19 -fmodules -std=c++23 -fmodule-file=std=example/module-library/std.pcm example/module-library/main.cc example/module-library/std.pcm  -std=c++23 -stdlib=libc++ -U_FORTIFY_SOURCE -fstack-protector -Wall -Wthread-safety -Wself-assign -Wunused-but-set-parameter -Wno-free-nonheap-object -fcolor-diagnostics -fno-omit-frame-pointer '-std=c++23' -fPIC

clean:
	rm -rf *.pcm
	rm -rf *.gcm
	rm -rf *gcm
	rm -rf gcm.cache
	rm -rf hello_world_*
