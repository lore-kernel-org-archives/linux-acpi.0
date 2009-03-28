From: Len Brown <lenb@kernel.org>
Subject: [PATCH 78/98] ACPI: tidy up makefile
Date: Sat, 28 Mar 2009 00:31:53 -0400
Message-ID: <018f452e9d9d0cb5c3e8d33fd94dc6cd3c520a8f.1238214620.git.len.brown@intel.com>
References: <1238214733-8285-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173019pub.verizon.net ([206.46.173.19]:65009 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754268AbZC1Edk (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Mar 2009 00:33:40 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KH700DVK8O0IREV@vms173019.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 27 Mar 2009 23:33:37 -0500 (CDT)
In-reply-to: <1238214733-8285-1-git-send-email-lenb@kernel.org>
In-reply-to: <6503e5df08008b9a47022b5e9ebba658c8fa69af.1238214617.git.len.brown@intel.com>
References: <6503e5df08008b9a47022b5e9ebba658c8fa69af.1238214617.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Len Brown <len.brown@intel.com>

From: Bjorn Helgaas <bjorn.helgaas@hp.com>

This patch removes the suggestion that ec.o link order is important,
because it doesn't matter since acpi_ec_init() is no longer an initcall.
And it puts together most of the core modules that are not configurable.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/Makefile |    8 ++------
 1 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index b130ea0..61675e2 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -32,10 +32,8 @@ ifdef CONFIG_CPU_FREQ
 processor-objs	+= processor_perflib.o
 endif
 
-obj-y				+= bus.o glue.o
-obj-y				+= scan.o
-# Keep EC driver first. Initialization of others depend on it.
-obj-y				+= ec.o
+obj-y				+= bus.o glue.o scan.o ec.o \
+					power.o system.o event.o
 obj-$(CONFIG_ACPI_AC) 		+= ac.o
 obj-$(CONFIG_ACPI_BATTERY)	+= battery.o
 obj-$(CONFIG_ACPI_BUTTON)	+= button.o
@@ -51,8 +49,6 @@ obj-$(CONFIG_ACPI_PCI_SLOT)	+= pci_slot.o
 obj-$(CONFIG_ACPI_PROCESSOR)	+= processor.o
 obj-$(CONFIG_ACPI_CONTAINER)	+= container.o
 obj-$(CONFIG_ACPI_THERMAL)	+= thermal.o
-obj-y				+= power.o
-obj-y				+= system.o event.o
 obj-$(CONFIG_ACPI_DEBUG)	+= debug.o
 obj-$(CONFIG_ACPI_NUMA)		+= numa.o
 obj-$(CONFIG_ACPI_HOTPLUG_MEMORY)	+= acpi_memhotplug.o
-- 
1.6.0.6

