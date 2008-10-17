From: Zhao Yakui <yakui.zhao@intel.com>
Subject: [RFC] [PATCH]  Adjust the module link order in
	drivers/acpi/Makefile
Date: Fri, 17 Oct 2008 16:33:57 +0800
Message-ID: <1224232437.3944.164.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:9134 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751898AbYJQI2V (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 17 Oct 2008 04:28:21 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: lenb@kernel.org

Hi, All
   
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
---
 drivers/acpi/Makefile |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6/drivers/acpi/Makefile
===================================================================
--- linux-2.6.orig/drivers/acpi/Makefile
+++ linux-2.6/drivers/acpi/Makefile
@@ -49,10 +49,10 @@ obj-$(CONFIG_ACPI_BAY)		+= bay.o
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


