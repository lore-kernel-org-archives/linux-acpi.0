From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH] ACPI: update debug parameter documentation
Date: Tue, 29 Jul 2008 15:43:56 -0600
Message-ID: <20080729214338.27086.27534.stgit@tigger.helgaas>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g5t0006.atlanta.hp.com ([15.192.0.43]:44322 "EHLO
	g5t0006.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752626AbYG2VoN (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 29 Jul 2008 17:44:13 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, linux-acpi@vger.kernel.org


Reformat acpi.debug_layer and acpi.debug_level documentation so it's
readable, add some clues about how to figure out the mask bits that
enable a given ACPI_DEBUG_PRINT statement, and include a couple useful
examples.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
---

 Documentation/kernel-parameters.txt |   94 +++++++++++++++++++++++++----------
 1 files changed, 67 insertions(+), 27 deletions(-)


diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index 3cba6ed..76b2e97 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -200,37 +200,77 @@ and is between 256 and 4096 characters. It is defined in the file
 	acpi.debug_layer=	[HW,ACPI]
 			Format: <int>
 			Each bit of the <int> indicates an ACPI debug layer,
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
+			which corresponds to the _COMPONENT definition in
+			ACPI source files.  After system has booted, this mask
+			can be set via /sys/module/acpi/parameters/debug_layer.
+
+			CONFIG_ACPI_DEBUG must be enabled for this to produce
+			any output.  The number can be in decimal or prefixed
+			with 0x in hex.  Some of these options produce so much
+			output that the system is unusable.
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
+			For debugging PCI/_PRT issues (PCI, info msgs):
+			    acpi.debug_layer=0x400000 acpi.debug_level=0x10
+			For ACPI hardware issues (hardware, all msgs):
+			    acpi.debug_layer=0x2 acpi.debug_level=0xffffffff
 
 	acpi.debug_level=	[HW,ACPI]
 			Format: <int>
 			Each bit of the <int> indicates an ACPI debug level,
-			1: enable, 0: disable. It is useful for boot time
-			debugging. After system has booted up, it can be set
-			via /sys/module/acpi/parameters/debug_level.
-			CONFIG_ACPI_DEBUG must be enabled for this to produce any output.
-			Available bits (add the numbers together) to enable different
-			debug output levels of the ACPI subsystem:
-			0x01 error 0x02 warn 0x04 init 0x08 debug object
-			0x10 info 0x20 init names 0x40 parse 0x80 load
-			0x100 dispatch 0x200 execute 0x400 names 0x800 operation region
-			0x1000 bfield 0x2000 tables 0x4000 values 0x8000 objects
-			0x10000 resources 0x20000 user requests 0x40000 package.
-			The number can be in decimal or prefixed with 0x in hex.
-			Warning: Many of these options can produce a lot of
-			output and make your system unusable. Be very careful.
+			which corresponds to the level in an ACPI_DEBUG_PRINT
+			statement.  After system has booted up, this mask
+			can be set via /sys/module/acpi/parameters/debug_level.
+
+			CONFIG_ACPI_DEBUG must be enabled for this to produce
+			any output.  The number can be in decimal or prefixed
+			with 0x in hex.  Some of these options produce so much
+			output that the system is unusable.
+
+			The following global components are defined by the
+			ACPI CA:
+			       0x01 error
+			       0x02 warn
+			       0x04 init
+			       0x08 debug object
+			       0x10 info
+			       0x20 init names
+			       0x40 parse
+			       0x80 load
+			      0x100 dispatch
+			      0x200 execute
+			      0x400 names
+			      0x800 operation region
+			     0x1000 bfield
+			     0x2000 tables
+			     0x4000 values
+			     0x8000 objects
+			    0x10000 resources
+			    0x20000 user requests
+			    0x40000 package
 
 	acpi_pm_good	[X86-32,X86-64]
 			Override the pmtimer bug detection: force the kernel

