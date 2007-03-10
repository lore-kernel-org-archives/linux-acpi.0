From: Len Brown <lenb@kernel.org>
Subject: [PATCH 12/22] ACPI: EC: Make EC to initialize first in ACPI
Date: Fri,  9 Mar 2007 23:00:49 -0500
Message-ID: <11734992701086-git-send-email-lenb@kernel.org>
References: <11734992592550-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.89]:44913 "EHLO
	fmsmga101.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1945929AbXCJEBL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Mar 2007 23:01:11 -0500
In-Reply-To: <11734992592550-git-send-email-lenb@kernel.org>
Message-Id: <e4382a15d138ea6c0d4277967e646216ce57040f.1173498654.git.len.brown@intel.com>
In-Reply-To: <941b1971a405f95537bc6f9a738e737eb2186e45.1173498647.git.len.brown@intel.com>
References: <941b1971a405f95537bc6f9a738e737eb2186e45.1173498647.git.len.brown@intel.com>
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
1.5.0.3.310.g05ef5
