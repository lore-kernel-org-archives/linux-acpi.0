From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v2 14/19] ACPICA: Disassembler: Add new ACPI 5 interrupt sharing flags.
Date: Wed, 19 Dec 2012 13:38:12 +0800
Message-ID: <ea86ad7fcbf970fc9663fa76f6102d3fe3db0878.1355810294.git.lv.zheng@intel.com>
References: <cover.1353491652.git.lv.zheng@intel.com> <cover.1355810292.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:32565 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751133Ab2LSFiT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 19 Dec 2012 00:38:19 -0500
In-Reply-To: <cover.1355810292.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>, Rafael J Wysocki <rafael.j.wysocki@intel.com>
Cc: linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>

From: Bob Moore <robert.moore@intel.com>

This changes adds the ShareAndWake and ExclusiveAndWake flags which
were added to the Irq, Interrupt, and Gpio resource descriptors
in ACPI 5.0.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/rsdump.c  |    6 +++---
 drivers/acpi/acpica/utresrc.c |    4 +++-
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/acpica/rsdump.c b/drivers/acpi/acpica/rsdump.c
index 276e52f..0b7381f 100644
--- a/drivers/acpi/acpica/rsdump.c
+++ b/drivers/acpi/acpica/rsdump.c
@@ -98,7 +98,7 @@ struct acpi_rsdump_info acpi_rs_dump_irq[7] = {
 	 acpi_gbl_he_decode},
 	{ACPI_RSD_1BITFLAG, ACPI_RSD_OFFSET(irq.polarity), "Polarity",
 	 acpi_gbl_ll_decode},
-	{ACPI_RSD_1BITFLAG, ACPI_RSD_OFFSET(irq.sharable), "Sharing",
+	{ACPI_RSD_2BITFLAG, ACPI_RSD_OFFSET(irq.sharable), "Sharing",
 	 acpi_gbl_shr_decode},
 	{ACPI_RSD_UINT8, ACPI_RSD_OFFSET(irq.interrupt_count),
 	 "Interrupt Count", NULL},
@@ -287,7 +287,7 @@ struct acpi_rsdump_info acpi_rs_dump_ext_irq[8] = {
 	 "Triggering", acpi_gbl_he_decode},
 	{ACPI_RSD_1BITFLAG, ACPI_RSD_OFFSET(extended_irq.polarity), "Polarity",
 	 acpi_gbl_ll_decode},
-	{ACPI_RSD_1BITFLAG, ACPI_RSD_OFFSET(extended_irq.sharable), "Sharing",
+	{ACPI_RSD_2BITFLAG, ACPI_RSD_OFFSET(extended_irq.sharable), "Sharing",
 	 acpi_gbl_shr_decode},
 	{ACPI_RSD_SOURCE, ACPI_RSD_OFFSET(extended_irq.resource_source), NULL,
 	 NULL},
@@ -320,7 +320,7 @@ struct acpi_rsdump_info acpi_rs_dump_gpio[16] = {
 	 "ProducerConsumer", acpi_gbl_consume_decode},
 	{ACPI_RSD_UINT8, ACPI_RSD_OFFSET(gpio.pin_config), "PinConfig",
 	 acpi_gbl_ppc_decode},
-	{ACPI_RSD_2BITFLAG, ACPI_RSD_OFFSET(gpio.sharable), "Sharable",
+	{ACPI_RSD_2BITFLAG, ACPI_RSD_OFFSET(gpio.sharable), "Sharing",
 	 acpi_gbl_shr_decode},
 	{ACPI_RSD_2BITFLAG, ACPI_RSD_OFFSET(gpio.io_restriction),
 	 "IoRestriction", acpi_gbl_ior_decode},
diff --git a/drivers/acpi/acpica/utresrc.c b/drivers/acpi/acpica/utresrc.c
index 546ea73..8f8eab9 100644
--- a/drivers/acpi/acpica/utresrc.c
+++ b/drivers/acpi/acpica/utresrc.c
@@ -127,7 +127,9 @@ const char *acpi_gbl_rw_decode[] = {
 
 const char *acpi_gbl_shr_decode[] = {
 	"Exclusive",
-	"Shared"
+	"Shared",
+	"ExclusiveAndWake",	/* ACPI 5.0 */
+	"SharedAndWake"		/* ACPI 5.0 */
 };
 
 const char *acpi_gbl_siz_decode[] = {
-- 
1.7.10

