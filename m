From: Knut Neumann <knut.neumann-4bfl1RV3iZDOEhgYWvzSCYQuADTiUCJX@public.gmane.org>
Subject: Autotools for ospmd
Date: Fri, 28 Mar 2003 18:55:20 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1048874120.11321.5.camel@bacchus.gpphy.uni-duesseldorf.de>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="Boundary_(ID_lkBN4/y7KennPfS2FQCNSw)"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
Cc: andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--Boundary_(ID_lkBN4/y7KennPfS2FQCNSw)
Content-type: text/plain
Content-transfer-encoding: 7BIT

Hi Andrew,

the recent discussion about ospmd made me remember that I still have
some patches floating around. One of them was a transition-to-autotools
patch which I cleaned up and which is attached.

It should work - at least it did on the machines I could test it on - in
case there are issues I am willing to fix :)

I hope that helps - I was not sure about the COPYING file because of
licensing issues so I let it to you to fill it with something...

Regards
-Knut


--Boundary_(ID_lkBN4/y7KennPfS2FQCNSw)
Content-type: text/x-patch; charset=ISO-8859-15; name=autotools.patch
Content-disposition: attachment; filename=autotools.patch
Content-transfer-encoding: 7BIT

diff -ur --new-file ospmd-20030327.virgin/AUTHORS ospmd-20030327/AUTHORS
--- ospmd-20030327.virgin/AUTHORS	Thu Jan  1 01:00:00 1970
+++ ospmd-20030327/AUTHORS	Fri Mar 28 17:37:50 2003
@@ -0,0 +1 @@
+Andrew Grover <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
diff -ur --new-file ospmd-20030327.virgin/COPYING ospmd-20030327/COPYING
--- ospmd-20030327.virgin/COPYING	Thu Jan  1 01:00:00 1970
+++ ospmd-20030327/COPYING	Fri Mar 28 18:24:26 2003
@@ -0,0 +1 @@
+TBD
\ No newline at end of file
diff -ur --new-file ospmd-20030327.virgin/Makefile ospmd-20030327/Makefile
--- ospmd-20030327.virgin/Makefile	Tue Oct  8 20:16:36 2002
+++ ospmd-20030327/Makefile	Thu Jan  1 01:00:00 1970
@@ -1,9 +0,0 @@
-DIRS = ospmd libpower gui
-
-all:
-	for i in $(DIRS); do $(MAKE) -C $$i $@; done;
-
-clean:
-	for i in $(DIRS); do $(MAKE) -C $$i $@; done;
-
-.PHONY: all clean
diff -ur --new-file ospmd-20030327.virgin/Makefile.am ospmd-20030327/Makefile.am
--- ospmd-20030327.virgin/Makefile.am	Thu Jan  1 01:00:00 1970
+++ ospmd-20030327/Makefile.am	Fri Mar 28 14:25:27 2003
@@ -0,0 +1,4 @@
+SUBDIRS = 	 \
+	libpower \
+	gui	 \
+	ospmd 	
diff -ur --new-file ospmd-20030327.virgin/acinclude.m4 ospmd-20030327/acinclude.m4
--- ospmd-20030327.virgin/acinclude.m4	Thu Jan  1 01:00:00 1970
+++ ospmd-20030327/acinclude.m4	Fri Mar 28 17:05:50 2003
@@ -0,0 +1,525 @@
+dnl    This file ripped out of KDE, bug fixed and put on a major diet
+dnl    by Eric Blossom <eb-6J4zr+/w64/QT0dZR+AlfA@public.gmane.org>
+
+dnl    This file is part of the KDE libraries/packages
+dnl    Copyright (C) 1997 Janos Farkas (chexum-s/K2OiAIPkgiQ7mxAueCOg@public.gmane.org)
+dnl              (C) 1997,98,99 Stephan Kulow (coolo-RoXCvvDuEio@public.gmane.org)
+dnl		 (C) 2001 Free Software Foundation, Inc.
+
+dnl    This file is free software; you can redistribute it and/or
+dnl    modify it under the terms of the GNU Library General Public
+dnl    License as published by the Free Software Foundation; either
+dnl    version 2 of the License, or (at your option) any later version.
+
+dnl    This library is distributed in the hope that it will be useful,
+dnl    but WITHOUT ANY WARRANTY; without even the implied warranty of
+dnl    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+dnl    Library General Public License for more details.
+
+dnl    You should have received a copy of the GNU Library General Public License
+dnl    along with this library; see the file COPYING.LIB.  If not, write to
+dnl    the Free Software Foundation, Inc., 59 Temple Place - Suite 330,
+dnl    Boston, MA 02111-1307, USA.
+
+
+dnl
+dnl	KDE_USE_QT
+dnl	KDE_USE_QT([version[,"min version string" [,"qt version string"]]])
+dnl
+dnl	Specify which version of QT is required.  Default is 2.1 or later
+dnl
+dnl	sets:
+dnl		kde_qtver, kde_qtsubver, kde_qt_minversion, kde_qt_verstring,
+dnl		kde_qt_dirs
+dnl
+
+AC_DEFUN(KDE_USE_QT,
+[
+
+if test -z "$1"; then
+  kde_qtver=2
+  kde_qtsubver=1
+else
+  kde_qtsubver=`echo "$1" | sed -e 's#[0-9]\+\.\([0-9]\+\).*#\1#'`
+  # following is the check if subversion isn?t found in passed argument
+  if test "$kde_qtsubver" = "$1"; then
+    kde_qtsubver=1
+  fi
+  kde_qtver=`echo "$1" | sed -e 's#^\([0-9]\+\)\..*#\1#'`
+  if test "$kde_qtver" = "1"; then
+    kde_qtsubver=42
+  else
+   # this is the version number fallback to 2.1, unless major version is 1 or 2
+   if test "$kde_qtver" != "2"; then
+    kde_qtver=2
+    kde_qtsubver=1
+   fi
+  fi
+fi
+
+if test -z "$2"; then
+  if test $kde_qtver = 2; then
+    if test $kde_qtsubver -gt 0; then
+      kde_qt_minversion=">= Qt 2.2.1"
+    else
+      kde_qt_minversion=">= Qt 2.0.2"
+    fi
+  else
+    kde_qt_minversion=">= 1.42 and < 2.0"
+  fi
+else
+   kde_qt_minversion=$2
+fi
+
+if test -z "$3"; then
+   if test $kde_qtver = 2; then
+    if test $kde_qtsubver -gt 0; then
+      kde_qt_verstring="QT_VERSION >= 221"
+    else
+      kde_qt_verstring="QT_VERSION >= 200"
+    fi
+   else
+    kde_qt_verstring="QT_VERSION >= 142 && QT_VERSION < 200"
+  fi
+else
+   kde_qt_verstring=$3
+fi
+
+if test $kde_qtver = 2; then
+   kde_qt_dirs="$QTDIR /usr/lib/qt3 /usr/lib/qt2 /usr/lib/qt"
+else
+   kde_qt_dirs="$QTDIR /usr/lib/qt"
+fi
+])
+
+
+dnl ------------------------------------------------------------------------
+dnl Try to find the Qt headers and libraries.
+dnl $(QT_LDFLAGS) will be -Lqtliblocation (if needed)
+dnl and $(QT_INCLUDES) will be -Iqthdrlocation (if needed)
+dnl ------------------------------------------------------------------------
+dnl
+
+AC_DEFUN(AC_PATH_QT,
+[
+AC_REQUIRE([AC_PATH_XTRA])
+AC_REQUIRE([KDE_USE_QT])
+
+dnl ------------------------------------------------------------------------
+dnl Add configure flag to enable linking to MT version of Qt library.
+dnl ------------------------------------------------------------------------
+
+AC_ARG_ENABLE(
+  mt,
+  [  --enable-mt             link to threaded Qt (experimental)],
+  kde_use_qt_mt=$enableval,
+  kde_use_qt_mt=yes
+)
+
+USING_QT_MT=""
+
+dnl ------------------------------------------------------------------------
+dnl If we got --enable-qt-mt then adjust some vars for the host.
+dnl ------------------------------------------------------------------------
+
+if test "x$kde_use_qt_mt" = "xyes"; then
+
+  case $host in
+  *-*-linux-*)
+    if test "x$GCC" = "xyes"; then
+      CPPFLAGS="$CPPFLAGS -DQT_THREAD_SUPPORT -pthread"
+      X_EXTRA_LIBS="$X_EXTRA_LIBS -pthread"
+    else
+      AC_MSG_WARN([Compiler is not gcc. MT support disabled.])
+    fi
+    ;;
+  *)
+    AC_MSG_WARN([MT not yet supported on $host - disabled.])
+    ;;
+  esac
+
+fi
+
+dnl ------------------------------------------------------------------------
+dnl If we haven't been told how to link to Qt, we work it out for ourselves.
+dnl ------------------------------------------------------------------------
+
+LIBQT_GLOB="libqt.*"
+
+if test -z "$LIBQT"; then
+
+  LIBQT="-lqt"
+  kde_int_qt="-lqt"
+
+dnl ------------------------------------------------------------------------
+dnl If we got --enable-qt-mt then adjust the Qt library name for the host.
+dnl ------------------------------------------------------------------------
+
+  if test "x$kde_use_qt_mt" = "xyes"; then
+
+      case $host in
+      *-*-linux-*)
+        if test "x$GCC" = "xyes"; then
+          LIBQT="-lqt-mt"
+          kde_int_qt="-lqt-mt"
+          LIBQT_GLOB="libqt-mt.*"
+          USING_QT_MT="using -mt"
+        fi
+      ;;
+      esac
+  fi
+
+else
+  kde_int_qt="$LIBQT"
+fi
+
+if test $kde_qtver = 2; then
+
+  dnl -eb __AC_REQUIRE([AC_FIND_PNG])
+  dnl -eb __AC_REQUIRE([AC_FIND_JPEG])
+  dnl -eb LIBQT="$LIBQT $LIBPNG $LIBJPEG"
+  :
+fi
+
+AC_MSG_CHECKING([for Qt])
+
+dnl -eb
+dnl LIBQT="$LIBQT $X_PRE_LIBS -lXext -lX11 $LIBSM $LIBSOCKET"
+LIBQT="$LIBQT $X_PRE_LIBS $X_EXTRA_LIBS -lXext -lX11 $X_LIBS"
+
+ac_qt_includes=NO ac_qt_libraries=NO ac_qt_bindir=NO
+qt_libraries=""
+qt_includes=""
+AC_ARG_WITH(qt-dir,
+    [  --with-qt-dir=DIR       where the root of Qt is installed ],
+    [  ac_qt_includes="$withval"/include
+       ac_qt_libraries="$withval"/lib
+       ac_qt_bindir="$withval"/bin
+    ])
+
+AC_ARG_WITH(qt-includes,
+    [  --with-qt-includes=DIR  where the Qt includes are. ],
+    [
+       ac_qt_includes="$withval"
+    ])
+
+kde_qt_libs_given=no
+
+AC_ARG_WITH(qt-libraries,
+    [  --with-qt-libraries=DIR where the Qt library is installed.],
+    [  ac_qt_libraries="$withval"
+       kde_qt_libs_given=yes
+    ])
+
+AC_CACHE_VAL(ac_cv_have_qt,
+[#try to guess Qt locations
+
+qt_incdirs=""
+for dir in $kde_qt_dirs; do
+   qt_incdirs="$qt_incdirs $dir/include $dir"
+done
+qt_incdirs="$QTINC $qt_incdirs /usr/local/qt/include /usr/include/qt /usr/include /usr/X11R6/include/X11/qt /usr/X11R6/include/qt $x_includes"
+if test ! "$ac_qt_includes" = "NO"; then
+   qt_incdirs="$ac_qt_includes $qt_incdirs"
+fi
+
+if test "$kde_qtver" = "2"; then
+  kde_qt_header=qstyle.h
+else
+  kde_qt_header=qglobal.h
+fi
+
+AC_FIND_FILE($kde_qt_header, $qt_incdirs, qt_incdir)
+ac_qt_includes="$qt_incdir"
+
+qt_libdirs=""
+for dir in $kde_qt_dirs; do
+   qt_libdirs="$qt_libdirs $dir/lib $dir"
+done
+qt_libdirs="$QTLIB $qt_libdirs /usr/X11R6/lib /usr/lib /usr/local/qt/lib $x_libraries"
+if test ! "$ac_qt_libraries" = "NO"; then
+  qt_libdir=$ac_qt_libraries
+else
+  qt_libdirs="$ac_qt_libraries $qt_libdirs"
+  # if the Qt was given, the chance is too big that libqt.* doesn't exist
+  qt_libdir=NONE
+  for dir in $qt_libdirs; do
+    try="ls -1 $dir/${LIBQT_GLOB}"
+    if test -n "`$try 2> /dev/null`"; then qt_libdir=$dir; break; else echo "tried $dir" >&AC_FD_CC ; fi
+  done
+fi
+
+ac_qt_libraries="$qt_libdir"
+
+AC_LANG_SAVE
+AC_LANG_CPLUSPLUS
+
+ac_cxxflags_safe="$CXXFLAGS"
+ac_ldflags_safe="$LDFLAGS"
+ac_libs_safe="$LIBS"
+
+CXXFLAGS="$CXXFLAGS -I$qt_incdir"
+LDFLAGS="$LDFLAGS -L$qt_libdir $USER_LDFLAGS"
+LIBS="$LIBS $LIBQT"
+
+
+KDE_PRINT_QT_PROGRAM
+
+if AC_TRY_EVAL(ac_link) && test -s conftest; then
+  rm -f conftest*
+else
+  echo "configure: failed program was:" >&AC_FD_CC
+  cat conftest.$ac_ext >&AC_FD_CC
+  ac_qt_libraries="NO"
+fi
+rm -f conftest*
+CXXFLAGS="$ac_cxxflags_safe"
+LDFLAGS="$ac_ldflags_safe"
+LIBS="$ac_libs_safe"
+
+AC_LANG_RESTORE
+
+if test "$ac_qt_includes" = NO || test "$ac_qt_libraries" = NO; then
+  dnl didn't find QT, record this fact in the cache
+  ac_cv_have_qt="have_qt=no"
+  ac_qt_notfound=""
+  if test "$ac_qt_includes" = NO; then
+    if test "$ac_qt_libraries" = NO; then
+      ac_qt_notfound="(headers and libraries)";
+    else
+      ac_qt_notfound="(headers)";
+    fi
+  else
+    ac_qt_notfound="(libraries)";
+  fi
+
+  AC_MSG_ERROR([Qt ($kde_qt_minversion) $ac_qt_notfound not found. Please check your installation!
+For more details about this problem, look at the end of config.log.])
+
+else
+  dnl Did find qt, record this fact as well as where we found the incs and libs in cache
+  have_qt="yes"
+  ac_cv_have_qt="have_qt=yes \
+     ac_qt_includes=$ac_qt_includes ac_qt_libraries=$ac_qt_libraries"
+fi
+]) dnl end of AC_CACHE_VAL(ac_cv_have_qt,...)
+
+eval "$ac_cv_have_qt"
+
+if test "$have_qt" != yes; then
+  AC_MSG_RESULT([$have_qt]);
+else
+  AC_MSG_RESULT([libraries $ac_qt_libraries, headers $ac_qt_includes $USING_QT_MT])
+fi
+
+
+qt_libraries="$ac_qt_libraries"
+qt_includes="$ac_qt_includes"
+
+AC_SUBST(qt_libraries)
+AC_SUBST(qt_includes)
+
+if test "$qt_includes" = "$x_includes" || test -z "$qt_includes"; then
+ QT_INCLUDES="";
+else
+ QT_INCLUDES="-I$qt_includes"
+fi
+
+if test "$qt_libraries" = "$x_libraries" || test -z "$qt_libraries"; then
+ QT_LDFLAGS=""
+else
+ QT_LDFLAGS="-L$qt_libraries"
+fi
+
+AC_SUBST(QT_INCLUDES)
+AC_SUBST(QT_LDFLAGS)
+AC_PATH_QT_MOC_UIC
+
+LIB_QT="$kde_int_qt "'$(LIBPNG) $(LIBJPEG) $(X_PRE_LIBS) $(X_EXTRA_LIBS) -lXext -lX11 $(X_LIBS)'
+dnl LIB_QT="$kde_int_qt "'$(LIBPNG) $(LIBJPEG) -lXext $(LIB_X11) $(LIBSM)'
+AC_SUBST(LIB_QT)
+
+])
+
+dnl ------------------------------------------------------------------------
+dnl Find a file (or one of more files in a list of dirs)
+dnl ------------------------------------------------------------------------
+dnl
+AC_DEFUN(AC_FIND_FILE,
+[
+$3=NO
+for i in $2;
+do
+  for j in $1;
+  do
+    if test -r "$i/$j"; then
+      $3=$i
+      break 2
+    fi
+  done
+done
+])
+
+dnl KDE_FIND_PATH(programm-name, variable-name, list of directories,
+dnl	if-not-found, test-parameter)
+AC_DEFUN(KDE_FIND_PATH,
+[
+   AC_MSG_CHECKING([for $1])
+   if test -n "$$2"; then
+        kde_cv_path="$$2";
+   else
+        kde_cache=`echo $1 | sed 'y%./+-%__p_%'`
+
+        AC_CACHE_VAL(kde_cv_path_$kde_cache,
+        [
+        kde_cv_path="NONE"
+	dirs="$3"
+	kde_save_IFS=$IFS
+	IFS=':'
+	for dir in $PATH; do
+	  dirs="$dirs $dir"
+        done
+	IFS=$kde_save_IFS
+
+        for dir in $dirs; do
+	  if test -x "$dir/$1"; then
+	    if test -n "$5"
+	    then
+              evalstr="$dir/$1 $5 2>&1 "
+	      if eval $evalstr; then
+                kde_cv_path="$dir/$1"
+                break
+	      fi
+            else
+		kde_cv_path="$dir/$1"
+                break
+	    fi
+          fi
+        done
+
+        eval "kde_cv_path_$kde_cache=$kde_cv_path"
+
+        ])
+
+      eval "kde_cv_path=\"`echo '$kde_cv_path_'$kde_cache`\""
+
+   fi
+
+   if test -z "$kde_cv_path" || test "$kde_cv_path" = NONE; then
+      AC_MSG_RESULT(not found)
+      $4
+   else
+      AC_MSG_RESULT($kde_cv_path)
+      $2=$kde_cv_path
+
+   fi
+])
+
+AC_DEFUN(KDE_MOC_ERROR_MESSAGE,
+[
+    AC_MSG_ERROR([No Qt meta object compiler (moc) found!
+Please check whether you installed Qt correctly.
+You need to have a running moc binary.
+configure tried to run $ac_cv_path_moc and the test didn't
+succeed. If configure shouldn't have tried this one, set
+the environment variable MOC to the right one before running
+configure.
+])
+])
+
+AC_DEFUN(KDE_UIC_ERROR_MESSAGE,
+[
+    AC_MSG_WARN([No Qt ui compiler (uic) found!
+Please check whether you installed Qt correctly.
+You need to have a running uic binary.
+configure tried to run $ac_cv_path_uic and the test didn't
+succeed. If configure shouldn't have tried this one, set
+the environment variable UIC to the right one before running
+configure.
+])
+])
+
+
+dnl ------------------------------------------------------------------------
+dnl Find the meta object compiler and the ui compiler in the PATH,
+dnl in $QTDIR/bin, and some more usual places
+dnl ------------------------------------------------------------------------
+dnl
+AC_DEFUN(AC_PATH_QT_MOC_UIC,
+[
+   qt_bindirs=""
+   for dir in $kde_qt_dirs; do
+      qt_bindirs="$qt_bindirs $dir/bin $dir/src/moc"
+   done
+   qt_bindirs="$qt_bindirs /usr/bin /usr/X11R6/bin /usr/local/qt/bin"
+   if test ! "$ac_qt_bindir" = "NO"; then
+      qt_bindirs="$ac_qt_bindir $qt_bindirs"
+   fi
+
+   KDE_FIND_PATH(moc, MOC, [$qt_bindirs], [KDE_MOC_ERROR_MESSAGE])
+   KDE_FIND_PATH(uic, UIC, [$qt_bindirs], [UIC="" ; KDE_UIC_ERROR_MESSAGE])
+   if test -z "$UIC" ; then
+     if test -z "$UIC_NOT_NEEDED" ; then
+       exit 1
+     else
+       UIC="echo uic not available: "
+     fi
+   fi
+   AC_SUBST(MOC)
+   AC_SUBST(UIC)
+])
+
+AC_DEFUN(KDE_PRINT_QT_PROGRAM,
+[
+AC_REQUIRE([KDE_USE_QT])
+cat > conftest.$ac_ext <<EOF
+#include "confdefs.h"
+#include <qglobal.h>
+#include <qapplication.h>
+#include <qapp.h>
+#include <qobjcoll.h>
+EOF
+if test "$kde_qtver" = "2"; then
+cat >> conftest.$ac_ext <<EOF
+#include <qevent.h>
+#include <qstring.h>
+#include <qstyle.h>
+EOF
+
+if test $kde_qtsubver -gt 0; then
+cat >> conftest.$ac_ext <<EOF
+#include <qiconview.h>
+EOF
+fi
+
+fi
+
+echo "#if ! ($kde_qt_verstring)" >> conftest.$ac_ext
+cat >> conftest.$ac_ext <<EOF
+#error 1
+#endif
+
+int main() {
+EOF
+if test "$kde_qtver" = "2"; then
+cat >> conftest.$ac_ext <<EOF
+    QStringList *t = new QStringList();
+EOF
+if test $kde_qtsubver -gt 0; then
+cat >> conftest.$ac_ext <<EOF
+    QIconView iv(0);
+    iv.setWordWrapIconText(false);
+    QString s;
+    s.setLatin1("Elvis is alive", 14);
+    int magnolia = QEvent::Speech; /* new in 2.2 beta2 */
+EOF
+fi
+fi
+cat >> conftest.$ac_ext <<EOF
+    return 0;
+}
+EOF
+])
+
+
+
diff -ur --new-file ospmd-20030327.virgin/autogen.sh ospmd-20030327/autogen.sh
--- ospmd-20030327.virgin/autogen.sh	Thu Jan  1 01:00:00 1970
+++ ospmd-20030327/autogen.sh	Fri Mar 28 18:36:07 2003
@@ -0,0 +1,64 @@
+#!/bin/sh
+
+srcdir=`dirname $0`
+
+test -z "$srcdir" && srcdir=.
+
+DIE=0
+
+(test -f $srcdir/configure.in) || {
+    echo -n "**Error**: Directory "\`$srcdir\'" does not look like the"
+    echo " top-level package directory"
+    exit 1
+}
+
+(libtoolize --version) < /dev/null > /dev/null 2>&1 || {
+  echo
+  echo "**Error**: You must have \`libtool' installed."
+  echo "Download the appropriate package for your distribution,"
+  echo "or get the source tarball at ftp://ftp.gnu.org/pub/gnu/"
+  DIE=1
+}
+
+(autoconf --version) < /dev/null > /dev/null 2>&1 || {
+  echo
+  echo "**Error**: You must have \`autoconf' installed."
+  echo "Download the appropriate package for your distribution,"
+  echo "or get the source tarball at ftp://ftp.gnu.org/pub/gnu/"
+  DIE=1
+}
+
+(automake --version) < /dev/null > /dev/null 2>&1 || {
+  echo
+  echo "**Error**: You must have \`automake' installed."
+  echo "You can get it from: ftp://ftp.gnu.org/pub/gnu/"
+  DIE=1
+  NO_AUTOMAKE=yes
+}
+
+test -n "$NO_AUTOMAKE" || (aclocal --version) < /dev/null > /dev/null 2>&1 || {
+  echo
+  echo "**Error**: Missing \`aclocal'.  The version of \`automake'"
+  echo "installed doesn't appear recent enough."
+  echo "You can get automake from ftp://ftp.gnu.org/pub/gnu/"
+  DIE=1
+}
+
+if test "$DIE" -eq 1; then
+  exit 1
+fi
+
+if test -z "$*"; then
+	echo "I am going to run ./configure with no arguments - if you wish "
+        echo "to pass any to it, please specify them on the $0 command line."
+fi
+
+libtoolize --automake 
+aclocal $ACLOCAL_FLAGS
+automake --add-missing
+autoconf
+
+./configure $*
+
+echo "Now type 'make' to compile ospmd."
+
diff -ur --new-file ospmd-20030327.virgin/configure.in ospmd-20030327/configure.in
--- ospmd-20030327.virgin/configure.in	Thu Jan  1 01:00:00 1970
+++ ospmd-20030327/configure.in	Fri Mar 28 18:05:46 2003
@@ -0,0 +1,46 @@
+AC_INIT(ospmd, 20030327, http://acpi.sourceforge.net)
+
+AM_INIT_AUTOMAKE
+AM_MAINTAINER_MODE
+
+
+# Checks for programs.
+AC_PROG_CXX
+AC_PROG_CC
+AC_PROG_CPP
+AC_PROG_INSTALL
+AC_PROG_LN_S
+AC_PROG_MAKE_SET
+dnl AC_PROG_RANLIB
+AC_PROG_LIBTOOL
+
+# Checks for libraries.
+
+AC_CHECK_LIB([pthread], [pthread_create])
+
+KDE_USE_QT(2.3)
+AC_PATH_QT
+
+# Checks for header files.
+AC_HEADER_DIRENT
+AC_HEADER_STDC
+AC_HEADER_SYS_WAIT
+AC_CHECK_HEADERS([arpa/inet.h fcntl.h netinet/in.h stdlib.h string.h sys/ioctl.h sys/socket.h sys/time.h syslog.h unistd.h])
+
+# Checks for typedefs, structures, and compiler characteristics.
+AC_C_CONST
+AC_C_INLINE
+AC_TYPE_PID_T
+
+# Checks for library functions.
+AC_FUNC_ALLOCA
+AC_FUNC_FORK
+AC_TYPE_SIGNAL
+AC_CHECK_FUNCS([memset select socket strchr strerror strtol])
+
+AC_CONFIG_FILES([Makefile
+                 gui/Makefile
+                 libpower/Makefile
+                 ospmd/Makefile])
+
+AC_OUTPUT
diff -ur --new-file ospmd-20030327.virgin/gui/Makefile ospmd-20030327/gui/Makefile
--- ospmd-20030327.virgin/gui/Makefile	Wed Nov 20 01:50:56 2002
+++ ospmd-20030327/gui/Makefile	Thu Jan  1 01:00:00 1970
@@ -1,107 +0,0 @@
-# Include variables
-QTDIR= /usr/lib/qt-3.0.5
-INC_KDE= /usr/include/kde
-INC_OSPMD= ../inc
-INCL= -I$(QTDIR)/include -I$(INC_KDE) -I$(INC_OSPMD)
-
-# Library flags
-KDELIB2= /usr/lib/kde2
-LDIRS= -L$(QTDIR)/lib -L$(KDELIB2) -L/usr/X11R6/lib
-LIBS= -lkdecore -lkdeui -lqt-mt -lX11 -lXext -ldl
-
-
-# These turn on debug printf(s) in their respective objects
-# Add this to CXXFLAGS
-GUI_CFLAGS= -D_OSPMD_GUI_BUTTON_CONFIG_DEBUG \
-	-D_OSPMD_GUI_BATTERY_CONFIG_DEBUG \
-	-D_OSPMD_GUI_BATDET_CONFIG_DEBUG \
-	-D_OSPMD_GUI_BATTERY_CRITALARM_DEBUG \
-	-D_OSPMD_GUI_GENINFO_DEBUG \
-	-D_OSPMD_GUI_THREAD_DEBUG \
-	-D_OSPMD_GUI_BATTERY_LOWALARM_DEBUG \
-	-D_OSPMD_GUI_NOTIFY_OBJ_DEBUG \
-	-D_OSPMD_GUI_PROPERTYSHEET_DEBUG \
-	-D_OSPMD_GUI_PROPSHEET_MAIN_DEBUG
-
-# Compile flags without optimization -O2 but with debug -g
-CXXFLAGS= -pipe -g -fno-strength-reduce -Wall $(INCL) $(GUI_CFLAGS)
-
-OBJS=   PropertySheetMain.o \
-	PropertySheet.o \
-	moc_PropertySheet.o \
-	GUIThread.o \
-	GenInfoPage.o \
-	ButtonPage.o \
-	moc_ButtonPage.o \
-	BatteryPage.o \
-	moc_BatteryPage.o \
-	BatDetails.o \
-	moc_BatDetails.o \
-	ActionGroup.o \
-	NotifyGroup.o \
-	LowAlarmDialog.o \
-	moc_LowAlarmDialog.o \
-	CriticalAlarmDialog.o \
-	moc_CriticalAlarmDialog.o \
-	PowerPage.o \
-	moc_PowerPage.o
-
-all: ospmd_gui
-
-# Describe what components go into the GUI application
-ospmd_gui:  $(OBJS) libpower.a
-	$(CC) $(LDIRS) -o ospmd_gui $(OBJS) libpower.a $(LIBS)
-	
-
-# Describe "target rules" that is, how to make each part required above.
-PropertySheetMain.o: PropertySheet.h
-
-PropertySheet.o: PropertySheet.h
-
-moc_PropertySheet.cpp: PropertySheet.h
-	$(QTDIR)/bin/moc PropertySheet.h -o moc_PropertySheet.cpp
-
-GUIThread.o: GUIThread.h
-
-GenInfoPage.o: GenInfoPage.h
-
-ButtonPage.o: ButtonPage.h
-
-moc_ButtonPage.cpp: ButtonPage.h
-	$(QTDIR)/bin/moc ButtonPage.h -o moc_ButtonPage.cpp
-
-BatteryPage.o: BatteryPage.h
-
-moc_BatteryPage.cpp: BatteryPage.h
-	$(QTDIR)/bin/moc BatteryPage.h -o moc_BatteryPage.cpp
-
-BatDetails.o: BatDetails.h
-
-moc_BatDetails.cpp: BatDetails.h
-	$(QTDIR)/bin/moc BatDetails.h -o moc_BatDetails.cpp
-
-ActionGroup.o: ActionGroup.h
-
-NotifyGroup.o: NotifyGroup.h
-
-LowAlarmDialog.o: LowAlarmDialog.h
-
-moc_LowAlarmDialog.cpp: LowAlarmDialog.h
-	$(QTDIR)/bin/moc LowAlarmDialog.h -o moc_LowAlarmDialog.cpp
-
-CriticalAlarmDialog.o: CriticalAlarmDialog.h
-
-moc_CriticalAlarmDialog.cpp: CriticalAlarmDialog.h
-	$(QTDIR)/bin/moc CriticalAlarmDialog.h -o moc_CriticalAlarmDialog.cpp
-
-PowerPage.o: PowerPage.h
-
-moc_PowerPage.cpp: PowerPage.h
-	$(QTDIR)/bin/moc PowerPage.h -o moc_PowerPage.cpp
-
-clean:
-	rm -f ospmd_gui $(OBJS) moc_*
-
-#define the rule for generating .o files from .cpp
-%.o : %.cpp
-	$(CXX) -c $(CPPFLAGS) $(CXXFLAGS) $< -o $@
diff -ur --new-file ospmd-20030327.virgin/gui/Makefile.am ospmd-20030327/gui/Makefile.am
--- ospmd-20030327.virgin/gui/Makefile.am	Thu Jan  1 01:00:00 1970
+++ ospmd-20030327/gui/Makefile.am	Fri Mar 28 15:38:16 2003
@@ -0,0 +1,59 @@
+INCLUDES = $(QT_INCLUDES) -I$(top_srcdir)/libpower
+
+MOC_FILES		=		\
+	moc_PropertySheet.cpp		\
+	moc_ButtonPage.cpp		\
+	moc_LowAlarmDialog.cpp		\
+	moc_BatDetails.cpp		\
+	moc_CriticalAlarmDialog.cpp	\
+	moc_BatteryPage.cpp		\
+	moc_PowerPage.cpp
+
+BUILT_SOURCES		=		\
+	$(MOC_FILES)
+
+bin_PROGRAMS = ospmd_gui
+
+ospmd_gui_SOURCES=		\
+	ActionGroup.cpp		\
+	ActionGroup.h		\
+	BatDetails.cpp		\
+	CriticalAlarmDialog.cpp \
+	NotifyGroup.cpp		\
+	BatDetails.h		\
+	CriticalAlarmDialog.h	\
+	NotifyGroup.h		\
+	ospmd_bat_defs.h	\
+	BatteryPage.cpp		\
+	GenInfoPage.cpp		\
+	PowerPage.cpp		\
+	BatteryPage.h		\
+	GenInfoPage.h		\
+	PowerPage.h		\
+	GUIThread.cpp		\
+	PropertySheet.cpp	\
+	GUIThread.h		\
+	PropertySheetDefs.h	\
+	PropertySheet.h		\
+	LowAlarmDialog.cpp	\
+	PropertySheetMain.cpp	\
+	ButtonPage.cpp		\
+	LowAlarmDialog.h	\
+	ButtonPage.h		\
+	$(MOC_FILES)
+
+ospmd_gui_LDADD = $(top_srcdir)/libpower/libpower.la -L/usr/X11R6/lib $(LIB_QT)
+
+CLEANFILES =	$(MOC_FILES) fake.ts
+
+moc_%.cpp: %.h
+	$(MOC) -o $@ $<
+
+#
+# We really don't want to package up the files our version of
+# moc generated.  The user may be using a different version.
+#
+dist-hook:
+	cd $(distdir); rm -f $(MOC_FILES)
+
+
--- ospmd-20030327.virgin/inc/power.h	Wed Nov 20 04:18:46 2002
+++ ospmd-20030327/inc/power.h	Thu Jan  1 01:00:00 1970
@@ -1,490 +0,0 @@
-/******************************************************************************
- *
- * Name: power.h - Structs and function decls used by callers of libpower
- *       $Revision: 1.6 $
- *
- *****************************************************************************/
-
-/******************************************************************************
- *
- * 1. Copyright Notice
- *
- * Some or all of this work - Copyright (c) 1999-2002 Intel Corp.
- * All rights reserved.
- *
- * 2. License
- *
- * 2.1. This is your license from Intel Corp. under its intellectual property
- * rights.  You may have additional license terms from the party that provided
- * you this software, covering your right to use that party's intellectual
- * property rights.
- *
- * 2.2. Intel grants, free of charge, to any person ("Licensee") obtaining a
- * copy of the source code appearing in this file ("Covered Code") an
- * irrevocable, perpetual, worldwide license under Intel's copyrights in the
- * base code distributed originally by Intel ("Original Intel Code") to copy,
- * make derivatives, distribute, use and display any portion of the Covered
- * Code in any form, with the right to sublicense such rights; and
- *
- * 2.3. Intel grants Licensee a non-exclusive and non-transferable patent
- * license (with the right to sublicense), under only those claims of Intel
- * patents that are infringed by the Original Intel Code, to make, use, sell,
- * offer to sell, and import the Covered Code and derivative works thereof
- * solely to the minimum extent necessary to exercise the above copyright
- * license, and in no event shall the patent license extend to any additions
- * to or modifications of the Original Intel Code.  No other license or right
- * is granted directly or by implication, estoppel or otherwise;
- *
- * The above copyright and patent license is granted only if the following
- * conditions are met:
- *
- * 3. Conditions
- *
- * 3.1. Redistribution of Source with Rights to Further Distribute Source.
- * Redistribution of source code of any substantial portion of the Covered
- * Code or modification with rights to further distribute source must include
- * the above Copyright Notice, the above License, this list of Conditions,
- * and the following Disclaimer and Export Compliance provision.  In addition,
- * Licensee must cause all Covered Code to which Licensee contributes to
- * contain a file documenting the changes Licensee made to create that Covered
- * Code and the date of any change.  Licensee must include in that file the
- * documentation of any changes made by any predecessor Licensee.  Licensee
- * must include a prominent statement that the modification is derived,
- * directly or indirectly, from Original Intel Code.
- *
- * 3.2. Redistribution of Source with no Rights to Further Distribute Source.
- * Redistribution of source code of any substantial portion of the Covered
- * Code or modification without rights to further distribute source must
- * include the following Disclaimer and Export Compliance provision in the
- * documentation and/or other materials provided with distribution.  In
- * addition, Licensee may not authorize further sublicense of source of any
- * portion of the Covered Code, and must include terms to the effect that the
- * license from Licensee to its licensee is limited to the intellectual
- * property embodied in the software Licensee provides to its licensee, and
- * not to intellectual property embodied in modifications its licensee may
- * make.
- *
- * 3.3. Redistribution of Executable. Redistribution in executable form of any
- * substantial portion of the Covered Code or modification must reproduce the
- * above Copyright Notice, and the following Disclaimer and Export Compliance
- * provision in the documentation and/or other materials provided with the
- * distribution.
- *
- * 3.4. Intel retains all right, title, and interest in and to the Original
- * Intel Code.
- *
- * 3.5. Neither the name Intel nor any other trademark owned or controlled by
- * Intel shall be used in advertising or otherwise to promote the sale, use or
- * other dealings in products derived from or relating to the Covered Code
- * without prior written authorization from Intel.
- *
- * 4. Disclaimer and Export Compliance
- *
- * 4.1. INTEL MAKES NO WARRANTY OF ANY KIND REGARDING ANY SOFTWARE PROVIDED
- * HERE.  ANY SOFTWARE ORIGINATING FROM INTEL OR DERIVED FROM INTEL SOFTWARE
- * IS PROVIDED "AS IS," AND INTEL WILL NOT PROVIDE ANY SUPPORT,  ASSISTANCE,
- * INSTALLATION, TRAINING OR OTHER SERVICES.  INTEL WILL NOT PROVIDE ANY
- * UPDATES, ENHANCEMENTS OR EXTENSIONS.  INTEL SPECIFICALLY DISCLAIMS ANY
- * IMPLIED WARRANTIES OF MERCHANTABILITY, NONINFRINGEMENT AND FITNESS FOR A
- * PARTICULAR PURPOSE.
- *
- * 4.2. IN NO EVENT SHALL INTEL HAVE ANY LIABILITY TO LICENSEE, ITS LICENSEES
- * OR ANY OTHER THIRD PARTY, FOR ANY LOST PROFITS, LOST DATA, LOSS OF USE OR
- * COSTS OF PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES, OR FOR ANY INDIRECT,
- * SPECIAL OR CONSEQUENTIAL DAMAGES ARISING OUT OF THIS AGREEMENT, UNDER ANY
- * CAUSE OF ACTION OR THEORY OF LIABILITY, AND IRRESPECTIVE OF WHETHER INTEL
- * HAS ADVANCE NOTICE OF THE POSSIBILITY OF SUCH DAMAGES.  THESE LIMITATIONS
- * SHALL APPLY NOTWITHSTANDING THE FAILURE OF THE ESSENTIAL PURPOSE OF ANY
- * LIMITED REMEDY.
- *
- * 4.3. Licensee shall not export, either directly or indirectly, any of this
- * software or system incorporating such software without first obtaining any
- * required license or other approval from the U. S. Department of Commerce or
- * any other agency or department of the United States Government.  In the
- * event Licensee exports any such software from the United States or
- * re-exports any such software from a foreign destination, Licensee shall
- * ensure that the distribution and export/re-export of the software is in
- * compliance with all laws, regulations, orders, or other restrictions of the
- * U.S. Export Administration Regulations. Licensee agrees that neither it nor
- * any of its subsidiaries will export/re-export any technical data, process,
- * software, or service, directly or indirectly, to any country for which the
- * United States government or any agency thereof requires an export license,
- * other governmental approval, or letter of assurance, without first obtaining
- * such license, approval or letter.
- *
- *****************************************************************************/
-
-
-#ifndef _POWER_H
-#define _POWER_H
-
-#ifndef TRUE
-#define TRUE 1
-#define FALSE 0
-#endif
-
-#define MAX_BAT_SLOTS  4
-#define MAX_AC_SLOTS  4
-
-#ifdef __cplusplus
-#define BEGIN_PWR_DECLS	extern "C" {
-#define END_PWR_DECLS	}
-#else
-#define BEGIN_PWR_DECLS
-#define END_PWR_DECLS
-#endif
-
-BEGIN_PWR_DECLS
-
-/* alarm_type is an enumeration of generic alarm types. */
-/* Batteries are defined to only have LOW and CRITICAL. */
-enum alarm_type {
-	ALARM_LOW,
-	ALARM_CRITICAL,
-	ALARM_COUNT
-};
-
-enum button_type {
-	BUTTON_POWER,
-	BUTTON_SLEEP,
-	BUTTON_LID,
-	BUTTON_TYPE_COUNT
-};
-
-enum button_action {
-	BUTTON_ACTION_NOTHING,
-	BUTTON_ACTION_SLEEP,
-	BUTTON_ACTION_HIBERNATE,
-	BUTTON_ACTION_SHUTDOWN,
-	BUTTON_ACTION_RUN_PROG,
-	BUTTON_ACTION_COUNT
-};
-
-enum cooling_mode {
-	COOLING_MODE_NONE,
-        COOLING_MODE_ACTIVE,
-        COOLING_MODE_PASSIVE
-};
-
-#define ACTION_POWER_DEFAULT	BUTTON_ACTION_SHUTDOWN
-#define ACTION_SLEEP_DEFAULT	BUTTON_ACTION_SLEEP
-#define ACTION_LID_DEFAULT	BUTTON_ACTION_NOTHING
-
-typedef struct button_actions
-{
-	int power_action;
-	int sleep_action;
-	int lid_action;
-
-} BUTTON_ACTIONS;
-
-#define ALARM_PROG_PATH_LEN 256
-
-/*This holds information from the alarm configuration files.*/
-typedef struct alarm_config
-{
-	int alarm_enable;
-	int alarm_percent;
-	int alarm_notify;
-	int alarm_action;
-	char alarm_prog_path[ALARM_PROG_PATH_LEN];
-} ALARM_CONFIG;
-
-
-enum pwr_te_id {
-	OSPM_PWR_TE_LB_PIMON=0,
-	OSPM_PWR_TE_LB_PIDISKS,
-	OSPM_PWR_TE_LB_PISTANDBY,
-	OSPM_PWR_TE_LB_OBMON,
-	OSPM_PWR_TE_LB_OBDISKS,
-	OSPM_PWR_TE_LB_OBSTANDBY,
-	OSPM_PWR_TE_LB_COUNT
-};
-/*
- The values in this pwr_time_entry structure represent
- the character time list start, end, and current indicies.
- This full time list definition is found in PowerPage.cpp
- It is copied here as a comment for convenience.
- char *strtime[]={"1 min","2 min","3 min","5 min","10 min","15 min",
-			"20 min","25 min","30 min","45 min","1 hour","2 hour",
-			"3 hour","4 hour","5 hour","Never"};
- So and index of 0 corresponds to a time delay of 1 minute before
- the associated activity takes place, e.g. blank screen, spin down disk,
- or go into standby.
-*/
-/*The valid range of values for PWR_TIME_ENTRY data items
-  start,end,and current is 0 to and including 15. This
-  is noted in the following two defines.*/
-#define MIN_PTE_VALUE  0
-#define MAX_PTE_VALUE  15
-
-typedef struct pwr_time_entry
-{
-	int start;
-	int end;
-	int current;
-} PWR_TIME_ENTRY;
-
-/*
- The data item prefixes in the following structure
- pi means "plugged in" and ob means "on batteries".
-*/
-typedef struct pwr_scheme
-{
-	int pwr_scheme_flag; /*user or factory created.*/
-	PWR_TIME_ENTRY pimon;
-	PWR_TIME_ENTRY pidisks;
-	PWR_TIME_ENTRY pistandby;
-	PWR_TIME_ENTRY obmon;
-	PWR_TIME_ENTRY obdisks;
-	PWR_TIME_ENTRY obstandby;
-} PWR_SCHEME;
-
-/*
-  The first 5 power schemes should always
-  be filled from the pwrscheme.conf configuration
-  file.  The event server manages this file.
-*/
-#define MAX_PWR_SCHEMES  10
-
-typedef struct pwr_scheme_list
-{
-	int num_pwr_schemes;
-	int current_pwr_scheme;
-	PWR_SCHEME ps[MAX_PWR_SCHEMES];
-} PWR_SCHEME_LIST;
-
-typedef struct num_with_units
-{
-	int num;
-	char units[4];
-} NUM_WITH_UNITS;
-
-enum battery_cap_state {
-	BATCAPSTATE_UNKNOWN,
-	BATCAPSTATE_OK,
-	BATCAPSTATE_LOW,
-	BATCAPSTATE_CRITLOW
-};
-
-enum battery_charge_state {
-	BATSTATE_UNKNOWN=0,
-	BATSTATE_CHARGING,
-	BATSTATE_DISCHARGING,
-	BATSTATE_CHARGDIS
-};
-
-typedef struct battery_status
-{
-	int present; /*no=0x00, yes=0x01*/
-	int capstate; /*ok=0x00, low=0x01, critical=0x02*/
-	int state;/*unknown=0x00, charging=0x01, discharging=0x02, charging/discharging=0x03 */
-	NUM_WITH_UNITS rate;
-	NUM_WITH_UNITS rem_cap; /*remaining capacity in mWh*/
-	NUM_WITH_UNITS voltage; /* mV */
-
-} BATTERY_STATUS;
-
-#define MAX_MODEL_NUM_LEN   64
-#define MAX_SERIAL_NUM_LEN  64
-#define MAX_BATT_TYPE_LEN   64
-#define MAX_OEM_INFO_LEN    64
-#define MAX_BATT_ERR_LEN    64
-
-/*
- NOTE: Regarding measurement units, from ACPI Spec 2.0 section 3.9.2
-   "A system may use either rate and capacity [mA/mAh] or power and
-    energy [mW/mWh] for the unit of battery information calculation
-    and reporting. Mixing [mA] and [mW] is not allowed on a system."
-*/
-
-typedef struct bat_time
-{
-	int hours;
-	int minutes;
-
-} BAT_TIME;
-
-/*
-  Capacity Ratio "capacity_ratio" = lastfullcap/designcap
-*/
-typedef struct battery_info
-{
-	int present;
-	NUM_WITH_UNITS designcap;
-	NUM_WITH_UNITS lastfullcap;
-	int techtype;
-	NUM_WITH_UNITS designvoltage;
-	NUM_WITH_UNITS designcapwarning;
-	NUM_WITH_UNITS designcaplow;
-	NUM_WITH_UNITS capgran1;
-	NUM_WITH_UNITS capgran2;
-	int capacity_ratio;
-	int rempercent;
-	int lowalarm;
-	int critalarm;
-	BAT_TIME remhours;
-	char model_number[MAX_MODEL_NUM_LEN];
-	char serial_number[MAX_SERIAL_NUM_LEN];
-	char battery_type[MAX_BATT_TYPE_LEN];
-	char oem_info[MAX_OEM_INFO_LEN];
-	char strErr[MAX_BATT_ERR_LEN];
-} BATTERY_INFO;
-
-#define MAX_BAT_UID_PATHNAME_LEN  64
-
-typedef struct battery_presence
-{
-	int number;
-	int present[MAX_BAT_SLOTS];
-
-} BATTERY_PRESENCE;
-
-#define SOCK_DATA_STR_MAX  1024
-
-typedef struct all_bat_data
-{
-	BATTERY_INFO bi;
-	BATTERY_STATUS bs;
-}ALL_BAT_DATA;
-
-typedef struct all_ac_adapters
-{
-	int num;
-	int online;
-}ALL_AC_ADAPTERS;
-
-#define MAX_EV_CLASS_LEN  32
-#define MAX_EV_DEV_LEN    32
-
-enum event_class
-{
-	EVENT_CLASS_UNKNOWN,
-	EVENT_CLASS_AC,
-	EVENT_CLASS_BATTERY,
-	EVENT_CLASS_BUTTON,
-	EVENT_CLASS_PROCESSOR,
-	EVENT_CLASS_THERMAL,
-	EVENT_CLASS_COUNT,
-};
-
-typedef struct ospmd_event
-{
-	unsigned short ev_class;
-	char ev_dev_name[MAX_EV_DEV_LEN];
-	unsigned int ev_data;
-
-} OSPMD_EVENT;
-
-typedef struct processor_perf
-{
-	unsigned short perf_state;
-	unsigned short throttle_state;
-
-} PROCESSOR_PERF;
-
-typedef struct processor_perf_info
-{
-	PROCESSOR_PERF current;
-	PROCESSOR_PERF max;
-
-}PROCESSOR_PERF_INFO;
-
-/* [FIXME: Implement trippoints, have to understand format first] */
-
-typedef struct pm_thermal_trippoints
-{
-} PM_THERMAL_TRIPPOINTS;
-
-typedef struct pm_thermal_data
-{
-  unsigned int cooling_mode;
-  unsigned int polling_frequency;
-  unsigned short state;
-  unsigned short temperature;
-} PM_THERMAL_DATA;
-
-/* TODO: clean up, make names consistent */
-
-/* implemented functions */
-
-int pm_get_processor_info(PROCESSOR_PERF* perf_info);
-int pm_get_batt_presence(BATTERY_PRESENCE* batt_pres);
-/* TODO: change "info" to "data"? */
-int pm_get_batt_info(int batt_num, ALL_BAT_DATA* batt_info);
-int pm_get_ac_presence(ALL_AC_ADAPTERS* ac_info);
-int pm_set_button_actions(BUTTON_ACTIONS* abc);
-int pm_get_button_actions(BUTTON_ACTIONS* abc);
-int pm_get_power_schemes(PWR_SCHEME_LIST* power_list);
-int pm_set_power_schemes(PWR_SCHEME_LIST* power_list);
-
-int pm_get_thermal_data (PM_THERMAL_DATA* thermal_data);
-
-void *pm_event_listen_start(void (*func_ptr)(OSPMD_EVENT* ev));
-int pm_event_listen_stop(void* handle);
-
-/* half-implemented functions */
-
-int pm_get_batt_alarm(unsigned short type, ALARM_CONFIG* alarm_cfg);
-int pm_set_batt_alarm(unsigned short type, ALARM_CONFIG* alarm_cfg);
-
-/* unimplemented functions */
-
-int pm_screen_disallow_blank(void);
-int pm_screen_allow_blank(void);
-
-int pm_system_disallow_suspend(void);
-int pm_system_allow_suspend(void);
-
-int pm_suspend_system(void);
-int pm_hibernate_system(void);
-int pm_shutdown_system(void);
-
-int pm_get_fan_info(void);
-
-/* unused (as yet) data structures*/
-
-/*device_handle is an opaque value that identifies the
-  battery in question. It cooresponds to the GUI enumeration
-  device_ids. */
-typedef int device_handle;
-
-typedef struct power_info
-{
-	unsigned char power_source;	/* 0x00=unknown, 0x01=AC, 0x02=battery */
-	unsigned char percent_remaining;/* 0-100%: coalesced - only applicable on battery */
-	unsigned long time_remaining;	/* Coalesced - in seconds - only applicable on battery */
-	struct {
-		unsigned long	count;
-		device_handle	*devices;
-	}ac_adapters;
-	struct {
-		unsigned long	count;
-		device_handle	*devices;
-	}batteries;
-} POWER_INFO;
-
-typedef struct battery_alarm_action
-{
-	unsigned long broadcast:1; /*Message to all processes(used when GUI isn't present) */
-	unsigned long sleep:3;     /*Initiate sleep (S1=1, S2=2, ... S5=5) */
-	unsigned long reserved:28;
-
-} BATTERY_ALARM_ACTION;
-
-
-/* battery_alarm is a data structure containing the threshold value
-  (% battery capacity remaining) and action(s) that policy should
-  take (if any).  Note that the UI will be responsible for certain
-  actions (e.g. displaying message box, sounding a beep-beep-beep,
-  etc.), while policy will be responsible for other (e.g. initiate sleep).*/
-typedef struct battery_alarm
-{
-	unsigned long trip_point;  /* 0-100% */
-	struct battery_alarm_action action; /* Action that policy should perform */
-
-} BATTERY_ALARM;
-
-END_PWR_DECLS
-
-#endif
diff -ur --new-file ospmd-20030327.virgin/inc/power_private.h ospmd-20030327/inc/power_private.h
--- ospmd-20030327.virgin/inc/power_private.h	Wed Nov 20 04:18:02 2002
+++ ospmd-20030327/inc/power_private.h	Thu Jan  1 01:00:00 1970
@@ -1,203 +0,0 @@
-/******************************************************************************
- *
- * Name: power_private.h - Structs and function decls used for lib <--> daemon
- *       communication only.
- *       $Revision: 1.3 $
- *
- *****************************************************************************/
-
-/******************************************************************************
- *
- * 1. Copyright Notice
- *
- * Some or all of this work - Copyright (c) 1999-2002 Intel Corp.
- * All rights reserved.
- *
- * 2. License
- *
- * 2.1. This is your license from Intel Corp. under its intellectual property
- * rights.  You may have additional license terms from the party that provided
- * you this software, covering your right to use that party's intellectual
- * property rights.
- *
- * 2.2. Intel grants, free of charge, to any person ("Licensee") obtaining a
- * copy of the source code appearing in this file ("Covered Code") an
- * irrevocable, perpetual, worldwide license under Intel's copyrights in the
- * base code distributed originally by Intel ("Original Intel Code") to copy,
- * make derivatives, distribute, use and display any portion of the Covered
- * Code in any form, with the right to sublicense such rights; and
- *
- * 2.3. Intel grants Licensee a non-exclusive and non-transferable patent
- * license (with the right to sublicense), under only those claims of Intel
- * patents that are infringed by the Original Intel Code, to make, use, sell,
- * offer to sell, and import the Covered Code and derivative works thereof
- * solely to the minimum extent necessary to exercise the above copyright
- * license, and in no event shall the patent license extend to any additions
- * to or modifications of the Original Intel Code.  No other license or right
- * is granted directly or by implication, estoppel or otherwise;
- *
- * The above copyright and patent license is granted only if the following
- * conditions are met:
- *
- * 3. Conditions
- *
- * 3.1. Redistribution of Source with Rights to Further Distribute Source.
- * Redistribution of source code of any substantial portion of the Covered
- * Code or modification with rights to further distribute source must include
- * the above Copyright Notice, the above License, this list of Conditions,
- * and the following Disclaimer and Export Compliance provision.  In addition,
- * Licensee must cause all Covered Code to which Licensee contributes to
- * contain a file documenting the changes Licensee made to create that Covered
- * Code and the date of any change.  Licensee must include in that file the
- * documentation of any changes made by any predecessor Licensee.  Licensee
- * must include a prominent statement that the modification is derived,
- * directly or indirectly, from Original Intel Code.
- *
- * 3.2. Redistribution of Source with no Rights to Further Distribute Source.
- * Redistribution of source code of any substantial portion of the Covered
- * Code or modification without rights to further distribute source must
- * include the following Disclaimer and Export Compliance provision in the
- * documentation and/or other materials provided with distribution.  In
- * addition, Licensee may not authorize further sublicense of source of any
- * portion of the Covered Code, and must include terms to the effect that the
- * license from Licensee to its licensee is limited to the intellectual
- * property embodied in the software Licensee provides to its licensee, and
- * not to intellectual property embodied in modifications its licensee may
- * make.
- *
- * 3.3. Redistribution of Executable. Redistribution in executable form of any
- * substantial portion of the Covered Code or modification must reproduce the
- * above Copyright Notice, and the following Disclaimer and Export Compliance
- * provision in the documentation and/or other materials provided with the
- * distribution.
- *
- * 3.4. Intel retains all right, title, and interest in and to the Original
- * Intel Code.
- *
- * 3.5. Neither the name Intel nor any other trademark owned or controlled by
- * Intel shall be used in advertising or otherwise to promote the sale, use or
- * other dealings in products derived from or relating to the Covered Code
- * without prior written authorization from Intel.
- *
- * 4. Disclaimer and Export Compliance
- *
- * 4.1. INTEL MAKES NO WARRANTY OF ANY KIND REGARDING ANY SOFTWARE PROVIDED
- * HERE.  ANY SOFTWARE ORIGINATING FROM INTEL OR DERIVED FROM INTEL SOFTWARE
- * IS PROVIDED "AS IS," AND INTEL WILL NOT PROVIDE ANY SUPPORT,  ASSISTANCE,
- * INSTALLATION, TRAINING OR OTHER SERVICES.  INTEL WILL NOT PROVIDE ANY
- * UPDATES, ENHANCEMENTS OR EXTENSIONS.  INTEL SPECIFICALLY DISCLAIMS ANY
- * IMPLIED WARRANTIES OF MERCHANTABILITY, NONINFRINGEMENT AND FITNESS FOR A
- * PARTICULAR PURPOSE.
- *
- * 4.2. IN NO EVENT SHALL INTEL HAVE ANY LIABILITY TO LICENSEE, ITS LICENSEES
- * OR ANY OTHER THIRD PARTY, FOR ANY LOST PROFITS, LOST DATA, LOSS OF USE OR
- * COSTS OF PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES, OR FOR ANY INDIRECT,
- * SPECIAL OR CONSEQUENTIAL DAMAGES ARISING OUT OF THIS AGREEMENT, UNDER ANY
- * CAUSE OF ACTION OR THEORY OF LIABILITY, AND IRRESPECTIVE OF WHETHER INTEL
- * HAS ADVANCE NOTICE OF THE POSSIBILITY OF SUCH DAMAGES.  THESE LIMITATIONS
- * SHALL APPLY NOTWITHSTANDING THE FAILURE OF THE ESSENTIAL PURPOSE OF ANY
- * LIMITED REMEDY.
- *
- * 4.3. Licensee shall not export, either directly or indirectly, any of this
- * software or system incorporating such software without first obtaining any
- * required license or other approval from the U. S. Department of Commerce or
- * any other agency or department of the United States Government.  In the
- * event Licensee exports any such software from the United States or
- * re-exports any such software from a foreign destination, Licensee shall
- * ensure that the distribution and export/re-export of the software is in
- * compliance with all laws, regulations, orders, or other restrictions of the
- * U.S. Export Administration Regulations. Licensee agrees that neither it nor
- * any of its subsidiaries will export/re-export any technical data, process,
- * software, or service, directly or indirectly, to any country for which the
- * United States government or any agency thereof requires an export license,
- * other governmental approval, or letter of assurance, without first obtaining
- * such license, approval or letter.
- *
- *****************************************************************************/
-
-#include "power.h"
-
-#ifndef _POWER_PRIVATE_H
-#define _POWER_PRIVATE_H
-
-BEGIN_PWR_DECLS
-
-#define OSPM_ACTION_BAT_ALARM_GET		0x00
-#define OSPM_ACTION_BAT_ALARM_SET		0x01
-#define OSPM_ACTION_BAT_STATUS_GET		0x02
-#define OSPM_ACTION_BAT_INFO_GET		0x03
-#define OSPM_ACTION_BAT_PRESENCE_GET		0x04
-#define OSPM_ACTION_AC_PRESENCE_GET		0x05
-#define OSPM_ACTION_PWRSCHEME_GET_ALL		0x06
-#define OSPM_ACTION_PWRSCHEME_SET_ALL		0x07
-#define OSPM_ACTION_PWRSCHEME_SET_CURRENT	0x08
-#define OSPM_ACTION_BUTTON_GET_ALL		0x09
-#define OSPM_ACTION_BUTTON_SET_ALL		0x0A
-#define OSPM_ACTION_CRITBATT_GET		0x0B
-#define OSPM_ACTION_LOWBATT_GET			0x0C
-#define OSPM_ACTION_CRITBATT_SET		0x0D
-#define OSPM_ACTION_LOWBATT_SET			0x0E
-#define OSPM_ACTION_PROC_INFO_GET		0x0F
-#define OSPM_ACTION_THERMAL_GET		        0x10
-#define OSPM_ACTION_MAX				OSPM_ACTION_THERMAL_GET
-
-/* Events are handled differently */
-#define OSPM_ACTION_EVENT_CONNECT		0x80
-#define OSPM_ACTION_EVENT			0x81
-#define OSPM_ACTION_EVENT_DISCONNECT		0x82
-
-
-typedef struct
-{
-	int sd_len;  /*Length of this structure*/
-	int error; /*0=success -1=error this is a return value from the server*/
-	int dev_class; /*Device class this ID is associated with.*/
-	int id;/*Id of device from device driver's viewpoint from enum device_ids*/
-	int action;  /*An encoded action from GUI to Policy*/
-	void* ptr; /*pointer to the widget*/
-	void* callback; /*pointer for callback when registering one*/
-	int data_len;  /*Length of the data in the union*/
-	union
-	{
-		int                 nval;
-		double              dval;
-		OSPMD_EVENT         ev_data;
-		BATTERY_PRESENCE    bat_pres;
-		BATTERY_ALARM       bat_alarm;
-		ALL_BAT_DATA        bat_all;
-		ALL_AC_ADAPTERS     ac_all;
-		BUTTON_ACTIONS      bc_all;
-		ALARM_CONFIG        alcfg;
-		PWR_SCHEME_LIST     psl;
-		POWER_INFO          pwr_info;
-		PROCESSOR_PERF_INFO proc_info;
-	        PM_THERMAL_DATA     thermal_data;
-		char str[SOCK_DATA_STR_MAX];
-	}data;
-} SOCK_DATA;
-
-struct wire_data_hdr
-{
-	unsigned int magic;
-	int data_len;
-	unsigned int req_type;
-};
-
-struct wire_msg_types
-{
-	unsigned int type;
-	int datalen_to_server;
-	int datalen_from_server;
-};
-
-#define OSPMD_SERVER_PATH "/tmp/.ospm-unix"
-
-#define OSPMD_CONFIG_BATTERY
-#define OSPMD_CONFIG_ACADAPTER
-
-#define OSPM_WIRE_MAGIC		0x504F5752	/* 'POWR' */
-#define OSPM_WIRE_DATA_MAX	2048		/* arbitrary */
-
-END_PWR_DECLS
-
-#endif
diff -ur --new-file ospmd-20030327.virgin/libpower/.deps/libpower.Plo ospmd-20030327/libpower/.deps/libpower.Plo
--- ospmd-20030327.virgin/libpower/.deps/libpower.Plo	Thu Jan  1 01:00:00 1970
+++ ospmd-20030327/libpower/.deps/libpower.Plo	Fri Mar 28 18:21:46 2003
@@ -0,0 +1 @@
+# dummy
diff -ur --new-file ospmd-20030327.virgin/libpower/Makefile ospmd-20030327/libpower/Makefile
--- ospmd-20030327.virgin/libpower/Makefile	Tue Oct  8 23:54:12 2002
+++ ospmd-20030327/libpower/Makefile	Thu Jan  1 01:00:00 1970
@@ -1,32 +0,0 @@
-#
-# libpower makefile
-#
-INC_OSPMD= ../inc
-VPATH=$(INC_OSPMD)
-
-# Compile flags
-CXXFLAGS= -Wall -I$(INC_OSPMD) -fPIC -DPWR_DEBUG -g
-
-OBJS=   libpower.o
-
-all: libpower.a
-
-shared: $(OBJS)
-	$(CC) -shared -Wl,-soname,libpower.so.1 -o libpower.so.1.0.0 $(OBJS)
-
-# Describe what goes into the library
-libpower.a: libpower.a($(OBJS))
-	cp libpower.a ../gui
-
-# Describe how to make library components
-libpower.o: libpower.h power.h power_private.h
-
-# Clean up and delete library
-clean:
-	rm -f libpower.a $(OBJS)
-
-
-#define the rule for generating .o files from .cpp
-%.o : %.cpp
-	$(CXX) -c $(CPPFLAGS) $(CXXFLAGS) $< -o $@
-
diff -ur --new-file ospmd-20030327.virgin/libpower/Makefile.am ospmd-20030327/libpower/Makefile.am
--- ospmd-20030327.virgin/libpower/Makefile.am	Thu Jan  1 01:00:00 1970
+++ ospmd-20030327/libpower/Makefile.am	Fri Mar 28 15:48:32 2003
@@ -0,0 +1,6 @@
+
+lib_LTLIBRARIES     = libpower.la
+
+libpower_la_SOURCES = libpower.cpp
+
+include_HEADERS = power.h
diff -ur --new-file ospmd-20030327.virgin/libpower/power.h ospmd-20030327/libpower/power.h
--- ospmd-20030327.virgin/libpower/power.h	Thu Jan  1 01:00:00 1970
+++ ospmd-20030327/libpower/power.h	Thu Mar 27 20:03:24 2003
@@ -0,0 +1,490 @@
+/******************************************************************************
+ *
+ * Name: power.h - Structs and function decls used by callers of libpower
+ *       $Revision: 1.6 $
+ *
+ *****************************************************************************/
+
+/******************************************************************************
+ *
+ * 1. Copyright Notice
+ *
+ * Some or all of this work - Copyright (c) 1999-2002 Intel Corp.
+ * All rights reserved.
+ *
+ * 2. License
+ *
+ * 2.1. This is your license from Intel Corp. under its intellectual property
+ * rights.  You may have additional license terms from the party that provided
+ * you this software, covering your right to use that party's intellectual
+ * property rights.
+ *
+ * 2.2. Intel grants, free of charge, to any person ("Licensee") obtaining a
+ * copy of the source code appearing in this file ("Covered Code") an
+ * irrevocable, perpetual, worldwide license under Intel's copyrights in the
+ * base code distributed originally by Intel ("Original Intel Code") to copy,
+ * make derivatives, distribute, use and display any portion of the Covered
+ * Code in any form, with the right to sublicense such rights; and
+ *
+ * 2.3. Intel grants Licensee a non-exclusive and non-transferable patent
+ * license (with the right to sublicense), under only those claims of Intel
+ * patents that are infringed by the Original Intel Code, to make, use, sell,
+ * offer to sell, and import the Covered Code and derivative works thereof
+ * solely to the minimum extent necessary to exercise the above copyright
+ * license, and in no event shall the patent license extend to any additions
+ * to or modifications of the Original Intel Code.  No other license or right
+ * is granted directly or by implication, estoppel or otherwise;
+ *
+ * The above copyright and patent license is granted only if the following
+ * conditions are met:
+ *
+ * 3. Conditions
+ *
+ * 3.1. Redistribution of Source with Rights to Further Distribute Source.
+ * Redistribution of source code of any substantial portion of the Covered
+ * Code or modification with rights to further distribute source must include
+ * the above Copyright Notice, the above License, this list of Conditions,
+ * and the following Disclaimer and Export Compliance provision.  In addition,
+ * Licensee must cause all Covered Code to which Licensee contributes to
+ * contain a file documenting the changes Licensee made to create that Covered
+ * Code and the date of any change.  Licensee must include in that file the
+ * documentation of any changes made by any predecessor Licensee.  Licensee
+ * must include a prominent statement that the modification is derived,
+ * directly or indirectly, from Original Intel Code.
+ *
+ * 3.2. Redistribution of Source with no Rights to Further Distribute Source.
+ * Redistribution of source code of any substantial portion of the Covered
+ * Code or modification without rights to further distribute source must
+ * include the following Disclaimer and Export Compliance provision in the
+ * documentation and/or other materials provided with distribution.  In
+ * addition, Licensee may not authorize further sublicense of source of any
+ * portion of the Covered Code, and must include terms to the effect that the
+ * license from Licensee to its licensee is limited to the intellectual
+ * property embodied in the software Licensee provides to its licensee, and
+ * not to intellectual property embodied in modifications its licensee may
+ * make.
+ *
+ * 3.3. Redistribution of Executable. Redistribution in executable form of any
+ * substantial portion of the Covered Code or modification must reproduce the
+ * above Copyright Notice, and the following Disclaimer and Export Compliance
+ * provision in the documentation and/or other materials provided with the
+ * distribution.
+ *
+ * 3.4. Intel retains all right, title, and interest in and to the Original
+ * Intel Code.
+ *
+ * 3.5. Neither the name Intel nor any other trademark owned or controlled by
+ * Intel shall be used in advertising or otherwise to promote the sale, use or
+ * other dealings in products derived from or relating to the Covered Code
+ * without prior written authorization from Intel.
+ *
+ * 4. Disclaimer and Export Compliance
+ *
+ * 4.1. INTEL MAKES NO WARRANTY OF ANY KIND REGARDING ANY SOFTWARE PROVIDED
+ * HERE.  ANY SOFTWARE ORIGINATING FROM INTEL OR DERIVED FROM INTEL SOFTWARE
+ * IS PROVIDED "AS IS," AND INTEL WILL NOT PROVIDE ANY SUPPORT,  ASSISTANCE,
+ * INSTALLATION, TRAINING OR OTHER SERVICES.  INTEL WILL NOT PROVIDE ANY
+ * UPDATES, ENHANCEMENTS OR EXTENSIONS.  INTEL SPECIFICALLY DISCLAIMS ANY
+ * IMPLIED WARRANTIES OF MERCHANTABILITY, NONINFRINGEMENT AND FITNESS FOR A
+ * PARTICULAR PURPOSE.
+ *
+ * 4.2. IN NO EVENT SHALL INTEL HAVE ANY LIABILITY TO LICENSEE, ITS LICENSEES
+ * OR ANY OTHER THIRD PARTY, FOR ANY LOST PROFITS, LOST DATA, LOSS OF USE OR
+ * COSTS OF PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES, OR FOR ANY INDIRECT,
+ * SPECIAL OR CONSEQUENTIAL DAMAGES ARISING OUT OF THIS AGREEMENT, UNDER ANY
+ * CAUSE OF ACTION OR THEORY OF LIABILITY, AND IRRESPECTIVE OF WHETHER INTEL
+ * HAS ADVANCE NOTICE OF THE POSSIBILITY OF SUCH DAMAGES.  THESE LIMITATIONS
+ * SHALL APPLY NOTWITHSTANDING THE FAILURE OF THE ESSENTIAL PURPOSE OF ANY
+ * LIMITED REMEDY.
+ *
+ * 4.3. Licensee shall not export, either directly or indirectly, any of this
+ * software or system incorporating such software without first obtaining any
+ * required license or other approval from the U. S. Department of Commerce or
+ * any other agency or department of the United States Government.  In the
+ * event Licensee exports any such software from the United States or
+ * re-exports any such software from a foreign destination, Licensee shall
+ * ensure that the distribution and export/re-export of the software is in
+ * compliance with all laws, regulations, orders, or other restrictions of the
+ * U.S. Export Administration Regulations. Licensee agrees that neither it nor
+ * any of its subsidiaries will export/re-export any technical data, process,
+ * software, or service, directly or indirectly, to any country for which the
+ * United States government or any agency thereof requires an export license,
+ * other governmental approval, or letter of assurance, without first obtaining
+ * such license, approval or letter.
+ *
+ *****************************************************************************/
+
+
+#ifndef _POWER_H
+#define _POWER_H
+
+#ifndef TRUE
+#define TRUE 1
+#define FALSE 0
+#endif
+
+#define MAX_BAT_SLOTS  4
+#define MAX_AC_SLOTS  4
+
+#ifdef __cplusplus
+#define BEGIN_PWR_DECLS	extern "C" {
+#define END_PWR_DECLS	}
+#else
+#define BEGIN_PWR_DECLS
+#define END_PWR_DECLS
+#endif
+
+BEGIN_PWR_DECLS
+
+/* alarm_type is an enumeration of generic alarm types. */
+/* Batteries are defined to only have LOW and CRITICAL. */
+enum alarm_type {
+	ALARM_LOW,
+	ALARM_CRITICAL,
+	ALARM_COUNT
+};
+
+enum button_type {
+	BUTTON_POWER,
+	BUTTON_SLEEP,
+	BUTTON_LID,
+	BUTTON_TYPE_COUNT
+};
+
+enum button_action {
+	BUTTON_ACTION_NOTHING,
+	BUTTON_ACTION_SLEEP,
+	BUTTON_ACTION_HIBERNATE,
+	BUTTON_ACTION_SHUTDOWN,
+	BUTTON_ACTION_RUN_PROG,
+	BUTTON_ACTION_COUNT
+};
+
+enum cooling_mode {
+	COOLING_MODE_NONE,
+        COOLING_MODE_ACTIVE,
+        COOLING_MODE_PASSIVE
+};
+
+#define ACTION_POWER_DEFAULT	BUTTON_ACTION_SHUTDOWN
+#define ACTION_SLEEP_DEFAULT	BUTTON_ACTION_SLEEP
+#define ACTION_LID_DEFAULT	BUTTON_ACTION_NOTHING
+
+typedef struct button_actions
+{
+	int power_action;
+	int sleep_action;
+	int lid_action;
+
+} BUTTON_ACTIONS;
+
+#define ALARM_PROG_PATH_LEN 256
+
+/*This holds information from the alarm configuration files.*/
+typedef struct alarm_config
+{
+	int alarm_enable;
+	int alarm_percent;
+	int alarm_notify;
+	int alarm_action;
+	char alarm_prog_path[ALARM_PROG_PATH_LEN];
+} ALARM_CONFIG;
+
+
+enum pwr_te_id {
+	OSPM_PWR_TE_LB_PIMON=0,
+	OSPM_PWR_TE_LB_PIDISKS,
+	OSPM_PWR_TE_LB_PISTANDBY,
+	OSPM_PWR_TE_LB_OBMON,
+	OSPM_PWR_TE_LB_OBDISKS,
+	OSPM_PWR_TE_LB_OBSTANDBY,
+	OSPM_PWR_TE_LB_COUNT
+};
+/*
+ The values in this pwr_time_entry structure represent
+ the character time list start, end, and current indicies.
+ This full time list definition is found in PowerPage.cpp
+ It is copied here as a comment for convenience.
+ char *strtime[]={"1 min","2 min","3 min","5 min","10 min","15 min",
+			"20 min","25 min","30 min","45 min","1 hour","2 hour",
+			"3 hour","4 hour","5 hour","Never"};
+ So and index of 0 corresponds to a time delay of 1 minute before
+ the associated activity takes place, e.g. blank screen, spin down disk,
+ or go into standby.
+*/
+/*The valid range of values for PWR_TIME_ENTRY data items
+  start,end,and current is 0 to and including 15. This
+  is noted in the following two defines.*/
+#define MIN_PTE_VALUE  0
+#define MAX_PTE_VALUE  15
+
+typedef struct pwr_time_entry
+{
+	int start;
+	int end;
+	int current;
+} PWR_TIME_ENTRY;
+
+/*
+ The data item prefixes in the following structure
+ pi means "plugged in" and ob means "on batteries".
+*/
+typedef struct pwr_scheme
+{
+	int pwr_scheme_flag; /*user or factory created.*/
+	PWR_TIME_ENTRY pimon;
+	PWR_TIME_ENTRY pidisks;
+	PWR_TIME_ENTRY pistandby;
+	PWR_TIME_ENTRY obmon;
+	PWR_TIME_ENTRY obdisks;
+	PWR_TIME_ENTRY obstandby;
+} PWR_SCHEME;
+
+/*
+  The first 5 power schemes should always
+  be filled from the pwrscheme.conf configuration
+  file.  The event server manages this file.
+*/
+#define MAX_PWR_SCHEMES  10
+
+typedef struct pwr_scheme_list
+{
+	int num_pwr_schemes;
+	int current_pwr_scheme;
+	PWR_SCHEME ps[MAX_PWR_SCHEMES];
+} PWR_SCHEME_LIST;
+
+typedef struct num_with_units
+{
+	int num;
+	char units[4];
+} NUM_WITH_UNITS;
+
+enum battery_cap_state {
+	BATCAPSTATE_UNKNOWN,
+	BATCAPSTATE_OK,
+	BATCAPSTATE_LOW,
+	BATCAPSTATE_CRITLOW
+};
+
+enum battery_charge_state {
+	BATSTATE_UNKNOWN=0,
+	BATSTATE_CHARGING,
+	BATSTATE_DISCHARGING,
+	BATSTATE_CHARGDIS
+};
+
+typedef struct battery_status
+{
+	int present; /*no=0x00, yes=0x01*/
+	int capstate; /*ok=0x00, low=0x01, critical=0x02*/
+	int state;/*unknown=0x00, charging=0x01, discharging=0x02, charging/discharging=0x03 */
+	NUM_WITH_UNITS rate;
+	NUM_WITH_UNITS rem_cap; /*remaining capacity in mWh*/
+	NUM_WITH_UNITS voltage; /* mV */
+
+} BATTERY_STATUS;
+
+#define MAX_MODEL_NUM_LEN   64
+#define MAX_SERIAL_NUM_LEN  64
+#define MAX_BATT_TYPE_LEN   64
+#define MAX_OEM_INFO_LEN    64
+#define MAX_BATT_ERR_LEN    64
+
+/*
+ NOTE: Regarding measurement units, from ACPI Spec 2.0 section 3.9.2
+   "A system may use either rate and capacity [mA/mAh] or power and
+    energy [mW/mWh] for the unit of battery information calculation
+    and reporting. Mixing [mA] and [mW] is not allowed on a system."
+*/
+
+typedef struct bat_time
+{
+	int hours;
+	int minutes;
+
+} BAT_TIME;
+
+/*
+  Capacity Ratio "capacity_ratio" = lastfullcap/designcap
+*/
+typedef struct battery_info
+{
+	int present;
+	NUM_WITH_UNITS designcap;
+	NUM_WITH_UNITS lastfullcap;
+	int techtype;
+	NUM_WITH_UNITS designvoltage;
+	NUM_WITH_UNITS designcapwarning;
+	NUM_WITH_UNITS designcaplow;
+	NUM_WITH_UNITS capgran1;
+	NUM_WITH_UNITS capgran2;
+	int capacity_ratio;
+	int rempercent;
+	int lowalarm;
+	int critalarm;
+	BAT_TIME remhours;
+	char model_number[MAX_MODEL_NUM_LEN];
+	char serial_number[MAX_SERIAL_NUM_LEN];
+	char battery_type[MAX_BATT_TYPE_LEN];
+	char oem_info[MAX_OEM_INFO_LEN];
+	char strErr[MAX_BATT_ERR_LEN];
+} BATTERY_INFO;
+
+#define MAX_BAT_UID_PATHNAME_LEN  64
+
+typedef struct battery_presence
+{
+	int number;
+	int present[MAX_BAT_SLOTS];
+
+} BATTERY_PRESENCE;
+
+#define SOCK_DATA_STR_MAX  1024
+
+typedef struct all_bat_data
+{
+	BATTERY_INFO bi;
+	BATTERY_STATUS bs;
+}ALL_BAT_DATA;
+
+typedef struct all_ac_adapters
+{
+	int num;
+	int online;
+}ALL_AC_ADAPTERS;
+
+#define MAX_EV_CLASS_LEN  32
+#define MAX_EV_DEV_LEN    32
+
+enum event_class
+{
+	EVENT_CLASS_UNKNOWN,
+	EVENT_CLASS_AC,
+	EVENT_CLASS_BATTERY,
+	EVENT_CLASS_BUTTON,
+	EVENT_CLASS_PROCESSOR,
+	EVENT_CLASS_THERMAL,
+	EVENT_CLASS_COUNT,
+};
+
+typedef struct ospmd_event
+{
+	unsigned short ev_class;
+	char ev_dev_name[MAX_EV_DEV_LEN];
+	unsigned int ev_data;
+
+} OSPMD_EVENT;
+
+typedef struct processor_perf
+{
+	unsigned short perf_state;
+	unsigned short throttle_state;
+
+} PROCESSOR_PERF;
+
+typedef struct processor_perf_info
+{
+	PROCESSOR_PERF current;
+	PROCESSOR_PERF max;
+
+}PROCESSOR_PERF_INFO;
+
+/* [FIXME: Implement trippoints, have to understand format first] */
+
+typedef struct pm_thermal_trippoints
+{
+} PM_THERMAL_TRIPPOINTS;
+
+typedef struct pm_thermal_data
+{
+  unsigned int cooling_mode;
+  unsigned int polling_frequency;
+  unsigned short state;
+  unsigned short temperature;
+} PM_THERMAL_DATA;
+
+/* TODO: clean up, make names consistent */
+
+/* implemented functions */
+
+int pm_get_processor_info(PROCESSOR_PERF* perf_info);
+int pm_get_batt_presence(BATTERY_PRESENCE* batt_pres);
+/* TODO: change "info" to "data"? */
+int pm_get_batt_info(int batt_num, ALL_BAT_DATA* batt_info);
+int pm_get_ac_presence(ALL_AC_ADAPTERS* ac_info);
+int pm_set_button_actions(BUTTON_ACTIONS* abc);
+int pm_get_button_actions(BUTTON_ACTIONS* abc);
+int pm_get_power_schemes(PWR_SCHEME_LIST* power_list);
+int pm_set_power_schemes(PWR_SCHEME_LIST* power_list);
+
+int pm_get_thermal_data (PM_THERMAL_DATA* thermal_data);
+
+void *pm_event_listen_start(void (*func_ptr)(OSPMD_EVENT* ev));
+int pm_event_listen_stop(void* handle);
+
+/* half-implemented functions */
+
+int pm_get_batt_alarm(unsigned short type, ALARM_CONFIG* alarm_cfg);
+int pm_set_batt_alarm(unsigned short type, ALARM_CONFIG* alarm_cfg);
+
+/* unimplemented functions */
+
+int pm_screen_disallow_blank(void);
+int pm_screen_allow_blank(void);
+
+int pm_system_disallow_suspend(void);
+int pm_system_allow_suspend(void);
+
+int pm_suspend_system(void);
+int pm_hibernate_system(void);
+int pm_shutdown_system(void);
+
+int pm_get_fan_info(void);
+
+/* unused (as yet) data structures*/
+
+/*device_handle is an opaque value that identifies the
+  battery in question. It cooresponds to the GUI enumeration
+  device_ids. */
+typedef int device_handle;
+
+typedef struct power_info
+{
+	unsigned char power_source;	/* 0x00=unknown, 0x01=AC, 0x02=battery */
+	unsigned char percent_remaining;/* 0-100%: coalesced - only applicable on battery */
+	unsigned long time_remaining;	/* Coalesced - in seconds - only applicable on battery */
+	struct {
+		unsigned long	count;
+		device_handle	*devices;
+	}ac_adapters;
+	struct {
+		unsigned long	count;
+		device_handle	*devices;
+	}batteries;
+} POWER_INFO;
+
+typedef struct battery_alarm_action
+{
+	unsigned long broadcast:1; /*Message to all processes(used when GUI isn't present) */
+	unsigned long sleep:3;     /*Initiate sleep (S1=1, S2=2, ... S5=5) */
+	unsigned long reserved:28;
+
+} BATTERY_ALARM_ACTION;
+
+
+/* battery_alarm is a data structure containing the threshold value
+  (% battery capacity remaining) and action(s) that policy should
+  take (if any).  Note that the UI will be responsible for certain
+  actions (e.g. displaying message box, sounding a beep-beep-beep,
+  etc.), while policy will be responsible for other (e.g. initiate sleep).*/
+typedef struct battery_alarm
+{
+	unsigned long trip_point;  /* 0-100% */
+	struct battery_alarm_action action; /* Action that policy should perform */
+
+} BATTERY_ALARM;
+
+END_PWR_DECLS
+
+#endif
diff -ur --new-file ospmd-20030327.virgin/libpower/power_private.h ospmd-20030327/libpower/power_private.h
--- ospmd-20030327.virgin/libpower/power_private.h	Thu Jan  1 01:00:00 1970
+++ ospmd-20030327/libpower/power_private.h	Thu Mar 27 20:03:24 2003
@@ -0,0 +1,203 @@
+/******************************************************************************
+ *
+ * Name: power_private.h - Structs and function decls used for lib <--> daemon
+ *       communication only.
+ *       $Revision: 1.3 $
+ *
+ *****************************************************************************/
+
+/******************************************************************************
+ *
+ * 1. Copyright Notice
+ *
+ * Some or all of this work - Copyright (c) 1999-2002 Intel Corp.
+ * All rights reserved.
+ *
+ * 2. License
+ *
+ * 2.1. This is your license from Intel Corp. under its intellectual property
+ * rights.  You may have additional license terms from the party that provided
+ * you this software, covering your right to use that party's intellectual
+ * property rights.
+ *
+ * 2.2. Intel grants, free of charge, to any person ("Licensee") obtaining a
+ * copy of the source code appearing in this file ("Covered Code") an
+ * irrevocable, perpetual, worldwide license under Intel's copyrights in the
+ * base code distributed originally by Intel ("Original Intel Code") to copy,
+ * make derivatives, distribute, use and display any portion of the Covered
+ * Code in any form, with the right to sublicense such rights; and
+ *
+ * 2.3. Intel grants Licensee a non-exclusive and non-transferable patent
+ * license (with the right to sublicense), under only those claims of Intel
+ * patents that are infringed by the Original Intel Code, to make, use, sell,
+ * offer to sell, and import the Covered Code and derivative works thereof
+ * solely to the minimum extent necessary to exercise the above copyright
+ * license, and in no event shall the patent license extend to any additions
+ * to or modifications of the Original Intel Code.  No other license or right
+ * is granted directly or by implication, estoppel or otherwise;
+ *
+ * The above copyright and patent license is granted only if the following
+ * conditions are met:
+ *
+ * 3. Conditions
+ *
+ * 3.1. Redistribution of Source with Rights to Further Distribute Source.
+ * Redistribution of source code of any substantial portion of the Covered
+ * Code or modification with rights to further distribute source must include
+ * the above Copyright Notice, the above License, this list of Conditions,
+ * and the following Disclaimer and Export Compliance provision.  In addition,
+ * Licensee must cause all Covered Code to which Licensee contributes to
+ * contain a file documenting the changes Licensee made to create that Covered
+ * Code and the date of any change.  Licensee must include in that file the
+ * documentation of any changes made by any predecessor Licensee.  Licensee
+ * must include a prominent statement that the modification is derived,
+ * directly or indirectly, from Original Intel Code.
+ *
+ * 3.2. Redistribution of Source with no Rights to Further Distribute Source.
+ * Redistribution of source code of any substantial portion of the Covered
+ * Code or modification without rights to further distribute source must
+ * include the following Disclaimer and Export Compliance provision in the
+ * documentation and/or other materials provided with distribution.  In
+ * addition, Licensee may not authorize further sublicense of source of any
+ * portion of the Covered Code, and must include terms to the effect that the
+ * license from Licensee to its licensee is limited to the intellectual
+ * property embodied in the software Licensee provides to its licensee, and
+ * not to intellectual property embodied in modifications its licensee may
+ * make.
+ *
+ * 3.3. Redistribution of Executable. Redistribution in executable form of any
+ * substantial portion of the Covered Code or modification must reproduce the
+ * above Copyright Notice, and the following Disclaimer and Export Compliance
+ * provision in the documentation and/or other materials provided with the
+ * distribution.
+ *
+ * 3.4. Intel retains all right, title, and interest in and to the Original
+ * Intel Code.
+ *
+ * 3.5. Neither the name Intel nor any other trademark owned or controlled by
+ * Intel shall be used in advertising or otherwise to promote the sale, use or
+ * other dealings in products derived from or relating to the Covered Code
+ * without prior written authorization from Intel.
+ *
+ * 4. Disclaimer and Export Compliance
+ *
+ * 4.1. INTEL MAKES NO WARRANTY OF ANY KIND REGARDING ANY SOFTWARE PROVIDED
+ * HERE.  ANY SOFTWARE ORIGINATING FROM INTEL OR DERIVED FROM INTEL SOFTWARE
+ * IS PROVIDED "AS IS," AND INTEL WILL NOT PROVIDE ANY SUPPORT,  ASSISTANCE,
+ * INSTALLATION, TRAINING OR OTHER SERVICES.  INTEL WILL NOT PROVIDE ANY
+ * UPDATES, ENHANCEMENTS OR EXTENSIONS.  INTEL SPECIFICALLY DISCLAIMS ANY
+ * IMPLIED WARRANTIES OF MERCHANTABILITY, NONINFRINGEMENT AND FITNESS FOR A
+ * PARTICULAR PURPOSE.
+ *
+ * 4.2. IN NO EVENT SHALL INTEL HAVE ANY LIABILITY TO LICENSEE, ITS LICENSEES
+ * OR ANY OTHER THIRD PARTY, FOR ANY LOST PROFITS, LOST DATA, LOSS OF USE OR
+ * COSTS OF PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES, OR FOR ANY INDIRECT,
+ * SPECIAL OR CONSEQUENTIAL DAMAGES ARISING OUT OF THIS AGREEMENT, UNDER ANY
+ * CAUSE OF ACTION OR THEORY OF LIABILITY, AND IRRESPECTIVE OF WHETHER INTEL
+ * HAS ADVANCE NOTICE OF THE POSSIBILITY OF SUCH DAMAGES.  THESE LIMITATIONS
+ * SHALL APPLY NOTWITHSTANDING THE FAILURE OF THE ESSENTIAL PURPOSE OF ANY
+ * LIMITED REMEDY.
+ *
+ * 4.3. Licensee shall not export, either directly or indirectly, any of this
+ * software or system incorporating such software without first obtaining any
+ * required license or other approval from the U. S. Department of Commerce or
+ * any other agency or department of the United States Government.  In the
+ * event Licensee exports any such software from the United States or
+ * re-exports any such software from a foreign destination, Licensee shall
+ * ensure that the distribution and export/re-export of the software is in
+ * compliance with all laws, regulations, orders, or other restrictions of the
+ * U.S. Export Administration Regulations. Licensee agrees that neither it nor
+ * any of its subsidiaries will export/re-export any technical data, process,
+ * software, or service, directly or indirectly, to any country for which the
+ * United States government or any agency thereof requires an export license,
+ * other governmental approval, or letter of assurance, without first obtaining
+ * such license, approval or letter.
+ *
+ *****************************************************************************/
+
+#include "power.h"
+
+#ifndef _POWER_PRIVATE_H
+#define _POWER_PRIVATE_H
+
+BEGIN_PWR_DECLS
+
+#define OSPM_ACTION_BAT_ALARM_GET		0x00
+#define OSPM_ACTION_BAT_ALARM_SET		0x01
+#define OSPM_ACTION_BAT_STATUS_GET		0x02
+#define OSPM_ACTION_BAT_INFO_GET		0x03
+#define OSPM_ACTION_BAT_PRESENCE_GET		0x04
+#define OSPM_ACTION_AC_PRESENCE_GET		0x05
+#define OSPM_ACTION_PWRSCHEME_GET_ALL		0x06
+#define OSPM_ACTION_PWRSCHEME_SET_ALL		0x07
+#define OSPM_ACTION_PWRSCHEME_SET_CURRENT	0x08
+#define OSPM_ACTION_BUTTON_GET_ALL		0x09
+#define OSPM_ACTION_BUTTON_SET_ALL		0x0A
+#define OSPM_ACTION_CRITBATT_GET		0x0B
+#define OSPM_ACTION_LOWBATT_GET			0x0C
+#define OSPM_ACTION_CRITBATT_SET		0x0D
+#define OSPM_ACTION_LOWBATT_SET			0x0E
+#define OSPM_ACTION_PROC_INFO_GET		0x0F
+#define OSPM_ACTION_THERMAL_GET		        0x10
+#define OSPM_ACTION_MAX				OSPM_ACTION_THERMAL_GET
+
+/* Events are handled differently */
+#define OSPM_ACTION_EVENT_CONNECT		0x80
+#define OSPM_ACTION_EVENT			0x81
+#define OSPM_ACTION_EVENT_DISCONNECT		0x82
+
+
+typedef struct
+{
+	int sd_len;  /*Length of this structure*/
+	int error; /*0=success -1=error this is a return value from the server*/
+	int dev_class; /*Device class this ID is associated with.*/
+	int id;/*Id of device from device driver's viewpoint from enum device_ids*/
+	int action;  /*An encoded action from GUI to Policy*/
+	void* ptr; /*pointer to the widget*/
+	void* callback; /*pointer for callback when registering one*/
+	int data_len;  /*Length of the data in the union*/
+	union
+	{
+		int                 nval;
+		double              dval;
+		OSPMD_EVENT         ev_data;
+		BATTERY_PRESENCE    bat_pres;
+		BATTERY_ALARM       bat_alarm;
+		ALL_BAT_DATA        bat_all;
+		ALL_AC_ADAPTERS     ac_all;
+		BUTTON_ACTIONS      bc_all;
+		ALARM_CONFIG        alcfg;
+		PWR_SCHEME_LIST     psl;
+		POWER_INFO          pwr_info;
+		PROCESSOR_PERF_INFO proc_info;
+	        PM_THERMAL_DATA     thermal_data;
+		char str[SOCK_DATA_STR_MAX];
+	}data;
+} SOCK_DATA;
+
+struct wire_data_hdr
+{
+	unsigned int magic;
+	int data_len;
+	unsigned int req_type;
+};
+
+struct wire_msg_types
+{
+	unsigned int type;
+	int datalen_to_server;
+	int datalen_from_server;
+};
+
+#define OSPMD_SERVER_PATH "/tmp/.ospm-unix"
+
+#define OSPMD_CONFIG_BATTERY
+#define OSPMD_CONFIG_ACADAPTER
+
+#define OSPM_WIRE_MAGIC		0x504F5752	/* 'POWR' */
+#define OSPM_WIRE_DATA_MAX	2048		/* arbitrary */
+
+END_PWR_DECLS
+
+#endif
diff -ur --new-file ospmd-20030327.virgin/ospmd/Makefile ospmd-20030327/ospmd/Makefile
--- ospmd-20030327.virgin/ospmd/Makefile	Tue Oct  8 20:16:39 2002
+++ ospmd-20030327/ospmd/Makefile	Thu Jan  1 01:00:00 1970
@@ -1,44 +0,0 @@
-#
-# ospmd makefile
-#
-INC_OSPMD= ../inc
-VPATH=$(INC_OSPMD)
-
-# Uncomment the last part to enable debug messages
-CXXFLAGS= -pipe -Wall -g -I$(INC_OSPMD) -DOSPMD_DEBUG
-
-# list of object files
-OBJS=   ospmd.o \
-	acpi_interface.o \
-	apm_interface.o \
-	client.o \
-	pwrscheme.o \
-	policy_button.o \
-	policy_battery.o \
-	policy_misc.o \
-	properties.o
-
-
-GLOBAL_DEPS= power.h ospmd.h power_private.h properties.h
-
-all: ospmd
-
-# Describe what components go into the ospmd daemon.
-# Cannot use implicit rule since then C++ linker would not be used
-ospmd: $(OBJS)
-	$(CXX) $(OBJS) -o $@
-
-# define header dependencies
-ospmd.o alarm.o client.o pwrscheme.o policy_button.o policy_battery.o \
-policy_misc.o properties.o: $(GLOBAL_DEPS)
-
-apm_interface.o : apm_interface.h $(GLOBAL_DEPS)
-
-acpi_interface.o : acpi_interface.h $(GLOBAL_DEPS)
-
-clean:
-	rm -f ospmd $(OBJS)
-
-#define the rule for generating .o files from .cpp
-%.o : %.cpp
-	$(CXX) -c $(CPPFLAGS) $(CXXFLAGS) $< -o $@
diff -ur --new-file ospmd-20030327.virgin/ospmd/Makefile.am ospmd-20030327/ospmd/Makefile.am
--- ospmd-20030327.virgin/ospmd/Makefile.am	Thu Jan  1 01:00:00 1970
+++ ospmd-20030327/ospmd/Makefile.am	Fri Mar 28 18:38:59 2003
@@ -0,0 +1,20 @@
+INCLUDES = -I$(top_srcdir)/libpower
+
+bin_PROGRAMS = ospmd
+
+ospmd_SOURCES = 			\
+		acpi_interface.cpp	\
+		acpi_interface.h	\
+		apm_interface.cpp	\
+		apm_interface.h		\
+		client.cpp		\
+		ospmd.cpp		\
+		ospmd.h			\
+		policy_battery.cpp	\
+		policy_button.cpp	\
+		policy_misc.cpp		\
+		properties.cpp		\
+		properties.h		\
+		pwrscheme.cpp		
+
+ospmd_LDADD = $(top_srcdir)/libpower/libpower.la $(PTHREAD_LIB)

--Boundary_(ID_lkBN4/y7KennPfS2FQCNSw)--


-------------------------------------------------------
This SF.net email is sponsored by:
The Definitive IT and Networking Event. Be There!
NetWorld+Interop Las Vegas 2003 -- Register today!
http://ads.sourceforge.net/cgi-bin/redirect.pl?keyn0001en
