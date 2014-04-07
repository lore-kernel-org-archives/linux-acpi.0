From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH 3/4] tools/power/acpi: Introduce acpi_validate with manpage for easy validation of ACPI BIOS tables
Date: Mon,  7 Apr 2014 15:16:56 +0200
Message-ID: <1396876617-53345-4-git-send-email-trenn@suse.de>
References: <1396876617-53345-1-git-send-email-trenn@suse.de>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:47849 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755333AbaDGNRB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 7 Apr 2014 09:17:01 -0400
In-Reply-To: <1396876617-53345-1-git-send-email-trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@rjwysocki.net
Cc: lv.zheng@intel.com, linux-acpi@vger.kernel.org, Thomas Renninger <trenn@suse.de>

The used iasl compiler shares the same code base as the kernel.
Warnings or errors mostly point to bad BIOSes.
These errors should get reported to the BIOS vendors and may indicated that
acpica (kernel ACPI parts) need compatibility adjustings.


Why is an extra tool needed for this?

The dynamic ACPI Source Language (ASL) parts are located in DSDT and often
multiple SSDT tables. Those often have dependencies to each other and the iasl
compiler often cannot resolve external symbols correctly if they are not
passed as external tables (iasl -e option) when tables get disassembled.
This quickly leads to false positive errors.
This tool makes sure disassembling and recompilation is done correctly.

This tool is also made for ACPI BIOS table verification for BIOS vendors and
hardware certification tools for distributions.
Hardware which supports Linux must/should not show any warnings or errors.
Remarks and optimization hints in the logs can be used to further enhance
the ACPI BIOS code.
Warnings and errors mostly describe the issues in a way, so that they can
get passed to and used by BIOS developers to fix the problems easily.

Signed-off-by: Thomas Renninger <trenn@suse.de>
---
 tools/power/acpi/Makefile            |    3 +
 tools/power/acpi/man/acpidump.8      |    3 +
 tools/power/acpi/tools/acpi_validate |  201 ++++++++++++++++++++++++++++++++++
 3 files changed, 207 insertions(+), 0 deletions(-)
 create mode 100755 tools/power/acpi/tools/acpi_validate

diff --git a/tools/power/acpi/Makefile b/tools/power/acpi/Makefile
index d97dada..a033cfe 100644
--- a/tools/power/acpi/Makefile
+++ b/tools/power/acpi/Makefile
@@ -89,8 +89,11 @@ clean:
 
 install: 
 	$(foreach dir,$(SUBDIRS),make -C $(dir) install;)
+	$(INSTALL_PROGRAM) -D tools/acpi_validate $(DESTDIR)${bindir}/acpi_validate
+
 
 uninstall:
 	$(foreach dir,$(SUBDIRS),make -C $(dir) uninstall;)
+	- rm -f $(DESTDIR)${bindir}/acpi_validate
 
 .PHONY: all install uninstall clean
diff --git a/tools/power/acpi/man/acpidump.8 b/tools/power/acpi/man/acpidump.8
index adfa991..302b602 100644
--- a/tools/power/acpi/man/acpidump.8
+++ b/tools/power/acpi/man/acpidump.8
@@ -53,6 +53,9 @@ ACPICA: https://acpica.org/
 /sys/firmware/acpi/tables/dynamic/*
 .fi
 
+.SH "SEE ALSO"
+.BR acpi_validate (8)
+
 .PP
 .SH AUTHOR
 .nf
diff --git a/tools/power/acpi/tools/acpi_validate b/tools/power/acpi/tools/acpi_validate
new file mode 100755
index 0000000..40701bf
--- /dev/null
+++ b/tools/power/acpi/tools/acpi_validate
@@ -0,0 +1,201 @@
+#!/bin/bash
+#
+# Copyright (c) 2012 SUSE Linux Products GmbH
+# Thomas Renninger <trenn@suse.de>
+#
+# This program is free software; you can redistribute it and/or modify it
+# under the terms and conditions of the GNU General Public License,
+# version 2, as published by the Free Software Foundation.
+#
+# This program is distributed in the hope it will be useful, but WITHOUT
+# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+# FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+# more details.
+#
+# You should have received a copy of the GNU General Public License along with
+# this program; if not, write to the Free Software Foundation, Inc.,
+# 51 Franklin St - Fifth Floor, Boston, MA 02110-1301 USA.
+#
+                                                                             
+OUTPUT_DIR="$PWD"
+VERBOSE=0
+# Disable remarks and resource checks. The latter often/mostly generates
+# false positive warnings. Can be overridden via -c option
+COMPILE_OPTIONS="-sa -cr -vr -in"
+DISASSEMBLE_OPTIONS="-in"
+OUTPUT="/dev/null"
+ACPIDUMP=""
+MUST_BE_ROOT=1
+
+function usage()
+{
+    echo "acpi_validate [ -o output_dir ] [ -v ] [ -a acpidump ]"
+    echo "              [ -c compile_options ] [ -d disassemble_options ]"
+    echo
+    echo "This tool extracts, disassembles and recompiles ACPI BIOS tables."
+    echo "The disassembled files will be copied into the local or specified"
+    echo "output directory (-o option)."
+    echo
+    echo "The underlying iasl compiler verifies and may complain about"
+    echo "correctness of some of the BIOS tables."
+    echo "These can give a pointer to possible malfunction of the system."
+    echo
+    echo "If you think you found a bug in the iasl compiler or related tools,"
+    echo "you can ask here for help: devel@acpica.org"
+    echo "You may also want to ask there if you are not sure whether it really"
+    echo "is a BIOS bug."
+    echo
+    echo "If you are sure you found a BIOS issue, complain to your hardware vendor."
+    echo "The iasl compiler typically provides a description of the warning/error in a way,"
+    echo "so that BIOS authors can easily fix it."
+    echo
+    echo "Options"
+    echo "   -o output_dir: Copy tables to this directory instead of local one"
+    echo "   -v:          : be more verbose"
+    echo "   -a acpidump  : Use this acpidump file"
+    echo "                  instead of the tables from the local machine"
+    echo "   -d options   : Pass iasl disassemble options"
+    echo "   -c options   : Pass iasl compile options"
+    echo "                  will override -sa -cr -vr (default options)"
+    echo "   -h           : Show help"
+    exit 1
+}
+
+while getopts hva:o:c:d: name ; do
+    case $name in
+        o)
+	    OUTPUT_DIR="$OPTARG"
+	    if [ ! -d "$OUTPUT_DIR" ];then
+		mkdir "$OUTPUT_DIR"
+		if [[ $? != 0 ]];then
+		    echo "Cannot create directory $OUTPUT_DIR"
+		    exit 1
+		fi
+	    elif [ ! -w "$OUTPUT_DIR" ];then
+		echo "Cannot write into directory $OUTPUT_DIR"
+		exit 1
+	    fi
+
+	    [[ $VERBOSE == 1 ]] && echo "Installing for architecture: $OUTPUT_DIR"
+	    ;;
+        a)
+	    ACPIDUMP="$OPTARG"
+	    if [ ! -r "$ACPIDUMP" ];then
+		echo "$ACPIDUMP does not exist"
+		exit 1
+	    fi
+	    [[ $VERBOSE == 1 ]] && echo "acpidump file: $ACPIDUMP"
+	    MUST_BE_ROOT=0
+	    ;;
+        c)
+	    COMPILE_OPTIONS="$OPTARG"
+	    [[ $VERBOSE == 1 ]] && echo "Compile options: $COMPILE_OPTIONS"
+	    ;;
+        c)
+	    DISASSEMBLE_OPTIONS="$OPTARG"
+	    [[ $VERBOSE == 1 ]] && echo "Disassemble options: $DISASSEMBLE_OPTIONS"
+	    ;;
+        v)
+            VERBOSE=1
+	    OUTPUT="1"
+            ;;
+        ?)
+	    usage
+	    ;;
+    esac
+done
+shift $(($OPTIND -1))
+
+if [[ $MUST_BE_ROOT == 1 ]] && [ "$(id -u)" != "0" ]; then
+   echo "This script must be run as root"
+   echo "(or use -a acpidump option and pass already dumped acpi tables)"
+   exit 1
+fi
+
+shopt -s nocasematch
+TEMP_DIR=$(mktemp -d)
+[[ $VERBOSE == 1 ]] && echo "Using temporary directory: $TEMP_DIR"
+
+if [ -r "$ACPIDUMP" ];then
+    cp "$ACPIDUMP" "$TEMP_DIR"/acpidump
+fi
+
+pushd "$TEMP_DIR" >/dev/null
+
+mkdir log
+mkdir err
+if [ ! -r acpidump ];then
+    acpidump >acpidump
+fi
+acpixtract -a acpidump >&$OUTPUT 2>&1
+
+
+# ACPICA changed from uppercase to lowercase, try to find both:
+SDTs=$(ls [SD]DST*.dat 2>/dev/null)
+SDTs="${SDTs}$(ls [sd]sdt*.dat 2>/dev/null)"
+
+for file in *.dat;do
+    table=${file/.dat/}
+    # Enable case insensitive pattern matching
+
+    case $file in
+	[DS]SDT*.dat | [sd]sdt*.dat)
+		# Use other [sd]sdt*.dat tables to reference possible
+		# external symbols. Pass the table itself for disassembling
+		# comma separted.
+		# For example you we have:
+		# dsdt.dat ssdt1 ssdt2.dat
+		# and the current table to disassemble is ssdt1.dat the
+		# command has to be:
+		# iasl -e dsdt.dat,ssdt2.dat -d ssdt1.dat
+
+		# Get rid of the table which gets disassembled
+		# could have leading or trailing whitespace depending whether
+		# it is at the end or the beginning of the list
+		REF_TABLE_LIST=${SDTs/[[:space:]]$file/}
+		REF_TABLE_LIST=${REF_TABLE_LIST/$file[[:space:]]/}
+		# Convert the whitespace list into a comma separated one:
+		REF_TABLE_LIST=${REF_TABLE_LIST//[[:space:]]/,}
+		if [ "$REF_TABLE_LIST" != "" ];then
+		    FINAL_DISASSEMBLE_OPTIONS="-e ${REF_TABLE_LIST} $DISASSEMBLE_OPTIONS"
+		else
+		    FINAL_DISASSEMBLE_OPTIONS="$DISASSEMBLE_OPTIONS"
+		fi
+		echo "stdout and stderr of $file disassembling:" >log/${table}.log
+		[[ $VERBOSE == 1 ]] && echo "iasl $FINAL_DISASSEMBLE_OPTIONS -d $file 1>>log/${table}.log 2>&1"
+		iasl $FINAL_DISASSEMBLE_OPTIONS -d $file 1>>log/${table}.log 2>&1
+		[[ $VERBOSE == 1 ]] && echo "iasl $COMPILE_OPTIONS ${table}.dsl 1>>log/${table}.log 2>>err/${table}.err"
+		iasl $COMPILE_OPTIONS ${table}.dsl 1>>log/${table}.log 2>>err/${table}.err
+		;;
+	*.dat)
+		iasl -d $file 1>log/${table}.log 2>&1
+		iasl -sa ${table}.dsl 1>log/${table}.log 2>err/${table}.err
+		;;
+    esac
+done
+
+# remove empty error files
+rm $(find err -size 0)
+ERR_TABLES=$(ls err)
+ERR_TABLES=${ERR_TABLES//.err/}
+
+popd >/dev/null
+cp -r "$TEMP_DIR"/* "$OUTPUT_DIR"
+
+if [[ $VERBOSE == 1 ]];then
+    echo "Temporary directory (undeleted): $TEMP_DIR"
+else
+    rm -rf "$TEMP_DIR"
+fi
+
+if [ "$ERR_TABLES" = "" ];then
+    echo "No errors or warnings detected"
+    exit 0
+else
+    echo "These tables have warnings or errors (details in "$OUTPUT_DIR"/err directory):"
+    for err in $ERR_TABLES;do
+	echo -n $err $'\t'
+	sed -n -e 's/Compilation complete. \(.* Errors, .* Warnings\).*/\1/p' "$OUTPUT_DIR"/log/$err.log
+    done
+    exit 1
+fi
-- 
1.7.6.1

