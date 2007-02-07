From: Len Brown <lenb@kernel.org>
Subject: [PATCH 6/140] ACPI: adjust init order
Date: Wed,  7 Feb 2007 13:50:20 -0500
Message-ID: <11708743702194-git-send-email-lenb@kernel.org>
References: <11708743541314-git-send-email-lenb@kernel.org> <11708743561383-git-send-email-lenb@kernel.org> <117087435785-git-send-email-lenb@kernel.org> <11708743582090-git-send-email-lenb@kernel.org> <11708743611662-git-send-email-lenb@kernel.org> <11708743653073-git-send-email-lenb@kernel.org> <11708743674006-git-send-email-lenb@kernel.org> <11708743693386-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([143.182.124.22]:45379 "EHLO
	azsmga101.ch.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1422709AbXBGSwx (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Feb 2007 13:52:53 -0500
In-Reply-To: <11708743693386-git-send-email-lenb@kernel.org>
Message-Id: <a7178df5e7e5730e5daa6cf6d8b8bf73adbe75c0.1170873816.git.len.brown@intel.com>
In-Reply-To: <9e89dde2b063ca73fcdc9244fe68e2dea32c5088.1170873816.git.len.brown@intel.com>
References: <9e89dde2b063ca73fcdc9244fe68e2dea32c5088.1170873816.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Li Shaohua <shaohua.li@intel.com>, Zhang Rui <rui.zhang@intel.com>, Len Brown <len.brown@intel.com>

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
1.5.0.rc3.39.gec804
