From: Len Brown <lenb@kernel.org>
Subject: [PATCH 11/21] ACPI: remove CONFIG_ACPI_POWER
Date: Thu, 06 Nov 2008 23:39:15 -0500
Message-ID: <fefe5ab3d67b0ade6200fec5ed6f2812cbcbb658.1226032677.git.len.brown@intel.com>
References: <1226032765-15330-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173007pub.verizon.net ([206.46.173.7]:54874 "EHLO
	vms173007pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751399AbYKGEjh (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 6 Nov 2008 23:39:37 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173007.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K9Y00K3B4WC62Z1@vms173007.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 06 Nov 2008 22:38:37 -0600 (CST)
In-reply-to: <1226032765-15330-1-git-send-email-lenb@kernel.org>
In-reply-to: <2830c9fb8e66cee70b8bffdfb0de01c144c7e643.1226032677.git.len.brown@intel.com>
References: <2830c9fb8e66cee70b8bffdfb0de01c144c7e643.1226032677.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Len Brown <len.brown@intel.com>

From: Bjorn Helgaas <bjorn.helgaas@hp.com>

Remove CONFIG_ACPI_POWER.  It was always set the same as CONFIG_ACPI,
and it had no menu label, so there was no way to set it to anything
other than "y".

The interfaces under CONFIG_ACPI_POWER (acpi_device_sleep_wake(),
acpi_power_transition(), etc) are called unconditionally from the
ACPI core, so we already depend on it always being present.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/Kconfig        |    4 ----
 drivers/acpi/Makefile       |    2 +-
 include/acpi/acpi_drivers.h |    2 --
 3 files changed, 1 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index f4f6329..4fa7866 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -341,10 +341,6 @@ config ACPI_PCI_SLOT
 	  help you correlate PCI bus addresses with the physical geography
 	  of your slots. If you are unsure, say N.
 
-config ACPI_POWER
-	bool
-	default y
-
 config ACPI_SYSTEM
 	bool
 	default y
diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index d91c027..8017f63 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -51,7 +51,7 @@ obj-$(CONFIG_ACPI_PCI_SLOT)	+= pci_slot.o
 obj-$(CONFIG_ACPI_PROCESSOR)	+= processor.o
 obj-$(CONFIG_ACPI_CONTAINER)	+= container.o
 obj-$(CONFIG_ACPI_THERMAL)	+= thermal.o
-obj-$(CONFIG_ACPI_POWER)	+= power.o
+obj-y				+= power.o
 obj-$(CONFIG_ACPI_SYSTEM)	+= system.o event.o
 obj-$(CONFIG_ACPI_DEBUG)	+= debug.o
 obj-$(CONFIG_ACPI_NUMA)		+= numa.o
diff --git a/include/acpi/acpi_drivers.h b/include/acpi/acpi_drivers.h
index cf04c60..818215f 100644
--- a/include/acpi/acpi_drivers.h
+++ b/include/acpi/acpi_drivers.h
@@ -86,7 +86,6 @@ struct pci_bus *pci_acpi_scan_root(struct acpi_device *device, int domain,
                                   Power Resource
    -------------------------------------------------------------------------- */
 
-#ifdef CONFIG_ACPI_POWER
 int acpi_device_sleep_wake(struct acpi_device *dev,
                            int enable, int sleep_state, int dev_state);
 int acpi_enable_wakeup_device_power(struct acpi_device *dev, int sleep_state);
@@ -94,7 +93,6 @@ int acpi_disable_wakeup_device_power(struct acpi_device *dev);
 int acpi_power_get_inferred_state(struct acpi_device *device);
 int acpi_power_transition(struct acpi_device *device, int state);
 extern int acpi_power_nocheck;
-#endif
 
 /* --------------------------------------------------------------------------
                                   Embedded Controller
-- 
1.5.6.5

