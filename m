From: akpm@linux-foundation.org
Subject: [patch 4/6] Use menuconfig objects: ACPI
Date: Wed, 23 May 2007 14:12:28 -0700
Message-ID: <200705232112.l4NLCSLd032154@shell0.pdx.osdl.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([207.189.120.13]:57412 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755850AbXEWVYt (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 23 May 2007 17:24:49 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, akpm@linux-foundation.org, jengelh@linux01.gwdg.de, jengelh@gmx.de

From: Jan Engelhardt <jengelh@linux01.gwdg.de>

Use menuconfigs instead of menus, so the whole menu can be disabled at once
instead of going through all options.

Signed-off-by: Jan Engelhardt <jengelh@gmx.de>
Cc: Len Brown <lenb@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/acpi/Kconfig |   13 ++-----------
 1 files changed, 2 insertions(+), 11 deletions(-)

diff -puN drivers/acpi/Kconfig~use-menuconfig-objects-acpi drivers/acpi/Kconfig
--- a/drivers/acpi/Kconfig~use-menuconfig-objects-acpi
+++ a/drivers/acpi/Kconfig
@@ -2,16 +2,12 @@
 # ACPI Configuration
 #
 
-menu "ACPI (Advanced Configuration and Power Interface) Support"
+menuconfig ACPI
+	bool "ACPI Support (Advanced Configuration and Power Interface) Support"
 	depends on !X86_NUMAQ
 	depends on !X86_VISWS
 	depends on !IA64_HP_SIM
 	depends on IA64 || X86
-	depends on PM
-
-config ACPI
-	bool "ACPI Support"
-	depends on IA64 || X86
 	depends on PCI
 	depends on PM
 	select PNP
@@ -49,7 +45,6 @@ if ACPI
 config ACPI_SLEEP
 	bool "Sleep States"
 	depends on X86 && (!SMP || SUSPEND_SMP)
-	depends on PM
 	default y
 	---help---
 	  This option adds support for ACPI suspend states. 
@@ -82,7 +77,6 @@ config ACPI_SLEEP_PROC_SLEEP
 
 config ACPI_PROCFS
 	bool "Procfs interface (deprecated)"
-	depends on ACPI
 	default y
 	---help---
 	  The Procfs interface for ACPI is made optional for backward compatibility.
@@ -330,7 +324,6 @@ config ACPI_CONTAINER
 
 config ACPI_HOTPLUG_MEMORY
 	tristate "Memory Hotplug"
-	depends on ACPI
 	depends on MEMORY_HOTPLUG
 	default n
 	help
@@ -359,5 +352,3 @@ config ACPI_SBS
 	  to today's ACPI "Control Method" battery.
 
 endif	# ACPI
-
-endmenu
_
