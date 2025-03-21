all:
	clang++-19 -std=c++23 -stdlib=libc++ main.cpp  -o demo
	clang++-19 -std=c++23 -stdlib=libc++ -fmodule-file=std=std.pcm main2.cpp -o demo2

CXXFLAGS_CLANG += -std=c++23 -stdlib=libc++ -U_FORTIFY_SOURCE -fstack-protector -Wall -Wthread-safety -Wself-assign -Wunused-but-set-parameter -Wno-free-nonheap-object -fcolor-diagnostics -fno-omit-frame-pointer '-std=c++23' -fPIC

std.pcm:
	clang++-19 ${CXXFLAGS_CLANG} -std=c++23 -stdlib=libc++ --precompile -o std.pcm /usr/lib/llvm-19/share/libc++/v1/std.cppm