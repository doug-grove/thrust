#include <unittest/unittest.h>
#include <thrust/distance.h>

// TODO expand this with other iterator types (forward, bidirectional, etc.)

template <typename Vector>
void TestDistance(void)
{
    typedef typename Vector::value_type T;
    typedef typename Vector::iterator Iterator;

    Vector v(100);

    Iterator i = v.begin();

    ASSERT_EQUAL(thrust::distance(i, v.end()), 100);

    i++;

    ASSERT_EQUAL(thrust::distance(i, v.end()), 99);

    i += 49;

    ASSERT_EQUAL(thrust::distance(i, v.end()), 50);
    
    ASSERT_EQUAL(thrust::distance(i, i), 0);
}
DECLARE_VECTOR_UNITTEST(TestDistance);

template<typename InputIterator>
int distance(my_system &system, InputIterator, InputIterator)
{
    system.validate_dispatch();
    return 13;
}

void TestDistanceDispatchExplicit()
{
    thrust::device_vector<int> vec;

    my_system sys(0);
    thrust::distance(sys, vec.begin(), vec.end());

    ASSERT_EQUAL(true, sys.is_valid());
}
DECLARE_UNITTEST(TestDistanceDispatchExplicit);


template<typename InputIterator>
int distance(my_tag, InputIterator, InputIterator)
{
    return 13;
}

void TestDistanceDispatchImplicit()
{
    thrust::device_vector<int> vec;

    int result = thrust::distance(thrust::retag<my_tag>(vec.begin()),
                                  thrust::retag<my_tag>(vec.end()));

    ASSERT_EQUAL(13, result);
}
DECLARE_UNITTEST(TestDistanceDispatchImplicit);

