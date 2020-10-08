# AMPL_Python
A bridge between AMPL and Python allowing users to define external functions in Python and use those functions inside AMPL models. 
This is based on existing work by PyOptimizer(https://github.com/orgs/PythonOptimizers/people).Based on their work, the following modifications
have been made;
  * Make it work on windows.
  * Because there is some problem with*Clang* on my computer, so I use *gcc* instead
    * To achieve this, I need to modify the `Makefile`
## Purpose & background
Because the official AMPL APIs to Python just allow us to transfer data with AMPL or to change the algebraic statements of the objectives and constraints. However, to the best of my knowledge, we are not allowed to use external **Python functions**  inside AMPL models. Thus, this work is devoted to bridge this gap. 

## 
    

