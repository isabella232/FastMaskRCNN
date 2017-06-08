//@ECHO OFF

set MSVCPATH="C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\bin"
set NVCCPATH="C:\Program Files\NVIDIA GPU Computing Toolkit\CUDA\v8.0\bin\nvcc.exe"
set CUDAINC="C:\Program Files\NVIDIA GPU Computing Toolkit\CUDA\v8.0\include"
set PYTHONLIBS="C:\Users\valkn\AppData\Local\Programs\Python\Python35\libs"
set PYTHONINC="C:\Users\valkn\AppData\Local\Programs\Python\Python35\include"
set NUMPYINC="C:\Users\valkn\AppData\Local\Programs\Python\Python35\lib\site-packages\numpy\core\include"
set CRTINC="C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\include"
set COREINC="C:\Program Files (x86)\Windows Kits\10\Include\10.0.15063.0\ucrt"

%NVCCPATH% -ccbin %MSVCPATH% -I%CUDAINC% -maxrregcount=0 --ptxas-options=-v --machine 64 --compile -DWIN32 -DWIN32 -DWIN64 -DNDEBUG -D_CONSOLE -D_WINDLL -D_MBCS -Xcompiler "/EHsc /W3 /nologo /O2 /FS /Zi  /MT " -o nms_kernel.cu.obj nms_kernel.cu
%NVCCPATH% gpu_nms.cpp -c -x c++ -O -o gpu_nms.obj  -I %NUMPYINC% -I %PYTHONINC%
%NVCCPATH% --shared gpu_nms.obj nms_kernel.cu.obj -o gpu_nms.pyd  -lcublas -L %PYTHONLIBS% -I %PYTHONINC% -I %NUMPYINC%