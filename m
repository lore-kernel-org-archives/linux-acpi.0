From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 6/14] ACPI: adjust init order
Date: Thu, 07 Dec 2006 20:56:34 +0800
Message-ID: <1165496194.11485.80.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:39031 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1032174AbWLGMw2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 7 Dec 2006 07:52:28 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: "linux-acpi@vger" <linux-acpi@vger.kernel.org>

From: Li Shaohua <shaohua.li@intel.com>

Adjust link order to add ACPI devices to global list before PCI devices.
In addition, acpi_bus type must be initialized before any driver loads.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index bce7ca2..a749510 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
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
-- 
1.4.4.g59427
