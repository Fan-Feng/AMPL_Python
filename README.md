# AMPL_Python
A bridge between AMPL and Python allowing users to define external functions in Python and use those functions inside AMPL models. This is based on existing work by [PyOptimizer](https://github.com/PythonOptimizers/pyampl). Based on their work, the following modifications have been made;
  * Make it work on windows.
  * Because there is some problem with *Clang* on my computer, so I use *gcc* instead
    * To achieve this, I need to modify the `Makefile`
## Purpose & background
Because the official AMPL APIs to Python just allow us to transfer data with AMPL or to change the algebraic statements of the objectives and constraints. However, to the best of my knowledge, we are not allowed to use external **Python functions**  inside AMPL models. Thus, this work is devoted to bridge this gap. 

The whole flowchart are shown below.

![Flowchart](./Figs/Flowchart.png)

**1)** Preparation

You need to have GCC or other compilers(e.g. Clang, MSVC) in your computer. For convenience, you could install Mingw, which is a collection of several compilers. You need to add it to you path to allow you run it from command line.
One important note is **if you are using 32-bit AMPL, you need to use 32-bit GCC or compile 32-bit DLL file. Also, you need to use 64 bit for 64-bit AMPL. Otherwise, you will get some errors because of compatibility issues**

**2)** `amplsolve.lib`

First, we need to compile an AMPL Solver library-`amplsolv.lib`. This library is necessary for C/C++ to communicate with AMPl.
**Step1.** Change your directory to folder-ASL
**Step2.** Run command
> make  // You might need to run Mingw32-make or you can make an alias for this.

**Step3.** The previous steps should create `amplsolv.lib`

**3)**`amplfunc.dll`

Then, compile `amplfunc.dll` without embedding **Python**.  The C file for this is **funcadd.c**.
Basically, the compilation of DLL files involves three steps: [**Pre-processing**,**compilation**, and **linking**](https://stackoverflow.com/questions/6264249/how-does-the-compilation-linking-process-work). Therefore, there are two issues that should gain significant attentions. That is, i) set correct include directories, where we could find all necessary `.h` files, and ii) correct lib directories, where we could find all required `lib` and `dll` files. 
Usually the compilation tasks are defined in a **Makefile** file. There are many good Makefile tutorials available(e.g. [1](https://opensource.com/article/18/8/what-how-makefile)), and necessary knowledge about Makefile could be easily gained by reading these tutorials. Therefore, both the include directories and lib directories are provided in Makefile, as below. These are the directories in my computer and should be modified accordingly. 

![Alt text](./Figs/snippetOfMakefile.png)

After this, run **make**to compile **amplfunc.dll**.
If nothing goes wrong, we will get this dll file. Now we can load it in AMPL to see if it works. The test script is shown below.

	load amplfunc.dll;
	function ginv;
	
	param p1;
	let p1 := ginv(10);
	display p1;

Again, if nothing goes wrong, AMPL will display
	>p1=0.1


#### Q&A
**1.** Different from compiling an executable program, compiling an DLL file requires us to provide an argument--:**-shared** to gcc command. Otherwise, 
    

