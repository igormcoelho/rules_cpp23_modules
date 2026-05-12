all:
	clang++ -std=c++23 -stdlib=libc++ main.cpp  -o demo
	clang++ -std=c++23 -stdlib=libc++ -fmodule-file=std=std.pcm main2.cpp -o demo2

CXXFLAGS_CLANG += -std=c++23 -stdlib=libc++ -U_FORTIFY_SOURCE -fstack-protector -Wall -Wthread-safety -Wself-assign -Wunused-but-set-parameter -Wno-free-nonheap-object -fcolor-diagnostics -fno-omit-frame-pointer '-std=c++23' -fPIC
CXXFLAGS_GCC   += -std=c++23  -fmodules -U_FORTIFY_SOURCE -fstack-protector -Wall  -Wunused-but-set-parameter -Wno-free-nonheap-object  -fno-omit-frame-pointer '-std=c++23' -fPIC
COMPILE= -c -fmodules -fsearch-include-path bits/std.cc # --precompile


std.pcm:
	clang++ ${CXXFLAGS_CLANG} -std=c++23 -stdlib=libc++ --precompile -o std.pcm /usr/lib/llvm-21/share/libc++/v1/std.cppm

std_gcm: 
	g++ $(CXXFLAGS_GCC)  ${COMPILE} $^

