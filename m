From: Zhang Rui <rui.zhang@intel.com>
Subject: [06/12] acpi: adjust init order
Date: Fri, 22 Sep 2006 17:31:03 +0800
Message-ID: <1158917463.11985.63.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:5416 "EHLO mga01.intel.com")
	by vger.kernel.org with ESMTP id S1750837AbWIVJ3f (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 22 Sep 2006 05:29:35 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: len.brown@intel.com

From: Li Shaohua <shaohua.li@intel.com>

Adjust link order to add ACPI devices to global list before PCI devices.
In addition, acpi_bus type must be initialized before any driver loads.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>

---
 drivers/acpi/Makefile |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.18-rc5/drivers/acpi/Makefile
===================================================================
--- linux-2.6.18-rc5.orig/drivers/acpi/Makefile	2006-09-12 10:09:28.000000000 +0800
+++ linux-2.6.18-rc5/drivers/acpi/Makefile	2006-09-12 10:10:25.000000000 +0800
@@ -37,6 +37,7 @@ endif
 
 obj-y				+= sleep/
 obj-y				+= bus.o glue.o
+obj-y				+= scan.o motherboard.o
 obj-$(CONFIG_ACPI_AC) 		+= ac.o
 obj-$(CONFIG_ACPI_BATTERY)	+= battery.o
 obj-$(CONFIG_ACPI_BUTTON)	+= button.o
@@ -56,7 +57,6 @@ obj-$(CONFIG_ACPI_NUMA)		+= numa.o
 obj-$(CONFIG_ACPI_ASUS)		+= asus_acpi.o
 obj-$(CONFIG_ACPI_IBM)		+= ibm_acpi.o
 obj-$(CONFIG_ACPI_TOSHIBA)	+= toshiba_acpi.o
-obj-y				+= scan.o motherboard.o
 obj-$(CONFIG_ACPI_HOTPLUG_MEMORY)	+= acpi_memhotplug.o
 obj-y				+= cm_sbs.o
 obj-$(CONFIG_ACPI_SBS)		+= i2c_ec.o sbs.o
