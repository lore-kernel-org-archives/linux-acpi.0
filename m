From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 5/5] ACPI: update debug parameter documentation
Date: Fri, 07 Nov 2008 16:58:05 -0700
Message-ID: <20081107235805.32050.47567.stgit@bob.kio>
References: <20081107235644.32050.74757.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g5t0006.atlanta.hp.com ([15.192.0.43]:19347 "EHLO
	g5t0006.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752711AbYKGX6H (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 7 Nov 2008 18:58:07 -0500
In-Reply-To: <20081107235644.32050.74757.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Thomas Renninger <trenn@suse.de>, Randy Dunlap <rdunlap@xenotime.net>

Reformat acpi.debug_layer and acpi.debug_level documentation so it's
more readable, add some clues about how to figure out the mask bits that
enable a specific ACPI_DEBUG_PRINT statement, and include some useful
examples.

Move the list of masks to Documentation/acpi/debug.txt (these are
copies of the authoritative values in acoutput.h and acpi_drivers.h).

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
---
 Documentation/acpi/debug.txt        |  148 +++++++++++++++++++++++++++++++++++
 Documentation/kernel-parameters.txt |   75 +++++-------------
 drivers/acpi/Kconfig                |   10 ++
 3 files changed, 178 insertions(+), 55 deletions(-)
 create mode 100644 Documentation/acpi/debug.txt

diff --git a/Documentation/acpi/debug.txt b/Documentation/acpi/debug.txt
new file mode 100644
index 0000000..65bf47c
--- /dev/null
+++ b/Documentation/acpi/debug.txt
@@ -0,0 +1,148 @@
+			ACPI Debug Output
+
+
+The ACPI CA, the Linux ACPI core, and some ACPI drivers can generate debug
+output.  This document describes how to use this facility.
+
+Compile-time configuration
+--------------------------
+
+ACPI debug output is globally enabled by CONFIG_ACPI_DEBUG.  If this config
+option is turned off, the debug messages are not even built into the
+kernel.
+
+Boot- and run-time configuration
+--------------------------------
+
+When CONFIG_ACPI_DEBUG=y, you can select the component and level of messages
+you're interested in.  At boot-time, use the acpi.debug_layer and
+acpi.debug_level kernel command line options.  After boot, you can use the
+debug_layer and debug_level files in /sys/module/acpi/parameters/ to control
+the debug messages.
+
+debug_layer (component)
+-----------------------
+
+The "debug_layer" is a mask that selects components of interest, e.g., a
+specific driver or part of the ACPI interpreter.  To build the debug_layer
+bitmask, look for the "#define _COMPONENT" in an ACPI source file.
+
+You can set the debug_layer mask at boot-time using the acpi.debug_layer
+command line argument, and you can change it after boot by writing values
+to /sys/module/acpi/parameters/debug_layer.
+
+The possible components are defined in include/acpi/acoutput.h and
+include/acpi/acpi_drivers.h.  Reading /sys/module/acpi/parameters/debug_layer
+shows the supported mask values, currently these:
+
+    ACPI_UTILITIES                  0x00000001
+    ACPI_HARDWARE                   0x00000002
+    ACPI_EVENTS                     0x00000004
+    ACPI_TABLES                     0x00000008
+    ACPI_NAMESPACE                  0x00000010
+    ACPI_PARSER                     0x00000020
+    ACPI_DISPATCHER                 0x00000040
+    ACPI_EXECUTER                   0x00000080
+    ACPI_RESOURCES                  0x00000100
+    ACPI_CA_DEBUGGER                0x00000200
+    ACPI_OS_SERVICES                0x00000400
+    ACPI_CA_DISASSEMBLER            0x00000800
+    ACPI_COMPILER                   0x00001000
+    ACPI_TOOLS                      0x00002000
+    ACPI_BUS_COMPONENT              0x00010000
+    ACPI_AC_COMPONENT               0x00020000
+    ACPI_BATTERY_COMPONENT          0x00040000
+    ACPI_BUTTON_COMPONENT           0x00080000
+    ACPI_SBS_COMPONENT              0x00100000
+    ACPI_FAN_COMPONENT              0x00200000
+    ACPI_PCI_COMPONENT              0x00400000
+    ACPI_POWER_COMPONENT            0x00800000
+    ACPI_CONTAINER_COMPONENT        0x01000000
+    ACPI_SYSTEM_COMPONENT           0x02000000
+    ACPI_THERMAL_COMPONENT          0x04000000
+    ACPI_MEMORY_DEVICE_COMPONENT    0x08000000
+    ACPI_VIDEO_COMPONENT            0x10000000
+    ACPI_PROCESSOR_COMPONENT        0x20000000
+
+debug_level
+-----------
+
+The "debug_level" is a mask that selects different types of messages, e.g.,
+those related to initialization, method execution, informational messages, etc.
+To build debug_level, look at the level specified in an ACPI_DEBUG_PRINT()
+statement.
+
+The ACPI interpreter uses several different levels, but the Linux
+ACPI core and ACPI drivers generally only use ACPI_LV_INFO.
+
+You can set the debug_level mask at boot-time using the acpi.debug_level
+command line argument, and you can change it after boot by writing values
+to /sys/module/acpi/parameters/debug_level.
+
+The possible levels are defined in include/acpi/acoutput.h.  Reading
+/sys/module/acpi/parameters/debug_level shows the supported mask values,
+currently these:
+
+    ACPI_LV_INIT                    0x00000001
+    ACPI_LV_DEBUG_OBJECT            0x00000002
+    ACPI_LV_INFO                    0x00000004
+    ACPI_LV_INIT_NAMES              0x00000020
+    ACPI_LV_PARSE                   0x00000040
+    ACPI_LV_LOAD                    0x00000080
+    ACPI_LV_DISPATCH                0x00000100
+    ACPI_LV_EXEC                    0x00000200
+    ACPI_LV_NAMES                   0x00000400
+    ACPI_LV_OPREGION                0x00000800
+    ACPI_LV_BFIELD                  0x00001000
+    ACPI_LV_TABLES                  0x00002000
+    ACPI_LV_VALUES                  0x00004000
+    ACPI_LV_OBJECTS                 0x00008000
+    ACPI_LV_RESOURCES               0x00010000
+    ACPI_LV_USER_REQUESTS           0x00020000
+    ACPI_LV_PACKAGE                 0x00040000
+    ACPI_LV_ALLOCATIONS             0x00100000
+    ACPI_LV_FUNCTIONS               0x00200000
+    ACPI_LV_OPTIMIZATIONS           0x00400000
+    ACPI_LV_MUTEX                   0x01000000
+    ACPI_LV_THREADS                 0x02000000
+    ACPI_LV_IO                      0x04000000
+    ACPI_LV_INTERRUPTS              0x08000000
+    ACPI_LV_AML_DISASSEMBLE         0x10000000
+    ACPI_LV_VERBOSE_INFO            0x20000000
+    ACPI_LV_FULL_TABLES             0x40000000
+    ACPI_LV_EVENTS                  0x80000000
+
+Examples
+--------
+
+For example, drivers/acpi/bus.c contains this:
+
+    #define _COMPONENT              ACPI_BUS_COMPONENT
+    ...
+    ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Device insertion detected\n"));
+
+To turn on this message, set the ACPI_BUS_COMPONENT bit in acpi.debug_layer
+and the ACPI_LV_INFO bit in acpi.debug_level.  (The ACPI_DEBUG_PRINT
+statement uses ACPI_DB_INFO, which is macro based on the ACPI_LV_INFO
+definition.)
+
+Enable all AML "Debug" output (stores to the Debug object while interpreting
+AML) during boot:
+
+    acpi.debug_layer=0xffffffff acpi.debug_level=0x2
+
+Enable PCI and PCI interrupt routing debug messages:
+
+    acpi.debug_layer=0x400000 acpi.debug_level=0x4
+
+Enable all ACPI hardware-related messages:
+
+    acpi.debug_layer=0x2 acpi.debug_level=0xffffffff
+
+Enable all ACPI_DB_INFO messages after boot:
+
+    # echo 0x4 > /sys/module/acpi/parameters/debug_level
+
+Show all valid component values:
+
+    # cat /sys/module/acpi/parameters/debug_layer
diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index 1bbcaa8..f2ed59a 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -198,59 +198,30 @@ and is between 256 and 4096 characters. It is defined in the file
 			that require a timer override, but don't have
 			HPET
 
-	acpi.debug_layer=	[HW,ACPI]
+	acpi.debug_layer=	[HW,ACPI,ACPI_DEBUG]
+	acpi.debug_level=	[HW,ACPI,ACPI_DEBUG]
 			Format: <int>
-			Each bit of the <int> indicates an ACPI debug layer,
-			1: enable, 0: disable. It is useful for boot time
-			debugging. After system has booted up, it can be set
-			via /sys/module/acpi/parameters/debug_layer.
-			CONFIG_ACPI_DEBUG must be enabled for this to produce any output.
-			Available bits (add the numbers together) to enable debug output
-			for specific parts of the ACPI subsystem:
-			0x01 utilities 0x02 hardware 0x04 events 0x08 tables
-			0x10 namespace 0x20 parser 0x40 dispatcher
-			0x80 executer 0x100 resources 0x200 acpica debugger
-			0x400 os services 0x800 acpica disassembler.
-			The number can be in decimal or prefixed with 0x in hex.
-			Warning: Many of these options can produce a lot of
-			output and make your system unusable. Be very careful.
-
-	acpi.debug_level=	[HW,ACPI]
-			Format: <int>
-			Each bit of the <int> indicates an ACPI debug level,
-			which corresponds to the level in an ACPI_DEBUG_PRINT
-			statement.  After system has booted up, this mask
-			can be set via /sys/module/acpi/parameters/debug_level.
-
-			CONFIG_ACPI_DEBUG must be enabled for this to produce
-			any output.  The number can be in decimal or prefixed
-			with 0x in hex.  Some of these options produce so much
-			output that the system is unusable.
-
-			The following global components are defined by the
-			ACPI CA:
-			       0x01 error
-			       0x02 warn
-			       0x04 init
-			       0x08 debug object
-			       0x10 info
-			       0x20 init names
-			       0x40 parse
-			       0x80 load
-			      0x100 dispatch
-			      0x200 execute
-			      0x400 names
-			      0x800 operation region
-			     0x1000 bfield
-			     0x2000 tables
-			     0x4000 values
-			     0x8000 objects
-			    0x10000 resources
-			    0x20000 user requests
-			    0x40000 package
- 			The number can be in decimal or prefixed with 0x in hex.
- 			Warning: Many of these options can produce a lot of
- 			output and make your system unusable. Be very careful.
+			CONFIG_ACPI_DEBUG must be enabled to produce any ACPI
+			debug output.  Bits in debug_layer correspond to a
+			_COMPONENT in an ACPI source file, e.g.,
+			    #define _COMPONENT ACPI_PCI_COMPONENT
+			Bits in debug_level correspond to a level in
+			ACPI_DEBUG_PRINT statements, e.g.,
+			    ACPI_DEBUG_PRINT((ACPI_DB_INFO, ...
+			See Documentation/acpi/debug.txt for more information
+			about debug layers and levels.
+
+			Enable AML "Debug" output, i.e., stores to the Debug
+			object while interpreting AML:
+			    acpi.debug_layer=0xffffffff acpi.debug_level=0x2
+			Enable PCI/PCI interrupt routing info messages:
+			    acpi.debug_layer=0x400000 acpi.debug_level=0x4
+			Enable all messages related to ACPI hardware:
+			    acpi.debug_layer=0x2 acpi.debug_level=0xffffffff
+
+			Some values produce so much output that the system is
+			unusable.  The "log_buf_len" parameter may be useful
+			if you need to capture more output.
 
  	acpi.power_nocheck=	[HW,ACPI]
  			Format: 1/0 enable/disable the check of power state.
diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index f4f6329..4f75996 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -312,9 +312,13 @@ config ACPI_DEBUG
 	bool "Debug Statements"
 	default n
 	help
-	  The ACPI driver can optionally report errors with a great deal
-	  of verbosity. Saying Y enables these statements. This will increase
-	  your kernel size by around 50K.
+	  The ACPI subsystem can produce debug output.  Saying Y enables this
+	  output and increases the kernel size by around 50K.
+
+	  Use the acpi.debug_layer and acpi.debug_level kernel command-line
+	  parameters documented in Documentation/acpi/debug.txt and
+	  Documentation/kernel-parameters.txt to control the type and
+	  amount of debug output.
 
 config ACPI_DEBUG_FUNC_TRACE
 	bool "Additionally enable ACPI function tracing"

