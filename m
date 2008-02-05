From: akpm@linux-foundation.org
Subject: [patch 1/7] acpi: enable C3 Power State on Dell Inspiron 8200
Date: Mon, 04 Feb 2008 23:31:17 -0800
Message-ID: <200802050730.m157UwvP009612@imap1.linux-foundation.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:56174 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751191AbYBEHb7 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 5 Feb 2008 02:31:59 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, akpm@linux-foundation.org, dag@bakke.com, arjan@infradead.org

From: Dag Bakke <dag@bakke.com>

Taken from http://bugzilla.kernel.org/show_bug.cgi?id=8703

[akpm@linux-foundation.org: fix warning]
Tested-by: Arjan van de Ven <arjan@infradead.org>
Cc: Len Brown <lenb@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/acpi/processor_idle.c |   23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff -puN drivers/acpi/processor_idle.c~acpi-enable-c3-power-state-on-dell-inspiron-8200 drivers/acpi/processor_idle.c
--- a/drivers/acpi/processor_idle.c~acpi-enable-c3-power-state-on-dell-inspiron-8200
+++ a/drivers/acpi/processor_idle.c
@@ -100,6 +100,8 @@ static int acpi_processor_set_power_poli
 
 #endif
 
+static int forced_c3;
+
 /*
  * IBM ThinkPad R40e crashes mysteriously when going into C2 or C3.
  * For now disable this. Probably a bug somewhere else.
@@ -120,6 +122,19 @@ static int set_max_cstate(const struct d
 	return 0;
 }
 
+/*
+ * Some (Dell) machines set the C3 latency to a value which effectively says:
+ * "Don't use C3." Still, C3 works if we force it.
+ * This enables C3 on Dell Inspiron 8200 machines.
+ */
+static int dmi_force_c3(const struct dmi_system_id *id)
+{
+	forced_c3 = 1;
+	printk(KERN_NOTICE PREFIX "%s detected - Force enabling C3.",
+			id->ident);
+	return 0;
+}
+
 /* Actually this shouldn't be __cpuinitdata, would be better to fix the
    callers to only run once -AK */
 static struct dmi_system_id __cpuinitdata processor_power_dmi_table[] = {
@@ -178,6 +193,9 @@ static struct dmi_system_id __cpuinitdat
 	  DMI_MATCH(DMI_BIOS_VENDOR,"Phoenix Technologies LTD"),
 	  DMI_MATCH(DMI_BIOS_VERSION,"SHE845M0.86C.0013.D.0302131307")},
 	 (void *)2},
+	{ dmi_force_c3, "Dell Inspiron 8200", {
+	  DMI_MATCH(DMI_SYS_VENDOR,"Dell Computer Corporation"),
+	  DMI_MATCH(DMI_PRODUCT_NAME,"Inspiron 8200") }, NULL},
 	{},
 };
 
@@ -1026,11 +1044,12 @@ static void acpi_processor_power_verify_
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
_
