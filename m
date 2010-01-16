From: Len Brown <lenb@kernel.org>
Subject: [PATCH 08/16] ACPI: Advertise to BIOS in _OSC: _OST on _PPC changes
Date: Sat, 16 Jan 2010 02:32:58 -0500
Message-ID: <6a4e2b7503d1f630bface040cf0f5a7aac1fabdb.1263627123.git.len.brown@intel.com>
References: <1263627186-21384-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173007pub.verizon.net ([206.46.173.7]:59002 "EHLO
	vms173007pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751779Ab0APHdP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 16 Jan 2010 02:33:15 -0500
Received: from localhost.localdomain ([unknown] [74.104.151.18])
 by vms173007.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0KWB009ZNWZCR2V4@vms173007.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 16 Jan 2010 01:33:15 -0600 (CST)
In-reply-to: <1263627186-21384-1-git-send-email-lenb@kernel.org>
In-reply-to: <a62e8f1978f49e52f87a711ff6711b323d4b12ff.1263627123.git.len.brown@intel.com>
References: <a62e8f1978f49e52f87a711ff6711b323d4b12ff.1263627123.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Zhao Yakui <yakui.zhao@intel.com>, Len Brown <len.brown@intel.com>

From: Zhao Yakui <yakui.zhao@intel.com>

If the BIOS pokes the system-wide OSC bits to see if Linux
supports evaluating _OST after a _PPC change notification,
answer yes.

Also, fix an oversight where we neglected to set the OSC
bit advertising processor aggregator device support
when acpi-pad is compiled as a module.

Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/bus.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index cf761b9..a52126e 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -490,9 +490,14 @@ static void acpi_bus_osc_support(void)
 
 	capbuf[OSC_QUERY_TYPE] = OSC_QUERY_ENABLE;
 	capbuf[OSC_SUPPORT_TYPE] = OSC_SB_PR3_SUPPORT; /* _PR3 is in use */
-#ifdef CONFIG_ACPI_PROCESSOR_AGGREGATOR
+#if defined(CONFIG_ACPI_PROCESSOR_AGGREGATOR) ||\
+			defined(CONFIG_ACPI_PROCESSOR_AGGREGATOR_MODULE)
 	capbuf[OSC_SUPPORT_TYPE] |= OSC_SB_PAD_SUPPORT;
 #endif
+
+#if defined(CONFIG_ACPI_PROCESSOR) || defined(CONFIG_ACPI_PROCESSOR_MODULE)
+	capbuf[OSC_SUPPORT_TYPE] |= OSC_SB_PPC_OST_SUPPORT;
+#endif
 	if (ACPI_FAILURE(acpi_get_handle(NULL, "\\_SB", &handle)))
 		return;
 	if (ACPI_SUCCESS(acpi_run_osc(handle, &context)))
-- 
1.6.0.6

