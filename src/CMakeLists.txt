set(LIB fortran_tester)
add_library(${LIB} tester.f90)
add_library(${NAMESPACE}${LIB} ALIAS ${LIB})

target_include_directories(${LIB}
    INTERFACE
        $<BUILD_INTERFACE:${CMAKE_Fortran_MODULE_DIRECTORY}>
)

# installation and export of targets
include(GNUInstallDirs)

# installation and export of targets
install(DIRECTORY ${CMAKE_Fortran_MODULE_DIRECTORY}/
    DESTINATION
        ${CMAKE_INSTALL_INCLUDEDIR}/${PROJECT_NAME}
    COMPONENT
        ${PROJECT_NAME}_Developement
)

install(TARGETS ${LIB} EXPORT ${TARGETS_EXPORT_NAME}
    ARCHIVE
        DESTINATION ${CMAKE_INSTALL_LIBDIR}
        COMPONENT ${PROJECT_NAME}_Development
    LIBRARY
        DESTINATION ${CMAKE_INSTALL_LIBDIR}
        COMPONENT ${PROJECT_NAME}_Runtime
        # NAMELINK_COMPONENT ${PROJECT_NAME}_Developement #needs cmake 3.12 or higher
    RUNTIME
        DESTINATION ${CMAKE_INSTALL_BINDIR}
        COMPONENT ${PROJECT_NAME}_Runtime
    INCLUDES
        DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/${PROJECT_NAME}
        COMPONENT ${PROJECT_NAME}_Development
)
