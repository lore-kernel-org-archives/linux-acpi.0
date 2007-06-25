From: Dag Bakke <dag@bakke.com>
Subject: [PATCH] Enable C3 Power State on Dell Inspiron 8200
Date: Mon, 25 Jun 2007 22:25:09 +0200
Message-ID: <468024A5.4010505@bakke.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from bgo1smout1.broadpark.no ([217.13.4.94]:51601 "EHLO
	bgo1smout1.broadpark.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752108AbXFYVZ1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 25 Jun 2007 17:25:27 -0400
Received: from bgo1sminn1.broadpark.no ([217.13.4.93])
 by bgo1smout1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-0.15 (built Feb  9 2007))
 with ESMTP id <0JK7000VIKPXRZ70@bgo1smout1.broadpark.no> for
 linux-acpi@vger.kernel.org; Mon, 25 Jun 2007 22:25:09 +0200 (CEST)
Received: from [10.0.0.3] ([84.48.89.144]) by bgo1sminn1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-0.15 (built Feb  9 2007))
 with ESMTP id <0JK7000HKKP9JO20@bgo1sminn1.broadpark.no> for
 linux-acpi@vger.kernel.org; Mon, 25 Jun 2007 22:24:45 +0200 (CEST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, arjan@linux.intel.com

The attached patch makes the kernel ignore the fact that P_LVL3_LAT is
set to 2000 in the relevant ACPI table, and enforces the C3 power state
anyway. I have not observed any ill effects with this patch on my
P4m-equipped Inspiron 8200, and would like to see this patch applied
upstream.

It saves ~2.5 watts on an idle system, so should be well worth it.

The patch was written by Arjan van de Ven based on my initial tests, and
 the patch has been tested by myself.
It applies to 2.6.22-rc5 and likely also -rc6.


Dag Bakke


Tested-by: Dag Bakke <dag@bakke.com>

--- linux/drivers/acpi/processor_idle.c.org	2007-06-10
14:18:27.000000000 -0700
+++ linux/drivers/acpi/processor_idle.c	2007-06-10 14:27:45.000000000 -0700
@@ -67,6 +67,8 @@ ACPI_MODULE_NAME("processor_idle");
 #define C2_OVERHEAD			1	/* 1us */
 #define C3_OVERHEAD			1	/* 1us */

+static int forced_c3;
+
 void acpi_max_cstate_changed(void)
 {
 	/* Driver will reset devices' max cstate limit */
@@ -115,6 +117,20 @@ static int set_max_cstate(struct dmi_sys
 	return 0;
 }

+/*
+ * Some (Dell) machines have a too large C3 latency set, but it still
works completely.
+ * Dell provides a driver for other operating systems to hack around
this bug, so we know
+ * it's safe.
+ */
+static int dmi_force_c3(struct dmi_system_id *id)
+{
+	forced_c3 = 1;
+
+	printk(KERN_NOTICE PREFIX "%s detected - Force enabling C3.", id->ident);
+
+	return 0;
+}
+
 /* Actually this shouldn't be __cpuinitdata, would be better to fix the
    callers to only run once -AK */
 static struct dmi_system_id __cpuinitdata processor_power_dmi_table[] = {
@@ -173,6 +189,9 @@ static struct dmi_system_id __cpuinitdat
 	  DMI_MATCH(DMI_BIOS_VENDOR,"Phoenix Technologies LTD"),
 	  DMI_MATCH(DMI_BIOS_VERSION,"SHE845M0.86C.0013.D.0302131307")},
 	 (void *)2},
+	{ dmi_force_c3, "Dell Inspiron 8200", {
+	  DMI_MATCH(DMI_SYS_VENDOR,"Dell Computer Corporation"),
+	  DMI_MATCH(DMI_PRODUCT_NAME,"Inspiron 8200") }, NULL},
 	{},
 };

@@ -474,11 +493,12 @@ static void acpi_processor_power_verify_
 	 * C3 latency must be less than or equal to 1000
 	 * microseconds.
 	 */
-	else if (cx->latency > ACPI_PROCESSOR_MAX_C3_LATENCY) {
+	if (cx->latency > ACPI_PROCESSOR_MAX_C3_LATENCY && !forced_c3) {
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
 				  "latency too large [%d]\n", cx->latency));
 		return;
-	}
+	} else if (forced_c3)
+		cx->latency = ACPI_PROCESSOR_MAX_C3_LATENCY;

 	/*
 	 * PIIX4 Erratum #18: We don't support C3 when Type-F (fast)
