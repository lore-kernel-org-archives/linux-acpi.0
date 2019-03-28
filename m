From: Changbin Du <changbin.du@gmail.com>
Subject: [PATCH 17/23] acpi doc: convert acpi/aml-debugger.txt to rst format
Date: Fri, 29 Mar 2019 00:27:15 +0800
Message-ID: <20190328162721.26138-18-changbin.du@gmail.com>
References: <20190328162721.26138-1-changbin.du@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190328162721.26138-1-changbin.du@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jonathan Corbet <corbet@lwn.net>
Cc: rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
List-Id: linux-acpi@vger.kernel.org

This converts the plain text documentation to reStructuredText format and
add it to Sphinx TOC tree. No essential content change.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 Documentation/acpi/aml-debugger.rst | 74 +++++++++++++++++++++++++++++
 Documentation/acpi/aml-debugger.txt | 66 -------------------------
 Documentation/acpi/index.rst        |  1 +
 3 files changed, 75 insertions(+), 66 deletions(-)
 create mode 100644 Documentation/acpi/aml-debugger.rst
 delete mode 100644 Documentation/acpi/aml-debugger.txt

diff --git a/Documentation/acpi/aml-debugger.rst b/Documentation/acpi/aml-debugger.rst
new file mode 100644
index 000000000000..dc9b75530dc3
--- /dev/null
+++ b/Documentation/acpi/aml-debugger.rst
@@ -0,0 +1,74 @@
+.. include:: <isonum.txt>
+
+================
+The AML Debugger
+================
+
+:Copyright: |copy| 2016, Intel Corporation
+:Author: Lv Zheng <lv.zheng@intel.com>
+
+
+This document describes the usage of the AML debugger embedded in the Linux
+kernel.
+
+1. Build the debugger
+=====================
+
+The following kernel configuration items are required to enable the AML
+debugger interface from the Linux kernel::
+
+   CONFIG_ACPI_DEBUGGER=y
+   CONFIG_ACPI_DEBUGGER_USER=m
+
+The userspace utilities can be built from the kernel source tree using
+the following commands::
+
+   $ cd tools
+   $ make acpi
+
+The resultant userspace tool binary is then located at::
+
+   tools/power/acpi/acpidbg
+
+It can be installed to system directories by running "make install" (as a
+sufficiently privileged user).
+
+2. Start the userspace debugger interface
+=========================================
+
+After booting the kernel with the debugger built-in, the debugger can be
+started by using the following commands::
+
+   # mount -t debugfs none /sys/kernel/debug
+   # modprobe acpi_dbg
+   # tools/power/acpi/acpidbg
+
+That spawns the interactive AML debugger environment where you can execute
+debugger commands.
+
+The commands are documented in the "ACPICA Overview and Programmer Reference"
+that can be downloaded from
+
+https://acpica.org/documentation
+
+The detailed debugger commands reference is located in Chapter 12 "ACPICA
+Debugger Reference".  The "help" command can be used for a quick reference.
+
+3. Stop the userspace debugger interface
+========================================
+
+The interactive debugger interface can be closed by pressing Ctrl+C or using
+the "quit" or "exit" commands.  When finished, unload the module with::
+
+   # rmmod acpi_dbg
+
+The module unloading may fail if there is an acpidbg instance running.
+
+4. Run the debugger in a script
+===============================
+
+It may be useful to run the AML debugger in a test script. "acpidbg" supports
+this in a special "batch" mode.  For example, the following command outputs
+the entire ACPI namespace::
+
+   # acpidbg -b "namespace"
diff --git a/Documentation/acpi/aml-debugger.txt b/Documentation/acpi/aml-debugger.txt
deleted file mode 100644
index 75ebeb64ab29..000000000000
--- a/Documentation/acpi/aml-debugger.txt
+++ /dev/null
@@ -1,66 +0,0 @@
-The AML Debugger
-
-Copyright (C) 2016, Intel Corporation
-Author: Lv Zheng <lv.zheng@intel.com>
-
-
-This document describes the usage of the AML debugger embedded in the Linux
-kernel.
-
-1. Build the debugger
-
-   The following kernel configuration items are required to enable the AML
-   debugger interface from the Linux kernel:
-
-   CONFIG_ACPI_DEBUGGER=y
-   CONFIG_ACPI_DEBUGGER_USER=m
-
-   The userspace utilities can be built from the kernel source tree using
-   the following commands:
-
-   $ cd tools
-   $ make acpi
-
-   The resultant userspace tool binary is then located at:
-
-     tools/power/acpi/acpidbg
-
-   It can be installed to system directories by running "make install" (as a
-   sufficiently privileged user).
-
-2. Start the userspace debugger interface
-
-   After booting the kernel with the debugger built-in, the debugger can be
-   started by using the following commands:
-
-   # mount -t debugfs none /sys/kernel/debug
-   # modprobe acpi_dbg
-   # tools/power/acpi/acpidbg
-
-   That spawns the interactive AML debugger environment where you can execute
-   debugger commands.
-
-   The commands are documented in the "ACPICA Overview and Programmer Reference"
-   that can be downloaded from
-
-   https://acpica.org/documentation
-
-   The detailed debugger commands reference is located in Chapter 12 "ACPICA
-   Debugger Reference".  The "help" command can be used for a quick reference.
-
-3. Stop the userspace debugger interface
-
-   The interactive debugger interface can be closed by pressing Ctrl+C or using
-   the "quit" or "exit" commands.  When finished, unload the module with:
-
-   # rmmod acpi_dbg
-
-   The module unloading may fail if there is an acpidbg instance running.
-
-4. Run the debugger in a script
-
-   It may be useful to run the AML debugger in a test script. "acpidbg" supports
-   this in a special "batch" mode.  For example, the following command outputs
-   the entire ACPI namespace:
-
-   # acpidbg -b "namespace"
diff --git a/Documentation/acpi/index.rst b/Documentation/acpi/index.rst
index 48964586ef75..241723643468 100644
--- a/Documentation/acpi/index.rst
+++ b/Documentation/acpi/index.rst
@@ -21,3 +21,4 @@ Linux ACPI (Advanced Configuration and Power Interface)
    dsdt-override
    debug
    method-tracing
+   aml-debugger
-- 
2.20.1
