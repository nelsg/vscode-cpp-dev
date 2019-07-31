#include "static_lib_sample.h"
#include <boost/format.hpp>
#include <iostream>
#include <string>

void StaticLibSample(std::string s) { std::cout << (boost::format("%1% library sample") % s) << std::endl; }
