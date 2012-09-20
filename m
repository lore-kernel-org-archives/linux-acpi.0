From: Matthew Garrett <mjg@redhat.com>
Subject: [PATCH 1/2] ACPI: Reorder IPMI driver before any other ACPI drivers
Date: Thu, 20 Sep 2012 17:46:12 -0400
Message-ID: <1348177573-7537-1-git-send-email-mjg@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:26587 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754028Ab2ITVq2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 20 Sep 2012 17:46:28 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: yakui.zhao@intel.com
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, cminyard@mvista.com, Matthew Garrett <mjg@redhat.com>

Drivers may make calls that require the ACPI IPMI driver to have been
initialised already, so make sure that it appears earlier in the build
order.

Signed-off-by: Matthew Garrett <mjg@redhat.com>
---
 drivers/acpi/Makefile | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index 47199e2..82422fe 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -47,6 +47,10 @@ acpi-y				+= video_detect.o
 endif
 
 # These are (potentially) separate modules
+
+# IPMI may be used by other drivers, so it has to initialise before them
+obj-$(CONFIG_ACPI_IPMI)		+= acpi_ipmi.o
+
 obj-$(CONFIG_ACPI_AC) 		+= ac.o
 obj-$(CONFIG_ACPI_BUTTON)	+= button.o
 obj-$(CONFIG_ACPI_FAN)		+= fan.o
@@ -70,6 +74,5 @@ processor-y			+= processor_idle.o processor_thermal.o
 processor-$(CONFIG_CPU_FREQ)	+= processor_perflib.o
 
 obj-$(CONFIG_ACPI_PROCESSOR_AGGREGATOR) += acpi_pad.o
-obj-$(CONFIG_ACPI_IPMI)		+= acpi_ipmi.o
 
 obj-$(CONFIG_ACPI_APEI)		+= apei/
-- 
1.7.11.4

