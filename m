From: yakui.zhao@intel.com
Subject: [PATCH] ACPI: Set \_SB.OSC capbility bit to evaluate _OST for _PPC change notification
Date: Fri,  8 Jan 2010 21:29:58 +0800
Message-ID: <1262957398-7154-1-git-send-email-yakui.zhao@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:32250 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752483Ab0AHNbz (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 8 Jan 2010 08:31:55 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, Zhao Yakui <yakui.zhao@intel.com>

From: Zhao Yakui <yakui.zhao@intel.com>

Set the capability bit for \_SB.OSC object to add the support of
evaluating the _OST object as result of _PPC change notification
event.

At the same time it also adds the support of aggregator device
when the aggregator is compiled as module.

Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
---
 drivers/acpi/bus.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index ae9226d..b70cd37 100644
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
1.5.4.5

