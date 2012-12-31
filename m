From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 23/27] ACPICA: Resources: Support for ACPI 5 wake bit in ExtendedInterrupt descriptor.
Date: Mon, 31 Dec 2012 08:07:24 +0800
Message-ID: <df14053d170c2916d867a7fd9bb659bd8731e3b0.1356668534.git.lv.zheng@intel.com>
References: <cover.1356668530.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:11711 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755268Ab2LaAHe (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 30 Dec 2012 19:07:34 -0500
In-Reply-To: <cover.1356668530.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>, Rafael J Wysocki <rafael.j.wysocki@intel.com>
Cc: linux-acpi@vger.kernel.org, Aaron Lu <aaron.lu@intel.com>, Bob Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>

From: Aaron Lu <aaron.lu@intel.com>

Add support to both get and set the extended share flags for the
Interrupt() resource descriptor. Reported by Aaron Lu.

Signed-off-by: Aaron Lu <aaron.lu@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/rsirq.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/acpica/rsirq.c b/drivers/acpi/acpica/rsirq.c
index 14cb76e..f3733ee 100644
--- a/drivers/acpi/acpica/rsirq.c
+++ b/drivers/acpi/acpica/rsirq.c
@@ -190,8 +190,10 @@ struct acpi_rsconvert_info acpi_rs_convert_ext_irq[9] = {
 	 sizeof(struct aml_resource_extended_irq),
 	 0},
 
-	/* Flag bits */
-
+	/*
+	 * Flags: Producer/Consumer[0], Triggering[1], Polarity[2],
+	 *        sharing_and_wake[3:4]
+	 */
 	{ACPI_RSC_1BITFLAG, ACPI_RS_OFFSET(data.extended_irq.producer_consumer),
 	 AML_OFFSET(extended_irq.flags),
 	 0},
@@ -204,7 +206,7 @@ struct acpi_rsconvert_info acpi_rs_convert_ext_irq[9] = {
 	 AML_OFFSET(extended_irq.flags),
 	 2},
 
-	{ACPI_RSC_1BITFLAG, ACPI_RS_OFFSET(data.extended_irq.sharable),
+	{ACPI_RSC_2BITFLAG, ACPI_RS_OFFSET(data.extended_irq.sharable),
 	 AML_OFFSET(extended_irq.flags),
 	 3},
 
@@ -283,7 +285,6 @@ struct acpi_rsconvert_info acpi_rs_convert_fixed_dma[4] = {
 	 * request_lines
 	 * Channels
 	 */
-
 	{ACPI_RSC_MOVE16, ACPI_RS_OFFSET(data.fixed_dma.request_lines),
 	 AML_OFFSET(fixed_dma.request_lines),
 	 2},
@@ -291,5 +292,4 @@ struct acpi_rsconvert_info acpi_rs_convert_fixed_dma[4] = {
 	{ACPI_RSC_MOVE8, ACPI_RS_OFFSET(data.fixed_dma.width),
 	 AML_OFFSET(fixed_dma.width),
 	 1},
-
 };
-- 
1.7.10

