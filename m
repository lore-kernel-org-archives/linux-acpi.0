From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 01/11] ACPI: update debug parameter documentation
Date: Wed, 05 Nov 2008 16:17:37 -0700
Message-ID: <20081105231737.26131.62046.stgit@bob.kio>
References: <20081105231710.26131.3110.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g5t0008.atlanta.hp.com ([15.192.0.45]:7076 "EHLO
	g5t0008.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752586AbYKEXRi (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 5 Nov 2008 18:17:38 -0500
In-Reply-To: <20081105231710.26131.3110.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Zhao Yakui <yakui.zhao@intel.com>, Alexey Starikovskiy <astarikovskiy@suse.de>

Fix the init, debug, info level definitions, which changed recently.

Reformat acpi.debug_layer and acpi.debug_level documentation so it's
more readable, add some clues about how to figure out the mask bits that
enable a specific ACPI_DEBUG_PRINT statement, and include some useful
examples.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
---
 Documentation/kernel-parameters.txt |   98 ++++++++++++++++++++++-------------
 drivers/acpi/Kconfig                |   12 +++-
 2 files changed, 70 insertions(+), 40 deletions(-)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index 1bbcaa8..ddc791e 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -198,42 +198,69 @@ and is between 256 and 4096 characters. It is defined in the file
 			that require a timer override, but don't have
 			HPET
 
-	acpi.debug_layer=	[HW,ACPI]
+	acpi.debug_*=	[HW,ACPI,ACPI_DEBUG]
+			CONFIG_ACPI_DEBUG must be enabled to produce any ACPI
+			debug output.  The type and amount of output is
+			controlled by debug_layer and debug_level parameters,
+			which can be in decimal or hex (prefixed with "0x").
+			Some values produce so much output that the system is
+			unusable.  The "log_buf_len" parameter may be useful
+			if you need to capture more output.
+
+			To see AML "Debug" output (stores to the Debug object
+			while interpreting AML (this is enabled by default)):
+			    acpi.debug_layer=0xffffffff acpi.debug_level=0x2
+			For debugging PCI/_PRT issues (PCI, info msgs):
+			    acpi.debug_layer=0x400000 acpi.debug_level=0x4
+			For ACPI hardware issues (hardware, all msgs):
+			    acpi.debug_layer=0x2 acpi.debug_level=0xffffffff
+
+	    acpi.debug_layer=	[HW,ACPI,ACPI_DEBUG]
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
+			Bits in <int> correspond to _COMPONENT definitions in
+			ACPI source files.  After boot, this mask can changed
+			on the fly, e.g., 
+			    echo 0x2 > /sys/module/acpi/parameters/debug_layer
+			The contents of debug_layer show the names of all the
+			defined bits and their current state.
+
+			The following are some of the global components
+			defined by the ACPI CA and the Linux OSPM:
+				0x01 utilities
+				0x02 hardware
+				0x04 events
+				0x08 tables
+				0x10 namespace
+				0x20 parser
+				0x40 dispatcher
+				0x80 executer
+			       0x100 resources
+			       0x200 ACPI CA debugger
+			       0x400 OS services
+			       0x800 ACPI CA disassembler
+			     0x40000 battery
+			     0x80000 button
+			    0x200000 fan
+			    0x400000 PCI
+			  0x10000000 bay
+
+			Many others, e.g., ACPI_BUS_COMPONENT and
+			ACPI_AC_COMPONENT, are defined by the Linux OSPM and
+			individual drivers.
+
+	    acpi.debug_level=	[HW,ACPI,ACPI_DEBUG]
 			Format: <int>
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
+			Bits in <int> correspond to levels in ACPI_DEBUG_PRINT
+			statements.  After boot, this mask can be changed on
+			the fly, e.g.,
+			    echo 0x2 > /sys/module/acpi/parameters/debug_level
+			The contents of debug_level show the names of all the
+			defined bits and their current state.
+
+			The following levels are defined by the ACPI CA:
+			       0x01 init
+			       0x02 debug (AML stores to the Debug object)
+			       0x04 info
 			       0x20 init names
 			       0x40 parse
 			       0x80 load
@@ -248,9 +275,6 @@ and is between 256 and 4096 characters. It is defined in the file
 			    0x10000 resources
 			    0x20000 user requests
 			    0x40000 package
- 			The number can be in decimal or prefixed with 0x in hex.
- 			Warning: Many of these options can produce a lot of
- 			output and make your system unusable. Be very careful.
 
  	acpi.power_nocheck=	[HW,ACPI]
  			Format: 1/0 enable/disable the check of power state.
diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index f4f6329..1c954a7 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -312,9 +312,15 @@ config ACPI_DEBUG
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
+	  parameters documented in Documentation/kernel-parameters.txt to
+	  control the type and amount of debug output.
+
+	  When no parameters are supplied, the default settings cause AML
+	  stores to the "Debug" object to produce console output.
 
 config ACPI_DEBUG_FUNC_TRACE
 	bool "Additionally enable ACPI function tracing"

