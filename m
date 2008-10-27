From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [patch] ACPI: update debug parameter documentation
Date: Mon, 27 Oct 2008 15:40:45 -0600
Message-ID: <200810271540.46188.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0015.houston.hp.com ([15.201.24.18]:22437 "EHLO
	g4t0015.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751828AbYJ0Vkt (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 27 Oct 2008 17:40:49 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Thomas Renninger <trenn@suse.de>

[I posted this earlier: http://marc.info/?l=linux-acpi&m=121736785510685&w=2
 but somehow only half of it made it.  Here's the rest.]

Reformat acpi.debug_layer and acpi.debug_level documentation so it's
readable, add some clues about how to figure out the mask bits that
enable a given ACPI_DEBUG_PRINT statement, and include a couple useful
examples.
    
Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index 343e0f0..8d17859 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -201,26 +201,50 @@ and is between 256 and 4096 characters. It is defined in the file
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
 			which corresponds to the level in an ACPI_DEBUG_PRINT
-			statement.  After system has booted up, this mask
-			can be set via /sys/module/acpi/parameters/debug_level.
+			statement.  After system has booted, this mask can be
+			set via /sys/module/acpi/parameters/debug_level.
 
 			CONFIG_ACPI_DEBUG must be enabled for this to produce
 			any output.  The number can be in decimal or prefixed
@@ -248,9 +272,6 @@ and is between 256 and 4096 characters. It is defined in the file
 			    0x10000 resources
 			    0x20000 user requests
 			    0x40000 package
- 			The number can be in decimal or prefixed with 0x in hex.
- 			Warning: Many of these options can produce a lot of
- 			output and make your system unusable. Be very careful.
 
  	acpi.power_nocheck=	[HW,ACPI]
  			Format: 1/0 enable/disable the check of power state.
