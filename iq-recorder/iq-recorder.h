#ifndef IQ_RECORDER_H_
#define IQ_RECORDER_H_
#include <stdio.h>
#include <string>

class iq_recorder
{
private:
    FILE *file_ptr;

public:
    iq_recorder()
    {
        file_ptr = fopen("output.bin", "wb");
    }

    iq_recorder(std::string filename)
    {
        file_ptr = fopen(filename.c_str(), "wb");
    }

    iq_recorder(const char *filename)
    {
        file_ptr = fopen(filename, "wb");
    }

    iq_recorder(char *filename)
    {
        file_ptr = fopen(filename, "wb");
    }

    ~iq_recorder()
    {
        fclose(file_ptr);
    }

    inline void record(void *buffer, size_t sample_size, size_t nsamples)
    {
        fwrite(buffer, sample_size, nsamples, file_ptr);
    }
};

#endif // IQ_RECORDER_H_
