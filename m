From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 19/27] ACPICA: Resource manager: Add support for ACPI 5 wake bit in IRQ descriptor.
Date: Mon, 31 Dec 2012 08:07:01 +0800
Message-ID: <5879bf4855d00954329d735ffdf5f04061bf419b.1356668534.git.lv.zheng@intel.com>
References: <cover.1356668530.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:44713 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755268Ab2LaAHL (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 30 Dec 2012 19:07:11 -0500
In-Reply-To: <cover.1356668530.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>, Rafael J Wysocki <rafael.j.wysocki@intel.com>
Cc: linux-acpi@vger.kernel.org, Aaron Lu <aaron.lu@intel.com>, Bob Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>

From: Aaron Lu <aaron.lu@intel.com>

Add support to both get and set the extended share flags for the
IRQ() resource descriptor. Reported by Aaron Lu.

Signed-off-by: Aaron Lu <aaron.lu@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/rsirq.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/acpica/rsirq.c b/drivers/acpi/acpica/rsirq.c
index a718eca..14cb76e 100644
--- a/drivers/acpi/acpica/rsirq.c
+++ b/drivers/acpi/acpica/rsirq.c
@@ -80,7 +80,7 @@ struct acpi_rsconvert_info acpi_rs_get_irq[8] = {
 
 	{ACPI_RSC_EXIT_NE, ACPI_RSC_COMPARE_AML_LENGTH, 0, 3},
 
-	/* Get flags: Triggering[0], Polarity[3], Sharing[4] */
+	/* Get flags: Triggering[0], Polarity[3], sharing_and_wake[4:5] */
 
 	{ACPI_RSC_1BITFLAG, ACPI_RS_OFFSET(data.irq.triggering),
 	 AML_OFFSET(irq.flags),
@@ -90,7 +90,7 @@ struct acpi_rsconvert_info acpi_rs_get_irq[8] = {
 	 AML_OFFSET(irq.flags),
 	 3},
 
-	{ACPI_RSC_1BITFLAG, ACPI_RS_OFFSET(data.irq.sharable),
+	{ACPI_RSC_2BITFLAG, ACPI_RS_OFFSET(data.irq.sharable),
 	 AML_OFFSET(irq.flags),
 	 4}
 };
@@ -114,7 +114,7 @@ struct acpi_rsconvert_info acpi_rs_set_irq[13] = {
 	 AML_OFFSET(irq.irq_mask),
 	 ACPI_RS_OFFSET(data.irq.interrupt_count)},
 
-	/* Set the flags byte */
+	/* Set flags: Triggering[0], Polarity[3], sharing_and_wake[4:5] */
 
 	{ACPI_RSC_1BITFLAG, ACPI_RS_OFFSET(data.irq.triggering),
 	 AML_OFFSET(irq.flags),
@@ -124,7 +124,7 @@ struct acpi_rsconvert_info acpi_rs_set_irq[13] = {
 	 AML_OFFSET(irq.flags),
 	 3},
 
-	{ACPI_RSC_1BITFLAG, ACPI_RS_OFFSET(data.irq.sharable),
+	{ACPI_RSC_2BITFLAG, ACPI_RS_OFFSET(data.irq.sharable),
 	 AML_OFFSET(irq.flags),
 	 4},
 
-- 
1.7.10

