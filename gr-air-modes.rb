require 'formula'

class GrAirModes < Formula
  homepage 'https://github.com/bistromath/gr-air-modes'
  head 'git://github.com/bistromath/gr-air-modes.git', :revision => 'master'

  depends_on 'cmake' => :build
  depends_on 'boost'
  depends_on 'gnuradio'

  def install
    mkdir 'build' do
      system "cmake", '..', *std_cmake_args << "-DPYTHON_LIBRARY=#{python_path}/Frameworks/Python.framework/"
      system "make"
      system "make install"
    end
  end

  def python_path
    python = Formula.factory('python')
    kegs = python.rack.children.reject { |p| p.basename.to_s == '.DS_Store' }
    kegs.find { |p| Keg.new(p).linked? } || kegs.last
  end

#  def patches
#    DATA
#  end
end

__END__

diff --git a/CMakeLists.txt b/CMakeLists.txt
index 656f60f..168147f 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -48,6 +48,7 @@ endif()
 if(UNIX AND EXISTS "/usr/lib64")
     list(APPEND BOOST_LIBRARYDIR "/usr/lib64") #fedora 64-bit fix
 endif(UNIX AND EXISTS "/usr/lib64")
+set(Boost_USE_MULTITHREADED      ON)
 set(Boost_ADDITIONAL_VERSIONS
     "1.35.0" "1.35" "1.36.0" "1.36" "1.37.0" "1.37" "1.38.0" "1.38" "1.39.0" "1.39"
     "1.40.0" "1.40" "1.41.0" "1.41" "1.42.0" "1.42" "1.43.0" "1.43" "1.44.0" "1.44"
@@ -57,7 +58,7 @@ set(Boost_ADDITIONAL_VERSIONS
     "1.60.0" "1.60" "1.61.0" "1.61" "1.62.0" "1.62" "1.63.0" "1.63" "1.64.0" "1.64"
     "1.65.0" "1.65" "1.66.0" "1.66" "1.67.0" "1.67" "1.68.0" "1.68" "1.69.0" "1.69"
 )
-find_package(Boost "1.35")
+find_package(Boost "1.35" COMPONENTS system)
 
 if(NOT Boost_FOUND)
     message(FATAL_ERROR "Boost required to compile gr_ais")
@@ -123,4 +124,4 @@ add_subdirectory(swig)
 add_subdirectory(python)
 add_subdirectory(grc)
 add_subdirectory(apps)
-add_subdirectory(docs)
\ No newline at end of file
+add_subdirectory(docs)
-- 
1.8.0.1


