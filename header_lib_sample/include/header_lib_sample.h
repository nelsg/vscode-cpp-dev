#include <boost/format.hpp>
#include <iostream>

template <typename T>
void HeaderLibSample(T s)
{
    std::cout << (boost::format("%1% library sample") % s) << std::endl;
}
