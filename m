From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [patch] ACPI: make debug command-line arguments work again
Date: Thu, 13 Nov 2008 17:30:13 -0600
Message-ID: <200811131630.14781.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0014.houston.hp.com ([15.201.24.17]:22493 "EHLO
	g4t0014.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751129AbYKMXaR (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 13 Nov 2008 18:30:17 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: bjorn.helgaas@hp.com, Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Thomas Renninger <trenn@suse.de>, Randy Dunlap <rdunlap@xenotime.net>

I stupidly tried to set the default ACPI debug level in acpi_early_init(),
but that's after command-line arguments are parsed, so any user-supplied
arguments were overwritten.
    
This changes the default initialization, so command-line arguments
work again.
    
This sets the default level to "info", which is what all the ACPI
drivers use.  So to enable messages from drivers, you only have to
supply the "layer" (a.k.a. "component").  For non-"info" ACPI core
and ACPI interpreter messages, you have to supply both level and
layer masks, as before.

This should go in 2.6.28; otherwise there'll be no way to turn on
ACPI debugging.
    
Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index c600c4f..95eeb9f 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -220,14 +220,17 @@ and is between 256 and 4096 characters. It is defined in the file
 			Bits in debug_level correspond to a level in
 			ACPI_DEBUG_PRINT statements, e.g.,
 			    ACPI_DEBUG_PRINT((ACPI_DB_INFO, ...
-			See Documentation/acpi/debug.txt for more information
-			about debug layers and levels.
+			The debug_level mask defaults to "info".  See
+			Documentation/acpi/debug.txt for more information about
+			debug layers and levels.
 
+			Enable processor driver info messages:
+			    acpi.debug_layer=0x20000000
+			Enable PCI/PCI interrupt routing info messages:
+			    acpi.debug_layer=0x400000
 			Enable AML "Debug" output, i.e., stores to the Debug
 			object while interpreting AML:
 			    acpi.debug_layer=0xffffffff acpi.debug_level=0x2
-			Enable PCI/PCI interrupt routing info messages:
-			    acpi.debug_layer=0x400000 acpi.debug_level=0x4
 			Enable all messages related to ACPI hardware:
 			    acpi.debug_layer=0x2 acpi.debug_level=0xffffffff
 
diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 7edf6d9..765fd1c 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -688,14 +688,6 @@ void __init acpi_early_init(void)
 	if (acpi_disabled)
 		return;
 
-	/*
-	 * ACPI CA initializes acpi_dbg_level to non-zero, which means
-	 * we get debug output merely by turning on CONFIG_ACPI_DEBUG.
-	 * Turn it off so we don't get output unless the user specifies
-	 * acpi.debug_level.
-	 */
-	acpi_dbg_level = 0;
-
 	printk(KERN_INFO PREFIX "Core revision %08x\n", ACPI_CA_VERSION);
 
 	/* enable workarounds, unless strict ACPI spec. compliance */
diff --git a/drivers/acpi/utilities/utglobal.c b/drivers/acpi/utilities/utglobal.c
index 670551b..37da826 100644
--- a/drivers/acpi/utilities/utglobal.c
+++ b/drivers/acpi/utilities/utglobal.c
@@ -60,11 +60,11 @@ ACPI_EXPORT_SYMBOL(acpi_gbl_FADT)
  * are already set when the debugger is entered.
  */
 /* Debug switch - level and trace mask */
-u32 acpi_dbg_level = ACPI_DEBUG_DEFAULT;
+u32 acpi_dbg_level = ACPI_LV_INFO;
 
 /* Debug switch - layer (component) mask */
 
-u32 acpi_dbg_layer = ACPI_COMPONENT_DEFAULT | ACPI_ALL_DRIVERS;
+u32 acpi_dbg_layer = 0;
 u32 acpi_gbl_nesting_level = 0;
 
 /* Debugger globals */
