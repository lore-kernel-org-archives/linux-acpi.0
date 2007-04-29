From: Len Brown <len.brown@intel.com>
Subject: [PATCH 003/105] ACPI: EC: Make EC to initialize first in ACPI
Date: Sun, 29 Apr 2007 00:50:03 -0400
Message-ID: <11778223083747-git-send-email-len.brown@intel.com>
References: <11778223052751-git-send-email-len.brown@intel.com>
 <11778223068-git-send-email-len.brown@intel.com>
 <11778223072296-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:62745 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754581AbXD2Evt (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 29 Apr 2007 00:51:49 -0400
In-Reply-To: <11778223072296-git-send-email-len.brown@intel.com>
Message-Id: <33d20b6100d05a0b14883e7dc8ab41e4531fcf59.1177822058.git.len.brown@intel.com>
In-Reply-To: <ac122bb64b0d51f0512185d3522a75f3f3a80bc9.1177822058.git.len.brown@intel.com>
References: <ac122bb64b0d51f0512185d3522a75f3f3a80bc9.1177822058.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>, Len Brown <len.brown@intel.com>

From: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>

Signed-off-by: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/Makefile |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index 5956e9f..9623aac 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -1,6 +1,6 @@
 #
 # Makefile for the Linux ACPI interpreter
-# 
+#
 
 export ACPI_CFLAGS
 
@@ -32,16 +32,17 @@ obj-y				+= osl.o utils.o \
 processor-objs	+= processor_core.o processor_throttling.o \
 				processor_idle.o processor_thermal.o
 ifdef CONFIG_CPU_FREQ
-processor-objs	+= processor_perflib.o			
+processor-objs	+= processor_perflib.o
 endif
 
 obj-y				+= sleep/
 obj-y				+= bus.o glue.o
 obj-y				+= scan.o
+# Keep EC driver first. Initialization of others depend on it.
+obj-$(CONFIG_ACPI_EC)		+= ec.o
 obj-$(CONFIG_ACPI_AC) 		+= ac.o
 obj-$(CONFIG_ACPI_BATTERY)	+= battery.o
 obj-$(CONFIG_ACPI_BUTTON)	+= button.o
-obj-$(CONFIG_ACPI_EC)		+= ec.o
 obj-$(CONFIG_ACPI_FAN)		+= fan.o
 obj-$(CONFIG_ACPI_DOCK)		+= dock.o
 obj-$(CONFIG_ACPI_BAY)		+= bay.o
-- 
1.5.2.rc0.34.gda94
