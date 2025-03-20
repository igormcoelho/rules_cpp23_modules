# CXX = clang++-19
# CXX = g++-15
# CXX_GCC=g++-15
CXX_CLANG=clang++-19
# CXXFLAGS_GCC   += -std=c++23  -fmodules -U_FORTIFY_SOURCE -fstack-protector -Wall  -Wunused-but-set-parameter -Wno-free-nonheap-object  -fno-omit-frame-pointer '-std=c++23' -fPIC
CXXFLAGS_CLANG += -std=c++23 -stdlib=libc++ -U_FORTIFY_SOURCE -fstack-protector -Wall -Wthread-safety -Wself-assign -Wunused-but-set-parameter -Wno-free-nonheap-object -fcolor-diagnostics -fno-omit-frame-pointer '-std=c++23' -fPIC

COMPILE= -c -fmodules -fsearch-include-path bits/std.cc # --precompile

all: multi_src_clang # multi_src_gcc


multi_src_clang: std.pcm spanish_english_dictionary.pcm spanish_english_dictionary_impl.cc speech.pcm speech_impl.cc  main.cc
	echo "BUILDING HELLO WORLD ON CLANG"
	$(CXX_CLANG) $(CXXFLAGS_CLANG) -fmodule-file=std=std.pcm -fmodule-file=speech=speech.pcm  -fmodule-file=spanish_english_dictionary=spanish_english_dictionary.pcm  -o $@ $^

std.pcm: /usr/lib/llvm-19/share/libc++/v1/std.cppm 
	$(CXX_CLANG) $(CXXFLAGS_CLANG) -Wno-reserved-identifier -Wno-reserved-module-identifier --precompile -o $@ $^

speech.pcm: speech.cppm  std.pcm
	$(CXX_CLANG) $(CXXFLAGS_CLANG) -fmodule-file=std=std.pcm -Wno-reserved-identifier -Wno-reserved-module-identifier --precompile -o $@ $^


spanish_english_dictionary.pcm: spanish_english_dictionary.cppm  std.pcm
	$(CXX_CLANG) $(CXXFLAGS_CLANG) -fmodule-file=std=std.pcm -Wno-reserved-identifier -Wno-reserved-module-identifier --precompile -o $@ $^


clean:
	rm -rf *.pcm
	rm -rf *.gcm
	rm -rf *gcm
	rm -rf gcm.cache
	rm -rf multi_src_*
