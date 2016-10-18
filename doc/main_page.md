project: fortran_tester
src_dir: ../src
         ../test
output_dir: html/publish/
project_github: https://github.com/pdebuyl/fortran_tester
summary: Fortran module to test Fortran programs
author: Pierre de Buyl
github: https://github.com/pdebuyl
md_extensions: markdown.extensions.toc(anchorlink=True)
               markdown.extensions.smarty(smart_quotes=False)
               markdown.extensions.extra
               markdown_checklist.extension
docmark: <
display: public
         protected
         private
source: true
warn: true
graph: true
extra_mods: iso_fortran_env:https://gcc.gnu.org/onlinedocs/gfortran/ISO_005fFORTRAN_005fENV.html

{!../README.md!}
