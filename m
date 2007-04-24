From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH] Improve acpi debug documentation
Date: Tue, 24 Apr 2007 13:53:22 +0800
Message-ID: <1177394002.9072.98.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:4093 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752549AbXDXFyT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 24 Apr 2007 01:54:19 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: lenb@kernel.org, ak@suse.de, randy.dunlap@oracle.com

Now we use acpi.debug_level and acpi.debug_layer as kernel boot
parameters instead of acpi_dbg_level and acpi_dbg_layer.
But the document is not updated in time.
Thanks to Andi Kleen for pointing it out.

This is the patch to update documentation for ACPI debug option.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 Documentation/kernel-parameters.txt |   30 ++++++++++++++++++++++++++----
 1 files changed, 26 insertions(+), 4 deletions(-)

Index: linux-2.6.21-rc7/Documentation/kernel-parameters.txt
===================================================================
--- linux-2.6.21-rc7.orig/Documentation/kernel-parameters.txt	2007-04-18 15:22:49.000000000 +0800
+++ linux-2.6.21-rc7/Documentation/kernel-parameters.txt	2007-04-24 13:42:54.000000000 +0800
@@ -181,19 +181,41 @@ and is between 256 and 4096 characters. 
 			that require a timer override, but don't have
 			HPET
 
-	acpi_dbg_layer=	[HW,ACPI]
+	acpi.debug_layer=	[HW,ACPI]
 			Format: <int>
 			Each bit of the <int> indicates an ACPI debug layer,
 			1: enable, 0: disable. It is useful for boot time
 			debugging. After system has booted up, it can be set
-			via /proc/acpi/debug_layer.
+			via /sys/module/acpi/parameters/debug_layer.
+			CONFIG_ACPI_DEBUG must be enabled for this to produce any output.
+			Available bits (add the numbers together) to enable debug output
+			for specific parts of the ACPI subsystem:
+			0x01 utilities 0x02 hardware 0x04 events 0x08 tables
+			0x10 namespace 0x20 parser 0x40 dispatcher
+			0x80 executer 0x100 resources 0x200 acpica debugger
+			0x400 os services 0x800 acpica disassembler.
+			The number can be in decimal or prefixed with 0x in hex.
+			Warning: Many of these options can produce a lot of
+			output and make your system unusable. Be very careful.
 
-	acpi_dbg_level=	[HW,ACPI]
+	acpi.debug_level=	[HW,ACPI]
 			Format: <int>
 			Each bit of the <int> indicates an ACPI debug level,
 			1: enable, 0: disable. It is useful for boot time
 			debugging. After system has booted up, it can be set
-			via /proc/acpi/debug_level.
+			via /sys/module/acpi/parameters/debug_level.
+			CONFIG_ACPI_DEBUG must be enabled for this to produce any output.
+			Available bits (add the numbers together) to enable different
+			debug output levels of the ACPI subsystem:
+			0x01 error 0x02 warn 0x04 init 0x08 debug object
+			0x10 info 0x20 init names 0x40 parse 0x80 load
+			0x100 dispatch 0x200 execute 0x400 names 0x800 operation region
+			0x1000 bfield 0x2000 tables 0x4000 values 0x8000 objects
+			0x10000 resources 0x20000 user requests 0x40000 package.
+			The number can be in decimal or prefixed with 0x in hex.
+			Warning: Many of these options can produce a lot of
+			output and make your system unusable. Be very careful.
+
 
 	acpi_fake_ecdt	[HW,ACPI] Workaround failure due to BIOS lacking ECDT
 
