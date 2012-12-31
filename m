From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 24/27] ACPICA: Resources: Split interrupt share/wake bits into two fields.
Date: Mon, 31 Dec 2012 08:07:31 +0800
Message-ID: <df3768c9a578cf9fa6acd567772220a125dda4e8.1356668535.git.lv.zheng@intel.com>
References: <cover.1356668530.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:6243 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755268Ab2LaAHk (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 30 Dec 2012 19:07:40 -0500
In-Reply-To: <cover.1356668530.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>, Rafael J Wysocki <rafael.j.wysocki@intel.com>
Cc: linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>

From: Bob Moore <robert.moore@intel.com>

These two bits are merged at the external interface level for the
IRQ, Interrupt, and GpioInt resource descriptors. However, these
bits are logically independent and there is no need to keep them
merged internally. Therefore, this change splits the bits into
"sharable" and "wake capable" fields within the resource manager.
This simplifies drive code that needs to examine these bits.
Aaron Lu, Bob Moore.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/rsirq.c    |   32 ++++++++++++++++++++++----------
 drivers/acpi/acpica/rsserial.c |    8 ++++++--
 include/acpi/acrestyp.h        |   10 ++++++++--
 3 files changed, 36 insertions(+), 14 deletions(-)

diff --git a/drivers/acpi/acpica/rsirq.c b/drivers/acpi/acpica/rsirq.c
index f3733ee..9c1d74a 100644
--- a/drivers/acpi/acpica/rsirq.c
+++ b/drivers/acpi/acpica/rsirq.c
@@ -53,7 +53,7 @@ ACPI_MODULE_NAME("rsirq")
  * acpi_rs_get_irq
  *
  ******************************************************************************/
-struct acpi_rsconvert_info acpi_rs_get_irq[8] = {
+struct acpi_rsconvert_info acpi_rs_get_irq[9] = {
 	{ACPI_RSC_INITGET, ACPI_RESOURCE_TYPE_IRQ,
 	 ACPI_RS_SIZE(struct acpi_resource_irq),
 	 ACPI_RSC_TABLE_SIZE(acpi_rs_get_irq)},
@@ -80,7 +80,7 @@ struct acpi_rsconvert_info acpi_rs_get_irq[8] = {
 
 	{ACPI_RSC_EXIT_NE, ACPI_RSC_COMPARE_AML_LENGTH, 0, 3},
 
-	/* Get flags: Triggering[0], Polarity[3], sharing_and_wake[4:5] */
+	/* Get flags: Triggering[0], Polarity[3], Sharing[4], Wake[5] */
 
 	{ACPI_RSC_1BITFLAG, ACPI_RS_OFFSET(data.irq.triggering),
 	 AML_OFFSET(irq.flags),
@@ -90,9 +90,13 @@ struct acpi_rsconvert_info acpi_rs_get_irq[8] = {
 	 AML_OFFSET(irq.flags),
 	 3},
 
-	{ACPI_RSC_2BITFLAG, ACPI_RS_OFFSET(data.irq.sharable),
+	{ACPI_RSC_1BITFLAG, ACPI_RS_OFFSET(data.irq.sharable),
 	 AML_OFFSET(irq.flags),
-	 4}
+	 4},
+
+	{ACPI_RSC_1BITFLAG, ACPI_RS_OFFSET(data.irq.wake_capable),
+	 AML_OFFSET(irq.flags),
+	 5}
 };
 
 /*******************************************************************************
@@ -101,7 +105,7 @@ struct acpi_rsconvert_info acpi_rs_get_irq[8] = {
  *
  ******************************************************************************/
 
-struct acpi_rsconvert_info acpi_rs_set_irq[13] = {
+struct acpi_rsconvert_info acpi_rs_set_irq[14] = {
 	/* Start with a default descriptor of length 3 */
 
 	{ACPI_RSC_INITSET, ACPI_RESOURCE_NAME_IRQ,
@@ -114,7 +118,7 @@ struct acpi_rsconvert_info acpi_rs_set_irq[13] = {
 	 AML_OFFSET(irq.irq_mask),
 	 ACPI_RS_OFFSET(data.irq.interrupt_count)},
 
-	/* Set flags: Triggering[0], Polarity[3], sharing_and_wake[4:5] */
+	/* Set flags: Triggering[0], Polarity[3], Sharing[4], Wake[5] */
 
 	{ACPI_RSC_1BITFLAG, ACPI_RS_OFFSET(data.irq.triggering),
 	 AML_OFFSET(irq.flags),
@@ -124,10 +128,14 @@ struct acpi_rsconvert_info acpi_rs_set_irq[13] = {
 	 AML_OFFSET(irq.flags),
 	 3},
 
-	{ACPI_RSC_2BITFLAG, ACPI_RS_OFFSET(data.irq.sharable),
+	{ACPI_RSC_1BITFLAG, ACPI_RS_OFFSET(data.irq.sharable),
 	 AML_OFFSET(irq.flags),
 	 4},
 
+	{ACPI_RSC_1BITFLAG, ACPI_RS_OFFSET(data.irq.wake_capable),
+	 AML_OFFSET(irq.flags),
+	 5},
+
 	/*
 	 * All done if the output descriptor length is required to be 3
 	 * (i.e., optimization to 2 bytes cannot be attempted)
@@ -181,7 +189,7 @@ struct acpi_rsconvert_info acpi_rs_set_irq[13] = {
  *
  ******************************************************************************/
 
-struct acpi_rsconvert_info acpi_rs_convert_ext_irq[9] = {
+struct acpi_rsconvert_info acpi_rs_convert_ext_irq[10] = {
 	{ACPI_RSC_INITGET, ACPI_RESOURCE_TYPE_EXTENDED_IRQ,
 	 ACPI_RS_SIZE(struct acpi_resource_extended_irq),
 	 ACPI_RSC_TABLE_SIZE(acpi_rs_convert_ext_irq)},
@@ -192,7 +200,7 @@ struct acpi_rsconvert_info acpi_rs_convert_ext_irq[9] = {
 
 	/*
 	 * Flags: Producer/Consumer[0], Triggering[1], Polarity[2],
-	 *        sharing_and_wake[3:4]
+	 *        Sharing[3], Wake[4]
 	 */
 	{ACPI_RSC_1BITFLAG, ACPI_RS_OFFSET(data.extended_irq.producer_consumer),
 	 AML_OFFSET(extended_irq.flags),
@@ -206,10 +214,14 @@ struct acpi_rsconvert_info acpi_rs_convert_ext_irq[9] = {
 	 AML_OFFSET(extended_irq.flags),
 	 2},
 
-	{ACPI_RSC_2BITFLAG, ACPI_RS_OFFSET(data.extended_irq.sharable),
+	{ACPI_RSC_1BITFLAG, ACPI_RS_OFFSET(data.extended_irq.sharable),
 	 AML_OFFSET(extended_irq.flags),
 	 3},
 
+	{ACPI_RSC_1BITFLAG, ACPI_RS_OFFSET(data.extended_irq.wake_capable),
+	 AML_OFFSET(extended_irq.flags),
+	 4},
+
 	/* IRQ Table length (Byte4) */
 
 	{ACPI_RSC_COUNT, ACPI_RS_OFFSET(data.extended_irq.interrupt_count),
diff --git a/drivers/acpi/acpica/rsserial.c b/drivers/acpi/acpica/rsserial.c
index 9aa5e68..197bab0 100644
--- a/drivers/acpi/acpica/rsserial.c
+++ b/drivers/acpi/acpica/rsserial.c
@@ -53,7 +53,7 @@ ACPI_MODULE_NAME("rsserial")
  * acpi_rs_convert_gpio
  *
  ******************************************************************************/
-struct acpi_rsconvert_info acpi_rs_convert_gpio[17] = {
+struct acpi_rsconvert_info acpi_rs_convert_gpio[18] = {
 	{ACPI_RSC_INITGET, ACPI_RESOURCE_TYPE_GPIO,
 	 ACPI_RS_SIZE(struct acpi_resource_gpio),
 	 ACPI_RSC_TABLE_SIZE(acpi_rs_convert_gpio)},
@@ -75,10 +75,14 @@ struct acpi_rsconvert_info acpi_rs_convert_gpio[17] = {
 	 AML_OFFSET(gpio.flags),
 	 0},
 
-	{ACPI_RSC_2BITFLAG, ACPI_RS_OFFSET(data.gpio.sharable),
+	{ACPI_RSC_1BITFLAG, ACPI_RS_OFFSET(data.gpio.sharable),
 	 AML_OFFSET(gpio.int_flags),
 	 3},
 
+	{ACPI_RSC_1BITFLAG, ACPI_RS_OFFSET(data.gpio.wake_capable),
+	 AML_OFFSET(gpio.int_flags),
+	 4},
+
 	{ACPI_RSC_2BITFLAG, ACPI_RS_OFFSET(data.gpio.io_restriction),
 	 AML_OFFSET(gpio.int_flags),
 	 0},
diff --git a/include/acpi/acrestyp.h b/include/acpi/acrestyp.h
index 17f2d05..b58c3cb 100644
--- a/include/acpi/acrestyp.h
+++ b/include/acpi/acrestyp.h
@@ -102,8 +102,11 @@ typedef u32 acpi_rsdesc_size;	/* Max Resource Descriptor size is (Length+3) = (6
 
 #define ACPI_EXCLUSIVE                  (u8) 0x00
 #define ACPI_SHARED                     (u8) 0x01
-#define ACPI_EXCLUSIVE_AND_WAKE         (u8) 0x02
-#define ACPI_SHARED_AND_WAKE            (u8) 0x03
+
+/* Wake */
+
+#define ACPI_NOT_WAKE_CAPABLE           (u8) 0x00
+#define ACPI_WAKE_CAPABLE               (u8) 0x01
 
 /*
  * DMA Attributes
@@ -171,6 +174,7 @@ struct acpi_resource_irq {
 	u8 triggering;
 	u8 polarity;
 	u8 sharable;
+	u8 wake_capable;
 	u8 interrupt_count;
 	u8 interrupts[1];
 };
@@ -346,6 +350,7 @@ struct acpi_resource_extended_irq {
 	u8 triggering;
 	u8 polarity;
 	u8 sharable;
+	u8 wake_capable;
 	u8 interrupt_count;
 	struct acpi_resource_source resource_source;
 	u32 interrupts[1];
@@ -365,6 +370,7 @@ struct acpi_resource_gpio {
 	u8 producer_consumer;	/* For values, see Producer/Consumer above */
 	u8 pin_config;
 	u8 sharable;		/* For values, see Interrupt Attributes above */
+	u8 wake_capable;	/* For values, see Interrupt Attributes above */
 	u8 io_restriction;
 	u8 triggering;		/* For values, see Interrupt Attributes above */
 	u8 polarity;		/* For values, see Interrupt Attributes above */
-- 
1.7.10

