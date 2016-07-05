From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 3/5] ACPI / debugger: Add AML debugger documentation
Date: Tue,  5 Jul 2016 19:18:13 +0800
Message-ID: <8c221ad3601f62334bc4133e31e08285029c45d8.1467717305.git.lv.zheng@intel.com>
References: <cover.1467717304.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1467717304.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

This patch adds AML debugger documentation.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 Documentation/acpi/aml-debugger.txt |   56 +++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)
 create mode 100644 Documentation/acpi/aml-debugger.txt

diff --git a/Documentation/acpi/aml-debugger.txt b/Documentation/acpi/aml-debugger.txt
new file mode 100644
index 0000000..0789332
--- /dev/null
+++ b/Documentation/acpi/aml-debugger.txt
@@ -0,0 +1,56 @@
+The AML Debugger
+
+Copyright (C) 2016, Intel Corporation
+Author: Lv Zheng <lv.zheng@intel.com>
+
+
+Abstract:
+
+This document describes the usage of the AML debugger embedded in the Linux
+kernel.
+
+1. Build the debugger
+
+   The following kernel configuration items are required to enable the AML
+   debugger interface from the Linux kernel:
+   CONFIG_ACPI_DEBUGGER=y
+   CONFIG_ACPI_DEBUGGER_USER=m
+   The userspace utlities can be built from the kernel source tree using
+   the following commands:
+   # cd tools
+   # make acpi
+   The built userspace tool can be found at:
+     tools/acpi/power/acpi/acpidbg/acpidbg
+   You can install it to the system directories using the following
+   command:
+   # sudo make install
+
+2. Start the userspace debugger interface
+
+   After booting the kernel with the debugger built-in, developers can
+   start the debugger with the following commands:
+   # sudo mount -t debugfs none /sys/kernel/debug
+   # sudo modprobe acpi_dbg
+   # sudo tools/acpi/power/acpi/acpidbg/acpidbg
+   Now you have entered the interactive AML debugger environment, where
+   you can execute the debugger functionalities by typing the debugger
+   commands.
+   You can start to use it from typing "help" command and can download
+   <ACPICA Overview and Programmer Reference> from the following site:
+     https://acpica.org/documentation
+   And find detailed command reference in "Chapter 12. ACPICA Debugger
+   Reference".
+
+3. Stop the userspace debugger interface
+
+   You can type the Ctrl+C, quit, exit to end the interactive debugger
+   interface. And unload the module with the following commands:
+   # sudo rmmod acpi_dbg
+   The module unloading may fail if there is an acpidbg instance running.
+
+4. Run the debugger in a script
+
+   It will be very useful to have the ability to run the AML debugger in
+   a test script. "acpidbg" supports this in a special "batch" mode. For
+   example, the following command outputs the entire ACPI namespace:
+   # sudo acpidbg -b "namespace"
-- 
1.7.10
