From: Len Brown <lenb@kernel.org>
Subject: Re: [patch] ACPI: make debug command-line arguments work again
Date: Fri, 19 Dec 2008 00:09:19 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0812190008170.6312@localhost.localdomain>
References: <200811131630.14781.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173009pub.verizon.net ([206.46.173.9]:35576 "EHLO
	vms173009.mailsrvcs.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750833AbYLSFJW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 19 Dec 2008 00:09:22 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173009.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KC300LI0Y438I92@vms173009.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 18 Dec 2008 23:04:51 -0600 (CST)
In-reply-to: <200811131630.14781.bjorn.helgaas@hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: linux-acpi@vger.kernel.org, Thomas Renninger <trenn@suse.de>, Randy Dunlap <rdunlap@xenotime.net>

>From ddcee424e5eec9433e852101e834516c012c64fd Mon Sep 17 00:00:00 2001
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Date: Thu, 13 Nov 2008 17:30:13 -0600
Subject: [PATCH] ACPI: fix 2.6.28 acpi.debug_level regression
Organization: Intel Open Source Technology Center

acpi_early_init() was changed to over-write the cmdline param,
making it really inconvenient to set debug flags at boot-time.

Also,
This sets the default level to "info", which is what all the ACPI
drivers use.  So to enable messages from drivers, you only have to
supply the "layer" (a.k.a. "component").  For non-"info" ACPI core
and ACPI interpreter messages, you have to supply both level and
layer masks, as before.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 Documentation/kernel-parameters.txt |   11 +++++++----
 drivers/acpi/bus.c                  |    8 --------
 drivers/acpi/utilities/utglobal.c   |    2 +-
 include/acpi/acoutput.h             |    2 +-
 4 files changed, 9 insertions(+), 14 deletions(-)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index e0f346d..c9115c1 100644
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
index 670551b..17ed5ac 100644
--- a/drivers/acpi/utilities/utglobal.c
+++ b/drivers/acpi/utilities/utglobal.c
@@ -64,7 +64,7 @@ u32 acpi_dbg_level = ACPI_DEBUG_DEFAULT;
 
 /* Debug switch - layer (component) mask */
 
-u32 acpi_dbg_layer = ACPI_COMPONENT_DEFAULT | ACPI_ALL_DRIVERS;
+u32 acpi_dbg_layer = 0;
 u32 acpi_gbl_nesting_level = 0;
 
 /* Debugger globals */
diff --git a/include/acpi/acoutput.h b/include/acpi/acoutput.h
index 09d33c7..db8852d 100644
--- a/include/acpi/acoutput.h
+++ b/include/acpi/acoutput.h
@@ -172,7 +172,7 @@
 
 /* Defaults for debug_level, debug and normal */
 
-#define ACPI_DEBUG_DEFAULT          (ACPI_LV_INIT | ACPI_LV_DEBUG_OBJECT)
+#define ACPI_DEBUG_DEFAULT          (ACPI_LV_INFO)
 #define ACPI_NORMAL_DEFAULT         (ACPI_LV_INIT | ACPI_LV_DEBUG_OBJECT)
 #define ACPI_DEBUG_ALL              (ACPI_LV_AML_DISASSEMBLE | ACPI_LV_ALL_EXCEPTIONS | ACPI_LV_ALL)
 
-- 
1.6.1.rc3.35.gc0ceb

