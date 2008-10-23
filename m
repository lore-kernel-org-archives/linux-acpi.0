From: Len Brown <lenb@kernel.org>
Subject: [PATCH 121/122] ACPI: hack around sysfs warning with link order
Date: Thu, 23 Oct 2008 02:39:35 -0400
Message-ID: <5eaff72218b9c2cb7ca7aa284cf0271870c7a7b1.1224743917.git.len.brown@intel.com>
References: <1224743976-31033-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms044pub.verizon.net ([206.46.252.44]:38944 "EHLO
	vms044pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752603AbYJWGoJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 23 Oct 2008 02:44:09 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms044.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0K9600KZWIPH3KY1@vms044.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 23 Oct 2008 01:44:07 -0500 (CDT)
In-reply-to: <1224743976-31033-1-git-send-email-lenb@kernel.org>
In-reply-to: <a0ad05c75aa362c91f4d9cd91ff375a739574dd8.1224743916.git.len.brown@intel.com>
References: <a0ad05c75aa362c91f4d9cd91ff375a739574dd8.1224743916.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Zhao Yakui <yakui.zhao@intel.com>, Len Brown <len.brown@intel.com>

From: Zhao Yakui <yakui.zhao@intel.com>

    There exists the following warning message will appear after the
following commit is merged.
   >commit f2e969acd6d5981e6b1272810002558650d0736e
   >Author: Zhao Yakui <yakui.zhao@intel.com>
   >Date:   Mon Aug 11 14:57:50 2008 +0800
    >ACPI: Add "acpi.power_nocheck=1" to disable power state check in
power transition:

   >WARNING: at linux-2.6/fs/sysfs/dir.c:463  sysfs_add_one+0x33/0x39()
   >sysfs: duplicate filename 'acpi' can not be created
   >kobject_add_internal failed for acpi with -EEXIST, don't try to register
            things with the same name in the same directory

   In the above commit the "acpi.power_nocheck" module parameter is defined
in drivers/acpi/power.c file. As several module parameters using the same ACPI
prefix are defined in the different files(for example: power_nocheck is
defined in drivers/acpi/power.c,debug_layer/debug_level are defined in
drivers/acpi/debug.c) and there exists another module between them, the
warning message will be printed when using the current generic param code.
(In the function of param_sysfs_init).

   In fact when ACPI is selected, the drivers/acpi/power will also be compiled
as built-in kernel.So this issue can be fixed by the following approach.
   workaround it by adjusting the module link order in drivers/acpi/Makefile.
In such case the module parameter using the same prefix(ACPI) are put together
in the param data section.

   Of course the better solution is to fix it in generic param code related
with sysfs.

Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index ad4bfd5..d91c027 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -48,10 +48,10 @@ obj-$(CONFIG_ACPI_DOCK)		+= dock.o
 obj-$(CONFIG_ACPI_VIDEO)	+= video.o
 obj-y				+= pci_root.o pci_link.o pci_irq.o pci_bind.o
 obj-$(CONFIG_ACPI_PCI_SLOT)	+= pci_slot.o
-obj-$(CONFIG_ACPI_POWER)	+= power.o
 obj-$(CONFIG_ACPI_PROCESSOR)	+= processor.o
 obj-$(CONFIG_ACPI_CONTAINER)	+= container.o
 obj-$(CONFIG_ACPI_THERMAL)	+= thermal.o
+obj-$(CONFIG_ACPI_POWER)	+= power.o
 obj-$(CONFIG_ACPI_SYSTEM)	+= system.o event.o
 obj-$(CONFIG_ACPI_DEBUG)	+= debug.o
 obj-$(CONFIG_ACPI_NUMA)		+= numa.o
-- 
1.5.5.1

