# IQ Recorder

This is a simple header file to include in a C/C++ project that easily allows recording binary data to a file. Though its name and convention is for storing IQ data, it can be used for any binary data.

To use, simply add this file to a project and add this code where needed in a different file:
```
#include "iq-recorder.h"

...
...
iq_recorder iq("my_filename.cs16"); // file input is optional, accepts any file extension

iq.record(buffer, sample_size, nsamples);
```